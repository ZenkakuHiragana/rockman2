
;84EE
;���b�N�}����ԕʂ̏���
;DoRockman:
	lda <zStopFlag
	and #$04
	beq .do
	rts
.do
	lda #$00
	sta <zScrollFlag
	ldx <zStatus
	lda Table_DoRockmanlo,x
	sta <zPtrlo
	lda Table_DoRockmanhi,x
	sta <zPtrhi
	jmp [zPtr]

;8508
;���b�N�}�����#0���j���[������Ƃ��́u�҂�����v
DoRockman00_Land:
	lda aObjFrame
	cmp #$04
	bne .skip
	lda #$C0
	sta aObjVYlo
	lda #$FF
	sta aObjVY
	lda #$00
	sta <zStopFlag
	lda #$03
	sta <zStatus
	jsr SetRockmanAnimation
	lda aObjX
	sta <$08
	lda aObjRoom
	sta <$09
	lda aObjY
	sta <$0A
	lda #$00
	sta <$0B
	jsr PickupMap
	lda <$00
	cmp #$04
	bne .skip
	lda #$04
	sta <zWaterLevel
.skip
	rts

;8545
;���b�N�}�����#1�]��
DoRockman01_Fall:
	rts

;8546
;���b�N�}�����#2�m�b�N�o�b�N
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
	ldy #$06
	lda <$00
	beq .air
	ldy #$03
.air
	sty <zStatus
	rts

;8569
;���b�N�}�����#3��~��
DoRockman03_Stand:
	jsr DoRockman_ShootWeapon
	lda <zKeyDown
	and #$C0
	beq .stand
	lda #$04
	sta <zStatus
	jsr DoRockman_SetDirection
.stand
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	bne DoRockman_CheckJump
	lda #$06
	sta <zStatus
	jsr SetRockmanAnimation
	rts
;858E
DoRockman_CheckJump:
	lda <zKeyPress
	and #$01
	beq .nojump
	lda <zJumpPowerlo
	sta aObjVYlo
	lda <zJumpPowerhi
	sta aObjVY
	lda #$06
	sta <zStatus
.nojump
	mJSR_NORTS SetRockmanAnimation

;85A6
;���b�N�}�����#4�����n��
DoRockman04_StartWalking:
	jsr DoRockman_ShootWeapon
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	beq DoRockman05_InAir
	lda <zKeyDown
	and #$C0
	bne .walk
	lda #$03
	sta <zStatus
	bne .done
.walk
	lda aObjFrame
	cmp #$01
	bne .done
	lda #$05
	sta <zStatus
.done
	jmp DoRockman_CheckJump

;85D3
;���b�N�}�����#5���s��
DoRockman05_Walking:
	jsr DoRockman_ShootWeapon
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	bne DoRockman05_Walking_Skip
DoRockman05_InAir:
	lda #$06
	sta <zStatus
	mJSR_NORTS SetRockmanAnimation
DoRockman05_Walking_Skip:
	lda <zKeyDown
	and #$C0
	bne .walk
	lda #$07
	sta <zStatus
.walk
	jmp DoRockman_CheckJump

;85FB
;���b�N�}�����#6��
DoRockman06_Jumping:
	jsr DoRockman_ShootWeapon
	lda #$00
	sta aObjVXlo
	sta aObjVX
	lda <zKeyDown
	and #$C0
	bne .move
	lda <zSliplo
	ora <zSliphi
	bne .slip
	lda <zWindFlag
	and #$0F
	beq .nowind
	jsr DoRockman_SetVX_WithoutSlip
	jmp .nowind
.slip
	sec
	lda <zSliplo
	sbc #$80
	sta <zSliplo
	tax
	lda <zSliphi
	sbc #$00
	sta <zSliphi
	bmi .overflow
	bne .nowind
	cpx #$80
	bcs .nowind
.overflow
	lda #$00
	sta <zSliplo
	sta <zSliphi
	beq .nowind
.move
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
.nowind
	jsr DoRockman_BodyMoveX
	lda aObjVY
	bmi .fall
	jsr DoRockman_BodyMoveY
	lda <$00
	bne .done
	lda <zKeyDown
	and #$01
	bne .done
	lda aObjVY
	bmi .done
	cmp #$01
	bcc .done
	beq .done
	lda #$01
	sta aObjVY
	lda #$00
	sta aObjVYlo
.done
	rts
.fall
	jsr DoRockman_BodyMoveY
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

