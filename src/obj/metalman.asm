
;8B20
;メタルマン
Metalman:
	dex
	mMOV Table_MetalmanBehaviourlo,x, <zPtrlo
	mMOV Table_MetalmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8B2E
;2, メタルマン
Metalman2:
	lda #%10000111
	sta aObjFlags + 1
	jsr BossBehaviour_FaceTowards
	lda <zKeyPress
	and #$02
	bne .attack
	lda <zBossVar
	cmp #$BB
	bne .skip
.attack
	mMOV <zRand, <$01
	mMOV #$03, <$02
	jsr Divide8
	ldx <$04
	jsr Metalman_SetStatus
	jmp .wait
.skip
	lda <$00
	cmp #$48
	bcs .wait
	lda #%10000111
	ldy aObjX + 1
	cpy #$80
	bcs .isright
	ora #%01000000
.isright
	sta aObjFlags + 1
	ldx #$03
	jsr Metalman_SetStatus
.wait
	inc <zBossVar
	mJSR_NORTS Metalman_ChangeVector

;8B74
;Xに応じてメタルマンの速度と状態値を変える
Metalman_SetStatus:
	lda #$65
	jsr SetBossAnimation
	mMOV #$01, <zBossVar
	mMOV Table_MetalmanVYlo,x, aObjVYlo + 1
	mMOV Table_MetalmanVYhi,x, aObjVY + 1
	mMOV Table_MetalmanVXlo,x, aObjVXlo + 1
	mMOV Table_MetalmanVXhi,x, aObjVX + 1
	mMOV Table_MetalmanBehaviour,x, <zBossBehaviour
	mMOV aObjFlags + 1, aObjVar + 1
	rts

;8BA1
;メタルマンVYlo
Table_MetalmanVYlo:
	.db $ED, $A8, $00, $00
;8BA5
;メタルマンVYhi
Table_MetalmanVYhi:
	.db $06, $05, $04, $08
;8BA9
;メタルマンVXlo
Table_MetalmanVXlo:
	.db $00, $00, $00, $20
;8BAD
;メタルマンVXhi
Table_MetalmanVXhi:
	.db $00, $00, $00, $02
;8BB1
;メタルマン状態値
Table_MetalmanBehaviour:
	.db $03, $03, $03, $04

;8BB5
;3, メタルマン
;4, メタルマン
Metalman3:
Metalman4:
	mMOV aObjVar + 1, aObjFlags + 1
	jsr Metalman_ChangeVector
	lda <$00
	pha
	jsr BossBehaviour_FaceTowards
	pla
	sta <$00
	lda aObjVY + 1
	bpl .skip
	dec <zBossVar
	bne .wait
	ldy #$12
	lda <zBossBehaviour
	cmp #$04
	bne .1
	ldy #$40
.1
	sty <zBossVar
	mSTZ aObjVY + 1, aObjVYlo + 1
	lda aObjFlags + 1
	and #%11111011
	sta aObjFlags + 1
	mMOV #$01, aObjFrame + 1
.wait
	lda <$00
	beq .skip
	lda #$00
	sta <zBossVar
	dec <zBossBehaviour
	sta aObjVX + 1
	sta aObjVXlo + 1
	lda #$64
	jsr SetBossAnimation
.skip
	lda aObjFrame + 1
	bne .skip_anim
	sta aObjWait + 1
.skip_anim
	cmp #$02
	bne .rts
	lda aObjWait + 1
	bne .rts
	mPLAYTRACK #$23
	lda #$5C
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	clc
	tya
	adc #$10
	tax
	stx <zObjIndex
	mMOV #$00, <$08
	mMOV #$04, <$09
	jsr BossBehaviour_SetVelocityAtRockman
	lda aObjFlags + 1
	ora #%00000100
	sta aObjFlags + 1
.rts
	rts

;8C3E
;ベルトコンベアの向きを変える
Metalman_ChangeVector:
	mMOV #$0F, aPaletteSpr
	clc
	mADD aBossVar1, #$01
	mADD aBossVar2, #$00
	beq Metalman_Move
	lda aBossVar1
	cmp #$77
	bne Metalman_Move
	mSTZ aBossVar1, aBossVar2
	lda <zStage
	cmp #$0C
	beq Metalman_Move
	mMOV #$30, aPaletteSpr
	ldx #$00
	ldy #$00
	lda <zConveyorVec
	eor #%01100000
	sta <zConveyorVec
	and #%00100000
	beq .write_palette
	ldx #$04
.write_palette
	txa
	sta <zPaletteOffset

;8C90
;メタルマンの移動処理と当たり判定処理
Metalman_Move:
	ldy #$02
	lda <zPaletteIndex
	cmp #$03
	beq .set_palette
.loop_unsetpalette
	mORA aPaletteOverride + 5,y, #$80
	dey
	bpl .loop_unsetpalette
	bmi .move
.set_palette
	lda aPaletteOverride + 5,y
	and #$7F
	cmp #$7F
	beq .skip_setpalette
	sta aPaletteOverride + 5,y
.skip_setpalette
	dey
	bpl .set_palette
.move
	lda aBossInvincible
	beq .1
	jsr BossBehaviour_Move
	jmp .collision
.1
	jsr BossBehaviour_MoveAndCollide
	lda <$02
	cmp #$01
	bne .collision
	mMOV #$12, aBossInvincible
.collision
	mMOV #$07, <$01
	mMOV #$0C, <$02
	mJSR_NORTS BossBehaviour_WallCollisionXY

;8CB5
;メタルマンのコンベアの色
Table_MetalmanConveyorPalette:
	.db $10, $10, $10, $15, $15, $10

;8CBB
;メタルマン行動アドレス下位
Table_MetalmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Metalman2)
	.db LOW(Metalman3)
	.db LOW(Metalman4)
;8CBF
;メタルマン行動アドレス上位
Table_MetalmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Metalman2)
	.db HIGH(Metalman3)
	.db HIGH(Metalman4)
