;2C000-2FFFF

	mBEGIN $0B, $8000

;ボスを出現させる
Bank0B_SpawnBoss:
	jmp ___Bank0B_SpawnBoss
Bank0B_DoBossBehaviour:
	mMOV #$01, <zObjIndex
	ldy <zBossType
	lda <zStopFlag
	and #$01
	beq .do_normal
	lda Table_TimeStopperBossDamageInterval,y
	beq .do_normal
	jmp DoBossBehaviour_Stopping
.do_normal
	ldx <zBossBehaviour
	bpl .isalive
	jmp BossBehaviour_Dying
.isalive
	mMOV Table_BossBehaviourlo,y, <zPtrlo
	mMOV Table_BossBehaviourhi,y, <zPtrhi
	jmp [zPtr]
;802B
;ボス毎のタイムストッパーダメージ間隔
Table_TimeStopperBossDamageInterval:
	.db $0F, $0F, $0F, $0F, $1E, $0F, $0F, $0F
	.db $0F, $0F, $0F, $0F, $0F, $0F
;8039
;ボス毎のタイムストッパーダメージ
Table_TimeStopperBossDamageAmount:
	.db $00, $00, $00, $00, $01, $00, $00, $00
	.db $00, $00, $00, $00, $00, $00
;8047
;ボスの挙動アドレス下位
Table_BossBehaviourlo:
	.db LOW(Heatman)
	.db LOW(Airman)
	.db LOW(Woodman)
	.db LOW(Bubbleman)
	.db LOW(Quickman)
	.db LOW(Flashman)
	.db LOW(Metalman)
	.db LOW(Crashman)
	.db $10, $13, $9B, $6E, $C0, $2A
;8045
;ボスの挙動アドレス上位
Table_BossBehaviourhi:
	.db HIGH(Heatman)
	.db HIGH(Airman)
	.db HIGH(Woodman)
	.db HIGH(Bubbleman)
	.db HIGH(Quickman)
	.db HIGH(Flashman)
	.db HIGH(Metalman)
	.db HIGH(Crashman)
	.db $8E, $92, $93, $96, $96, $9B
;8063
;時間停止中のボスの処理
DoBossBehaviour_Stopping:
	mSTZ aObjWait + 1
	jsr BossBehaviour_RockmanTakeDamage
	lda <zEquipment
	cmp #$06
	bne .rts
	lda aObjFlags + 2
	bpl .rts
	lda <zBossBehaviour
	cmp #$02
	bcc .rts
	lda <zBossType
	cmp #$05
	beq .fillup
	cmp #$0D
	bne .dont_fillup
.fillup ;フラッシュマンとエイリアン相手の時、体力全回復
	mMOV #$1C, aObjLife + 1
	bne .rts
.dont_fillup
	inc aTimeStopper
	ldx <zBossType
	lda aTimeStopper
	cmp Table_TimeStopperBossDamageInterval,x
	bne .rts
	mSTZ aTimeStopper
	lda Table_TimeStopperBossDamageAmount,x
	beq .rts
	sec
	lda aObjLife + 1
	sbc Table_TimeStopperBossDamageAmount,x
	beq .die_boss
	bcs .write_life
.die_boss
	.ifndef ___OPTIMIZE
	lda #$00
	.endif
	lsr aObjFlags + 2
	mSTZ <zStopFlag
	mMOV #$01, <zWindhi
	inc aBossDeath
	lda #$00
.write_life
	sta aObjLife + 1
.rts
	rts

;80C5
;ヒートマンの処理
;Heatman:
	.include "src/obj/heatman.asm"

;82E3
;エアーマン
;Airman:
	.include "src/obj/airman.asm"

;84FB
;ウッドマン
;Woodman:
	.include "src/obj/woodman.asm"

;8655
;バブルマン
;Bubbleman:
	.include "src/obj/bubbleman.asm"

;879E
;クイックマン
;Quickman:
	.include "src/obj/quickman.asm"

;8956
;フラッシュマン
;Flashman:
	.include "src/obj/flashman.asm"

;8B20
;メタルマン
;Metalman:
	.include "src/obj/metalman.asm"

;8CC3
;クラッシュマン
;Crashman:
	.include "src/obj/crashman.asm"

;8E10
;メカドラゴン
;MechDragon:
	.include "src/obj/mechdragon.asm"

;9213
;ピコピコくん
;Pikopiko_kun:
	.include "src/obj/pikopiko_kun.asm"

;939B
;ガッツタンク
;GutsTank:
	.include "src/obj/gutstank.asm"

;966E
;ブービームトラップ
;BooBeamTrap:
	.include "src/obj/boobeamtrap.asm"

