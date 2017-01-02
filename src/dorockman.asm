
;ロックマンの処理を最適化して空き領域を得る
;移動処理とスクロール処理は分離

;$440～$44F: YYYY XXXX
;Y = Y screen(0～F)
;X = X screen(0～F)

;84EE
;ロックマン状態別の処理
;DoRockman:
	lda aObjX
	pha
	lda aObjY
	pha
	lda <zStopFlag
	and #$04
	bne DoRockman01_Fall
	mSTZ <zScrollFlag
	ldx <zStatus
	mMOV Table_DoRockmanlo,x, <zPtrlo
	mMOV Table_DoRockmanhi,x, <zPtrhi
	jsr IndirectJSR
	pla
	tay
	pla
	tax
	rts
	;jmp DoRockman_DoScroll

;8508
;ロックマン状態#0メニューを閉じたときの「ぴちゃっ」
DoRockman00_Land:
	lda aObjFrame
	cmp #$04
	bne .skip
	mMOV #$03, <zStatus
	jsr SetRockmanAnimation
	mMOV #$FF, aObjVY
	mSTZ aObjVYlo, <zStopFlag, <$0B
	mMOV aObjX, <$08
	mMOV aObjRoom, <$09
	mMOV aObjY, <$0A
	jsr PickupMap
	lda #$04
	cmp <$00
	bne .skip
	sta <zWaterLevel
.skip
DoRockman01_Fall:
	rts

;8545
;ロックマン状態#1転落
;	rts

;8546
;ロックマン状態#2ノックバック
DoRockman02_KnockBack:
	lda aObjFlags
	and #$40
	eor #$40
	sta <zMoveVec
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda aObjFrame
	beq .getup
	mJSR_NORTS SetRockmanAnimation
.getup
	lda #$06
	ldy <$00
	beq .air
	lsr a
.air
	sta <zStatus
	rts

;8569
;ロックマン状態#3停止中
DoRockman03_Stand:
	jsr DoRockman_ShootWeapon
	lda <zKeyDown
	and #$C0
	beq .stand
	inc <zStatus
	jsr DoRockman_SetDirection
.stand
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	beq DoRockman05_InAir
;858E
DoRockman_CheckJump:
	lda <zKeyPress
	lsr a
	bcs .jump
	mJSR_NORTS SetRockmanAnimation
.jump
	mMOV <zJumpPowerlo, aObjVYlo
	mMOV <zJumpPowerhi, aObjVY
	bne DoRockman05_InAir


;85A6
;ロックマン状態#4歩き始め
;868C
;ロックマン状態#7歩行終了
;ロックマン状態#8着地した瞬間
DoRockman04_StartWalking:
DoRockman07_EndWalking:
DoRockman08_OnLand:
	jsr DoRockman_ShootWeapon
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	beq  DoRockman05_InAir
	ldy <zStatus
	lda <zKeyDown
	and #$C0
	bne .walk
		cpy #$04
		beq .skip_notwalk
			lda aObjFrame
			cmp #$02
			bne DoRockman_CheckJump
.skip_notwalk
		mMOV #$03, <zStatus
		bne DoRockman_CheckJump
.walk
	ldx #$04
	cpy #$04
	bne .skip_walk
		ldy aObjFrame
		dey
		bne DoRockman_CheckJump
		inx
.skip_walk
	stx <zStatus
	rts

;85D3
;ロックマン状態#5歩行中
DoRockman05_Walking:
	jsr DoRockman_ShootWeapon
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	bne DoRockman05_Walking_Skip
DoRockman05_InAir:
	mMOV #$06, <zStatus
	mJSR_NORTS SetRockmanAnimation
DoRockman05_Walking_Skip:
	lda <zKeyDown
	and #$C0
	bne DoRockman_CheckJump
	lda #$07
	sta <zStatus
	bne DoRockman_CheckJump

;85FB
;ロックマン状態#6空中
DoRockman06_Jumping:
	jsr DoRockman_ShootWeapon
	mSTZ aObjVXlo, aObjVX
