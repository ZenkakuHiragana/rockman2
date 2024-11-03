
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
.5
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
	mMOV Table_AlienBGStarY,x, aObjY10,x
	lda Table_AlienBGStarX,x
	pha
	and #$F0
	ora #$04
	sta aObjX10,x
	pla
	and #$0F
	sta aObjFrame10,x
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
	jsr Alien_SetVelocity
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
	jsr BossBehaviour_FaceTowards
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
;エイリアン速度Y下位
Table_AlienVYlo:
	.db $B9, $19, $00, $E7, $47, $E7, $00, $19
;9CC0
;エイリアン速度Y上位
Table_AlienVY:
	.db $FE, $FF, $00, $00, $01, $00, $00, $FF
;9CC8
;エイリアン速度X下位
Table_AlienVXlo:
	.db $00, $E7, $47, $E7, $00, $E7, $47, $E7
;9CD0
;エイリアン速度X上位
Table_AlienVX:
	.db $00, $00, $01, $00, $00, $00, $01, $00

;9CD8
;エイリアン 速度を決定する
Alien_SetVelocity:
	dec <zBossVar
	bne .reset
	inc aBossVar2
	mMOV #$1C, <zBossVar
.reset
	lda aBossVar2
	pha
	and #$07
	tax
	mMOV Table_AlienVYlo,x, aObjVYlo + 1
	mMOV Table_AlienVY,x, aObjVY + 1
	mMOV Table_AlienVXlo,x, aObjVXlo + 1
	mMOV Table_AlienVX,x, aObjVX + 1
	ldx #%10000011
	pla
	and #$08
	beq .isleft
	ldx #%11000011
.isleft
	stx aObjFlags + 1
	rts

;9D0F
;3, エイリアン 倒された時
Alien_Defeated:
	ldx aObjVar + 1
	bne .init
	mMOVW $1000 - $40, aPPULinearlo, aPPULinearhi
	mMOVW Graphics_Dogeza, aBossPtrlo, aBossPtrhi
	mMOV #$40, <zBossVar
	inc aObjVar + 1
	inx
	mPLAYTRACK #$FF
	lsr aObjFlags + 1
.init
	dex
	mMOV Table_AlienBehaviourhi + 3,x, <zPtrhi
	mMOV Table_AlienBehaviourlo + 3,x, <zPtrlo
	jmp [zPtr]

;9D46
;エイリアンが倒された時にバシバシ鳴らしながら画面を点滅させる
Alien_DeathFlashScreen:
	lda <zFrameCounter
	and #$0F
	bne .playtrack
	mPLAYTRACK #$2B
.playtrack
	ldx #$10
	ldy #$0F
	lda <zFrameCounter
	and #$04
	bne .flashscreen
	ldy #$30
.flashscreen
	tya
.loop
	sta aPalette,x
	dex
	bpl .loop
	rts

;9D65
;4, エイリアン 倒されて点滅中に土下座部屋画像読み込み
Alien4:
	jsr Alien_DeathFlashScreen
	lda <zBossVar
	beq .end
	lda #$08
	dec <zBossVar
	jmp LoadBossBG
.end
	inc aObjVar + 1
	ldy #$0B
	jmp SetupEnemySpritesAnyBank

;9D80
;5, エイリアン
Alien5:
	jsr Alien_DeathFlashScreen
	lda <zPPUObjNum
	ora <zPPUObjlo
	beq .skip
	rts
.skip
	inc aObjVar + 1
	mMOV #$20, <$FD
	bne Alien6_Merge

;9DA2
;6, エイリアン
Alien6:
	jsr Alien_DeathFlashScreen
	lda <$FD
	beq Alien6_FinishedWriting
;9DAC
Alien6_Merge:
	dec <zStage ;zStage = #$0C
	lda #$42
	jsr WriteMapAddress18
	inc <zStage ;zStage = #$0D
	dec <$FD
	rts
;9DC7
;ネームテーブル書き込み終了
Alien6_FinishedWriting:
	inc aObjVar + 1
	inc <zRoom
	inc aObjRoom
	inc aObjRoom + 1
	mSTZ <zHScrollApparenthi, <zRoomApparent
	ldx #$10
.loop
	mMOV Table_AlienDogezaRoomPalette,x, aPalette,x
	dex
	bpl .loop
;博士生成
	ldy #$10
	ldx #$0E
	jsr CreateWeaponObject
	mMOV #%10000000, aObjFlags + $0E
	mMOV #$A7, aObjY + $0E
	mMOV #$E0, aObjX + $0E
;プラネタリウム生成
	ldy #$11
	ldx #$0D
	jsr CreateWeaponObject
	mMOV #$80, aObjX + $0D
	mMOV #$37, aObjY + $0D
;エイリアンだったものの位置指定
	mMOV #%10000000, aObjFlags + 1
	mMOV #$80, aObjY + 1
	mMOV #$D8, aObjX + 1
	mMOV #$0E, <zBossVar
	mSTZ aBossVar2, aBossVar3
	lda #$78
	jsr SetBossAnimation
	mPLAYTRACK #$2A, 1

;9E30
;土下座部屋の色
Table_AlienDogezaRoomPalette
	.db $0F, $20, $11, $01
	.db $0F, $20, $2C, $1C
	.db $0F, $20, $23, $13
	.db $0F, $20, $0F, $0F
	.db $0F;背景色

