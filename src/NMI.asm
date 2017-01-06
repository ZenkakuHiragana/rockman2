
;CFED NMI Interrupt
;NMI_Start:
	pha
	txa
	pha
	tya
	pha
	lda <zIsLag
	beq .notlag
	jmp .lag
.notlag
	lda <z2000
	and #%01111100
	sta <z2000
	sta $2000 ;PPU Reg0
	lda <z2001
	and #%11100111
	sta <z2001
	sta $2001 ;PPU Reg1
	lda $2002 ;PPU Stats
	jsr WritePPUScroll
	lda #$00
	sta $2003 ;Sprite Address
	lda #$02
	sta $4014 ;Sprite DMA
	lda <zPPUSqr
	beq .sqr
	jsr WritePPUSquare
.sqr
	jsr WritePalette
	lda <zPPULinear
	beq .linear
	jsr WritePPULinear
.linear
	lda <zPPULaser
	beq .laser
	jsr WritePPULaser
.laser
.s = $00
.r = $01
	mSTZ <$01
	lda <zHScroll
	sta <.s
	lda <zHScrollApparenthi
	beq .nofake_x
	sec
	lda <.s
	sbc <zHScrollApparenthi
	sta <.s
	lda #$00
	sbc <zRoomApparent
	and #$01
	sta <.r
.nofake_x
	lda <.s
	sta $2005 ;PPU Scroll Register
	lda <zVScroll
	sta <.s
	lda <zVScrollApparenthi
	beq .nofake_y
	sec
	lda <.s
	sbc <zVScrollApparenthi
	sta <.s
.nofake_y
	lda <.s
	sta $2005 ;PPU Scroll Register
	lda <z2001
	ora #%00011110
	sta <z2001
	sta $2001
	lda <z2000
	ora #%10000000
	sta <z2000
	lda <zRoom
	eor <.r
	and #$01
	ora <z2000
	ora <zScreenMod
	sta <z2000
	sta $2000 ;PPU Reg0
	sta <zIsLag
	inc <zFrameCounter
.lag
	lda <zPostProcSemaphore
	beq .sound
	inc <zPostProcessSound
	bne .jump
.sound
	lda #$0C
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	jsr $8000
.loop
	ldx <zSoundQueue
	beq .noqueue
	lda aSoundQueue - 1,x
	cmp #$FD
	bne .other
	ldy #$A0
.other
	jsr $8003
	dec <zSoundQueue
	bne .loop
.noqueue
	mCHANGEBANK <zBank
.jump
	lda aObjXlo
	eor <zRand
	adc <zFrameCounter
	lsr a
	sta <zRand
	pla
	tay
	pla
	tax
	pla
	rti

;20 D4 D0
GetPadInfo:
	ldx #$01
	stx $4016
	dex
	stx $4016
	inx
.players
	ldy #$08
.loop
	lda $4016,x
	sta <zKeyPress
	lsr a
	ora <zKeyPress
	lsr a
	ror <zKeyDown,x
	dey
	bne .loop
	dex
	bpl .players
	rts

;20 F2 D0
WritePalette:
	ldy #$3F
	sty $2006
	ldx #$00
	stx $2006
.loop
	lda aPalette,x
	sta $2007
	inx
	cpx #$20
	bne .loop
	sty $2006
	lda #$00
	sta $2006
	sta $2006
	sta $2006
	sta <z3A ;---------------------------?
	rts
	.beginregion "PPU_4way_scroll"
WritePPUScroll:
	lda <zPPUVScr
	bne .do_v
	jmp .skip_v
