
;966E
;ブービームトラップ
BooBeamTrap:
	dex
	mMOV Table_BooBeamTrapBehaviourlo,x, <zPtrlo
	mMOV Table_BooBeamTrapBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;967C
;1, ブービームトラップ 登場時
BooBeamTrap1:
	jsr BossBehaviour_ChargeLifeWily
	lda aObjLife + 1
	cmp #$1C
	beq .gonext
	rts
.gonext
	mMOV #$04, <$02
.loop_spawn
	lda #$6D
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	ldx <$02
	mMOV Table_BooBeamTrapX,x, aObjX10,y
	mMOV Table_BooBeamTrapY,x, aObjY10,y
	mMOV Table_BooBeamTrapF,x, aObjFlags10,y
	dec <$02
	bpl .loop_spawn
	inc <zBossBehaviour
	rts

;96AD
;ブービームトラップ生成位置X
Table_BooBeamTrapX:
	.db $14, $44, $AC, $EC, $EC
;96B2
;ブービームトラップ生成位置Y
Table_BooBeamTrapY:
	.db $60, $30, $40, $70, $B0
;96B7
;ブービームトラップ初期状態値
Table_BooBeamTrapF:
	.db %11000011, %11000011, %10000011, %10000011, %10000011

;96BC
;ブービームトラップ行動アドレス下位
Table_BooBeamTrapBehaviourlo:
	.db LOW(BooBeamTrap1)
	.db LOW(WilyBoss_Wait)

;96BE
;ブービームトラップ行動アドレス上位
Table_BooBeamTrapBehaviourhi:
	.db HIGH(BooBeamTrap1)
	.db HIGH(WilyBoss_Wait)