;滑り速度の減速
	sec
	lda <zSliplo
	sbc #$80
	sta <zSliplo
	bcs .borrow
	dec <zSliphi
	bmi .overflow
.borrow
	bit <zSliplo
	bmi .endslip
	lda <zSliphi
	bne .endslip
.overflow
	mSTZ <zSliplo, <zSliphi
.endslip
	lda <zKeyDown
	and #$C0
	beq .wind
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
	jmp .end_vx
.wind
	lda <zWindFlag  ;空中で滑るフラグは常にOFF？
	beq .end_vx
	jsr DoRockman_SetVX_WithoutSlip
.end_vx
	jsr DoRockman_BodyMoveX
	lda aObjVY
	pha
	jsr DoRockman_BodyMoveY
	pla
	bmi .fall
	lda <$00
	bne .done
	lda <zKeyDown
	lsr a
	bcs .done
	lda aObjVY
	sbc #$01
	bmi .done
	ldy #$01
	sty aObjVY
	dey
	sty aObjVYlo
.done
	rts
.fall
	lda <$00
	beq .done_fall
	mPLAYTRACK #$29
	ldx #$05
	lda <zKeyDownPrev
	and #$C0
	bne .walk
	ldx #$08
.walk
	stx <zStatus
	jmp DoRockman_CheckJump
.done_fall
	mJSR_NORTS SetRockmanAnimation

;86BC
;ロックマン状態#9はしご
;ロックマン状態#Aはしご登りきる時
DoRockman09_Ladder:
DoRockman0A_LadderTop:
	lda #$09
	sta <zStatus
	lda <zKeyDown
	and #$02
	beq .notshoot
	jmp .shoot
.notshoot
	lda #$00
	sta <zAutoFireTimer
.aftershoot
	lda <zKeyDown
	and #$31
	bne .move
	jmp .jump
.move
	and #$30
	beq .skip3
	and #$10
	beq .down
	ldy #$00
	ldx #$C0
	lda <zBGLadder
	and #$0C
	bne .middle
	lda aObjY ;登りきった時、立ち姿にする
	and #$F0
	sec
	sbc #$0C
	sta aObjY
	lda <zOffscreen
	sbc #$00
	sta <zOffscreen
	ldx #$03
	jmp .done
.middle
	and #$08
	bne .skip
	lda #$0A
	sta <zStatus
	bne .skip
.down
	lda <zBGLadder
	cmp #$01
	bne .skip2
	lda aObjY
	clc
	adc #$0C
	sta aObjY
	lda <zOffscreen
	adc #$00
	sta <zOffscreen
.skip2
	ldy #$FF
	ldx #$40
	lda <zBGLadder
	and #$0C
	bne .skip
	lda #$0A
	sta <zStatus
.skip
	lda <zShootPose
	beq .canmove
	ldy #$00
	ldx #$00
.canmove
	sty aObjVY
	stx aObjVYlo
	jsr DoRockman_CheckAttr_Center
	lda <zBGLadder
	beq .skip3
	jsr DoRockman_BodyMoveY
	lda <$00
	beq .skip4
	ldx #$03
	bne .done
.skip3
	ldx #$06
.done
	stx <zStatus
	lda #$00
	sta <zBGLadder
	lda #$C0
	sta aObjVYlo
	lda #$FF
	sta aObjVY
	bne .skip4
.jump
	lda #$00
	sta aObjWait
.skip4
	mJSR_NORTS SetRockmanAnimation
;8769
.shoot
	jsr DoRockman_SetDirection
	jsr FireWeapon
	bcc .skip5
	jmp .aftershoot
.skip5
	jmp .jump

;8776
;ロックマン状態#Bワープ棒上昇
DoRockman0B_Warp:
	sec
	lda aObjFrame
	sbc #$03
	bne .skip
	sta aObjWait
.skip
	rts

