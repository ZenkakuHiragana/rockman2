
;8CC3
;メカドラゴン
MechDragon:
	dex
	mMOV Table_MechDragonBehaviourlo,x, <zPtrlo
	mMOV Table_MechDragonBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8E1E
;1, メカドラゴン 背景部分書き込み
MechDragon1:
	lda aObjVar + 1
	bne .1
	lda #$09
	jsr LoadBossBG
	inc <zBossVar
	lda <zBossVar
	cmp #$40
	beq .end_0
	rts
.end_0
	inc aObjVar + 1
	mSTZ <zBossVar
	mMOV #$80, aBossVar1
	rts
.1
	cmp #$01
	bne .2
	ldx <zBossVar
	mMOV Table_MechDragonNTAddrhi,x, aPPULinearhi
	mMOV Table_MechDragonNTAddrlo,x, aPPULinearlo
	mMOV Table_MechDragonNTSize,x, <zPPULinear, <$00
	ldy #$00
.loop_nt
	mMOV aBossVar1, aPPULinearData,y
	iny
	inc aBossVar1
	dec <$00
	bne .loop_nt
	inx
	stx <zBossVar
	cpx #$0F
	bne .rts
	inc aObjVar + 1
	mSTZ <zBossVar
	rts
.2
	cmp #$02
	bne .3
	ldx <zBossVar
	cpx #$10
	beq .2_1
	mMOV #$23, aPPULinearhi
	txa
	asl a
	adc #$D0
	sta aPPULinearlo
	ldy #$00
.loop_attr
	mMOV Table_MechDragonAttr,x, aPPULinearData,y
	inx
	iny
	cpy #$04
	bne .loop_attr
	sty <zPPULinear
	stx <zBossVar
	rts
.2_1
	inc aObjVar + 1
	mMOV #$23, aPPULinearhi
	mMOV #$E0, aPPULinearlo
	mMOV #$1E, <zBossVar
.3
	lda #$00
	ldx #$1F
.loop_clear_attr
	sta aPPULinearData,x
	dex
	bpl .loop_clear_attr
	clc
	lda #$20
	sta <zPPULinear
	adc aPPULinearlo
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	dec <zBossVar
	bne .rts
	inc <zBossBehaviour
	mSTZ aObjVar + 1
.rts
	rts

;8ED9
;メカドラゴンネームテーブル書き込み位置上位
Table_MechDragonNTAddrhi:
	.db $21, $21, $21, $21, $21, $21, $21, $22
	.db $22, $22, $22, $22, $22, $22, $22

;8EE8
;メカドラゴンネームテーブル書き込み位置下位
Table_MechDragonNTAddrlo:
	.db $4B, $69, $87, $A6, $C5, $E5, $EE, $04
	.db $24, $44, $64, $84, $A4, $C5, $E6

;8EF7
;メカドラゴンネームテーブル書き込みサイズ
Table_MechDragonNTSize:
	.db $03, $06, $08, $0A, $0B, $05, $02, $07
	.db $07, $08, $08, $08, $08, $07, $03

;8F06
;メカドラゴン属性テーブル
Table_MechDragonAttr:
	.db $FF, $FF, $FF, $FF
	.db $FF, $5F, $FF, $F3
	.db $FF, $55, $7F, $FF
	.db $FF, $FF, $FF, $FF

;8F16
;2, メカドラゴン 登場する
MechDragon2:
	lda aObjVar + 1
	bne .1
	lda #$67
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	mMOV <zRoom, aObjRoom10,y
	mMOV #$30, aObjX10,y
	mMOV #$E0, aObjY10,y
	inc aObjVar + 1
	rts
.1
	cmp #$02
	bcs .do
	rts
.do
	bne .rts
	ldx #$0F
.loop_palette
	mMOV Table_MechDragonPalette,x, aPalette,x
	dex
	bpl .loop_palette
	jsr ___Bank0B_SpawnBoss
	mMOV #$03, <zBossBehaviour
	mMOV #$5D, <zBossVar
	lda #$65
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	mMOV #$40, aObjX10,y
	mMOV #$87, aObjY10,y
	lda #$66
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	mMOV #$38, aObjX10,y
	mMOV #$BF, aObjY10,y
	mPLAYTRACK #$2C
.rts
	rts

;8F7A
;メカドラゴンのパレット
Table_MechDragonPalette:
	.db $0F, $30, $29, $19
	.db $0F, $27, $11, $19
	.db $0F, $11, $29, $19
	.db $0F, $27, $29, $19

;8F8A
;3, メカドラゴン 追いかける
MechDragon3:
	mMOV #$63, <$00
	ldy #$0F ;足場を弾き飛ばすループ
