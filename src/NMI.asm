
;CFED NMI Interrupt
;NMI_Start:
	pha
	php
	txa
	pha
	tya
	pha
	lda <zIsLag
	beq .notlag
	jmp .lag
.notlag
	lda <z2000
	and #$7C
	sta <z2000
	sta $2000 ;PPU Reg0
	lda <z2001
	and #$E7
	sta <z2001
	sta $2001 ;PPU Reg1
	lda $2002 ;PPU Stats
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
	lda $2002 ;PPU Stats
	lda #$00
	sta <$01
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
	ora #$1E
	sta <z2001
	sta $2001
	lda <z2000
	ora #$80
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
	plp
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