;9E41
;7, エイリアン
Alien7:
	jsr Alien7_Blink
	lda aBossVar2
	cmp #$24
	beq .1
	jsr Alien_SetVelocity
	stx <$03
	mJSR_NORTS BossBehaviour_Move_NoCollide
.1
	mMOV #%10000100, aObjFlags + 1
	mSTZ <zBossVar, aObjVX + 1, aObjVXlo + 1, aObjVY + 1, aObjVYlo + 1
	inc aObjVar + 1
	rts

;9E6D
;エイリアンの土下座直前の処理の一部
Alien7_Blink:
	ldx #$2C
	lda <zFrameCounter
	and #$04
	bne .skip
	ldx #$00
.skip
	stx aPaletteSpr + $0A
	rts

;9E7B
;土下座直前のプラネタリウム発光のアニメーション
Table_Alien_DogezaPlanetariumPaletteAnimation:
	.db $0F, $20, $0F, $0F
	.db $0F, $20, $0C, $0F
	.db $0F, $20, $1C, $0C
	.db $0F, $20, $11, $0C
	.db $0F, $20, $11, $01

;9E8F
;8, エイリアン ビーコンがぐるぐる → 落下
Alien8:
	jsr Alien7_Blink
	mMOV #%10000000, <$03
	jsr BossBehaviour_Move_NoCollide
	mMOV #$04, <$01, <$02
	jsr BossBehaviour_WallCollisionY
	lda <$00
	beq .rts
	ldx <zBossVar
	cpx #$02
	beq .onland
	mMOV Table_AlienBounceVelocitylo,x, aObjVYlo + 1
	mMOV Table_AlienBounceVelocityhi,x, aObjVY + 1
	inc <zBossVar
.rts
	rts
;9EBB
;ビーコン落下、着地後
.onland
	lsr aObjFlags + $0E
	lda #$79
	jsr SetBossAnimation
	mMOV #$A7, aObjY + 1
	mMOV #$E0, aObjX + 1
	mMOV #$3E, <zBossVar
	mSTZ aBossVar1
	inc aObjVar + 1
	lsr aObjFlags + $0D
	ldx #$0F
.loop
	lsr aObjFlags10,x
	dex
	bpl .loop
	mMOV #$30, aPaletteSpr + $0E
	mMOV #$15, aPaletteSpr + $0F
	rts

;9EEF
;エイリアンだったものが跳ねる速度下位
Table_AlienBounceVelocitylo:
	.db $76, $00
;9EF1
;エイリアンだったものが跳ねる速度上位
Table_AlienBounceVelocityhi:
	.db $03, $02

;9EF3
;9, エイリアン 土下座直前のバシバシ
Alien9:
	lda <zBossVar
	beq .1
	lda <zFrameCounter
	and #$07
	bne .playtrack
	mPLAYTRACK #$2B
.playtrack
	ldx #$0F
	lda <zFrameCounter
	and #$04
	bne .flashscreen
	ldx #$30
.flashscreen
	stx aPaletteSpr
	dec <zBossVar
	rts
.1
	mMOV #$0F, aPaletteSpr
	inc aBossVar1
	lda aBossVar1
	cmp #$41
	beq .start_dogeza
	lsr a
	lsr a
	and #$1C
	tax
	ldy #$00
.loop
	mMOV Table_Alien_DogezaPlanetariumPaletteAnimation,x, aPalette + $0C,y
	inx
	iny
	cpy #$04
	bne .loop
	rts
;9F35
;土下座速度指定
.start_dogeza
	inc aObjVar + 1
	lda #$7A
	jsr SetBossAnimation
	mMOV #%10000100, aObjFlags + 1
	mMOV #$50, aObjVXlo + 1
	mMOV #$00, aObjVX + 1
	mMOV #$53, aObjVYlo + 1
	mMOV #$06, aObjVY + 1
	rts

;9F57
;A, エイリアン
AlienA:
	mMOV #%10000100, <$03
	jsr BossBehaviour_Move_NoCollide
	mMOV #$0C, <$01, <$02
	jsr BossBehaviour_WallCollisionY
	lda <$00
	bne .dogeza
	rts
;着地 → 土下座アニメーション開始
.dogeza
	lda aObjFlags
	and #%10111111
	ldx aObjX
	cpx #$B0
	bcs .isleft
	ora #%01000000
.isleft
	sta aObjFlags
	lda #$7B
	jsr SetBossAnimation
	inc aObjVar + 1
	mMOV #$FD, aBossVar1
	mMOV #$80, aBossVar2
	mMOV #$02, aBossVar3
	mPLAYTRACK #$16, 1

;9F9A
;B, エイリアン
AlienB:
	jsr BossBehaviour_FaceTowards
	lda aBossVar1
	beq .1
	dec aBossVar1
	rts
.1
	mSTZ aObjFrame + 1, aObjWait + 1
	dec aBossVar2
	bne .rts
	dec aBossVar3
	bne .rts
	mMOV #$FF, <zBossBehaviour
.rts
	rts

;9FBD
;エイリアン行動アドレス下位
Table_AlienBehaviourlo:
	.db LOW(Alien1)
	.db LOW(Alien2)
	.db LOW(Alien_Defeated)
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
	.db HIGH(Alien_Defeated)
	.db HIGH(Alien4)
	.db HIGH(Alien5)
	.db HIGH(Alien6)
	.db HIGH(Alien7)
	.db HIGH(Alien8)
	.db HIGH(Alien9)
	.db HIGH(AlienA)
	.db HIGH(AlienB)