;96C0
;ワイリーマシン
;WilyMachine:
	.include "src/obj/wilymachine.asm"

;9B2A
;エイリアン
;Alien:
	.include "src/obj/alien.asm"

BossBehaviour_Dying:
	sec
	lda <zBossType
	sbc #$08
	bcc .8bosses
	tax
	mMOV Table_DyingBossBehaviourlo,x, <zPtrlo
	mMOV Table_DyingBossBehaviourhi,x, <zPtrhi
	jmp [zPtr]
.8bosses
	mSTZ aObjWait + 1
	lda aBossVar1
	cmp #$10
	bcc .wait
	jmp BossBehaviour_DyingAfterSplash
.wait
	and #$01
	bne .skip_spawn
	lda aBossVar1
	and #$07
;A000
	sta <$02
	ldx #$01
.loop_tiwnround
	stx <$01
	lda #$60
	jsr BossBehaviour_SpawnEnemy_Specified
	ldx <$02
	clc
	lda aObjX + 1
	adc Table_TiwnBalldx,x
	sta aObjX10,y
	lda aObjRoom + 1
	adc Table_TiwnBalldr,x
	sta aObjRoom10,y
	clc
	lda aObjY + 1
	adc Table_TiwnBalldy,x
	sta aObjY10,y
	mMOV #$01, aObjFrame10,y
	inx
	stx <$02
	ldx <$01
	dex
	bpl .loop_tiwnround
.skip_spawn
	inc aBossVar1
	lda aBossVar1
	cmp #$10
	bne .rts
	ldx #$1B
	mMOV aObjX + 1, <$08
	mMOV aObjRoom + 1, <$09
	mMOV aObjY + 1, <$0A
	mMOV #$60, <$0B
	jsr SpawnTiwnRound_Specified
	mPLAYTRACK #$41
	mPLAYTRACK #$FF
	lda <zStage
	cmp #$0C
	bne .rts
	lda #$76
	ldx #$0E
	jsr BossBehaviour_SpawnEnemy_Specified
	mMOV #$02, aObjVY10 + $0E
	mMOV #%10000101, aObjFlags10 + $0E
	inc aObjVar10 + $0E
	lda <zBossRushProg
	cmp #$FF
	beq .rts
	lsr aObjFlags + 1
	mSTZ <zBossBehaviour
.rts
	rts
;A08B
BossBehaviour_DyingAfterSplash:
	lsr aObjFlags + 1
	lda aBossVar1
	cmp #$FD
	bcs .clearmusic
	inc aBossVar1
	rts
.clearmusic
	bne .wait
	inc aBossVar1
	lda #$FD
	sta aBossVar2
	mPLAYTRACK #$15, 1
.wait
	cmp #$FE
	bne .skip
	dec aBossVar2
	bne .rts
	inc aBossVar1
	mMOV #$D0, aBossVar2
.skip
	lda aBossVar2
	cmp #$40
	bcc .moveup
	bne .dec
	dec aBossVar2
	mMOV #$26, aObjAnim
	mSTZ aObjFrame, aObjWait
	mMOV #$0B, <zStatus
	mPLAYTRACK #$3A
.moveup
	lda aObjFrame
	cmp #$03
	bne .rts
	lda aObjFlags
	bpl .dec
	sec
	lda aObjY
	sbc #$08
	sta aObjY
	bcs .rts
	lsr aObjFlags
.dec
	dec aBossVar2
	bne .rts
	mMOV #$FF, <zBossBehaviour
.rts
	rts

;A100
;ワイリーステージのボス撃破後の挙動下位
Table_DyingBossBehaviourlo:
	.db LOW(MechDragon_Defeated)
	.db LOW(Pikopiko_kun_Defeated)
	.db LOW(MechDragon_Defeated)
	.db LOW(Pikopiko_kun_Defeated)
	.db LOW(WilyMachine_Defeated)
	.db LOW(Alien_Defeated)
;A106
;ワイリーステージのボス撃破後の挙動上位
Table_DyingBossBehaviourhi:
	.db HIGH(MechDragon_Defeated)
	.db HIGH(Pikopiko_kun_Defeated)
	.db HIGH(MechDragon_Defeated)
	.db HIGH(Pikopiko_kun_Defeated)
	.db HIGH(WilyMachine_Defeated)
	.db HIGH(Alien_Defeated)

;A10C
;ボスのアニメーション番号を設定, フレームカウンタをリセット
SetBossAnimation:
	sta aObjAnim + 1
	mSTZ aObjWait + 1, aObjFrame + 1
SetBossAnimation_RTS:
	rts

