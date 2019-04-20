
;8CC3
;クラッシュマン
Crashman:
	dex
	mMOV Table_CrashmanBehaviourlo,x, <zPtrlo
	mMOV Table_CrashmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8CD1
;2, クラッシュマン初期化
Crashman2:
	lda aObjVar + 1
	ora #%10000011
	sta aObjFlags + 1
	mSTZ aObjVYlo + 1, aObjVY + 1
	mMOV #$47, aObjVXlo + 1
	mMOV #$01, aObjVX + 1
	lda #$6A
	jsr SetBossAnimation
	inc <zBossBehaviour
	mJSR_NORTS Crashman_Move

;8CF6
;3, クラッシュマンが歩く
Crashman3:
	lda <zKeyPress
	and #$02
	bne .jump
	lda aBossVar1
	beq .nojump
	dec aBossVar1
	bne .nojump
;クラッシュマンがジャンプする
.jump
	lda #%10000111
	sta aObjFlags + 1
	jsr BossBehaviour_FaceTowards
	lda aObjFlags + 1
	sta aBossVar2
	mMOV #$ED, aObjVYlo + 1
	mMOV #$06, aObjVY + 1
	clc
	lda <$00
	adc #$20
	sta <$0B
	lda <zRand
	and #$01
	beq .skip
	sec
	lda <$0B
	sbc #$40
	bcs .borrow
	lda #$00
.borrow
	sta <$0B
.skip
	mMOV #$37, <$0D
	mSTZ <$0A, <$0C
	jsr Divide
	mMOV <$0F, aObjVX + 1
	mMOV <$0E, aObjVXlo + 1
	lda #$6B
	jsr SetBossAnimation
	mMOV #$04, <zBossBehaviour
	bne .jsrrts
;クラッシュマンがジャンプしない
.nojump
	ldx aObjX + 1
	lda aObjFlags + 1
	and #%01000000
	bne .isright
	cpx #$38
	bcs .jsrrts
	bcc .turn
.isright
	cpx #$C8
	bcc .jsrrts
.turn
	lda aObjVar + 1
	eor #%01000000
	sta aObjVar + 1
	lda aObjFlags + 1
	eor #%01000000
	sta aObjFlags + 1
.jsrrts
	mJSR_NORTS Crashman_Move

;8D80
;4, クラッシュマンがジャンプ中
Crashman4:
	lda aBossVar2
	sta aObjFlags + 1
	lda aObjVY + 1
	php
	jsr Crashman_Move
	mMOV #$0B, <$01
	mMOV #$0C, <$02
	jsr BossBehaviour_WallCollisionXY
	plp
	bmi .godown
	lda aObjVY + 1
	bpl .skip
	mMOV #$01, aObjFrame + 1
	bne .skip
.godown
	lda <$00
	beq .nohit
	mMOV #$02, <zBossBehaviour
	mMOV #$9C, aBossVar1
	bne .skip
.nohit
	lda aObjFrame + 1
	cmp #$02
	bne .skip
	lda aObjWait + 1
	bne .skip
	lda #$5E
	jsr BossBehaviour_CheckExistence
	bcc .skip
	lda #$5E
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .skip
	clc
	tya
	adc #$10
	tax
	stx <zObjIndex
	mMOV #$24, <$08
	mMOV #$06, <$09
	jsr BossBehaviour_SetVelocityAtRockman
.skip
	lda aObjFrame + 1
	bne .skip_anim
	sta aObjWait + 1
.skip_anim
	mJSR_NORTS BossBehaviour_FaceTowards

;8DF0
;クラッシュマンの移動処理と当たり判定処理
Crashman_Move:
	lda aBossInvincible
	beq .1
	mJSR_NORTS BossBehaviour_Move
.1
	jsr BossBehaviour_MoveAndCollide
	lda <$02
	cmp #$01
	bne .rts
	mMOV #$12, aBossInvincible
.rts
	rts

;8E08
;クラッシュマン行動アドレス下位
Table_CrashmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Crashman2)
	.db LOW(Crashman3)
	.db LOW(Crashman4)
;8E0C
;クラッシュマン行動アドレス上位
Table_CrashmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Crashman2)
	.db HIGH(Crashman3)
	.db HIGH(Crashman4)