.loop
	jsr BossBehaviour_CheckExistenceSpecified
	bcs .skip
	lda aObjFlags10,y
	and #%00000100
	bne .continue
	lda aObjX10,y
	cmp #$60
	bcs .continue
	mMOV #%11000100, aObjFlags10,y
	lda <zRand
	and #$03
	sta aObjVX10,y
.continue
	dey
	bpl .loop
.skip
	jsr MechDragon_MoveUpDown
	dec <zBossVar
	bne .skip2
	mMOV #$5D, <zBossVar
.skip2
	jsr MechDragon_BodyMoveXY
	lda aObjFrame + 1
	bne .rts
	sta aObjWait + 1
.rts
	rts

;8FC9
;メカドラゴンが上下に揺れる処理
MechDragon_MoveUpDown:
	lda aObjVar + 1
	bne .godown
	lda aObjY + 1
	cmp #$53
	bcc .godown
.goup
	mSTZ aObjVar + 1
	mSTZ aObjVY + 1
	mMOV #$80, aObjVYlo + 1
	rts
.godown
	lda aObjY + 1
	cmp #$73
	bcs .goup
	mMOV #$01, aObjVar + 1
	mMOV #$FF, aObjVY + 1
	mMOV #$80, aObjVYlo + 1
	rts

;8FFC
;4, メカドラゴン 体力を溜める
MechDragon4:
	mMOV #$63, <$00
	ldy #$0F
.loop
	jsr BossBehaviour_CheckExistenceSpecified
	bcs .skip
	lda aObjFlags10,y
	and #%00000100
	bne .continue
	lda aObjX10,y
	cmp #$90
	bcs .continue
	mMOV #%11000100, aObjFlags10,y
.continue
	dey
	bpl .loop
.skip
	jsr MechDragon_MoveUpDown
	jsr MechDragon_BodyMoveXY
	jsr BossBehaviour_ChargeLifeWily
	lda aObjLife + 1
	cmp #$1C
	bne .rts
	mSTZ aObjVar + 1
	inc <zBossBehaviour
.rts
	rts

;9035
;メカドラゴンが火の玉を発射する
MechDragon_Fire:
	mPLAYTRACK #$2C
	mMOV #$01, aObjFrame + 1
	lda #$68
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs WilyBoss_AlienInterrupt_rts
	clc
	lda aObjY10,y
	adc #$10
	sta aObjY10,y
	lda #$02
;9053
;エイリアン戦で割り込まれる
WilyBoss_AlienInterrupt:
	sta <$09
	mSTZ <$08
	tya
	clc
	adc #$10
	tax
	stx <zObjIndex
	mJSRJMP BossBehaviour_SetVelocityAtRockman
WilyBoss_AlienInterrupt_rts:
	rts

;9064
;5, メカドラゴン 向かってくる方
MechDragon5:
	lda aObjVar + 1
	bne .init
	ldy #$A0
	jsr MechDragon_SetMoveVelocity
	inc aObjVar + 1
.init
	jsr MechDragon_CheckAndFire ;火の玉発射
	bcs .fired
	lda aObjX + 1 ;発射しない場合、近づきすぎ検知
	cmp #$A0
	bcc MechDragon_MergeBehaviour
.fired
	mSTZ aObjVar + 1 ;発射した場合、引っ込む
	inc <zBossBehaviour
;9084
;処理がここで合流する
MechDragon_MergeBehaviour:
	lda aObjFrame + 1
	bne .waitanim
	sta aObjWait + 1
.waitanim
	lda aObjVY + 1
	bpl .goup
	lda aObjY + 1
	cmp #$A0
	bcc .skip
	bcs .inv_y
.goup
	lda aObjY + 1
	cmp #$20
	bcs .skip
.inv_y ;Y速度値を反転
	clc
	lda aObjVYlo + 1
	eor #$FF
	adc #$01
	sta aObjVYlo + 1
	lda aObjVY + 1
	eor #$FF
	adc #$00
	sta aObjVY + 1
.skip
	mMOV aBossVar1, aObjFlags + 1
	jsr MechDragon_BodyMoveXY
	mMOV #%10000011, aObjFlags + 1
	rts

;90C5
;メカドラゴンの移動速度を決定する Y = 仮想岩男X位置
MechDragon_SetMoveVelocity:
	mMOVWB $00C4, <$09, <$08
	ldx #$01
	stx <zObjIndex
	lda aObjX
	pha
	sty aObjX
	jsr BossBehaviour_SetVelocityAtRockman
	mMOV #%11000011, aBossVar1
	pla
	sta aObjX
	rts

;90E5
;6, メカドラゴン 引っ込む方
MechDragon6:
	lda aObjVar + 1
	bne .init
	ldy #$58
	jsr MechDragon_SetMoveVelocity
	mMOV #%10000011, aBossVar1
	inc aObjVar + 1