;868C
;���b�N�}�����#7���s�I��
;���b�N�}�����#8���n�����u��
DoRockman07_EndWalking:
DoRockman08_OnLand:
	jsr DoRockman_ShootWeapon
	jsr DoRockman_SetDirection
	jsr DoRockman_SetVX
	jsr DoRockman_BodyMoveX
	jsr DoRockman_BodyMoveY
	lda <$00
	bne .land
	jmp DoRockman05_InAir
.land
	lda <zKeyDown
	and #$C0
	bne .walk
	lda aObjFrame
	cmp #$02
	bne .skip
	lda #$03
	sta <zStatus
	bne .skip
.walk
	lda #$04
	sta <zStatus
.skip
	jmp DoRockman_CheckJump

;86BC
;���b�N�}�����#9�͂���
;���b�N�}�����#A�͂����o�肫�鎞
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
	lda aObjY ;�o�肫�������A�����p�ɂ���
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
;���b�N�}�����#B���[�v�_�㏸
DoRockman0B_Warp:
	lda aObjFrame
	cmp #$03
	bne .skip
	lda #$00
	sta aObjWait
.skip
	rts

;8783
;���b�N�}����ԕʂ̏����A�h���Xlo
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
;���b�N�}����ԕʂ̏����A�h���Xhi
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
;���b�N�}���̕���̃V���b�g����
DoRockman_ShootWeapon:
.x = $2E
	lda <zKeyDown
	and #$02
	bne .shoot
	lda #$00
	sta <zAutoFireTimer
	beq .noladder
.shoot
	jsr FireWeapon
.noladder
	lda <zBGLadder
	bne .ladder
.rts
	rts
.ladder
	lda <zKeyDown
	and #$30
	beq .rts
	ora <zBGLadder
	cmp #$11
	beq .rts
	cmp #$2E
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
	lda aObjFlags
	eor #%01000000
	sta aObjFlags
	jsr SetRockmanAnimation
	pla
	pla
	jmp DoRockman09_Ladder

;87F2
;���b�N�}���̌������L�[���͏�Ԃɉ����ĕς���
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
;���b�N�}���̏�Ԗ���Vx���Z�b�g
DoRockman_SetVX:
	ldx <zStatus
	lda Table_RockmanVXhi,x
	sta aObjVX
	lda Table_RockmanVXlo,x
	sta aObjVXlo
	lda <zShootPose
	cmp #$03
	bne .throw
	lda <zStatus
	cmp #$06
	beq .throw
	lda #$00
	sta aObjVXlo
	sta aObjVX
.throw
	lda <zWindFlag
	bmi .slip
	lda <zSliplo
	ora <zSliphi
	beq DoRockman_SetVX_WithoutSlip
	bne .slip2
.slip
	lda aObjFlags
	and #$40
	cmp <zMoveVec
	beq .accel
.slip2
	ldx #$00
	lda <zStatus
	cmp #$06
	beq .skip
	inx
	lda <zKeyDown
	and #$C0
	beq .skip
	inx
.skip
	sec
	lda <zSliplo
	sbc Table_SlipDeceleration,x
	sta <zSliplo
	tax
	lda <zSliphi
	sbc #$00
	sta <zSliphi
	bmi .overflow
	bne .stop
	cpx #$80
	bcs .stop
.overflow
	lda #$00
	sta <zSliplo
	sta <zSliphi
	beq .skip2
.stop
	lda <zSliplo
	sta aObjVXlo
	lda <zSliphi
	sta aObjVX
	jmp DoRockman_SetVX_WithoutSlip
.accel
	sec
	lda aObjVXlo
	sbc <zSliplo
	lda aObjVX
	sbc <zSliphi
	bcc .slip2
	lda aObjVXlo
	sta <zSliplo
	lda aObjVX
	sta <zSliphi
.skip2
	lda aObjFlags
	and #$40
	sta <zMoveVec
DoRockman_SetVX_WithoutSlip:
	lda <zWindFlag
	bpl .wind
	rts
;88A3
.wind
	and #$0F
	beq .notwind
	lda aObjFlags
	and #$40
	cmp <zWindVec
	beq .accel_wind
	sec
	lda aObjVXlo
	sbc <zWindlo
	sta aObjVXlo
	lda aObjVX
	sbc <zWindhi
	sta aObjVX
	bcc .overflow_wind
	lda aObjFlags
	and #$40
	sta <zMoveVec
	rts
.overflow_wind
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
.notwind
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
;���b�N�}���̏�Ԗ���Vxhi
Table_RockmanVXhi:
	.db $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $00

;8917
;���b�N�}���̏�Ԗ���Vxlo
Table_RockmanVXlo:
	.db $00, $00, $90, $00, $20, $60, $50, $80, $00, $00, $00

