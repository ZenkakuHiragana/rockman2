
;9B2A
;エイリアン
Alien:
	dex
	mMOV Table_AlienBehaviourlo,x, <zPtrlo
	mMOV Table_AlienBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;9B38
;1, エイリアン 登場時
Alien1:
	lda aObjVar + 1
	bne .1
;UFO生成
	ldy #$0F
	ldx #$0E
	jsr CreateWeaponObject
	mMOV #$08, aObjY + $0E
	mMOV #$B4, aObjX + $0E
	mMOV #$7D, <zBossVar
	mSTZ aPaletteAnim, aPaletteAnimWait
	inc aObjVar + 1
.1
	lda aObjVar + 1
	cmp #$02
	bcs .3
	lda aObjFlags + $0E
	bpl .2
	lda aObjY + $0E
	cmp #$90
	bcc .rts
	ldx #%10000011
	stx aObjFlags + 1
	cmp #$E0
	bcc .rts
	lsr aObjFlags + $0E
.rts
	rts
.2
	dec <zBossVar
	bne .rts
	ldx #$02
.loop_palette1
	mMOV Table_AlienPalette,x, aPaletteSpr + 9,x
	dex
	bpl .loop_palette1
	inc aObjVar + 1
	lda #$76
	mJSRJMP SetBossAnimation
	.ifndef ___NORTS
.rts2
	rts
	.endif
.3
	bne .4
	lda aObjFrame + 1
	cmp #$03
	.ifndef ___NORTS
	bne .rts2
	.else
	bne .rts
	.endif
	mSTZ aObjWait + 1
	ldx #$0A
	lda <zBossVar
	cmp #$7D
	bcc .12
	ldx #$12
.12
	lda <zBossVar
	and #$04
	beq .skip
	txa
	clc
	adc #$08
	tax
.skip
	ldy #$07
.loop_palette2
	mMOV Table_AlienPalette,x, aPaletteSpr + 8,y
	dex
	dey
	bpl .loop_palette2
	inc <zBossVar
	lda <zBossVar
	cmp #$FD
	.ifndef ___NORTS
	bne .rts3
	.else
	bne .rts
	.endif
	inc aObjVar + 1
	lda #$77
	mJSRJMP SetBossAnimation
	.ifndef ___NORTS
.rts3
	rts
	.endif
.4 ;横に動きつつ体力チャージ
	lda aObjX + 1
	cmp #$D8
	beq .5
	clc
	lda aObjXlo + 1
	adc #$80
	sta aObjXlo + 1
	lda aObjX + 1
	adc #$00
	sta aObjX + 1
	jsr BossBehaviour_ChargeLifeWily
	lda aObjLife + 1
	cmp #$1C
	.ifndef ___NORTS
	bne .rts3
	.else
	bne .rts
	.endif
;体力ため終わり
	inc <zBossBehaviour
	mMOV #$0E, <zBossVar
	mMOV #$3E, aBossVar1
	mSTZ aBossVar2
	mMOV #$30, aPalette + 9
	mMOV #$01, <zObjIndex
	ldx #$0C
.loop_star
	stx <$02
	lda #$70
	jsr BossBehaviour_SpawnEnemy_Specified
	ldx <$02
	mMOV Table_AlienBGStarY,x, aObjY10,y
	lda Table_AlienBGStarX,x
	pha
	and #$F0
	ora #$04
	sta aObjX10,x
	pla
	and #$0F
	sta aObjFrame + 1,x
	dex
	bpl .loop_star
	rts

;9C36
;エイリアン戦 背景の白玉Y位置
Table_AlienBGStarY:
	.db $34, $34, $64, $94, $B4, $D4, $24, $44
	.db $54, $74, $84, $B4, $C4
;9C43
;エイリアン戦 背景の白玉X位置, 画像番号
Table_AlienBGStarX:
	.db $20, $B0, $D0, $70, $40, $F0, $D1, $51
	.db $01, $A1, $31, $E1, $11

;9C50
;エイリアンパレット
Table_AlienPalette:
	.db $30, $38, $16
	.db $0F, $16, $30
	.db $30, $0F, $16
	.db $38, $38, $0F
	.db $16, $38, $29
	.db $0F, $16, $38
	.db $29, $0F, $16
	.db $29, $19, $0F
	.db $16, $29, $19

;9C6B
;2, エイリアン 
Alien2:
	jsr $9CD8
	jsr BossBehaviour_MoveAndCollide
	ldx #$0F
	lda <$02
	cmp #$01
	bne .write_palette
	lda aBossDeath
	beq .write_white
	mSTZ aObjVar + 1
	inc <zBossBehaviour
	rts
.write_white
	ldx #$30
.write_palette
	stx aPaletteSpr
	clc
	lda <zHScrollApparentlo
	adc #$60
	sta <zHScrollApparentlo
	lda <zHScrollApparenthi
	adc #$01
	sta <zHScrollApparenthi
	lda <zRoomApparent
	adc #$00
	sta <zRoomApparent
	jsr BossBehaviour_MoveTowards
	dec aBossVar1
	bne .rts
	mMOV #$3E, aBossVar1
	lda #$6F
	jsr BossBehaviour_SpawnEnemy
	bcs .rts
	lda #$04
	mJSRJMP WilyBoss_AlienInterrupt
.rts
	rts

;9CB8
;

	

;9CD8
;エイリアン 何か

	

;9FBD
;エイリアン行動アドレス下位
Table_AlienBehaviourlo:
	.db LOW(Alien1)
	.db LOW(Alien2)
	.db LOW(Alien3)
	.db LOW(Alien4)
	.db LOW(Alien5)
	.db LOW(Alien6)
	.db LOW(Alien7)
	.db LOW(Alien8)
	.db LOW(Alien9)
	.db LOW(AlienA)
	.db LOW(AlienB)

;9FC8
;エイリアン行動アドレス上位
Table_AlienBehaviourhi:
	.db HIGH(Alien1)
	.db HIGH(Alien2)
	.db HIGH(Alien3)
	.db HIGH(Alien4)
	.db HIGH(Alien5)
	.db HIGH(Alien6)
	.db HIGH(Alien7)
	.db HIGH(Alien8)
	.db HIGH(Alien9)
	.db HIGH(AlienA)
	.db HIGH(AlienB)