;8783
;ロックマン状態別の処理アドレスlo
Table_DoRockmanlo:
	.db LOW(DoRockman00_Land)
	.db LOW(DoRockman01_Fall)
	.db LOW(DoRockman02_KnockBack)
	.db LOW(DoRockman03_Stand)
	.db LOW(DoRockman04_StartWalking)
	.db LOW(DoRockman05_Walking)
	.db LOW(DoRockman06_Jumping)
	.db LOW(DoRockman07_EndWalking)
	.db LOW(DoRockman08_OnLand)
	.db LOW(DoRockman09_Ladder)
	.db LOW(DoRockman0A_LadderTop)
	.db LOW(DoRockman0B_Warp)
;878F
;ロックマン状態別の処理アドレスhi
Table_DoRockmanhi:
	.db HIGH(DoRockman00_Land)
	.db HIGH(DoRockman01_Fall)
	.db HIGH(DoRockman02_KnockBack)
	.db HIGH(DoRockman03_Stand)
	.db HIGH(DoRockman04_StartWalking)
	.db HIGH(DoRockman05_Walking)
	.db HIGH(DoRockman06_Jumping)
	.db HIGH(DoRockman07_EndWalking)
	.db HIGH(DoRockman08_OnLand)
	.db HIGH(DoRockman09_Ladder)
	.db HIGH(DoRockman0A_LadderTop)
	.db HIGH(DoRockman0B_Warp)

;879B
;ロックマンの武器のショット処理
DoRockman_ShootWeapon:
.x = $2E
	lda <zKeyDown
	and #$02
	bne .shoot
	mSTZ <zAutoFireTimer
	beq .dontshoot
.shoot
	jsr FireWeapon
.dontshoot
;はしごに掴まる判定
	lda <zBGLadder
	bne .ladder
.rts
	rts
.ladder
	lda <zKeyDown
	and #$30
	beq .rts
	ora <zBGLadder
	cmp #%00010001
	beq .rts
	cmp #%00101110
	beq .rts
	lda aObjX
	sta <.x
	and #$F0
	ora #$08
	sec
	sta aObjX
	sbc <.x
	bcc .right
	sta <$00
	jsr DoRockman_ScrollRight
	jmp .jump
.right
	eor #$FF
	clc
	adc #$01
	sta <$00
	jsr DoRockman_ScrollLeft
.jump
;掴んだ時、向きを反転。これいる？
;	lda aObjFlags
;	eor #%01000000
;	sta aObjFlags
	jsr SetRockmanAnimation
	pla
	pla
	jmp DoRockman09_Ladder

;87F2
;ロックマンの向きをキー入力状態に応じて変える
DoRockman_SetDirection:
	lda <zKeyDown
	and #$C0
	beq .done
	lda aObjFlags
	and #%10111111
	sta aObjFlags
	lda <zKeyDown
	and #%01000000
	eor #%01000000
	ora aObjFlags
	sta aObjFlags
.done
	rts

;880D
;ロックマンの状態毎にVxをセット
DoRockman_SetVX:
	ldx <zStatus
	cpx #$06
	beq .skip_throwstop
	lda <zShootPose
	cmp #$03
	bne .skip_throwstop
	lda #$00
	ldy #$00
	beq .write
.skip_throwstop
	lda Table_RockmanVXhi,x
	ldy Table_RockmanVXlo,x
.write
	sta aObjVX
	sty aObjVXlo
;風や滑りの補正
	lda <zWindFlag
	bpl DoRockman_SetVX_WithoutSlip
	
	lda aObjFlags
	and #$40
	cmp <zMoveVec
	beq .accel
;滑る方向と移動方向が逆
;滑りに対する抵抗力を決定
.slipresist
	ldx #$00
	lda <zStatus
	cmp #$06
	beq .jumping
	inx
	lda <zKeyDown
	and #$C0
	beq .jumping
	inx
.jumping
	sec
	lda <zSliplo
	sbc Table_SlipDeceleration,x
	sta <zSliplo
	bcs .borrow
	dec <zSliphi
	bmi .overflow
.borrow
	bit <zSliplo
	bmi .endslipresist
	lda <zSliphi
	bne .endslipresist
.overflow
	mSTZ <zSliplo, <zSliphi
	beq .done_slip