;A118
;ワイリーステージのボスの体力を溜める
BossBehaviour_ChargeLifeWily:
	lda <zFrameCounter
	and #$03
	.ifndef ___JSRJMP
		bne .rts
	.else
		bne SetBossAnimation_RTS
	.endif
	lda aObjLife + 1
	cmp #$1C
	.ifndef ___JSRJMP
		beq .rts
	.else
		beq SetBossAnimation_RTS
	.endif
	inc aObjLife + 1
	lda #$28
	mJSRJMP PlayTrack
	.ifndef ___JSRJMP
.rts
	rts
	.endif

;A12E
;向きを一時的に逆にして、後ろ向きに動く
BossBehaviour_MoveBackward:
	lda aObjFlags + 1
	eor #%01000000
	sta aObjFlags + 1
	jsr BossBehaviour_WallCollisionXY
	lda aObjFlags + 1
	sta <$03
	eor #%01000000
	sta aObjFlags + 1
	jmp BossBehaviour_Move_VectorSpecified

;A146
;被弾処理 + 移動処理
BossBehaviour_MoveAndCollide:
	jsr BossBehaviour_BossTakeDamage
	bcc BossBehaviour_Move
	inc aBossDeath
	rts
;A14F
;移動処理
BossBehaviour_Move:
	lda aObjFlags + 1
	sta <$03
;A154
;移動処理(方向指定)
BossBehaviour_Move_VectorSpecified:
	jsr BossBehaviour_RockmanTakeDamage
;A157
;移動処理(当たり判定なし)
BossBehaviour_Move_NoCollide:
	sec
	lda aObjYlo + 1
	sbc aObjVYlo + 1
	sta aObjYlo + 1
	lda aObjY + 1
	sbc aObjVY + 1
	sta aObjY + 1
	cmp #$F0
	bcc .out_y
	lda #$F0
	sta aObjY + 1
.out_y
	lda aObjFlags + 1
	and #%00000100
	beq .nogravity
	clc
	lda aObjVYlo + 1
	sbc <zGravity
	sta aObjVYlo + 1
	lda aObjVY + 1
	sbc <zGravityhi
	sta aObjVY + 1
.nogravity
	lda <$03
	and #$40
	bne .goright
	sec
	lda aObjXlo + 1
	sbc aObjVXlo + 1
	sta aObjXlo + 1
	lda aObjX + 1
	sbc aObjVX + 1
	sta aObjX + 1
	lda aObjRoom + 1
	sbc #$00
	sta aObjRoom + 1
	sec
	lda aObjX + 1
	sbc <zHScroll
	sta <$08
	lda aObjRoom + 1
	sbc <zRoom
	bne .out_x
	lda <$08
	cmp #$08
	bcs .rts
.out_x
	mMOV <zRoom, aObjRoom
	mMOV #$08, aObjX + 1
	bne .rts
	
.goright
	clc
	lda aObjXlo + 1
	adc aObjVXlo + 1
	sta aObjXlo + 1
	lda aObjX + 1
	adc aObjVX + 1
	sta aObjX + 1
	lda aObjRoom + 1
	adc #$00
	sta aObjRoom + 1
	sec
	lda aObjX + 1
	sbc <zHScroll
	sta <$08
	lda aObjRoom + 1
	sbc <zRoom
	bne .out_x_right
	lda <$08
	cmp #$F8
	bcc .rts
.out_x_right
	mMOV <zRoom, aObjRoom + 1
	mMOV #$F8, aObjX + 1
.rts
	clc
	rts

;A209
;ボスがロックマンの方を向く, $00に横距離
BossBehaviour_FaceTowards:
	lda aObjFlags + 1
	and #%10111111
	sta aObjFlags + 1
	sec
	lda aObjX + 1
	sbc aObjX
	sta <$00
	bcs .rts
	lda <$00
	eor #$FF
	adc #$01
	sta <$00
	lda #%01000000
	ora aObjFlags + 1
	sta aObjFlags + 1
.rts
	rts

;A22D
;a = Obj type, Aが存在する時clc
BossBehaviour_CheckExistence:
	sta <$00
	ldy #$0F
;A231
BossBehaviour_CheckExistenceSpecified:
	lda <$00
.loop
	cmp aObjAnim10,y
	beq .next
	dey
	bpl .loop
	sec
	rts
.next
	lda aObjFlags10,y
	bmi .found
	dey
	bpl BossBehaviour_CheckExistenceSpecified
	sec
	rts
.found
	clc
	rts

;A249
;壁判定縦
BossBehaviour_WallCollisionY:
.res = $00
.dx = $01
.dy = $02
.x = $08
.r = $09
.y = $0A
	mSTZ <$0B
	lda aObjVY + 1
	php
	bpl .goup
	clc
	lda aObjY + 1
	adc <.dy
	jmp .write_dy
.goup
	sec
	lda aObjY + 1
	sbc <.dy