.do_v
	ldx aPPUVScrhi
	stx $2006
	ldy aPPUVScrlo
	sty $2006
	
	mMOV aPPUVScrData, $2007
	mMOV aPPUVScrData + $01, $2007
	mMOV aPPUVScrData + $02, $2007
	mMOV aPPUVScrData + $03, $2007
	mMOV aPPUVScrData + $04, $2007
	mMOV aPPUVScrData + $05, $2007
	mMOV aPPUVScrData + $06, $2007
	mMOV aPPUVScrData + $07, $2007
	mMOV aPPUVScrData + $08, $2007
	mMOV aPPUVScrData + $09, $2007
	mMOV aPPUVScrData + $0A, $2007
	mMOV aPPUVScrData + $0B, $2007
	mMOV aPPUVScrData + $0C, $2007
	mMOV aPPUVScrData + $0D, $2007
	mMOV aPPUVScrData + $0E, $2007
	mMOV aPPUVScrData + $0F, $2007
	mMOV aPPUVScrData + $10, $2007
	mMOV aPPUVScrData + $11, $2007
	mMOV aPPUVScrData + $12, $2007
	mMOV aPPUVScrData + $13, $2007
	mMOV aPPUVScrData + $14, $2007
	mMOV aPPUVScrData + $15, $2007
	mMOV aPPUVScrData + $16, $2007
	mMOV aPPUVScrData + $17, $2007
	mMOV aPPUVScrData + $18, $2007
	mMOV aPPUVScrData + $19, $2007
	mMOV aPPUVScrData + $1A, $2007
	mMOV aPPUVScrData + $1B, $2007
	mMOV aPPUVScrData + $1C, $2007
	mMOV aPPUVScrData + $1D, $2007
	mMOV aPPUVScrData + $1E, $2007
	mMOV aPPUVScrData + $1F, $2007
	
	txa
	clc
	adc #$04
	sta $2006
	sty $2006
	
	mMOV aPPUVScrData + $20, $2007
	mMOV aPPUVScrData + $21, $2007
	mMOV aPPUVScrData + $22, $2007
	mMOV aPPUVScrData + $23, $2007
	mMOV aPPUVScrData + $24, $2007
	mMOV aPPUVScrData + $25, $2007
	mMOV aPPUVScrData + $26, $2007
	mMOV aPPUVScrData + $27, $2007
	mMOV aPPUVScrData + $28, $2007
	mMOV aPPUVScrData + $29, $2007
	mMOV aPPUVScrData + $2A, $2007
	mMOV aPPUVScrData + $2B, $2007
	mMOV aPPUVScrData + $2C, $2007
	mMOV aPPUVScrData + $2D, $2007
	mMOV aPPUVScrData + $2E, $2007
	mMOV aPPUVScrData + $2F, $2007
	mMOV aPPUVScrData + $30, $2007
	mMOV aPPUVScrData + $31, $2007
	mMOV aPPUVScrData + $32, $2007
	mMOV aPPUVScrData + $33, $2007
	mMOV aPPUVScrData + $34, $2007
	mMOV aPPUVScrData + $35, $2007
	mMOV aPPUVScrData + $36, $2007
	mMOV aPPUVScrData + $37, $2007
	mMOV aPPUVScrData + $38, $2007
	mMOV aPPUVScrData + $39, $2007
	mMOV aPPUVScrData + $3A, $2007
	mMOV aPPUVScrData + $3B, $2007
	mMOV aPPUVScrData + $3C, $2007
	mMOV aPPUVScrData + $3D, $2007
	mMOV aPPUVScrData + $3E, $2007
	mMOV aPPUVScrData + $3F, $2007
	
	mMOV #$23, $2006
	ldy aPPUVScrAttr
	sty $2006
	
	mMOV aPPUVScrAttrData, $2007
	mMOV aPPUVScrAttrData + 1, $2007
	mMOV aPPUVScrAttrData + 2, $2007
	mMOV aPPUVScrAttrData + 3, $2007
	mMOV aPPUVScrAttrData + 4, $2007
	mMOV aPPUVScrAttrData + 5, $2007
	mMOV aPPUVScrAttrData + 6, $2007
	mMOV aPPUVScrAttrData + 7, $2007
	
	mMOV #$2F, $2006
	sty $2006
	
	mMOV aPPUVScrAttrData + 8, $2007
	mMOV aPPUVScrAttrData + 9, $2007
	mMOV aPPUVScrAttrData + $A, $2007
	mMOV aPPUVScrAttrData + $B, $2007
	mMOV aPPUVScrAttrData + $C, $2007
	mMOV aPPUVScrAttrData + $D, $2007
	mMOV aPPUVScrAttrData + $E, $2007
	mMOV aPPUVScrAttrData + $F, $2007
