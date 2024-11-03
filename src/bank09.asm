;24000-27FFF

;8000-85FF: Stage Graphics(General)

	mBEGIN $09, $9000
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
	mMOV Bank09_RockmanSpritePtr_lo,y, <zPtrlo
	mMOV Bank09_RockmanSpritePtr_hi,y, <zPtrhi
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

Bank09_Sprite00: ;しっかり踏み出す方・向かって右足が前
	.db $23
	.db $80, $21, $00, $C0, $80, $22, $00, $C8, $80, $23, $00, $D0
	.db $88, $30, $00, $B8, $88, $31, $00, $C0, $88, $32, $00, $C8, $88, $33, $00, $D0
	.db $90, $40, $00, $B8, $90, $41, $00, $C0, $90, $42, $00, $C8, $90, $43, $00, $D0
	.db $98, $50, $00, $B8, $98, $51, $00, $C0, $98, $52, $00, $C8, $98, $53, $00, $D0
	.db $A0, $60, $00, $B8, $A0, $61, $00, $C0, $A0, $62, $00, $C8, $A0, $63, $00, $D0
	.db $A8, $70, $00, $B8, $A8, $71, $00, $C0, $A8, $72, $00, $C8, $A8, $73, $00, $D0
	.db $B0, $80, $00, $B8, $B0, $81, $00, $C0, $B0, $82, $00, $C8, $B0, $83, $00, $D0
	.db $B8, $90, $02, $B8, $B8, $91, $02, $C0, $B8, $92, $02, $C8, $B8, $93, $02, $D0
	.db $89, $20, $01, $C1, $89, $20, $41, $C9, $91, $9A, $01, $C1, $91, $9B, $01, $C9
Bank09_Sprite01: ;中途半端な方・向かって左足が前
	.db $22
	.db $80, $24, $00, $C0, $80, $25, $00, $C8
	.db $88, $34, $00, $B8, $88, $35, $00, $C0, $88, $35, $40, $C8, $88, $34, $40, $D0
	.db $90, $44, $00, $B8, $90, $45, $00, $C0, $90, $45, $40, $C8, $90, $44, $40, $D0
	.db $98, $54, $00, $B8, $98, $55, $00, $C0, $98, $56, $00, $C8, $98, $54, $40, $D0
	.db $A0, $64, $00, $B8, $A0, $65, $00, $C0, $A0, $66, $00, $C8, $A0, $64, $40, $D0
	.db $A8, $74, $00, $B8, $A8, $75, $00, $C0, $A8, $76, $00, $C8, $A8, $77, $00, $D0
	.db $B0, $84, $00, $B8, $B0, $85, $00, $C0, $B0, $86, $00, $C8, $B0, $87, $00, $D0
	.db $B8, $94, $02, $B8, $B8, $95, $02, $C0, $B8, $96, $02, $C8, $B8, $97, $02, $D0
	.db $88, $20, $01, $C0, $88, $20, $41, $C8, $90, $9A, $01, $C0, $90, $9B, $01, $C8
Bank09_Sprite02: ;しっかり踏み出す方・向かって左足が前
	.db $23
	.db $80, $21, $00, $BE, $80, $22, $00, $C6, $80, $23, $00, $CE
	.db $88, $30, $00, $B6, $88, $31, $00, $BE, $88, $32, $00, $C6, $88, $33, $00, $CE
	.db $90, $43, $40, $B8, $90, $42, $40, $C0, $90, $41, $40, $C8, $90, $40, $40, $D0
	.db $98, $53, $40, $B8, $98, $52, $40, $C0, $98, $51, $40, $C8, $98, $50, $40, $D0
	.db $A0, $63, $40, $B8, $A0, $62, $40, $C0, $A0, $61, $40, $C8, $A0, $60, $40, $D0
	.db $A8, $73, $40, $B8, $A8, $72, $40, $C0, $A8, $71, $40, $C8, $A8, $70, $40, $D0
	.db $B0, $83, $40, $B8, $B0, $82, $40, $C0, $B0, $81, $40, $C8, $B0, $80, $40, $D0
	.db $B8, $A0, $02, $B8, $B8, $A1, $02, $C0, $B8, $A2, $02, $C8, $B8, $A3, $02, $D0
	.db $89, $20, $01, $BF, $89, $20, $41, $C7, $91, $9A, $01, $BF, $91, $9B, $01, $C7