.write_dy
	sta <.y
	clc
	lda aObjX + 1
	adc <.dx
	sta <.x
	lda aObjRoom + 1
	adc #$00
	sta <.r
	jsr PickupMap_BossBank
	ldy <.res
	lda Table_BossTerrainBlockFlag,y
	sta <.dy
	sec
	lda aObjX + 1
	sbc <.dx
	sta <.x
	lda aObjRoom + 1
	sbc #$00
	sta <.r
	jsr PickupMap_BossBank
	ldy <.res
	lda Table_BossTerrainBlockFlag,y
	ora <.dy
	sta <.res
	beq .nohit_y
	plp
	bmi .godown
	lda <.y
	and #$0F
	eor #$0F
	sec
	adc aObjY + 1
	jmp .write_hit_y
.godown
	lda aObjY + 1
	pha
	lda <.y
	and #$0F
	sta <.dy
	pla
	sec
	sbc <.dy
.write_hit_y
	sta aObjY + 1
	mSTZ aObjYlo + 1
	lda aObjFlags + 1
	and #%00000100
	beq .rts
	mMOV #$C0, aObjVYlo + 1
	mMOV #$FF, aObjVY + 1
.rts
	rts
.nohit_y
	plp
	rts

;A2D4
;壁判定縦横
BossBehaviour_WallCollisionXY:
.res = $00
.dx = $01
.dy = $02
.tmp = $03
.x = $08
.r = $09
.y = $0A
	lda aObjY + 1
	sta <$0A
	mSTZ <$0B
	lda aObjFlags + 1
	and #%01000000
	php
	beq .goleft
	sec
	lda aObjX + 1
	adc <.dx
	sta <.x
	lda aObjRoom + 1
	adc #$00
	jmp .write_dx
.goleft
	clc
	lda aObjX + 1
	sbc <.dx
	sta <.x
	lda aObjRoom + 1
	sbc #$00
.write_dx
	sta <.r
	jsr PickupMap_BossBank
	ldy <.res
	lda Table_BossTerrainBlockFlag,y
	sta <$03
	beq .nohit_x
	plp
	beq .hitleft
	lda <.x
	and #$0F
	sta <.res
	sec
	lda aObjX + 1
	sbc <.res
	sta aObjX + 1
	lda aObjRoom + 1
	sbc #$00
	sta aObjRoom + 1
	jmp BossBehaviour_WallCollisionY
.hitleft
	lda <.x
	and #$0F
	eor #$0F
	sec
	adc aObjX + 1
	sta aObjX + 1
	lda aObjRoom + 1
	adc #$00
	sta aObjRoom + 1
	jmp BossBehaviour_WallCollisionY
.nohit_x
	plp
	jmp BossBehaviour_WallCollisionY

;A349
;壁フラグ
Table_BossTerrainBlockFlag:
	.db $00, $01, $00, $01, $00, $01, $01, $01, $01

;A352
;敵番号Aを生成
BossBehaviour_SpawnEnemy:
	pha
	jsr GetEnemyPointer
	bcs BossBehaviour_SpawnEnemy_Invalid
	pla
;A359
BossBehaviour_SpawnEnemy_Specified:
	jsr CreateObjectHere
	txa
	tay
	lda aObjFlags + 1
	and #$40
	ora aObjFlags10,y
	sta aObjFlags10,y
	mMOV aObjXlo + 1, aObjXlo10,y
	mMOV aObjX + 1, aObjX10,y
	mMOV aObjRoom + 1, aObjRoom10,y
	mMOV aObjYlo + 1, aObjYlo10,y
	mMOV aObjY + 1, aObjY10,y
	clc
	rts
BossBehaviour_SpawnEnemy_Invalid
	pla
	sec
	rts

;A38C
;オブジェクト位置Xの速度値をロックマンの方へ向ける
BossBehaviour_SetVelocityAtRockman:
	ldy #$40
	sec
	lda aObjX
	sbc aObjX,x
	.ifndef ___OPTIMIZE
	sta <$00
	.endif
	bcs .inv_x
	.ifndef ___OPTIMIZE
	lda <$00
	.endif
	eor #$FF
	adc #$01
	ldy #$00
	.ifndef ___OPTIMIZE
	sta <$00
.inv_x
	.else
.inv_x
	sta <$00
	.endif
;A3A3
BossBehaviour_SetVelocityAtRockman_Writedx:
	lda aObjFlags,x
	and #%10111111
	sta aObjFlags,x
	tya
	ora aObjFlags,x
	sta aObjFlags,x
	
	sec
	lda aObjY
	sbc aObjY,x
	php
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	sta <$01
	cmp <$00
	bcs .sety
