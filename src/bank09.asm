;24000-27FFF

;8000-85FF: Stage Graphics(General)

	mBEGIN $09, $8600
;8600
Bank09_ShowEndingSprites:
	jmp ___Bank09_ShowEndingSprites
;8603
Bank09_WriteEndingBossname:
	jmp ___Bank09_WriteEndingBossname
;8606
Bank09_InitStaffLine:
	jmp ___Bank09_InitStaffLine
;8609
Bank09_ScrollStaffLine:
	jmp ___Bank09_ScrollStaffLine

;860C
;エンディングの歩くロックマン + 武器取得のロックマンのスプライト表示
___Bank09_ShowEndingSprites:
	ldy <$01
	mMOV $8700,y, <zPtrlo
	mMOV $8708,y, <zPtrhi
	ldy #$00
	mMOV [zPtr],y, <$02
	iny
	ldx #$00
.loop2
	mMOV #$04, <$01
.loop
	mMOV [zPtr],y, aSprite,x
	iny
	inx
	dec <$01
	bne .loop
	dec <$02
	bne .loop2
	stx <$00
	rts

;8637
;スタッフロールのボス名表示処理
___Bank09_WriteEndingBossname:
	lda <zFrameCounter
	and #$03
	bne .rts
	ldx aObjFrame
	lda aObjWait
	tay
	cmp $8AD8,x
	beq .eq
	clc
	adc $8AC8,x
	tax
	mMOV $8AE8,x, aPPULinearData
	inc <zPPULinear
	inc aPPULinearlo
	inc aObjWait
	bne .rts
.eq
	lda aObjFrame
	and #$01
	bne .rts
	inc aObjFrame
	mSTZ aObjWait
	mMOVWB $25CC, aPPULinearhi
.rts
	rts

;8678
;スタッフロールの初期化かな？
___Bank09_InitStaffLine:
	mMOV #$8C, <$DF
	mMOV #$95, <$DE
	rts

;8681
___Bank09_ScrollStaffLine:
	clc
	lda <zVScrolllo
	adc #$78
	sta <zVScrolllo
	lda <zVScroll
	adc #$00
	cmp #$F0
	bcc .changescreen
	lda #$00
.changescreen
	sta <zVScroll
	and #$07
	bne .write_staffroll
	sec
	mMOV <zVScroll, <$01
	jsr Bank09_SetStaffLineAddr
	ldx #$20
	stx <zPPULinear
	dex
	lda #$00
.loop_clear_line
	sta aPPULinearData,x
	dex
	bpl .loop_clear_line
	rts
.write_staffroll
	ldx aObjFrame
	lda <zVScroll
	cmp $8BE0,x
	bne .rts
	lda <zVScroll
	and #$F8
	sta <$01
	jsr Bank09_SetStaffLineAddr
	mMOV $8C1D,x, aPPULinearlo
	mMOV $8C59,x, <zPPULinear
	ldy #$00
	ldx #$00
.loop
	mMOV [$DE],y, aPPULinearData,x
	clc
	lda <$DE
	adc #$01
	sta <$DE
	lda <$DF
	adc #$00
	sta <$DF
	inx
	cpx <zPPULinear
	bne .loop
	inc aObjFrame
.rts
	rts

;86EB
;スタッフロールの書き込み位置指定
Bank09_SetStaffLineAddr:
	mMOV #$20 >> 2, <$00
	lda <$01
	asl a
	rol <$00
	asl a
	rol <$00
	sta aPPULinearlo
	mMOV <$00, aPPULinearhi
	rts

;8700
;武器取得スプライトやエンディングのデータ
Bank09_RockmanSpritePtr_lo:
	.db LOW(Bank09_Sprite00)
	.db LOW(Bank09_Sprite01)
	.db LOW(Bank09_Sprite02)
	.db LOW(Bank09_Sprite03)
	.db LOW(Bank09_Sprite04)
	.db LOW(Bank09_Sprite05)
	.db LOW(Bank09_Sprite06)
	.db LOW(Bank09_Sprite07)
Bank09_RockmanSpritePtr_hi:
	.db HIGH(Bank09_Sprite00)
	.db HIGH(Bank09_Sprite01)
	.db HIGH(Bank09_Sprite02)
	.db HIGH(Bank09_Sprite03)
	.db HIGH(Bank09_Sprite04)
	.db HIGH(Bank09_Sprite05)
	.db HIGH(Bank09_Sprite06)
	.db HIGH(Bank09_Sprite07)

