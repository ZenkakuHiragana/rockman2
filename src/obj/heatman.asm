
;80C5
;ヒートマンの処理
Heatman:
	dex
	mMOV Table_HeatmanBehaviourlo,x, <zPtrlo
	mMOV Table_HeatmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]
;80D3
;8ボス入場処理
BossBehaviour_Spawn:
.dx = $01
.dy = $02
	lda aObjVar + 1
	bne .do_land
	ldy <zBossType
	mMOV Table_SpawnBossTerraindx,y, <.dx
	mMOV Table_SpawnBossTerraindy,y, <.dy
	jsr BossBehaviour_WallCollisionY
	lda <$00
	bne .land
	mSTZ aObjFrame + 1, aObjWait + 1
.move
	mJSR_NORTS BossBehaviour_Move
.land
	mSTZ aObjVY + 1, aObjVYlo + 1
	inc aObjVar + 1
.do_land
	lda aObjFrame + 1
	ldy <zBossType
	cmp Table_SpawnBossAnimationLength,y
	bne .move
	sta aObjFrame + 1
	mSTZ aObjWait + 1
	lda aObjLife + 1
	cmp #$1C
	bne BossBehaviour_ChargeLife
BossBehaviour_MaxLife:
	mMOV #$02, <zBossBehaviour
	mSTZ <zBossVar, aObjVar + 1
	ldy <zBossType
	lda Table_SpawnBossAnimationInit,y
	mJSR_NORTS SetBossAnimation
BossBehaviour_ChargeLife:
	lda <zFrameCounter
	and #$03
	bne BossBehaviour_SpawnRTS
	inc aObjLife + 1
	lda #$28
	mJSRJMP PlayTrack
BossBehaviour_SpawnRTS:
	rts

;813E
;ボスごとの地形判定範囲dx
Table_SpawnBossTerraindx:
	.db $09, $0C, $0F, $0A, $09, $09, $08, $08
;8146
;ボスごとの地形判定範囲dy
Table_SpawnBossTerraindy:
	.db $0C, $10, $10, $0C, $0C, $0C, $0C, $0C
;814E
;ボスの登場アニメーション終端位置
Table_SpawnBossAnimationLength:
	.db $0F, $0F, $0B, $05, $09, $07, $05, $03
;8156
;登場シーン終了後のアニメーション番号
Table_SpawnBossAnimationInit:
	.db $51, $67, $6D, $61, $55, $5C, $64, $6A

;815E
;2, ヒートマンが火の玉を投擲する
Heatman2:
	lda #$58
	jsr BossBehaviour_CheckExistence
	bcs .exist
	lda aObjFrame + 1
	bne Heatman_Move
	sta aObjWait + 1
	beq Heatman_Move
.exist
	lda aObjWait + 1
	bne Heatman_Move
	lda aObjFrame + 1
	cmp #$02
	bne Heatman_Move
	jsr BossBehaviour_FaceTowards
	mMOV <$00, <$03
	clc
	adc #$20
	sta <$02
	sec
	sbc #$40
	bcs .borrow_x
	lda #$00
.borrow_x
	sta <$04
	mMOV #$02, <$01
.loop
	ldx <$01
	mSTZ <$0A, <$0C
	mMOV <$02,x, <$0B
	lda HeatmanBallVX,x
	sta <$0D
	jsr Divide
	ldx #$01
	lda #$58
	jsr BossBehaviour_SpawnEnemy
	ldx <$01
	mMOV HeatmanBallVYlo,x, aObjVYlo10,y
	mMOV HeatmanBallVYhi,x, aObjVY10,y
	mMOV <$0E, aObjVXlo10,y
	mMOV <$0F, aObjVX10,y
	lda aObjFlags10,y
	ora #%00000100
	sta aObjFlags10,y
	dec <$01
	bpl .loop