.skip_v

	lda <zPPUHScr
	bne .do_h
	jmp .skip_h
.do_h
	
	mMOV #%00010100, $2000
	mMOV aPPUHScrhi, $2006
	mMOV aPPUHScrlo, $2006
	mMOV aPPUHScrData, $2007
	mMOV aPPUHScrData + $01, $2007
	mMOV aPPUHScrData + $02, $2007
	mMOV aPPUHScrData + $03, $2007
	mMOV aPPUHScrData + $04, $2007
	mMOV aPPUHScrData + $05, $2007
	mMOV aPPUHScrData + $06, $2007
	mMOV aPPUHScrData + $07, $2007
	mMOV aPPUHScrData + $08, $2007
	mMOV aPPUHScrData + $09, $2007
	mMOV aPPUHScrData + $0A, $2007
	mMOV aPPUHScrData + $0B, $2007
	mMOV aPPUHScrData + $0C, $2007
	mMOV aPPUHScrData + $0D, $2007
	mMOV aPPUHScrData + $0E, $2007
	mMOV aPPUHScrData + $0F, $2007
	mMOV aPPUHScrData + $10, $2007
	mMOV aPPUHScrData + $11, $2007
	mMOV aPPUHScrData + $12, $2007
	mMOV aPPUHScrData + $13, $2007
	mMOV aPPUHScrData + $14, $2007
	mMOV aPPUHScrData + $15, $2007
	mMOV aPPUHScrData + $16, $2007
	mMOV aPPUHScrData + $17, $2007
	mMOV aPPUHScrData + $18, $2007
	mMOV aPPUHScrData + $19, $2007
	mMOV aPPUHScrData + $1A, $2007
	mMOV aPPUHScrData + $1B, $2007
	mMOV aPPUHScrData + $1C, $2007
	mMOV aPPUHScrData + $1D, $2007
	
	ldy aPPUHScrAttrhi
	sty $2006
	mMOV aPPUHScrAttrlo, $2006
	mMOV aPPUHScrAttr, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + 2, $2006
	mMOV aPPUHScrAttr + 2, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + 4, $2006
	mMOV aPPUHScrAttr + 4, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + 6, $2006
	mMOV aPPUHScrAttr + 6, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + 8, $2006
	mMOV aPPUHScrAttr + 8, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + $A, $2006
	mMOV aPPUHScrAttr + $A, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + $C, $2006
	mMOV aPPUHScrAttr + $C, $2007
	sty $2006
	mMOV aPPUHScrAttrlo + $E, $2006
	mMOV aPPUHScrAttr + $E, $2007
	mMOV <z2000, $2000
	mSTZ <zPPUHScr, <zPPUVScr
.skip_h
	rts
	.endregion "PPU_4way_scroll"

;20 18 D1
WritePPUSquare:
	bpl .square
	jmp .isminus
.square
.n = $00
.l = $01
.ptr = $0A
.lo = $0A
.hi = $0B
	ldy #$00
.nloop
	sty <.n
	tya
	asl a
	asl a
	asl a
	asl a
	tax
	lda #$04
	sta <.l
	lda aPPUSqrhi,y
	sta <.hi
	lda aPPUSqrlo,y
	sta <.lo
	cmp #$80
	bcc .jump
	lda <.hi
	and #$03
	cmp #$03
	bne .jump
	lda #$02
	sta <.l
.jump
	lda aPPUSqrAttrhi,y
	sta $2006
	lda aPPUSqrAttrlo,y
	sta $2006
	lda aPPUSqrAttrData,y
	sta $2007
