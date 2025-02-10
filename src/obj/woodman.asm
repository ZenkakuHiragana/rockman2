
;84FB
;ウッドマン
Woodman:
	dex
	mMOV Table_WoodmanBehaviourlo,x, <zPtrlo
	mMOV Table_WoodmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8509
;2, ウッドマン
Woodman2:
	jsr BossBehaviour_FaceTowards
	lda aObjVar + 1
	bne .1
	lda #$61
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	inc aObjVar + 1
	jmp .jsrrts
.1
	cmp #$04
	bcs .2
	inc <zBossVar
	lda <zBossVar
	cmp #$12
	.ifndef ___OPTIMIZE
	bne .jmp
	.else
	bne .jsrrts
	.endif
	mSTZ <zBossVar
	inc aObjVar + 1
	lda #$62
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
.jmp
	jmp .jsrrts
.2
	lda #$62
	jsr BossBehaviour_CheckExistence
	bcc .jsrrts
	mMOV #$03, <$02
.loop
	lda #$62
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .skip
	ldx <$02
	mMOV #$C1, aObjFlags10,y
	mMOV #$20, aObjY10,y
	mMOV #$01, aObjVar10,y
	mMOV #$FE, aObjVY10,y
	mMOV #$02, aObjVX10,y
	mMOV Table_WoodmanLeafX,x, aObjX10,y
	dec <$02
	bpl .loop
.skip
	inc <zBossBehaviour
	lda #$6F
	jsr SetBossAnimation
.jsrrts
	mJSR_NORTS Woodman_Move

;857F
;ウッドマンの落ちる木の葉X座標
Table_WoodmanLeafX:
	.db $40, $70, $A0, $D0

;8583
;3, ウッドマンがリーフシールドを飛ばす
Woodman3:
	lda aObjFrame + 1
	cmp #$02
	bcc .jsrrts
	bne .skip
	lda aObjWait + 1
	bne .jsrrts
;ウッドマンがリーフシールドを飛ばす
	lda #$61
	jsr BossBehaviour_CheckExistence
	bcs .jsrrts
	mMOV #$04, aObjVX10,y
	lda aObjFlags10,y
	and #%10111111
	sta <$00
	lda aObjFlags + 1
	and #%01000000
	ora <$00
	sta aObjFlags10,y
	bne .jsrrts
.skip
	lda #$6E
	jsr SetBossAnimation
	inc <zBossBehaviour
.jsrrts
	mJSR_NORTS Woodman_Move

;85BB
;4, ウッドマン
Woodman4:
	jsr Woodman_Move
	lda aObjFrame + 1
	cmp #$02
	bcc .rts
	bne .skip
	lda aObjWait + 1
	bne .skip2
	mMOV #$04, aObjVY + 1
	mMOV #$01, aObjVX + 1
	lda aObjFlags + 1
	ora #%00000100
	sta aObjFlags + 1
.skip2
	mMOV #$01, aObjWait + 1
	lda aObjVY + 1
	php
	mMOV #$0F, <$01
	mMOV #$10, <$02
	jsr BossBehaviour_WallCollisionXY
	plp
	bpl .rts
	lda <$00
	beq .rts
	mMOV #$03, aObjFrame + 1
	mSTZ aObjVY + 1, aObjVYlo + 1, aObjVX + 1, aObjWait + 1, aObjVar + 1, <zBossVar
	lda aObjFlags + 1
	and #%11111011
	sta aObjFlags + 1
.skip
	lda aObjFrame + 1
	cmp #$04
	bne .rts
	mSTZ aObjWait + 1
	lda #$62
	jsr BossBehaviour_CheckExistence
	bcc .rts
	mMOV #$02, <zBossBehaviour
	lda #$6D
	mJSRJMP SetBossAnimation
.rts
	rts

;863F
;ウッドマンの移動処理と当たり判定処理
Woodman_Move:
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

;864E
Table_WoodmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Woodman2)
	.db LOW(Woodman3)
	.db LOW(Woodman4)
;8652
Table_WoodmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Woodman2)
	.db HIGH(Woodman3)
	.db HIGH(Woodman4)