Bank09_Sprite00:
	.db $23
	.db $80, $50, $00, $C0, $80, $51, $00, $C8
	.db $80, $52, $00, $D0, $88, $53, $00, $B8
	.db $88, $54, $00, $C0, $88, $55, $00, $C8
	.db $88, $56, $00, $D0, $90, $57, $00, $B8
	.db $90, $58, $00, $C0, $90, $59, $00, $C8
	.db $90, $5A, $00, $D0, $98, $5B, $00, $B8
	.db $98, $5C, $00, $C0, $98, $5D, $00, $C8
	.db $98, $5E, $00, $D0, $A0, $5F, $00, $B8
	.db $A0, $60, $00, $C0, $A0, $61, $00, $C8
	.db $A0, $62, $00, $D0, $A8, $63, $00, $B8
	.db $A8, $64, $00, $C0, $A8, $65, $00, $C8
	.db $A8, $66, $00, $D0, $B0, $67, $00, $B8
	.db $B0, $68, $00, $C0, $B0, $69, $00, $C8
	.db $B0, $6A, $00, $D0, $B8, $6B, $02, $B8
	.db $B8, $6C, $02, $C0, $B8, $6D, $02, $C8
	.db $B8, $6E, $02, $D0, $89, $A0, $01, $C1
	.db $89, $A0, $41, $C9, $91, $A1, $01, $C1
	.db $91, $A2, $01, $C9
Bank09_Sprite01:
	.db $22
	.db $80, $77, $00, $C0, $80, $78, $00, $C8
	.db $88, $79, $00, $B8, $88, $7A, $00, $C0
	.db $88, $7A, $40, $C8, $88, $79, $40, $D0
	.db $90, $7B, $00, $B8, $90, $7C, $00, $C0
	.db $90, $7C, $40, $C8, $90, $7B, $40, $D0
	.db $98, $7D, $00, $B8, $98, $7E, $00, $C0
	.db $98, $7F, $00, $C8, $98, $7D, $40, $D0
	.db $A0, $83, $00, $B8, $A0, $84, $00, $C0
	.db $A0, $85, $00, $C8, $A0, $83, $40, $D0
	.db $A8, $86, $00, $B8, $A8, $87, $00, $C0
	.db $A8, $88, $00, $C8, $A8, $89, $00, $D0
	.db $B0, $8A, $00, $B8, $B0, $8B, $00, $C0
	.db $B0, $8C, $00, $C8, $B0, $8D, $00, $D0
	.db $B8, $8E, $02, $B8, $B8, $8F, $02, $C0
	.db $B8, $9D, $02, $C8, $B8, $9E, $02, $D0
	.db $88, $A0, $01, $C0, $88, $A0, $41, $C8
	.db $90, $A1, $01, $C0, $90, $A2, $01, $C8
Bank09_Sprite02:
	.db $23
	.db $80, $50, $00, $BE, $80, $51, $00, $C6
	.db $80, $52, $00, $CE, $88, $53, $00, $B6
	.db $88, $54, $00, $BE, $88, $55, $00, $C6
	.db $88, $56, $00, $CE, $90, $5A, $40, $B8
	.db $90, $59, $40, $C0, $90, $58, $40, $C8
	.db $90, $57, $40, $D0, $98, $5E, $40, $B8
	.db $98, $5D, $40, $C0, $98, $5C, $40, $C8
	.db $98, $5B, $40, $D0, $A0, $62, $40, $B8
	.db $A0, $61, $40, $C0, $A0, $60, $40, $C8
	.db $A0, $5F, $40, $D0, $A8, $66, $40, $B8
	.db $A8, $65, $40, $C0, $A8, $64, $40, $C8
	.db $A8, $63, $40, $D0, $B0, $6A, $40, $B8
	.db $B0, $69, $40, $C0, $B0, $68, $40, $C8
	.db $B0, $67, $40, $D0, $B8, $A3, $02, $B8
	.db $B8, $A4, $02, $C0, $B8, $A5, $02, $C8
	.db $B8, $A6, $02, $D0, $89, $A0, $01, $BF
	.db $89, $A0, $41, $C7, $91, $A1, $01, $BF
	.db $91, $A2, $01, $C7
Bank09_Sprite03:
	.db $22
	.db $80, $77, $00, $C0, $80, $78, $00, $C8
	.db $88, $79, $00, $B8, $88, $7A, $00, $C0
	.db $88, $7A, $40, $C8, $88, $79, $40, $D0
	.db $90, $7B, $00, $B8, $90, $7C, $00, $C0
	.db $90, $7C, $40, $C8, $90, $7B, $40, $D0
	.db $98, $7D, $00, $B8, $98, $7F, $40, $C0
	.db $98, $7E, $40, $C8, $98, $7D, $40, $D0
	.db $A0, $83, $00, $B8, $A0, $85, $40, $C0
	.db $A0, $84, $40, $C8, $A0, $83, $40, $D0
	.db $A8, $89, $40, $B8, $A8, $88, $40, $C0
	.db $A8, $87, $40, $C8, $A8, $86, $40, $D0
	.db $B0, $8D, $40, $B8, $B0, $8C, $40, $C0
	.db $B0, $8B, $40, $C8, $B0, $8A, $40, $D0
	.db $B8, $A7, $02, $B8, $B8, $A8, $02, $C0
	.db $B8, $A9, $02, $C8, $B8, $AA, $02, $D0
	.db $88, $A0, $01, $C0, $88, $A0, $41, $C8
	.db $90, $A1, $01, $C0, $90, $A2, $01, $C8
