
;8956
;フラッシュマン
Flashman:
	dex
	mMOV #$30, aPaletteSpr + 8 + 1 ;パレットの黒の部分を書き換え
	mMOV Table_FlashmanBehaviourlo,x, <zPtrlo
	mMOV Table_FlashmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8964
;2, フラッシュマン
Flashman2:
	lda aObjFlags + 1
	ora #%00000100
	sta aObjFlags + 1
	mMOV #$06, aObjVXlo + 1
	mMOV #$01, aObjVX + 1
	inc <zBossVar
	lda <zBossVar
	cmp #$BB
	bcc .skip
	mSTZ aObjVar + 1
	mMOV #$03, <zBossBehaviour
	lda #$5A
	jsr SetBossAnimation
	mMOV #$03, aObjFrame + 1
	jsr Flashman_Move
	mPLAYTRACK #$21, 1
.skip
	jsr Flashman_Move
	lda <$03
	beq .rts
	lda <zBossBehaviour
	cmp #$06
	beq .rts
	mSTZ aObjVar + 1
	mMOV #$05, <zBossBehaviour
	lda #$5D
	mJSRJMP SetBossAnimation
.rts
	rts

;89B6
;3, フラッシュマン
Flashman3:
	mSTZ aObjVXlo + 1, aObjVX + 1
	lda aObjFrame + 1
	cmp #$07
	bne Flashman3_End
	mMOV #$5F, aObjAnim + $0F
	mMOV #$80, aObjFlags + $0F, aObjX + $0F, aObjY + $0F
	mMOV aObjRoom + 1, aObjRoom + $0F
	lda #$00
	sta aObjVYlo + $0F
	sta aObjVY + $0F
	sta aObjVX + $0F
	sta aObjVXlo + $0F
	sta aObjWait + $0F
	sta aObjFrame + $0F
	mMOV #%00000100, <zStopFlag
	mMOV #$20, aPaletteSpr
	mMOV #$06, aObjVar + 1
	mMOV #$1F, <zBossVar
	inc <zBossBehaviour
	lda #$5B
	jsr SetBossAnimation
Flashman3_End:
	mJSR_NORTS Flashman_Move

;8A0C
;4, フラッシュマン
Flashman4:
	mMOV #$0F, aPaletteSpr
	lda aObjFrame + 1
	beq Flashman3_End
	cmp #$02
	bne .1
	mMOV #$02, <zBossBehaviour
	mSTZ <zStopFlag, <zBossVar, aObjVar + 1
	lsr aObjFlags + $0F
	lda #$5C
	jsr SetBossAnimation
	jsr BossBehaviour_FaceTowards
	jmp Flashman3_End
.1
	jsr BossBehaviour_FaceTowards
	mSTZ aObjWait + 1
	dec <zBossVar
	bne Flashman3_End
	mMOV #$06, <zBossVar
	lda aObjY
	pha
	mMOV <zRand, <$01
	mMOV #$50, <$02
	jsr Divide8
	sec
	lda aObjY + 1
	sbc #$28
	clc
	adc <$04
	sta aObjY
	lda #$35
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .skip
	clc
	tya
	adc #$10
	tax
	stx <zObjIndex
	mMOV #$08, <$09
	mMOV #$00, <$08
	ldy #$00
	lda aObjFlags + 1
	and #%01000000
	pha
	bne .isright
	iny
.isright
	clc
	lda aObjX,x
	adc Table_FlashmanShotdx,y
	sta aObjX,x
	pla
	tay
	lda #$60
	jsr SetVelocityAtRockman.do
	mMOV #$01, <zObjIndex
.skip
	pla
	sta aObjY
	ldx #$01
	dec aObjVar + 1
	bne .jmp
	inc aObjFrame + 1
.jmp
	jmp Flashman3_End

;8AAB
;フラッシュマンのバスター出現位置dx
Table_FlashmanShotdx:
	.db $08, $F8

;8AAD
;5, フラッシュマン
Flashman5:
	lda aObjVar + 1
	bne .skip
	jsr BossBehaviour_FaceTowards
	mSTZ aObjVYlo + 1, aObjVX + 1
	mMOV #$04, aObjVY + 1
	mMOV #$80, aObjVXlo + 1
	inc aObjVar + 1
.skip
	jsr Flashman_Move
	bne .norts
.rts
	rts
.norts
	lda <zBossBehaviour
	cmp #$06
	beq .rts
	mSTZ aObjVar + 1
	mMOV #$02, <zBossBehaviour
	lda #$5C
	jsr SetBossAnimation
;8AE4
;フラッシュマンの移動処理と当たり判定処理
Flashman_Move:
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
	rts
.collision
	mMOV #$08, <$01
	mMOV #$0C, <$02
	lda aObjVY + 1
	php
	jsr BossBehaviour_WallCollisionXY
	plp
	bpl .goup
	lda <$00
	rts
.goup
	lda #$00
	rts

;8B16
;フラッシュマン行動アドレス下位
Table_FlashmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Flashman2)
	.db LOW(Flashman3)
	.db LOW(Flashman4)
	.db LOW(Flashman5)
;8B1B
;フラッシュマン行動アドレス上位
Table_FlashmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Flashman2)
	.db HIGH(Flashman3)
	.db HIGH(Flashman4)
	.db HIGH(Flashman5)
