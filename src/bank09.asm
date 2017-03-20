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
