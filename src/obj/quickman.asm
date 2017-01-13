
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
	

;8771
;クイックマンの移動処理と当たり判定処理
Quickman_Move:
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

;894C
;クイックマン行動アドレス下位
Table_QuickmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Quickman2)
	.db LOW(Quickman3)
	.db LOW(Quickman4)
;8951
;クイックマン行動アドレス上位
Table_QuickmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Quickman2)
	.db HIGH(Quickman3)
	.db HIGH(Quickman4)