.line
	lda <.hi
	sta $2006
	clc
	lda <.lo
	sta $2006
	adc #$20
	sta <.lo
	ldy #$04
.loop
	lda aPPUSqrData,x
	sta $2007
	inx
	dey
	bne .loop
	dec <.l
	bne .line
	ldy <.n
	iny
	dec <zPPUSqr
	bne .nloop
	rts
;縦スクロール関連らしいけどなにこれ？
.isminus
	ldx #$00
	stx <zPPUSqr
.loop2
	lda $0300
	sta $2006
	lda $0301
	sta $2006
.loop_alt
	lda $0302,x
	sta $2007
	inx
	txa
	and #$07
	bne .loop_alt
	clc
	lda $0301
	adc #$20
	sta $0301
	lda $0312
	sta $2006
	lda $0313
	sta $2006
	lda $2007
	lda $2007
	ldy <zPPUSqr
	and $0314
	ora $0315,y
	pha
	lda $0312
	sta $2006
	lda $0313
	sta $2006
	pla
	sta $2007
	inc <zPPUSqr
	inc $0313
	cpx #$10
	bne .loop2
	lda #$00
	sta <zPPUSqr
	rts

;20 DC D1
WritePPULinear:
	lda aPPULinearhi
	sta $2006
	lda aPPULinearlo
	sta $2006
	ldx #$00
.loop
	lda aPPULinearData,x
	sta $2007
	inx
	dec <zPPULinear
	bne .loop
	rts

;20 F6 D1
WritePPULaser:
	lda <z2000
	ora #$04
	sta $2000
	lda <zPPUShutterFlag
	bne .alternate
	ldy <zPPULaser
	bmi .shutter
.loop
	lda aPPULaserhi - 1,y
	sta $2006
	lda aPPULaserlo - 1,y
	sta $2006
	lda aPPULaserData - 1,y
	sta $2007
	clc
	adc #$01
	sta $2007
	dey
	bne .loop
.shutter_done
	sty <zPPULaser
	lda <z2000
	and #$FB
	sta $2000
	rts

.shutter
	tya
	and #$7F
	tay
.loop_shutter_3
	lda #$02
	sta <$00
	lda #$E4
	sta <$01
.loop_shutter_2
	lda aPPULaserhi - 1,y
	sta $2006
	lda aPPULaserlo - 1,y
	sta $2006
	lda #$02
	sta <$02
.loop_shutter
	lda <$01
	sta $2007
	inc <$01
	dec <$02
	bne .loop_shutter
	dec <$00
	beq .jump
	clc
	lda aPPULaserlo - 1,y
	adc #$01
	sta aPPULaserlo - 1,y
	jmp .loop_shutter_2
.jump
	dey
	bne .loop_shutter_3
	beq .shutter_done

.alternate
	bpl .isplus
	lda aPPULaserhi
	sta $2006
	ldx aPPULaserlo
	dex
	dex
	stx $2006
	lda $2007
	lda $2007
	tax
	jmp .jump_alt
.isplus
	ldx #$20
.jump_alt
	ldy #$02
.loop_alt
	lda aPPULaserhi
	sta $2006
	lda aPPULaserlo
	sta $2006
	stx $2007
	inx
	stx $2007
	inx
	inc aPPULaserlo
	dey
	bne .loop_alt
	lda $03C2
	sta $2006
	lda $03C8
	sta $2006
	lda <zPPUShutterFlag
	bpl .isplus_2
	lda $2007
	lda $2007
	sta <$00
	lda $03D4
	eor #$FF
	lsr a
	lsr a
	and <$00
	asl a
	asl a
	sta $03CE
	lda <$00
	jmp .not_read
.isplus_2
	lda $2007
	lda $2007
.not_read
	and $03D4
	ora $03CE
	tax
	lda $03C2
	sta $2006
	lda $03C8
	sta $2006
	stx $2007
	sty <zPPUShutterFlag
	jmp .shutter_done