;8922
;���b�N�}�����ړ�
DoRockman_BodyMoveX:
.r = $2D   ;�ړ��O��ʐ�
.x = $2E   ;�ړ��OX���
.xlo = $2F ;�ړ��OX����
	ldx aObjRoom
	stx <.r
	ldy aObjX
	sty <.x
	lda aObjXlo
	sta <.xlo
	lda #$00
	sta <$00
	lda <zMoveVec
	and #$40
	beq .left
;�E�ֈړ�
	cpx <zScrollRight
	bne .lim_right
	cpy #$EC
	bcc .lim_right
	lda #$02
	sta <zScrollFlag
	jmp .done_right
.lim_right
	clc
	lda aObjXlo
	adc aObjVXlo
	sta aObjXlo
	lda aObjX
	adc aObjVX
	sta aObjX
	lda aObjRoom
	adc #$00
	sta aObjRoom
	clc
	lda aObjX
	adc #$08
	sta <$08
	lda aObjRoom
	adc #$00
	sta <$09
	jsr DoRockman_WallCheckX
	lda <$00
	beq .nohit_right
	lda #$00
	sta aObjXlo
	lda <$08
	and #$0F
	sta <$00
	sec
	lda aObjX
	sbc <$00
	sta aObjX
	lda aObjRoom
	sbc #$00
	sta aObjRoom
.nohit_right
	sec
	lda aObjX
	sbc <.x
	sta <$00
	bpl .done_right
	clc
	eor #$FF
	adc #$01
	sta <$00
	jmp .done_left
;89AB
;���ֈړ�
.left
	cpx <zScrollLeft
	bne .lim_left
	cpy #$14
	bcs .lim_left
	jmp .done_left
.lim_left
	sec
	lda aObjXlo
	sbc aObjVXlo
	sta aObjXlo
	lda aObjX
	sbc aObjVX
	sta aObjX
	lda aObjRoom
	sbc #$00
	sta aObjRoom
	sec
	lda aObjX
	sbc #$08
	sta <$08
	lda aObjRoom
	sbc #$00
	sta <$09
	jsr DoRockman_WallCheckX
	lda <$00
	beq .nohit_left
	lda #$00
	sta aObjXlo
	lda <$08
	and #$0F
	eor #$0F
	sec
	adc aObjX
	sta aObjX
	lda aObjRoom
	adc #$00
	sta aObjRoom
.nohit_left
	sec
	lda <.x
	sbc aObjX
	sta <$00
	bpl .done_left
	eor #$FF
	clc
	adc #$01
	sta <$00
;8A12
.done_right
	jsr DoRockman_ScrollRight
	mJSR_NORTS DoRockman_CheckAttr_Center
;8A19
.done_left
	jsr DoRockman_ScrollLeft
	mJSR_NORTS DoRockman_CheckAttr_Center
;8A20
;���b�N�}���̉��ړ����̕ǔ���
DoRockman_WallCheckX:
.n = $01
	lda #$02
	sta <.n
.loop
	ldx <.n
	clc
	lda aObjY
	adc Table_WallCheckX_dy,x
	sta <$0A
	lda <zOffscreen
	adc Table_WallCheckX_dr,x
	sta <$0B
	jsr PickupBlock
	ldx <.n
	lda <$00
	sta <zBGAttr,x
	dec <.n
	bpl .loop
	lda #$00
	sta <$00
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
;�͂����␅������̂��߂̒n�`����
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
;���b�N�}���c�ړ�
DoRockman_BodyMoveY:
.vyhi = $00;�c���x�̕���
.y = $2E   ;�ړ��OY���
.ylo = $2F ;�ړ��OY����
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
;�ǔ���E�����
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
;�ǔ���E���������獇�� �d�͉����x�̓K�p�Ȃ�
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
;�ǔ���E������
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
;Y�����̕ǔ���
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
;�A�C�e���A�G���t�g�̒��n����
DoRockman_CheckLift:
.x = $08
.y = $09
.yprev = $2E ;�ړ��OY���
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
;�G���t�g����̃��[�v�J�n
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
;�G���t�g����J�n
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
	cmp #$13 ;�����u���b�N�Ȃ�
	bne .droplift
	inc aObjVar10,x
.droplift
;Y�ʒu�𒲐��A���n������
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
;�A�C�e���n���ꔻ��J�n
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
;Y�ʒu�𒲐��A���n������
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
;���b�N�}���̉E�����X�N���[������
DoRockman_ScrollRight:
.d = $00 ;�X�N���[����
.bg = $01;BG�^�C���������ݖ���
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
;���b�N�}���̍������X�N���[������
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