;dx > dy
	mMOV <$09, <$0D, aObjVX,x
	mMOV <$08, <$0C, aObjVXlo,x
	
	mMOV <$00, <$0B
	mSTZ <$0A
	jsr Divide
	mMOV <$0F, <$0D
	mMOV <$0E, <$0C
	mMOV <$01, <$0B
	mSTZ <$0A
	jsr Divide
	ldx <zObjIndex
	mMOV <$0F, aObjVY,x
	mMOV <$0E, aObjVYlo,x
	jmp .done
;dy >= dx
.sety
	mMOV <$09, <$0D, aObjVY,x
	mMOV <$08, <$0C, aObjVYlo,x
	mMOV <$01, <$0B
	mSTZ <$0A
	jsr Divide
	mMOV <$0F, <$0D
	mMOV <$0E, <$0C
	mMOV <$00, <$0B
	mSTZ <$0A
	jsr Divide
	ldx <zObjIndex
	mMOV <$0F, aObjVX,x
	mMOV <$0E, aObjVXlo,x

.done
	plp
	bcc .rts
	lda aObjVYlo,x
	eor #$FF
	adc #$01
	sta aObjVYlo,x
	lda aObjVY,x
	eor #$FF
	adc #$00
	sta aObjVY,x
.rts
	rts

;A451
;ボスが出現する
___Bank0B_SpawnBoss:
	ldx <zBossType
	mMOV <zRoom, aObjRoom + 1
	mMOV Table_SpawnBossFlags,x, aObjFlags + 1
	mMOV Table_SpawnBossX,x, aObjX + 1
	mMOV Table_SpawnBossY,x, aObjY + 1
	mMOV Table_SpawnBossAnim,x, aObjAnim + 1
	mMOV Table_SpawnBossCollision,x, aObjCollision + 1
	mMOV Table_SpawnBossVXlo,x, aObjVXlo + 1
	mMOV Table_SpawnBossVXhi,x, aObjVX + 1
	mMOV Table_SpawnBossVYlo,x, aObjVYlo + 1
	mMOV Table_SpawnBossVYhi,x, aObjVY + 1
	lda #$00
	sta aObjYlo + 1
	sta aObjXlo + 1
	sta aObjWait + 1
	sta aObjFrame + 1
	sta aObjVar + 1
	sta aObjLife + 1
	sta aBossInvincible
	sta aBossDeath
	sta <zBossVar
	mMOV #$01, <zBossBehaviour
	rts

;A4AF
;ボス初期状態値
Table_SpawnBossFlags:
	.db $83, $83, $83, $83, $83, $83, $83, $83
	.db $8B, $00, $00, $00, $83, $00
;A4BD
;ボス初期位置X
Table_SpawnBossX:
	.db $C8, $C8, $C8, $C8, $C8, $C8, $C8, $C8
	.db $70, $C8, $FF, $C8, $78, $B4
;A4CB
;ボス初期位置Y
Table_SpawnBossY:
	.db $28, $28, $30, $28, $28, $28, $28, $28
	.db $6B, $10, $4B, $10, $77, $7C
;A4D9
;ボスアニメーション番号初期値
Table_SpawnBossAnim:
	.db $50, $66, $6C, $60, $54, $5A, $63, $69
	.db $70, $50, $71, $50, $72, $75
;A4E7
;ボス判定サイズ初期値
Table_SpawnBossCollision:
	.db $01, $09, $09, $01, $01, $01, $01, $01
	.db $0D, $01, $01, $01, $00, $01
;A4F5
;ボス初期速度Xlo
Table_SpawnBossVXlo:
	.db $00, $00, $00, $00, $00, $00, $00, $00
	.db $00, $00, $60, $00, $C4, $00
;A503
;ボス初期速度Xhi
Table_SpawnBossVXhi:
	.db $00, $00, $00, $00, $00, $00, $00, $00
	.db $00, $00, $00, $00, $00, $00
;A511
;ボス初期速度Ylo
Table_SpawnBossVYlo:
	.db $00, $00, $00, $00, $00, $00, $00, $00
	.db $00, $00, $00, $00, $00, $00
;A51F
;ボス初期速度Yhi
Table_SpawnBossVYhi:
	.db $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
	.db $00, $00, $00, $00, $00, $00

;A52D
;ボスとロックマンの当たり判定処理
BossBehaviour_RockmanTakeDamage:
	mSTZ <$01
	lda <zStatus
	beq .rts
	lda <zNoDamage
	bne .rts
	lda <zOffscreen
	bne .rts
	sec
	lda aObjX
	sbc aObjX + 1
	bcs .inv_x
	eor #$FF
	adc #$01
