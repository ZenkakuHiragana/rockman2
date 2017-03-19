
;879E
;クイックマン
Quickman:
	dex
	mMOV Table_QuickmanBehaviourlo,x, <zPtrlo
	mMOV Table_QuickmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;87AC
;2, クイックマン
Quickman2:
	lda aObjVar + 1
	bne .1
	mMOV #%10000111, aObjFlags + 1
	jsr BossBehaviour_FaceTowards
	mMOV <zRand, <$01
	mMOV #$03, <$02
	jsr Divide8
	ldx <$04
	lda <$00
	clc
	adc #$20
	sta <$01
	sec
	sbc #$40
	bcs .borrow
	lda #$00
.borrow
	sta <$02
	mSTZ aObjVYlo + 1
	mMOV Table_QuickmanJumpVY,x, aObjVY + 1
	mMOV <$00,x, <$0B
	mMOV Table_QuickmanJumpVYlo,x, <$0D
	mSTZ <$0A, <$0C
	jsr Divide
	mMOV <$0F, aObjVX + 1
	mMOV <$0E, aObjVXlo + 1
	inc aObjVar + 1
	inc <zBossVar
.1
	mMOV #$08, <$01
	mMOV #$0C, <$02
	lda aObjVY + 1
	php
	jsr BossBehaviour_WallCollisionXY
	plp
	bpl .skip
	lda <$00
	beq .skip
	dec aObjVar + 1
	lda <zBossVar
	cmp #$03
	bne .skip
	ldx #$01
	jmp Quickman3_Do
;クイックブーメランを発射する
.skip
	lda aObjFrame + 1
	bne .skip_anim
	sta aObjWait + 1
.skip_anim
	lda aObjVY + 1
	php
	jsr Quickman_Move_NoCollision
	plp
	bmi .rts
	lda aObjVY + 1
	bpl .rts
	lda <zBossVar
	cmp #$02
	bne .rts
	lda <zBossBehaviour
	cmp #$02
	bne .rts
	mSTZ aObjWait + 1
	mMOV #$01, aObjFrame + 1
	lda aObjY
	pha
	sec
	sbc #$18
	sta aObjY
	mMOV #$03, <$02
.loop_obj
	lda #$59
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .skip_obj
	tya
	clc
	adc #$10
	tax
	sta <zObjIndex
	mMOV #$25, aObjVar,x
	mMOV #$04, <$09
	mMOV #$00, <$08
	jsr BossBehaviour_SetVelocityAtRockman
	clc
	lda aObjY
	adc #$18
	sta aObjY
	dec <$02
	bne .loop_obj
.skip_obj
	pla
	sta aObjY
.rts
	rts

;8893
;クイックマンのジャンプ力上位
Table_QuickmanJumpVY:
	.db $07, $08, $04
;8896
;クイックマンのジャンプ力下位
Table_QuickmanJumpVYlo:
	.db $38, $40, $20

;8899
;3, クイックマン
Quickman3:
	jsr BossBehaviour_FaceTowards
	ldx #$00
Quickman3_Do:
	mSTZ aObjVar + 1, <zBossVar
	mMOV $88B4,x, <zBossBehaviour
	lda $88B6,x
	jsr SetBossAnimation
	mJSR_NORTS Quickman_Move

;88B4
;クイックマンの行動を決める
Table_QuickmanBehaviour:
	.db $02, $05
;88B6
;クイックマンのアニメーション番号を決める
Table_QuickmanAnimations:
	.db $55, $58

;88B8
;4, クイックマン 効かない時
Quickman4:
	dec aObjVar + 1
	beq Quickman4_End
	mJSR_NORTS Quickman_Move

;88C1
;5, クイックマン
Quickman5:
	lda aObjVar + 1
	bne .skip
	mMOV #%10000111, aObjFlags + 1
	jsr BossBehaviour_FaceTowards
	mMOV #$02, aObjVX + 1
	mMOV #$3E, <zBossVar
	inc aObjVar + 1
.skip
	dec <zBossVar
	bne .jsrrts
	ldx #$00
	jsr Quickman3_Do
.jsrrts
	mJSR_NORTS Quickman_Move

;88E7
;
Quickman4_End:
	mSTZ aObjVar + 1, <zBossVar
	mMOV #$03, <zBossBehaviour
	lda #$56
	jsr SetBossAnimation
	mMOV #$0B, <$01
	mMOV #$0C, <$02
	mJSR_NORTS BossBehaviour_MoveBackward

;8903
;クイックマンの移動処理と当たり判定処理
Quickman_Move:
	mMOV #$08, <$01
	mMOV #$0C, <$02
	jsr BossBehaviour_WallCollisionXY
Quickman_Move_NoCollision:
	lda aBossInvincible
	beq .1
	.ifndef ___OPTIMIZE
	jsr BossBehaviour_Move
	jmp .rts
	.else
	mJSR_NORTS BossBehaviour_Move
	.endif
.1
	jsr BossBehaviour_MoveAndCollide
	lda <$02
	beq .rts
	cmp #$01
	bne .nodmg
	mMOV #$12, aBossInvincible
	bne .rts
.nodmg
	mSTZ aObjVX + 1, aObjVXlo + 1
	mMOV #$FF, aObjVY + 1
	mMOV #$C0, aObjVYlo + 1
	lda #$57
	jsr SetBossAnimation
	mMOV #$04, <zBossBehaviour
	mMOV #$3E, aObjVar + 1
.rts
	rts

;894C
;クイックマン行動アドレス下位
Table_QuickmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Quickman2)
	.db LOW(Quickman3)
	.db LOW(Quickman4)
	.db LOW(Quickman5)
;8951
;クイックマン行動アドレス上位
Table_QuickmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Quickman2)
	.db HIGH(Quickman3)
	.db HIGH(Quickman4)
	.db HIGH(Quickman5)