.endslipresist
	mMOV <zSliplo, aObjVXlo
	mMOV <zSliphi, aObjVX
	bpl DoRockman_SetVX_WithoutSlip
;滑る方向と移動方向が一致
.accel
	sec
	lda aObjVXlo
	sbc <zSliplo
	lda aObjVX
	sbc <zSliphi
	bcc .slipresist ;if VX < VSlip then
	mMOV aObjVXlo, <zSliplo
	mMOV aObjVX, <zSliphi
.done_slip
	lda aObjFlags
	and #$40
	sta <zMoveVec
DoRockman_SetVX_WithoutSlip:
	lda <zWindFlag
	and #$0F
	beq .skipwind
;88A3
;風の補正
	lda aObjFlags
	and #$40
	cmp <zWindVec
	beq .accel_wind
;風向きと移動方向が逆
	sec
	lda aObjVXlo
	sbc <zWindlo
	sta aObjVXlo
	lda aObjVX
	sbc <zWindhi
	sta aObjVX
	bcc .borrow_wind
		lda aObjFlags
		and #$40
		sta <zMoveVec
		rts
.borrow_wind
	lda aObjVXlo
	eor #$FF
	adc #$01
	sta aObjVXlo
	lda aObjVX
	eor #$FF
	adc #$00
	sta aObjVX
	lda <zWindVec
	sta <zMoveVec
	rts
;風向きと移動方向が一致
.accel_wind
	clc
	lda aObjVXlo
	adc <zWindlo
	sta aObjVXlo
	lda aObjVX
	adc <zWindhi
	sta aObjVX
	lda <zWindVec
	sta <zMoveVec
	rts
;88FA
.skipwind
	lda <zSliphi
	ora <zSliplo
	beq .notslip_wind
	rts
.notslip_wind
	lda aObjFlags
	and #$40
	sta <zMoveVec
	rts
;8909
Table_SlipDeceleration:
	.db $80, $02, $04

;890C
;ロックマンの状態毎のVxhi
Table_RockmanVXhi:
	.db $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00

;8917
;ロックマンの状態毎のVxlo
Table_RockmanVXlo:
	.db $00, $00, $90, $00, $20, $60, $50, $80, $00, $00, $00
	
;8922
;ロックマン横移動
DoRockman_BodyMoveX:
;.r = $2D   ;移動前画面数
;.x = $2E   ;移動前X上位
;.xlo = $2F ;移動前X下位
;	ldx aObjRoom
;	stx <.r
;	ldy aObjX
;	sty <.x
;	lda aObjXlo
;	sta <.xlo
	mSTZ <$00
	bit <zMoveVec
	bvc .left
;右へ移動
	clc
	lda aObjXlo
	adc aObjVXlo
	sta aObjXlo
	lda aObjX
	adc aObjVX
	sta aObjX
	bcc .carry_right
	inc aObjRoom
.carry_right
;右の地形判定
	clc
	lda aObjX
	adc #$08
	sta <$08
	lda aObjRoom
	adc #$00
	jsr DoRockman_WallCheckX
	lda <$00
	beq .nohit_right
	mSTZ aObjXlo
	lda <$08
	and #$0F
	sta <$00
	sec
	lda aObjX
	sbc <$00
	sta aObjX
	bcs .nohit_right
	dec aObjRoom
.nohit_right
	jmp DoRockman_CheckAttr_Center
;89AB
;左へ移動
.left
	sec
	lda aObjXlo
	sbc aObjVXlo
	sta aObjXlo
	lda aObjX
	sbc aObjVX
	sta aObjX
	bcs .borrow_left
	dec aObjRoom
.borrow_left
	sec
	lda aObjX
	sbc #$08
	sta <$08
	lda aObjRoom
	sbc #$00
	jsr DoRockman_WallCheckX
	lda <$00
	beq .nohit_left
	mSTZ aObjXlo
	lda <$08
	and #$0F
	eor #$0F
	sec
	adc aObjX
	sta aObjX
	bcc .nohit_left
	inc aObjRoom
.nohit_left
;8A12
;.done_right
;	jsr DoRockman_ScrollRight
	mJSR_NORTS DoRockman_CheckAttr_Center