.inv_x
	ldy aObjCollision + 1
	cmp Table_CollisionSizeX,y
	bcs .rts
	sec
	lda aObjY
	sbc aObjY + 1
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp Table_CollisionSizeY,y
	bcs .rts
	lda <zInvincible
	bne .rts
	ldy <zBossType
	sec
	lda aObjLife
	sbc Table_BossDamageAmount,y
	sta aObjLife
	beq .dead
	bcs .alive
.dead
	mSTZ <zStatus, aObjLife
	jmp DieRockman
.alive
	lda aObjFlags
	and #%10111111
	sta aObjFlags
	lda aObjFlags + 1
	and #%01000000
	eor #%01000000
	ora aObjFlags
	sta aObjFlags
	jsr DamageRockman
	inc <$01
.rts
	rts

;A59D
;ボスの被弾処理
BossBehaviour_BossTakeDamage:
	ldx #$09
	lda <zFrameCounter
	and #$01
	bne .loop
	dex
.loop
	lda aObjFlags,x
	bpl .skip
	and #$01
	beq .skip
	clc
	ldy aWeaponCollision,x
	lda Table_WeaponCollisionOffset,y
	adc aObjCollision + 1
	tay
	sec
	lda aObjX + 1
	sbc aObjCollision,x
	bcs .inv_x
	eor #$FF
	adc #$01
.inv_x
	cmp Table_CollisionSizeX,y
	bcs .skip
	sec
	lda aObjY + 1
	sbc aObjY,x
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp Table_CollisionSizeY,y
	bcc .hit
.skip
	dex
	dex
	cpx #$02
	bcs .loop
	ldx <zObjIndex
	mSTZ <zBossVar2, <$02
.nohit
	clc
	rts
.hit
	lda <zBossVar2
	bne .nohit
	ldy <zEquipment
	mMOV Table_BossTakeDamagelo,y, <zPtrlo
	mMOV Table_BossTakeDamagehi,y, <zPtrhi
	jmp [zPtr]

;A601
;ボスのロックバスターのダメージ処理
BossBehaviour_TakeRockBuster:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	mMOV Table_BossTakeDamageRockBuster,y, <$00
	beq .skip
	php
	lsr aObjFlags,x
	plp
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs .alive
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	lda aObjFlags,x
	eor #%01000000
	and #%11111110
	sta aObjFlags,x
	mMOV #$05, aObjVY,x, aObjVX,x
	mPLAYTRACK #$2D
	mMOV #$02, <$02
.alive
	clc
	rts

;A657
;ボスのアトミックファイヤーのダメージ処理
BossBehaviour_TakeAtomicFire:
	lda <zBossType
	cmp #$00
	bne .do
	jmp BossBehaviour_MaxBossLife
.do
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageAtomicFire,y
	beq .skip
	lda aObjVar,x
	cmp #$02
	bcc .buster
	beq .atomic
	lda Table_BossTakeDamageAtomicFire,y
	bne .write_dmg
.atomic
	clc
	lda Table_BossTakeDamageRockBuster,y
	asl a
	adc Table_BossTakeDamageRockBuster,y
	jmp .write_dmg
.buster
	lda Table_BossTakeDamageRockBuster,y
.write_dmg
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs BossBehaviour_TakeAtomicFireEnd
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	mPLAYTRACK #$2D
	mMOV #$02, <$02
	lsr aObjFlags,x
	jmp BossBehaviour_TakeAtomicFireRTS
BossBehaviour_TakeAtomicFireEnd:
	mSTZ aObjFlags,x
BossBehaviour_TakeAtomicFireRTS:
	clc
	rts

;A6C8
;ボスのエアーシューターのダメージ処理
BossBehaviour_TakeAirShooter:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageAirShooter,y
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs BossBehaviour_TakeAtomicFireEnd
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	mPLAYTRACK #$2D
	mMOV #$02, <$02
	lda aObjFlags,x
	and #%11111110
	sta aObjFlags,x
	mMOV #$3D, aObjAnim,x
	mSTZ aObjFrame,x, aObjWait,x
	clc
	rts

;A71C
;ボスのリーフシールドのダメージ処理
BossBehaviour_TakeLeafShield:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageLeafShield,y
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs BossBehaviour_TakeLeafShieldEnd
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	mPLAYTRACK #$2D
	mMOV #$02, <$02
	lda aObjFlags,x
	and #%11110010
	sta aObjFlags,x
	mMOV #$3B, aObjAnim,x
	mSTZ aObjFrame,x, aObjWait,x, aObjVar,x, aObjLife,x
BossBehaviour_TakeLeafShieldRTS:
	clc
	rts
BossBehaviour_TakeLeafShieldEnd:
	mSTZ aObjFlags,x
	beq BossBehaviour_TakeLeafShieldRTS

