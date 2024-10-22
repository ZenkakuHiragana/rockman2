; 6502 Decompressor for Tokumaru's compression algorithm
; Extracted from tokumaru_tile_compression.7z
; Copyright presumably Tokumaru ?

;decompresses a group of tiles from PRG-ROM to CHR-RAM
;LoadGraphicsCompressed:

.ColorCount = $00 ;4 bytes, number of colors that can follow each color
.NextColor0 = $04 ;4 bytes, first  color that can follow each color
.NextColor1 = $0C ;4 bytes, second color that can follow each color
.NextColor2 = $10 ;4 bytes, third  color that can follow each color

.SpecifiedColor = $08 ;color necessary to find all the colors that follow a color
.TempBit        = $08 ;temporally holds a bit when reading 2 from the stream

.CurrentColor = $09 ;color that can be followed by other colors
.CurrentRow   = $09 ;backup of the index of the row being worked on

.InputStream = $0A ;2 bytes, pointer to the data being decompressed
.TileCount   = $C0 ;number of tiles to decompress
.BitBuffer   = $C1 ;buffer of bits comming from the stream

.Plane0      = $C2 ;lower plane of a tile's row
.Plane1      = $C3 ;upper plane of a tile's row
.PlaneBuffer = $C4 ;8 bytes, buffer that holds the second plane until it's time to output it

	;copy the tile count from the stream
	ldy #$00
;ワイリーステージ読み込み用（Y保存）
.continue .public
	lda [.InputStream],y
	sta <.TileCount
	iny

	;clear the bit buffer
	lda #$80
	sta <.BitBuffer

.StartBlock

	;start by specifying how many colors can follow color 3 and listing all of them
	ldx #$03

.ProcessColor

	;copy from the stream the number of colors that can follow the current one
	jsr .Read2Bits
	sta <.ColorCount,x

	;go process the next color if the current one is only followed by itself
	beq .AdvanceColor

	;read from the stream the one color necessary to figure all of them out
	lda #$01
	sta <.SpecifiedColor
	jsr .ReadBit
	bcc .end_processcolor
	inc <.SpecifiedColor
	jsr .ReadBit
	bcc .end_processcolor
	inc <.SpecifiedColor
.end_processcolor
	cpx <.SpecifiedColor
	bcc .ListColors
	dec <.SpecifiedColor

.ListColors

	;assume the color is going to be listed
	lda <.SpecifiedColor
	pha

	;go list the color if it's the only one that can follow the current one
	lda <.ColorCount,x
	cmp #$02
	bcc .List1Color

	;keep the color from being listed if only 2 colors follow the current one
	bne .FindColors
	pla

.FindColors

	;save a copy of the current color so that values can be compared to it
	stx <.CurrentColor

	;find the 2 colors that are not the current one or the specified one
	lda #$00
.loop_findcolors
	cmp <.SpecifiedColor
	beq .skip_findcolors
	cmp <.CurrentColor
	beq .skip_findcolors
	pha
	sec
.skip_findcolors
	adc #$00
	cmp #$04
	bne .loop_findcolors

	;skip listing the third color if only 2 can follow the current one
	lda <.ColorCount,x
	cmp #$02
	beq .List2Colors

	;write the third color that can follow the current one
	pla
	sta <.NextColor2,x

.List2Colors

	;write the second color that can follow the current one
	pla
	sta <.NextColor1,x

.List1Color

	;write the first color that can follow the current one
	pla
	sta <.NextColor0,x

.AdvanceColor

	;move on to the next color if there are still colors left
	dex
	bpl .ProcessColor

	;pretend that all pixels of the previous row used color 0
	lda #$00
	sta <.Plane0
	sta <.Plane1

.DecodeTile

	;prepare to decode 8 rows
	ldx #$07

.DecodeRow

	;decide between repeating the previous row or decoding a new one
	jsr .ReadBit
	bcs .WriteRow

	;prepare the flag that will indicate the end of the row
	lda #$01
	sta <.Plane1

	;remember which row is being decoded
	stx <.CurrentRow

	;read a pixel from the stream and draw it
	jsr .Read2Bits
	bpl .DrawNewPixel

.CheckCount

	;go draw the pixel if its color can't be followed by any other
	lda <.ColorCount,x
	beq .RepeatPixel

	;decide between repeating the previous pixel or decoding a new one
	jsr .ReadBit
	bcs .RepeatPixel

	; Possible counts: -123. Bits so far: 0

	;skip if more than one color can follow the current one
	lda <.ColorCount,x
	cmp #$01
	bne .DecodeColor

	; Possible counts: -1--. Bits so far: 0

	;go draw the only color that follows the current one
	lda <.NextColor0,x
	bcs .DrawNewPixel

.DecodeColor

	; Possible counts: --23. Bits so far: 0
	;decode a pixel from the stream
	jsr .ReadBit
	bcs .skip_decodecolor1
	; Possible counts: --23. Bits so far: 00
	lda <.NextColor0,x
	bcc .DrawNewPixel
	; Possible counts: --23. Bits so far: 01
.skip_decodecolor1
	lda <.ColorCount,x
	cmp #$03
	bcc .skip_decodecolor2
	; Possible counts: ---3. Bits so far: 01
	jsr .ReadBit
	bcs .skip_decodecolor3
.skip_decodecolor2
	; Possible counts: ---3. Bits so far: 010
	; Possible counts: --2-. Bits so far: 01
	lda <.NextColor1,x
	bcc .DrawNewPixel
	; Possible counts: ---3. Bits so far: 011
.skip_decodecolor3
	lda <.NextColor2,x

.DrawNewPixel

	;make a copy of the pixel for the next iteration
	tax

.DrawPixel

	;draw the pixel to the row
	lsr a
	rol <.Plane0
	lsr a
	rol <.Plane1

	;go process the next pixel if the row isn't done
	bcc .CheckCount

	;restore the index of the row
	ldx <.CurrentRow

.WriteRow

	;output the fist plane of the row and buffer the second one
	lda <.Plane0
	sta $2007
	lda <.Plane1
	sta <.PlaneBuffer,x

	;move on to the next row if there are still rows left
	dex
	bpl .DecodeRow

	;output the second plane of the tile
	ldx #$07
.loop_writerow
	lda <.PlaneBuffer,x
	sta $2007
	dex
	bpl .loop_writerow

	;return if there are no more tiles to decode
	dec <.TileCount
	beq .Return

	;decide between decoding another tile or starting a new block
	jsr .ReadBit
	bcc .DecodeTile
	jmp .StartBlock

.RepeatPixel

	;go draw a pixel of the same color as the previous one
	txa
	bpl .DrawPixel

.Read2Bits

	;read 2 bits from the stream and return them in the accumulator
	jsr .ReadBit
	rol <.TempBit
	jsr .ReadBit
	lda <.TempBit
	rol a
	and #$03
	rts

.ReadBit

	;read a bit from the stream and return it in the carry flag
	asl <.BitBuffer
	bne .Return
	lda [.InputStream],y
	iny
	bne .carry_readbit
	inc <.InputStream + 1
.carry_readbit
	rol a
	sta <.BitBuffer

.Return
	rts