;8A19
;.done_left

;8A20
;ロックマンの横移動時の壁判定
DoRockman_WallCheckX:
.n = $02
.blk = $10
	and #$0F
	sta <$09
	lda #$02
	sta <.n
.loop
	ldx <.n
	clc
	lda aObjY
	adc Table_WallCheckX_dy,x
	sta <$0A
	lda <$09
	and #$F0
	php
	lsr a
	lsr a
	lsr a
	lsr a
	plp
	adc Table_WallCheckX_dr,x
	asl a
	asl a
	asl a
	asl a
	ora <$09
	sta <$09
	jsr PickupBlock
	ldx <.n
	mMOV <$00, <zBGAttr,x
	mMOV <$01, <.blk,x
	dec <.n
	bpl .loop
	mSTZ <$00
	ldx #$02
.loop2
	ldy <zBGAttr,x
	lda Table_WallCheck_Attr,y
	bpl .notshutter
	ldy #$02
	sty <zScrollFlag
	bne .continue
.notshutter
	cmp #$03
	bne .continue
	ldy <zInvincible
	bne .continue
	lda #$00
	sta <zStatus
	jmp DieRockman
.continue
	ora <$00
	sta <$00
	dex
	bpl .loop2
	rts
;8A6D
Table_Gravity:
	.db $40, $1E
;8A6F
Table_WaterLevel:
	.db $00, $04
;8A71
Table_JumpPowerhi:
	.db $04, $05
;8A73
Table_JumpPowerlo:
	.db $DF, $80

;8A75
Table_WallCheck_Attr:
	.db $00, $01, $00, $03, $00, $01, $01, $01, $81
;8A7E
Table_WallCheckX_dy:
	.db $F4, $FC, $0B
;8A81
Table_WallCheckX_dr:
	.db $FF, $FF, $00

;8A84
;はしごや水中判定のための地形判定
DoRockman_CheckAttr_Center:
	lda aObjX
	sta <$08
	lda aObjRoom
	sta <$09
	lda #$02
	sta <$01
.loop
	ldx <$01
	clc
	lda aObjY
	adc Table_WallCheckX_dy,x
	sta <$0A
	lda <zOffscreen
	adc Table_WallCheckX_dr,x
	sta <$0B
	jsr PickupMap
	ldx <$01
	lda <$00
	sta <zBGAttr,x
	dec <$01
	bpl .loop
	ldx #$00
	lda <zBossBehaviour
	beq .notboss
	lda <zBossKind
	cmp #$03
	beq .water
.notboss
	lda <zBGAttr2
	cmp #$04
	bne .air
	lda <zWaterLevel
	bne .water
	lda aObjVY
	bpl .water
	mPLAYTRACK #$3B
	lda aObjFlags + $0E
	bmi .water
	ldy #$0E
	ldx #$0E
	jsr CreateWeaponObject
	sec
	lda aObjY + $0E
	sbc #$04
	and #$F0
	sta aObjY + $0E
.water
	inc <zBubbleCounter
	lda <zBubbleCounter
	cmp #$60
	bcc .skip
	beq .createbubble
	cmp #$80
	bcc .skip
	lda #$00
	sta <zBubbleCounter
.createbubble
	lda <zOffscreen
	bne .skip
	stx <zObjIndex
	lda #$0E
	jsr CreateEnemyHere
	bcs .skip
	lda aObjFlags10,y
	and #%11110000
	sta aObjFlags10,y
.skip
	ldx #$00
	inx
.air
	lda Table_Gravity,x
	sta <zGravity
	lda Table_WaterLevel,x
	sta <zWaterLevel
	lda Table_JumpPowerhi,x
	sta <zJumpPowerhi
	lda Table_JumpPowerlo,x
	sta <zJumpPowerlo
	lda #$00
	sta <zBGLadder
	lda #$02
	sta <$01
	ldx #$02
.loop2
	lda <zBGAttr,x
	cmp #$02
	bne .notladder
	lda <$01
	ora <zBGLadder
	sta <zBGLadder
