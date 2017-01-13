
;8655
;バブルマン
Bubbleman:
	dex
	mMOV Table_BubblemanBehaviourlo,x, <zPtrlo
	mMOV Table_BubblemanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8664
;2, バブルマン
Bubbleman2:
	lda #%10000011
	sta aObjFlags + 1
	jsr BossBehaviour_FaceTowards
	lda aObjFrame,x
	bne .skip
	sta aObjWait + 1
.skip
	lda aObjVar + 1
	bne .skip2
	sec
	lda aObjY + 1
	sbc aObjY
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp #$03
	bcs .jsrrts
	mMOV <zRand, <$01
	mMOV #$03, <$02
	jsr Divide8
	inc <$04
	mMOV <$04, aObjVar + 1
	mMOV #$01, <zBossVar
.skip2
	dec <zBossVar
	bne .jsrrts
	mMOV #$1F, <zBossVar
	lda #$5B
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	mMOV #$01, aObjFrame + 1
	dec aObjVar + 1
	bne .jsrrts
	lda aObjY
	pha
	mMOV #$50, aObjY
	mMOV #$01, <$09
	mMOV #$60, <$08
	ldx #$01
	stx <zObjIndex
	jsr BossBehaviour_SetVelocityAtRockman
	pla
	sta aObjY
	mSTZ <zBossVar
	mMOV aObjFlags + 1, aObjVar + 1
	inc <zBossBehaviour
	lda #$62
	jsr SetBossAnimation
.jsrrts
	mJSR_NORTS Bubbleman_Move

;86EA
;3, バブルマン
Bubbleman3:
	mMOV aObjVar + 1, aObjFlags + 1
	jsr Bubbleman_Move
	lda aObjY + 1
	cmp #$50
	bcs Bubbleman3_Continue
	mMOV #$FF, aObjVY + 1
	mSTZ aObjVYlo + 1, aObjVX + 1, aObjVXlo + 1
	mMOV #$04, <zBossBehaviour
Bubbleman3_Continue:
	jsr BossBehaviour_FaceTowards
	lda <zBossVar
	bne .skip
	sec
	lda aObjY + 1
	sbc aObjY
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp #$03
	bcs Bubbleman3_End
	mMOV #$01, aBossVar1
	mMOV #$04, <zBossVar
.skip
	dec aBossVar1
	bne Bubbleman3_End
	mMOV #$12, aBossVar1
	mMOV #$03, aObjFrame + 1
	lda #$5A
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	dec <zBossVar
Bubbleman3_End:
	lda aObjFrame + 1
	cmp #$02
	bne .rts
	mSTZ aObjFrame + 1
.rts
	rts

;8754
;4, バブルマン
Bubbleman4:
	jsr Bubbleman_Move
	lda <$00
	beq Bubbleman3_Continue
	mMOV #$02, <zBossBehaviour
	mSTZ aObjVY + 1, aObjVar + 1, <zBossVar
	lda #$61
	jsr SetBossAnimation
	jmp Bubbleman3_End

;8771
;バブルマンの移動処理と当たり判定処理
Bubbleman_Move:
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
	mMOV #$09, <$01
	mMOV #$0C, <$02
	mJSR_NORTS BossBehaviour_WallCollisionXY

;864E
;バブルマン行動アドレス下位
Table_BubblemanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Bubbleman2)
	.db LOW(Bubbleman3)
	.db LOW(Bubbleman4)
;8652
;バブルマン行動アドレス上位
Table_BubblemanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Bubbleman2)
	.db HIGH(Bubbleman3)
	.db HIGH(Bubbleman4)