Bank09_Sprite03: ;中途半端な方・向かって右足が前
	.db $22
	.db $80, $24, $00, $C0, $80, $25, $00, $C8
	.db $88, $34, $00, $B8, $88, $35, $00, $C0, $88, $35, $40, $C8, $88, $34, $40, $D0
	.db $90, $44, $00, $B8, $90, $45, $00, $C0, $90, $45, $40, $C8, $90, $44, $40, $D0
	.db $98, $54, $00, $B8, $98, $56, $40, $C0, $98, $55, $40, $C8, $98, $54, $40, $D0
	.db $A0, $64, $00, $B8, $A0, $66, $40, $C0, $A0, $65, $40, $C8, $A0, $64, $40, $D0
	.db $A8, $77, $40, $B8, $A8, $76, $40, $C0, $A8, $75, $40, $C8, $A8, $74, $40, $D0
	.db $B0, $87, $40, $B8, $B0, $86, $40, $C0, $B0, $85, $40, $C8, $B0, $84, $40, $D0
	.db $B8, $A4, $02, $B8, $B8, $A5, $02, $C0, $B8, $A6, $02, $C8, $B8, $A7, $02, $D0
	.db $88, $20, $01, $C0, $88, $20, $41, $C8, $90, $9A, $01, $C0, $90, $9B, $01, $C8
Bank09_Sprite04: ;上を見上げる
	.db $23
	.db $80, $29, $00, $C0, $80, $2A, $00, $C8, $80, $2B, $00, $D0
	.db $88, $38, $00, $B8, $88, $39, $00, $C0, $88, $3A, $00, $C8, $88, $3B, $00, $D0
	.db $90, $48, $00, $B8, $90, $49, $00, $C0, $90, $4A, $00, $C8, $90, $4B, $00, $D0
	.db $98, $58, $00, $B8, $98, $59, $00, $C0, $98, $59, $40, $C8, $98, $58, $40, $D0
	.db $A0, $68, $00, $B8, $A0, $69, $00, $C0, $A0, $69, $40, $C8, $A0, $68, $40, $D0
	.db $A8, $78, $00, $B8, $A8, $79, $00, $C0, $A8, $79, $40, $C8, $A8, $78, $40, $D0
	.db $B0, $88, $00, $B8, $B0, $89, $00, $C0, $B0, $89, $40, $C8, $B0, $88, $40, $D0
	.db $B8, $98, $02, $B8, $B8, $99, $02, $C0, $B8, $99, $42, $C8, $B8, $98, $42, $D0
	.db $88, $7D, $01, $BF, $88, $7E, $01, $C7, $90, $8D, $01, $BF, $90, $8E, $01, $C7
Bank09_Sprite05: ;ヘルメット
	.db $09
	.db $A8, $6A, $00, $B8, $A8, $6B, $00, $C0, $A8, $6C, $00, $C8
	.db $B0, $7A, $00, $B8, $B0, $7B, $00, $C0, $B0, $7C, $00, $C8
	.db $B8, $8A, $02, $B8, $B8, $8B, $02, $C0, $B8, $8C, $02, $C8
Bank09_Sprite06: ;武器取得時のロックマン
	.db $23
	.db $34, $21, $00, $3F, $34, $22, $00, $47, $34, $23, $00, $4F
	.db $3C, $30, $00, $37, $3C, $31, $00, $3F, $3C, $32, $00, $47, $3C, $33, $00, $4F
	.db $44, $36, $00, $37, $44, $37, $00, $3F, $44, $42, $00, $47, $44, $46, $00, $4F
	.db $4C, $58, $00, $38, $4C, $47, $00, $40, $4C, $47, $40, $48, $4C, $58, $40, $50
	.db $54, $68, $00, $38, $54, $69, $00, $40, $54, $69, $40, $48, $54, $68, $40, $50
	.db $5C, $78, $00, $38, $5C, $79, $00, $40, $5C, $79, $40, $48, $5C, $78, $40, $50
	.db $64, $88, $00, $38, $64, $89, $00, $40, $64, $89, $40, $48, $64, $88, $40, $50
	.db $6C, $98, $02, $38, $6C, $99, $02, $40, $6C, $99, $42, $48, $6C, $98, $42, $50
	.db $3D, $20, $01, $40, $3D, $20, $41, $48, $45, $9A, $01, $40, $45, $9B, $01, $48
Bank09_Sprite07: ;アイテム入手時のライト博士
	.db $13
	.db $40, $2D, $03, $3B, $40, $2E, $03, $43, $40, $2F, $03, $4B
	.db $48, $3C, $03, $38, $48, $3D, $03, $40
	.db $48, $3E, $03, $48, $48, $3F, $03, $50
	.db $50, $4C, $03, $38, $50, $4D, $03, $40
	.db $50, $4E, $03, $48, $50, $4F, $03, $50
	.db $58, $5C, $03, $38, $58, $5D, $03, $40
	.db $58, $5E, $03, $48, $58, $5F, $03, $50

	.db $41, $1F, $01, $48
	.db $49, $6D, $01, $40, $49, $6E, $01, $48, $49, $6F, $01, $50

Table_ProbablyStaffRollText:
	.incbin "rockman2.prg", $24AC8, $4D8