.notladder
	asl <$01
	dex
	bpl .loop2
	sec
	lda aObjYlo
	sbc aObjVYlo
	lda aObjY
	sbc aObjVY
	ldx aObjVY
	bmi .fall
	sec
	sbc #$0C
	sta <$0A
	lda <zOffscreen
	sbc #$00
	jmp .jump
.fall
	clc
	adc #$0C
	sta <$0A
	lda <zOffscreen
	adc #$00
.jump
	sta <$0B
	jsr PickupMap
	lda <$00
	cmp #$02
	bne .done
	lda aObjVY
	bmi .fall2
	lda #$10
	bne .bne
.fall2
	lda #$01
.bne
	ora <zBGLadder
	sta <zBGLadder
.done
	rts

;8B83
;ロックマン縦移動
DoRockman_BodyMoveY:
.vyhi = $00;縦速度の符号
.y = $2E   ;移動前Y上位
.ylo = $2F ;移動前Y下位
	lda aObjY
	sta <.y
	lda aObjYlo
	sta <.ylo
	lda #$00
	sta <.vyhi
	lda aObjVY
	bpl .up
	dec <.vyhi
.up
	sec
	lda aObjYlo
	sbc aObjVYlo
	sta aObjYlo
	lda aObjY
	sbc aObjVY
	sta aObjY
	tax
	lda <zOffscreen
	sbc <.vyhi
	sta <zOffscreen
	cpx #$04
	bcs .godown
	lda <zStatus
	cmp #$09
	beq .scrollup
	cmp #$0A
	bne .skip
.scrollup
	lda #$01
	sta <zScrollFlag
	bne .skip
.godown
	cpx #$E8
	bcc .skip
	lda <zOffscreen
	bmi .skip
	lda #$03
	sta <zScrollFlag
.skip
	lda aObjVY
	bmi DoRockman_BodyMoveY_CheckWallDown
;壁判定・上方向
	sec
	lda aObjY
	sbc #$0C
	sta <$0A
	lda <zOffscreen
	sbc #$00
	sta <$0B
	jsr DoRockman_WallCheckY
	lda <$00
	beq DoRockman_BodyMoveY_NoHit_up
	lda #$00
	sta aObjYlo
	lda <$0A
	and #$0F
	eor #$0F
	sec
	adc aObjY
	sta aObjY
;壁判定・下方向から合流 重力加速度の適用など
DoRockman_BodyMoveY_Done:
	lda #$00
	sta aObjVYlo
	sta aObjVY
DoRockman_BodyMoveY_NoHit_up:
	sec
	lda aObjVYlo
	sbc <zGravity
	sta aObjVYlo
	lda aObjVY
	sbc <zGravityhi
	sta aObjVY
	bpl .done_up
	cmp #$F4
	bcs .done_up
	lda #$00
	sta aObjVYlo
	lda #$F4
	sta aObjVY
.done_up
	rts
;8C28
;壁判定・下方向
DoRockman_BodyMoveY_CheckWallDown
	clc
	lda aObjY
	adc #$0C
	sta <$0A
	lda <zOffscreen
	adc #$00
	sta <$0B
	jsr DoRockman_WallCheckY
	jsr DoRockman_CheckLift
	lda <$00
	bne .hit_down
	bcs .hit_lift
	bcc DoRockman_BodyMoveY_NoHit_up
.hit_down
	lda #$00
	sta aObjYlo
	lda aObjY
	pha
	lda <$0A
	and #$0F
	sta aObjY
	pla
	sec
	sbc aObjY
	sta aObjY
	lda <zOffscreen
	sbc #$00
	sta <zOffscreen
	jmp DoRockman_BodyMoveY_Done
.hit_lift
	lda #$01
	sta <$00
	rts

;8C6A
;Y方向の壁判定
DoRockman_WallCheckY:
.x = $08
.r = $09
.y = $0A
.yhi = $0B
	lda #$01
	sta <$01