Bank09_Sprite04:
	.db $23
	.db $80, $B5, $00, $C0, $80, $B6, $00, $C8
	.db $80, $B7, $00, $D0, $88, $B8, $00, $B8
	.db $88, $B9, $00, $C0, $88, $BA, $00, $C8
	.db $88, $BB, $00, $D0, $90, $BE, $00, $B8
	.db $90, $BF, $00, $C0, $90, $BC, $00, $C8
	.db $90, $BD, $00, $D0, $98, $CB, $00, $B8
	.db $98, $CC, $00, $C0, $98, $CC, $40, $C8
	.db $98, $CB, $40, $D0, $A0, $CD, $00, $B8
	.db $A0, $CE, $00, $C0, $A0, $CE, $40, $C8
	.db $A0, $CD, $40, $D0, $A8, $CF, $00, $B8
	.db $A8, $D9, $00, $C0, $A8, $D9, $40, $C8
	.db $A8, $CF, $40, $D0, $B0, $DA, $00, $B8
	.db $B0, $DB, $00, $C0, $B0, $DB, $40, $C8
	.db $B0, $DA, $40, $D0, $B8, $DC, $02, $B8
	.db $B8, $DD, $02, $C0, $B8, $DD, $42, $C8
	.db $B8, $DC, $42, $D0, $88, $AB, $01, $BF
	.db $88, $AC, $01, $C7, $90, $AD, $01, $BF
	.db $90, $AE, $01, $C7
Bank09_Sprite05:
	.db $09
	.db $A8, $DE, $00, $B8, $A8, $DF, $00, $C0
	.db $A8, $E0, $00, $C8, $B0, $E1, $00, $B8
	.db $B0, $E2, $00, $C0, $B0, $E3, $00, $C8
	.db $B8, $E4, $02, $B8, $B8, $E5, $02, $C0
	.db $B8, $E6, $02, $C8
Bank09_Sprite06:
	.db $23
	.db $34, $80, $00, $3F, $34, $81, $00, $47
	.db $34, $82, $00, $4F, $3C, $83, $00, $37
	.db $3C, $84, $00, $3F, $3C, $85, $00, $47
	.db $3C, $86, $00, $4F, $44, $B9, $00, $37
	.db $44, $BA, $00, $3F, $44, $89, $00, $47
	.db $44, $BB, $00, $4F, $4C, $9B, $00, $38
	.db $4C, $BC, $00, $40, $4C, $BC, $40, $48
	.db $4C, $9B, $40, $50, $54, $9D, $00, $38
	.db $54, $9E, $00, $40, $54, $9E, $40, $48
	.db $54, $9D, $40, $50, $5C, $9F, $00, $38
	.db $5C, $A9, $00, $40, $5C, $A9, $40, $48
	.db $5C, $9F, $40, $50, $64, $AA, $00, $38
	.db $64, $AB, $00, $40, $64, $AB, $40, $48
	.db $64, $AA, $40, $50, $6C, $AC, $02, $38
	.db $6C, $AD, $02, $40, $6C, $AD, $42, $48
	.db $6C, $AC, $42, $50, $3D, $BD, $01, $40
	.db $3D, $BD, $41, $48, $45, $BE, $01, $40
	.db $45, $BF, $01, $48
Bank09_Sprite07:
	.db $13
	.db $40, $C0, $03, $3B, $40, $C1, $03, $43
	.db $40, $C2, $03, $4B, $48, $C3, $03, $38
	.db $48, $C4, $03, $40, $48, $C5, $03, $48
	.db $48, $C6, $03, $50, $50, $C7, $03, $38
	.db $50, $C8, $03, $40, $50, $C9, $03, $48
	.db $50, $CA, $03, $50, $58, $CB, $03, $38
	.db $58, $CC, $03, $40, $58, $CD, $03, $48
	.db $58, $CE, $03, $50, $41, $CF, $01, $48
	.db $49, $D8, $01, $40, $49, $D9, $01, $48
	.db $49, $DA, $01, $50