;A77D
;ボスのバブルリードのダメージ処理
BossBehaviour_TakeBubbleLead:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageBubbleLead,y
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs BossBehaviour_TakeLeafShieldEnd
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	mSTZ aObjVX,x, aObjVXlo,x, aObjVYlo,x
	mMOV #$04, aObjVY,x
	mMOV #%10000000, aObjFlags,x
	mPLAYTRACK #$2D
	mMOV #$02, <$02
	clc
	rts

;A7D1
;ボスのクイックブーメランのダメージ処理
BossBehaviour_TakeQuickBoomerang:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageQuickBoomerang,y
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs BossBehaviour_TakeQuickBoomerangEnd
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	mMOV #$3C, aObjAnim,x
	lda aObjFlags,x
	and #%11000000
	eor #%01000000
	ora #%00000100
	sta aObjFlags,x
	mSTZ aObjFrame,x, aObjWait,x, aObjVX,x, aObjVYlo,x
	mMOV #$C0, aObjVXlo,x
	mMOV #$04, aObjVY,x
	mPLAYTRACK #$2D
	mMOV #$02, <$02
BossBehaviour_TakeQuickBoomerangRTS:
	ldx <zObjIndex
	clc
	rts
BossBehaviour_TakeQuickBoomerangEnd:
	mSTZ aObjFlags,x
	beq BossBehaviour_TakeQuickBoomerangRTS

;A842
;ボスのクラッシュボムのダメージ処理
BossBehaviour_TakeCrashBomb:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageCrashBomb,y
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs BossBehaviour_TakeQuickBoomerangEnd
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	lda aObjAnim,x
	cmp #$2F
	beq .end
	lda aObjVar,x
	cmp #$02
	beq .end
	mMOV #$05, aObjFrame,x
	mSTZ aObjWait,x
	mMOV #$38, aObjLife,x
	inc aObjVar,x
	mPLAYTRACK #$2D
	mMOV #$01, <$02
.end
	clc
	rts

;A8A1
;ボスのメタルブレードのダメージ処理
BossBehaviour_TakeMetalBlade:
	lda aObjFlags + 1
	and #%00001000
	bne .skip
	ldy <zBossType
	lda Table_BossTakeDamageMetalBlade,y
	sta <$00
	beq .skip
	bpl .dmg
	jmp BossBehaviour_MaxBossLife
.dmg
	mPLAYTRACK #$2B
	mMOV #$01, <$02
	inc <zBossVar2
	sec
	lda aObjLife + 1
	sbc <$00
	sta aObjLife + 1
	beq .dead
	bcs .alive
.dead
	mSTZ aObjLife + 1
	sec
	rts
.skip
	mMOV #$03, aObjVY,x
	mMOV #$B2, aObjVYlo,x
	mMOV #$01, aObjVX,x
	mMOV #$87, aObjVXlo,x
	lda aObjFlags,x
	and #%11110000
	sta aObjFlags,x
	mPLAYTRACK #$2D
	mMOV #$02, <$02
.end
	clc
	rts
.alive
	mSTZ aObjFlags,x
	beq .end

;A903
;ボス回復/ボスのタイムストッパーのダメージ処理(来ない)
BossBehaviour_TakeTimeStopper:
BossBehaviour_MaxBossLife:
	mMOV #$1C, aObjLife + 1
	mSTZ <$02
	lsr aObjFlags,x
	clc
	rts
	
;A911
;武器毎のボスに当てた時のルーチン下位
Table_BossTakeDamagelo:
	.db LOW(BossBehaviour_TakeRockBuster)
	.db LOW(BossBehaviour_TakeAtomicFire)
	.db LOW(BossBehaviour_TakeAirShooter)
	.db LOW(BossBehaviour_TakeLeafShield)
	.db LOW(BossBehaviour_TakeBubbleLead)
	.db LOW(BossBehaviour_TakeQuickBoomerang)
	.db LOW(BossBehaviour_TakeTimeStopper)
	.db LOW(BossBehaviour_TakeMetalBlade)
	.db LOW(BossBehaviour_TakeCrashBomb)
;A91A
;武器毎のボスに当てた時のルーチン上位
Table_BossTakeDamagehi:
	.db HIGH(BossBehaviour_TakeRockBuster)
	.db HIGH(BossBehaviour_TakeAtomicFire)
	.db HIGH(BossBehaviour_TakeAirShooter)
	.db HIGH(BossBehaviour_TakeLeafShield)
	.db HIGH(BossBehaviour_TakeBubbleLead)
	.db HIGH(BossBehaviour_TakeQuickBoomerang)
	.db HIGH(BossBehaviour_TakeTimeStopper)
	.db HIGH(BossBehaviour_TakeMetalBlade)
	.db HIGH(BossBehaviour_TakeCrashBomb)