.loop
	ldx <$01
	clc
	lda aObjX
	adc Table_WallCheckY_dx,x
	sta <.x
	lda aObjRoom
	adc Table_WallCheckY_dr,x
	sta <.r
	jsr PickupBlock
	ldx <$01
	lda <$00
	sta <zBGAttr,x
	dec <$01
	bpl .loop
	lda #$00
	sta <zWindFlag
	ldx #$01
.loop2
	lda <zBGAttr,x
	cmp #$08
	bcs .skip
	cmp #$05
	bcc .skip
	sbc #$05
	tay
	lda Table_ConveyorFlag,y
	sta <zWindFlag
	bmi .slip
	tay
	lda zConveyorVec - 1,y
	sta <zWindVec
	lda #$01
	sta <zWindhi
	lda #$00
	sta <zWindlo
.slip
	lda #$01
	bne .done
.skip
	cmp #$03
	bne .spike
	ldy <zInvincible
	bne .spike
	lda #$00
	sta <zStatus
	jmp DieRockman
.spike
	dex
	bpl .loop2
	lda <zBGAttr
	ora <zBGAttr2
	and #$01
.done
	sta <$00
	lda <zBGLadder
	beq .ladder
	cmp #$01
	beq .ladder2
	ldx <zOffscreen
	bpl .ladder
	lda <zKeyDown
	and #$30
	beq .ladder
	ldx #$01
	stx <zScrollFlag
.ladder2
	sta <$00
.ladder
	rts

;8CED
Table_WallCheckY_dx:
	.db $07, $F9
;8CEF
Table_WallCheckY_dr:
	.db $00, $FF
;8CF1
Table_ConveyorFlag:
	.db $01, $02, $80

;8CF4
;アイテム、敵リフトの着地判定
DoRockman_CheckLift:
.x = $08
.y = $09
.yprev = $2E ;移動前Y上位
	sec
	lda aObjX
	sbc <zHScroll
	sta <.x
	clc
	lda <.yprev
	adc #$0C
	sta <.y
	lda <zEquipment
	cmp #$09
	bcc .enemylift_begin
	ldx #$02
.loop_item
	lda aWeaponPlatformW,x
	bne .itemlift
.done_item
	dex
	bpl .loop_item
;8D13
;敵リフト判定のループ開始
.enemylift_begin
	ldx #$0F
.loop_enemy
	lda aPlatformWidth10,x
	bne .enemylift
.done_enemy
	dex
	bpl .loop_enemy
	clc
	rts
;8D1F
;敵リフト判定開始
.enemylift
	lda <zOffscreen
	bne .done_enemy
	sec
	lda aObjX10,x
	sbc <zHScroll
	sta <$0C
	sec
	sbc <.x
	bcs .inv_x_enemy
	eor #$FF
	adc #$01
.inv_x_enemy
	cmp aPlatformWidth10,x
	bcs .done_enemy
	lda aObjY10,x
	cmp <.y
	bcc .done_enemy
	lda aPlatformY10,x
	cmp <$0A
	beq .cont_enemy
	bcs .done_enemy
.cont_enemy
	lda aObjAnim10,x
	cmp #$13 ;落下ブロックなら
	bne .droplift
	inc aObjVar10,x
.droplift
;Y位置を調整、着地させる
	sec
	lda aPlatformY10,x
	sbc #$0C
	sta aObjY
	lda <zOffscreen
	sbc #$00
	sta <zOffscreen
	lda #$00
	sta aObjYlo
	sta aObjVYlo
	lda #$FF
	sta aObjVY
	lda #$01
	sta <zWindFlag
	lda aObjFlags10,x
	and #$40
	sta <zWindVec
	lda aObjVXlo10,x
	sta <zWindlo
	lda aObjVX10,x
	sta <zWindhi
	sec
	rts
;8D86
;アイテム系足場判定開始
.itemlift
	lda <zOffscreen
	bne .skip_item
	sec
	lda aObjX + 2,x
	sbc <zHScroll
	sta <$0C
	sec
	sbc <.x
	bcs .inv_x_item
	eor #$FF
	adc #$01