.init
	lda aObjX + 1
	cmp #$58
	beq .reach
	bcs .skip
.reach
	mSTZ aObjVar + 1
	dec <zBossBehaviour
.skip
	jmp MechDragon_MergeBehaviour

;910A
;メカドラゴンが発射可能か調べた上で発射する
MechDragon_CheckAndFire:
	sec
	lda aObjY
	sbc aObjY + 1
	bcs .inv
	eor #$FF
	adc #$01
.inv
	cmp #$04
	bcs .rts
	jsr MechDragon_Fire
	sec
	rts
.rts
	clc
	rts

;9122
;7, メカドラゴン 倒された時
MechDragon_Defeated:
	lda <zBossVar
	bne .1
	mMOV #$0F, aPaletteSpr
	jmp BossBehaviour_DyingAfterSplash
.1
	jsr WilyBoss_Defeated_FlashScreen
	lda <zFrameCounter
	and #$0F
	bne .rts
	ldx #$0F
.loop_palette
	sec
	lda aPalette,x
	sbc #$10
	bpl .black_out
	lda #$0F
.black_out
	sta aPalette,x
	dex
	bpl .loop_palette
	ldx #$07
.loop_palette_spr
	sec
	lda aPaletteSpr + $08,x
	sbc #$10
	bpl .black_out_spr
	lda #$0F
.black_out_spr
	sta aPaletteSpr + $08,x
	dex
	bpl .loop_palette_spr
	dec <zBossVar
	bne .rts
	mMOV #$70, aBossVar1
.rts
	rts

;9165
;メカドラゴンの位置と背景位置を合わせる
MechDragon_BodyMoveXY:
	lda aObjY
	cmp #$B0
	bcc .player_alive
	mSTZ aObjVYlo + 1, aObjVY + 1
.player_alive
	mMOV #$0F, aPaletteSpr
	jsr BossBehaviour_BossTakeDamage
	bcc .boss_alive
;死亡時
	mMOV #$0D, <zBossVar
	mSTZ aObjVYlo + 1, aObjVY + 1, aObjVXlo + 1, aObjVX + 1
	inc aBossDeath
	mMOV #$07, <zBossBehaviour
	bne WilyBoss_MoveWithBG
.boss_alive
;被弾処理
	lda <$02
	cmp #$01
	bne WilyBoss_MoveWithBG
	mMOV #$30, aPaletteSpr
;91A4
;ボス本体と背景を移動する
WilyBoss_MoveWithBG:
	jsr BossBehaviour_Move
	sec
	lda <zVScrollApparentlo
	sbc aObjVYlo + 1
	sta <zVScrollApparentlo
	lda <zVScrollApparenthi
	sbc aObjVY + 1
	sta <zVScrollApparenthi
	beq .skip
	ldy aObjVY + 1
	bpl .goup
	cmp #$10
	bcs .skip
	clc
	adc #$10
	sta <zVScrollApparenthi
	jmp .skip
.goup
	cmp #$11
	bcs .skip
	sec
	sbc #$10
	sta <zVScrollApparenthi
.skip
	lda aObjFlags + 1
	and #%01000000
	beq .goleft
	clc
	lda <zHScrollApparentlo
	adc aObjVXlo + 1
	sta <zHScrollApparentlo
	lda <zHScrollApparenthi
	adc aObjVX + 1
	sta <zHScrollApparenthi
	lda <zRoomApparent
	adc #$00
	sta <zRoomApparent
	rts
.goleft
	sec
	lda <zHScrollApparentlo
	sbc aObjVXlo + 1
	sta <zHScrollApparentlo
	lda <zHScrollApparenthi
	sbc aObjVX + 1
	sta <zHScrollApparenthi
	lda <zRoomApparent
	sbc #$00
	sta <zRoomApparent
	rts

;9205
;メカドラゴン行動アドレス下位
Table_MechDragonBehaviourlo:
	.db LOW(MechDragon1)
	.db LOW(MechDragon2)
	.db LOW(MechDragon3)
	.db LOW(MechDragon4)
	.db LOW(MechDragon5)
	.db LOW(MechDragon6)
	.ifndef ___OPTIMIZE
	.db LOW(MechDragon_Defeated)
	.endif
;920C
;メカドラゴン行動アドレス上位
Table_MechDragonBehaviourhi:
	.db HIGH(MechDragon1)
	.db HIGH(MechDragon2)
	.db HIGH(MechDragon3)
	.db HIGH(MechDragon4)
	.db HIGH(MechDragon5)
	.db HIGH(MechDragon6)
	.ifndef ___OPTIMIZE
	.db HIGH(MechDragon_Defeated)
	.endif