;81D3
Heatman_Move:
	ldx #$01
	jsr BossBehaviour_MoveAndCollide
	lda <$02
	cmp #$01
	bne .rts
	.ifndef ___OPTIMIZE
	bne .rts
	.endif
	mMOV #$04, <zBossBehaviour
	mMOV #$12, aBossInvincible
	lda #$53
	mJSRJMP SetBossAnimation
.rts
	rts
;81EF
;なんでしょこれ
.unknown
	.db $0F, $15, $0F, $0F, $0F
;81F4
;火の玉縦速度下位
HeatmanBallVYlo:
	.db $36, $A8, $76
;81F7
;火の玉縦速度上位
HeatmanBallVYhi:
	.db $07, $05, $03
;81FA
;火の玉の横速度を決定する定数
HeatmanBallVX:
	.db $3A, $2E, $1C

;81FD
;3, ヒートマンが体当たり
Heatman3:
	lda aObjVar + 1
	bne .1
;0 待機 → 突進姿勢
	lda aObjFrame + 1
	cmp #$02
	bne .skip0
	mSTZ aObjFrame + 1
.skip0
	dec <zBossVar
	bne Heatman_Move
	mMOV #$03, aObjFrame + 1
	mSTZ aObjWait + 1
	mMOV #$11, aObjCollision + 1
	jsr BossBehaviour_FaceTowards
	lda <$00
	lsr a
	lsr a
	clc
	adc #$0A
	sta <zBossVar
	mPLAYTRACK #$38
	inc aObjVar + 1
	bne Heatman_Move
;突進アニメーション → 速度指定 → 停止
.1
	cmp #$01
	bne .2
	lda aObjFrame + 1
	cmp #$06
	bcc .skip1
	ldy #$04
	sty aObjVX + 1
.skip1
	cmp #$09
	bne .skip12
	lda #$06
	sta aObjFrame + 1
.skip12
	lda <zBossVar
	beq .skip13
	dec <zBossVar
	bne .done
.skip13
	mSTZ aObjVX + 1, aObjWait + 1
	mMOV #$01, aObjCollision + 1
	mMOV #$0A, aObjFrame + 1
	inc aObjVar + 1
	bne .done
;停止 → 立ち姿勢
.2
	lda aObjFrame + 1
	cmp #$0D
	bne .done
	lda #$50
	jsr SetBossAnimation
	mMOV #%10000011, aObjFlags + 1
	jsr BossBehaviour_FaceTowards
	inc aObjFrame,x
	mMOV #$05, <zBossBehaviour
.done
	jmp Heatman_Move

;828D
;体当たり待機時間
Table_HeatmanChargeWait:
	.db $1F, $3E, $5D

;8290
;4, ヒートマンの突進準備
Heatman4:
	lda aObjFrame + 1
	beq .end
	dec <zBossBehaviour
	lda #%10001011
	ldx aObjX + 1
	cpx #$80
	bcs .left
	lda #%11001011
.left
	sta aObjFlags + 1
	mSTZ aObjVar + 1, <zBossVar2
	mMOV <zRand, <$01
	mMOV #$03, <$02
	jsr Divide8
	ldx <$04
	mMOV Table_HeatmanChargeWait,x, <zBossVar
	lda #$52
	jsr SetBossAnimation
	mPLAYTRACK #$38
.end
	mJSR_NORTS BossBehaviour_Move

;82CC
;5, 体当たりから戻る
Heatman5:
	lda aObjFrame + 1
	cmp #$04
	beq .jmp
	jmp Heatman_Move
.jmp
	jmp BossBehaviour_MaxLife

;82D9
;ヒートマン行動アドレス下位
Table_HeatmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Heatman2)
	.db LOW(Heatman3)
	.db LOW(Heatman4)
	.db LOW(Heatman5)
;82DE
;ヒートマン行動アドレス上位
Table_HeatmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Heatman2)
	.db HIGH(Heatman3)
	.db HIGH(Heatman4)
	.db HIGH(Heatman5)

