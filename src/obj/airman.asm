
;82E3
;エアーマン
Airman:
	dex
	mMOV Table_AirmanBehaviourlo,x, <zPtrlo
	mMOV Table_AirmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;82F1
;2, エアーマン
Airman2:
	mSTZ <zWindFlag, <zWindlo, <zWindhi
	lda <zBossVar
	cmp #$03
	bne .jump
;エアーマンがジャンプする
	mSTZ <zBossVar
	lda #$68
	jsr SetBossAnimation
	lda aObjFlags + 1
	ora #%00000100
	sta aObjFlags + 1
	mMOV #$04, <zBossBehaviour
	mMOV #$FF, aObjVY + 1
	bne .jsrrts
;エアーマンが竜巻を発射する
.jump
	mMOV <zRand, <$01
	mMOV #$05, <$02
	jsr Divide8
	ldx <$04
	lda Table_AirmanAirShooterWait,x
	sta aObjVar + 1
	lda <$04
	asl a
	sta <$01
	asl a
	adc <$01
	sta <$01
	mMOV #$06, <$02
.loop
	lda #$5D
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	ldx <$01
	mMOV Table_AirmanAirShooterVYlo,x, aObjVYlo10,y
	mMOV Table_AirmanAirShooterVYhi,x, aObjVY10,y
	mMOV Table_AirmanAirShooterVXlo,x, aObjVXlo10,y
	mMOV Table_AirmanAirShooterVXhi,x, aObjVX10,y
	mMOV Table_AirmanAirShooterTimer,x, aObjVar10,y
	inc <$01
	dec <$02
	bne .loop
	mPLAYTRACK #$3F
	inc <zBossVar
	inc <zBossBehaviour
	mSTZ aObjFrame + 1, aObjWait + 1
.jsrrts
	mJSR_NORTS Airman_Move

;837E
;エアーシューター発射時の硬直時間
Table_AirmanAirShooterWait:
	.db $44, $4A, $42, $43, $43
;8383
;エアーシューター初期VYlo
Table_AirmanAirShooterVYlo:
	.db $00, $F0, $50, $3C, $00, $00
	.db $D3, $CD, $68, $0F, $1A, $00
	.db $A7, $68, $00, $7F, $B1, $A7
	.db $88, $50, $D4, $D0, $D0, $B9
	.db $98, $50, $3C, $1A, $7C, $35
;83A1
;エアーシューター初期VYhi
Table_AirmanAirShooterVYhi:
	.db $04, $03, $03, $02, $02, $00
	.db $03, $03, $02, $02, $01, $00
	.db $03, $02, $02, $01, $00, $FF
	.db $03, $03, $02, $01, $01, $FF
	.db $03, $03, $02, $01, $00, $00
;83BF
;エアーシューター初期VXlo
Table_AirmanAirShooterVXlo:
	.db $00, $B1, $3C, $50, $76, $00
	.db $2B, $3C, $31, $6B, $DB, $00
	.db $A0, $31, $76, $B5, $F0, $FC
	.db $E0, $3C, $D4, $90, $90, $FD
	.db $C0, $3C, $50, $DB, $F8, $FE
;83DD
;エアーシューター初期VXhi
Table_AirmanAirShooterVXhi:
	.db $00, $00, $02, $03, $03, $04
	.db $01, $01, $03, $03, $03, $04
	.db $01, $03, $03, $03, $03, $03
	.db $01, $02, $02, $03, $03, $03
	.db $01, $02, $03, $03, $03, $03
;83FB
;エアーシューター移動時間
Table_AirmanAirShooterTimer:
	.db $0C, $16, $24, $0E, $24, $18
	.db $1B, $0E, $1E, $2A, $1D, $0C
	.db $0D, $0A, $20, $15, $22, $18
	.db $21, $15, $05, $0D, $23, $1C
	.db $1A, $0E, $1C, $1D, $10, $24

;8419
;3, エアーマン送風
Airman3:
	lda aObjVar + 1
	beq .1
.0
	mSTZ aObjWait + 1
	dec aObjVar + 1
	mJSR_NORTS Airman_Move
.1
	lda #$5D
	jsr BossBehaviour_CheckExistence
	bcc .2
	dec <zBossBehaviour
	.ifndef ___OPTIMIZE
	jmp .0
	.else
	bcs .0
	.endif
.2
	mMOV #$01, <zWindFlag
	lda aObjFlags + 1
	and #%01000000
	sta <zWindVec
	clc
	lda <zWindlo
	adc #$10
	sta <zWindlo
	lda <zWindhi
	adc #$00
	sta <zWindhi
	cmp #$04
	bne .max_wind
	mSTZ <zWindlo
.max_wind
;エアーシューターに風の速度を適用する
	ldy #$0F
	mMOV #$5D, <$00
.loop_air
	jsr BossBehaviour_CheckExistenceSpecified
	bcs .skip_air
	mMOV <zWindlo, aObjVXlo10,y
	mMOV <zWindhi, aObjVX10,y
	dey
	bpl .loop_air
.skip_air

	lda aObjFrame + 1
	cmp #$03
	bne .skip_anim
	mMOV #$01, aObjFrame + 1
.skip_anim
	ldx #$01
	mJSR_NORTS Airman_Move

;8480
;4, エアーマンジャンプ中
Airman4:
	jsr Airman_Move
	mMOV #$0B, <$01
	mMOV #$10, <$02
	jsr BossBehaviour_WallCollisionXY
	lda <$00
	beq .rts
	ldx <zBossVar
	mMOV Table_AirmanJumpVYlo,x, aObjVYlo + 1
	mMOV Table_AirmanJumpVYhi,x, aObjVY + 1
	mMOV Table_AirmanJumpVXlo,x, aObjVXlo + 1
	mMOV Table_AirmanJumpVXhi,x, aObjVX + 1
	inc <zBossVar
	lda <zBossVar
	cmp #$03
	bne .rts
	mMOV #$02, <zBossBehaviour
	lda aObjFlags + 1
	and #%11111011
	eor #%01000000
	sta aObjFlags + 1
	mSTZ <zBossVar
	lda #$67
	mJSR_NORTS SetBossAnimation
.rts
	rts
;84CD
;エアーマンジャンプ力Ylo
Table_AirmanJumpVYlo:
	.db $E6, $76, $00
;84D0
;エアーマンジャンプ力Yhi
Table_AirmanJumpVYhi:
	.db $04, $07, $00
;84D3
;エアーマンジャンプ力Xlo
Table_AirmanJumpVXlo:
	.db $39, $9A, $00
;84D6
;エアーマンジャンプ力Xhi
Table_AirmanJumpVXhi:
	.db $01, $01, $00

;84D9
;エアーマンの移動処理と当たり判定処理
Airman_Move:
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
	cmp #$01
	bne .rts
	mMOV #$12, aBossInvincible
.rts
	rts

;84F3
;エアーマン行動アドレス下位
Table_AirmanBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(Airman2)
	.db LOW(Airman3)
	.db LOW(Airman4)
;84F7
;エアーマン行動アドレス上位
Table_AirmanBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(Airman2)
	.db HIGH(Airman3)
	.db HIGH(Airman4)