.inv_x_item
	cmp aWeaponPlatformW,x
	bcs .skip_item
	lda aObjY + 2,x
	cmp <.y
	bcc .skip_item
	lda aWeaponPlatformY,x
	cmp <$0A
	beq .cont_item
	bcs .skip_item
.cont_item
	lda aObjAnim + 2,x
	cmp #$3A
	bne .item3
	lda aObjVar + 2,x
	ora #$80
	sta aObjVar + 2,x
.item3
;Y位置を調整、着地させる
	sec
	lda aWeaponPlatformY,x
	sbc #$0C
	sta aObjY
	lda <zOffscreen
	sbc #$00
	sta <zOffscreen
	lda #$00
	sta aObjYlo
	sta aObjVYlo
	lda #$FF
	sta aObjVY
	lda #$01
	sta <zWindFlag
	lda aObjFlags + 2,x
	and #$40
	sta <zWindVec
	lda aObjVXlo + 2,x
	sta <zWindlo
	lda aObjVX + 2,x
	sta <zWindhi
	sec
	rts
.skip_item
	jmp .done_item

;8DF5
;ロックマンの右方向スクロール処理
DoRockman_ScrollRight:
.d = $00 ;スクロール量
.bg = $01;BGタイル書き込み枚数
	sec
	lda aObjX
	sbc <zHScroll
	cmp #$80
	bcs .do
	rts
.do
	clc
	lda <zHScroll
	pha
	adc <.d
	sta <zHScroll
	lda <zRoom
	adc #$00
	sta <zRoom
	cmp <zScrollRight
	bne .stop
	sec
	lda <.d
	sbc <zHScroll
	sta <.d
	lda #$00
	sta <zHScroll
	sta <zHScrolllo
.stop
	pla
	and #$03
	adc <.d
	lsr a
	lsr a
	sta <.bg
	beq .skip
	clc
	lda <zNTNextlo
	sta <zPtrlo
	adc <.bg
	sta <zNTNextlo
	lda <zNTNexthi
	sta <zPtrhi
	adc #$00
	sta <zNTNexthi
	clc
	lda <zNTPrevlo
	adc <.bg
	sta <zNTPrevlo
	lda <zNTPrevhi
	adc #$00
	sta <zNTPrevhi
.loop
	jsr WriteNameTableByScroll
	inc <zNTPointer
	lda <zNTPointer
	and #$3F
	sta <zNTPointer
	clc
	lda <zPtrlo
	adc #$01
	sta <zPtrlo
	lda <zPtrhi
	adc #$00
	sta <zPtrhi
	dec <.bg
	bne .loop
.skip
	rts

;8E65
;ロックマンの左方向スクロール処理
DoRockman_ScrollLeft:
.d = $00
.bg = $01
	sec
	lda aObjX
	sbc <zHScroll
	cmp #$80
	bcc .do
	rts
.do
	sec
	lda <zHScroll
	pha
	sbc <.d
	sta <zHScroll
	lda <zRoom
	sbc #$00
	sta <zRoom
	ldx <zScrollLeft
	dex
	cpx <zRoom
	bne .stop
	inc <zRoom
	clc
	lda <.d
	adc <zHScroll
	sta <.d
	lda #$00
	sta <zHScroll
	sta <zHScrolllo
.stop
	clc
	pla
	eor #$FF
	and #$03
	adc <.d
	lsr a
	lsr a
	sta <.bg
	beq .skip
	sec
	lda <zNTPrevlo
	sta <zPtrlo
	sbc <.bg
	sta <zNTPrevlo
	lda <zNTPrevhi
	sta <zPtrhi
	sbc #$00
	sta <zNTPrevhi
	sec
	lda <zNTNextlo
	sbc <.bg
	sta <zNTNextlo
	lda <zNTNexthi
	sbc #$00
	sta <zNTNexthi
.loop
	jsr WriteNameTableByScroll
	dec <zNTPointer
	lda <zNTPointer
	and #$3F
	sta <zNTPointer
	sec
	lda <zPtrlo
	sbc #$01
	sta <zPtrlo
	lda <zPtrhi
	sbc #$00
	sta <zPtrhi
	dec <.bg
	bne .loop
.skip
	rts