;A923
;ボス毎のロックバスターダメージ
Table_BossTakeDamageRockBuster:
	.db $02, $02, $01, $01, $02, $02, $01, $01
	.db $01, $00, $01, $00, $01, $FF
;A931
;ボス毎のアトミックファイアーフルチャージダメージ
Table_BossTakeDamageAtomicFire:
	.db $FF, $06, $0E, $00, $0A, $06, $04, $06
	.db $08, $00, $08, $00, $0E, $FF
;A93F
;ボス毎のエアーシューターのダメージ
Table_BossTakeDamageAirShooter:
	.db $02, $00, $04, $00, $02, $00, $00, $0A
	.db $00, $00, $00, $00, $01, $FF
;A94D
;ボス毎のリーフシールドのダメージ
Table_BossTakeDamageLeafShield:
	.db $00, $08, $FF, $00, $00, $00, $00, $00
	.db $00, $00, $00, $00, $00, $FF
;A95B
;ボス毎のバブルリードのダメージ
Table_BossTakeDamageBubbleLead:
	.db $06, $00, $00, $FF, $00, $02, $00, $01
	.db $00, $00, $01, $00, $00, $01
;A969
;ボス毎のクイックブーメランのダメージ
Table_BossTakeDamageQuickBoomerang:
	.db $02, $02, $00, $02, $00, $00, $04, $01
	.db $01, $00, $02, $00, $01, $FF
;A977
;ボス毎のクラッシュボムのダメージ
Table_BossTakeDamageCrashBomb:
	.db $FF, $00, $02, $02, $04, $03, $00, $00
	.db $01, $00, $01, $00, $04, $FF
;A985
;ボス毎のメタルブレードのダメージ
Table_BossTakeDamageMetalBlade:
	.db $01, $00, $02, $04, $00, $04, $0E, $00
	.db $00, $00, $00, $00, $01, $FF
;A993
;ボス毎のロックマンへの体当たりダメージ
Table_BossDamageAmount:
	.db $08, $08, $08, $04, $04, $04, $06, $04
	.db $1C, $08, $04, $08, $0A, $14

;A9A1
;ガッツタンクのネームテーブル書き込み位置上位
Table_GutsTankNTPtrhi:
	.db $20, $20, $20, $21, $21, $21, $21, $21
	.db $21, $21, $21

;A9AC
;ガッツタンクのネームテーブル書き込み位置下位
Table_GutsTankNTPtrlo:
	.db $C7, $E6, $EE, $06, $26, $44, $64, $85
	.db $A5, $C5, $E6

;A9B7
;ガッツタンクのネームテーブル書き込みサイズ
Table_GutsTankNTSize:
	.db $03, $05, $02, $0A, $0A, $0D, $0F, $0E
	.db $0E, $0F, $0E

;A9C2
;ガッツタンクのネームテーブル書き込みデータ(キャタピラ部分)
Table_GutsTankNTRaw:
	.db $00, $00, $00, $00, $00, $00, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C
	.db $8D, $8D, $8D, $8E, $00, $00, $00, $00, $00, $00, $00, $00, $8F, $90, $91, $92
	.db $93, $94, $95, $96, $97, $98, $98, $99, $9A, $9B, $00, $00, $9C, $9D, $9E, $9F
	.db $A0, $A1, $A2, $A3, $A2, $A3, $A2, $A3, $A2, $A3, $A2, $A3, $A2, $A4, $A5, $A6
	.db $A7, $00, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $AE, $AF, $AE, $AF, $AE, $AF
	.db $AE, $AF, $AE, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC
	.db $BD, $BA, $BB, $BC, $BD, $BA, $BB, $BC, $BD, $BA, $BB, $BC, $BE, $BF, $C0, $C1
	.db $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C5, $C6, $C7, $C8, $C5, $C6, $C7, $C8, $C5
	.db $C6, $C7, $C9, $CA, $CB, $CC, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D0, $D1, $D2
	.db $D3, $D0, $D1, $D2, $D3, $D0, $D1, $D2, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
	.db $DC, $DD, $DE, $DF, $DC, $DD, $DE, $DF, $DC, $DD, $DE, $DF, $DC, $DD, $E0, $E1

;AA72
;ガッツタンクの属性テーブル
Table_GutsTankAttr:
	.db $FF, $3F, $0F, $FF, $FF, $FF
	.db $FF, $33, $44, $FD, $FF, $FF
	.db $FF, $7F, $D0, $FF, $FF, $FF
	.db $FF, $F7, $F5, $FF, $FF, $FF
	.db $AF, $AA, $AA, $AA, $AA, $AA

