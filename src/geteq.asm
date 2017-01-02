
;B9F9
;����擾����
___Bank0D_BeginGetEquipment:
	lda #$03
	jsr LoadGraphicsSet
	lda #$06
	jsr LoadGraphicsSet
	lda <zStage
	pha
	mMOV #$05, <zStage
	mMOVW $8F40, <zPtr
	jsr WriteMapAddressOffScreen1A
	mMOVW $8F80, <zPtr
	jsr WriteMapAddressOffScreen1A
	pla
	sta <zStage
	mPLAYTRACK #$17
	jsr ResetScrollPosition1A
	lda #$01
	jsr Password_SetScreenPalette
	ldx #$0F
	txa
.loop_initpalette
	sta aPaletteSpr,x
	dex
	bpl .loop_initpalette
	mMOV #$06, aObjAnim
	jsr ChangeBank_ShowEndingRockman
	mMOV #$05, <$FD
.loop_fadein
	lda <zFrameCounter
	and #$07
	bne .wait_fadein
	ldx #$1B
	ldy #$3B
	lda #$0F
	jsr FadeinPaletteSpecified
	dec <$FD
	beq .end_fadein
.wait_fadein
	jsr FrameAdvance1A
	jmp .loop_fadein
.end_fadein
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	jsr WaitForAWhile1A
	inc aPPULinearlo
	ldx <zStage
	mMOV Table_GetEqWeaponLetter,x, aPPULinearData
	inc <zPPULinear
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	inc aPPULinearlo
	inc aPPULinearlo
	jsr FrameAdvance1A
	lda <zStage
	jsr WriteWeaponName1A
	lda #$08
	jsr WriteWeaponName1A
	mMOV #$9C, <$FD
.loop_changecolor
	ldx #$00
	lda <$FD
	and #$01
	beq .changecolor
	ldx <zStage
	inx
	txa
	asl a
	tax
.changecolor
	lda Table_GetEqRockmanColor,x
	sta aPaletteSpr + $02
	sta aPaletteSpr + $0A
	lda Table_GetEqRockmanColor + 1,x
	sta aPaletteSpr + $03
	sta aPaletteSpr + $0B
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_changecolor
	ldx <zStage
	lda ItemBitTable,x
	beq .noitem
	jsr GetEquipment_Item
.noitem
	ldx #$08
	jsr WriteKeyword1A
	jsr FrameAdvance1A
	ldx #$09
	jsr WriteKeyword1A
	jsr FrameAdvance1A
.begin_select
	ldx #$03
.loop_curspr
	mMOV Table_GetEqCursorSprite,x, aSprite + $FC,x
	dex
	bpl .loop_curspr
	mMOV #$30, aPaletteSpr + $0E
	mSTZ <$FD
.loop_select
	ldx <$FD
	mMOV Table_GetEqCursorY,x, aSprite + $FC
	lda <zFrameCounter
	and #$08
	bne .hide
	mMOV #$F8, aSprite + $FC
.hide
	lda <zKeyPress
	and #$3C
	beq .noinput
	and #$08
	bne .decided
	mPLAYTRACK #$2F
	lda <$FD
	eor #$01
	sta <$FD
.noinput
	jsr FrameAdvance1A
	jmp .loop_select
.decided
	lda <$FD
	beq .password
	jmp .stageselect
.password
	ldx #$1F
.loop_backup
	mMOV aPalette,x, aPaletteBackup,x
	dex
	bpl .loop_backup
	jsr ShowPassword
	jsr ChangeBank_ShowEndingRockman
	mMOV #$05, <$FD
.loop_password
	lda <zFrameCounter
	and #$03
	bne .wait
	ldx #$1F
;�Ȃɂ���Ă�̂���
.loop_palette
	lda aPalette,x
	cmp #$0F
	bne .jump1
	lda aPaletteBackup,x
	and #$0F
	sta aPalette,x
	jmp .jump3
.jump1
	clc
	adc #$10
	cmp aPaletteBackup,x
	beq .jump2
	bcs .jump3
.jump2
	sta aPalette,x
.jump3
	dex
	bpl .loop_palette
	dec <$FD
	beq .end
.wait
	jsr FrameAdvance1A
	jmp .loop_password
.end
	jmp .begin_select
.stageselect
	mJSR_NORTS DisableScreen1A

;BB6B
;�A�C�e������̏���
GetEquipment_Item:
	lda #$0F
	sta aPalette + 6
	sta aPalette + 7
	ldx #$02
.loop_palette
	mMOV Table_GetEqDrRightColor,x, aPaletteSpr + $0D,x
	dex
	bpl .loop_palette
	jsr ClearSprite1A
	jsr GetEquipment_ClearScreen
	mMOV #$7D, <$FD
.loop_flash
	ldx #$0F
	lda <$FD
	and #$08
	beq .flash
	ldx #$15
.flash
	stx aPaletteSpr
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_flash
	mMOV #$07, aObjAnim
	jsr ChangeBank_ShowEndingRockman
	lda #$09
	jsr WriteWeaponName1A
	lda #$0A
	jsr WriteWeaponName1A
	jsr Wait7DFrames1A
	jsr GetEquipment_ClearScreen
	ldx <zStage
	lda ItemBitTable,x
	lsr a
	ora #$A0
	sta aObjFlags
	inc aObjFlags
	jsr WriteMinus2_1A
	lda #$0E
	jsr WriteWeaponName1A
	lda #$0B
	jsr WriteWeaponName1A
	lda #$0C
	jsr WriteWeaponName1A
	lda #$0D
	jsr WriteWeaponName1A
	jsr Wait7DFrames1A
	jsr GetEquipment_ClearScreen
	jsr ClearSprite1A
	mMOV #$06, aObjAnim
	jsr ChangeBank_ShowEndingRockman
	jsr WriteMinus2_1A
	lda aObjFlags
	and #$0F
	clc
	adc #$0E
	jsr WriteWeaponName1A
	lda #$08
	jsr WriteWeaponName1A
	mMOV #$7D, <$FD
.loop_changecolor
	ldx #$12
	lda <$FD
	and #$01
	bne .changecolor
	ldx <zStage
	inx
	txa
	asl a
	tax
.changecolor
	lda Table_GetEqRockmanColor,x
	sta aPaletteSpr + $02
	sta aPaletteSpr + $0A
	lda Table_GetEqRockmanColor + 1,x
	sta aPaletteSpr + $03
	sta aPaletteSpr + $0B
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_changecolor
	rts

;BC29
;�������̍���-��`��
WriteMinus1A:
	mMOVWB $24CD, aPPULinearhi
	mMOV #$94, aPPULinearData
	inc <zPPULinear
	rts
;BC3B
;�����҂�
WaitForAWhile1A:
	jsr FrameAdvance1A
	lda <zFrameCounter
	and #$07
	bne WaitForAWhile1A
	rts

;BC45
;���햼������
WriteWeaponName1A:
	asl a
	asl a
	sta <$00
	asl a
	adc <$00
	tax
	mMOV Table_GetEqKeywords,x, aPPULinearhi
	mMOV Table_GetEqKeywords + 1,x, aPPULinearlo
	inx
	inx
	stx <$FE
	mMOV #$0A, <$FD
.loop_write_weaponname
	jsr WaitForAWhile1A
	ldx <$FE
	cpx #$AE
	bne .skip
	lda aObjFlags
	bne .skip2
.skip
	lda Table_GetEqKeywords,x
.skip2
	sta aPPULinearData
	inc <zPPULinear
	inc aPPULinearlo
	inc <$FE
	dec <$FD
	bne .loop_write_weaponname
	mJSR_NORTS FrameAdvance1A

;BC84
;7Dh�t���[���҂�
Wait7DFrames1A:
	mMOV #$7D, <$FD
.loop
	jsr FrameAdvance1A
	dec <$FD
	bne .loop
	rts

;BC90
;����������
GetEquipment_ClearScreen:
	ldx #$1F
	lda #$00
.loop_init
	sta aPPULinearData,x
	dex
	bpl .loop_init
	mMOV #$09, <$FD
	mMOVWB $24AD, aPPULinearhi
.loop
	clc
	lda aPPULinearlo
	adc #$20
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	mMOV #$0C, <zPPULinear
	jsr FrameAdvance1A
	dec <$FD
	bpl .loop
	rts

;BCC5
;-��2�����Ă�c�c�H
WriteMinus2_1A
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	jsr WaitForAWhile1A
	inc aPPULinearlo
	ldx <zStage
	mMOV aObjFlags, aPPULinearData
	inc <zPPULinear
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	inc aPPULinearlo
	inc aPPULinearlo
	mJSR_NORTS FrameAdvance1A

;BCEB
;����擾�̎��ɏo�铪����
Table_GetEqWeaponLetter:
	.db $48, $41, $57, $42, $51, $46, $4D, $43

;BCF3
;���햼��u�� �\�E�r�V�}�X..�v�Ȃǂ̕�����
Table_GetEqKeywords:
;�A�g�~�b�N�t�@�C���[
	.db $25, $0D
	.db $60, $73, $7F, $8E, $67, $7B, $95, $61, $83, $94
;�G�A�[�V���[�^�[�@�@
	.db $25, $0D
	.db $63, $60, $94, $6B, $90, $94, $6F, $94, $40, $40
;���[�t�V�[���g�J�@�@
	.db $25, $0D
	.db $87, $94, $7B, $6B, $94, $88, $73, $92, $40, $40
;�n�J�t�J�����[�g�J�@
	.db $25, $0D
	.db $79, $92, $7B, $92, $88, $87, $94, $73, $92, $40
;�N�C�b�N�t�J�[������
	.db $25, $0D
	.db $67, $61, $8E, $67, $7B, $92, $94, $81, $86, $8D
;�^�C���X�g�b�n�K�[�@
	.db $25, $0D
	.db $6F, $61, $80, $6C, $73, $8E, $79, $93, $94, $40
;���^���t�J���[�g�J�@
	.db $25, $0D
	.db $81, $6F, $88, $7B, $92, $89, $94, $73, $92, $40
;�N���b�V���z�J���@�@
	.db $25, $0D
	.db $67, $86, $8E, $6B, $90, $7D, $92, $80, $40, $40
;���@�\�E�q�J�V�}�X�@
	.db $25, $4D
	.db $8B, $40, $6E, $62, $7A, $92, $6B, $7E, $6C, $40
;�cr.���C�g�@�J���@�m
	.db $25, $2D
	.db $44, $5B, $86, $61, $73, $40, $65, $86, $40, $78
;���b�Z�[�V�J�@�e�J�X
	.db $25, $6D
	.db $81, $8E, $6D, $94, $6B, $92, $40, $72, $92, $6C
;�J���Z�C�V�^�I�@�@�@
	.db $25, $4D
	.db $65, $8D, $6D, $61, $6B, $6F, $5F, $40, $40, $40
;�^�^�J�`�j�@�\�E�q�J
	.db $25, $8D
	.db $6F, $6F, $92, $70, $75, $40, $6E, $62, $7A, $92
;�V�^�}�G�I�I�@�@�@�@
	.db $25, $CD
	.db $6B, $6F, $7E, $63, $5F, $5F, $40, $40, $40, $40
;�A�C�e���@�R�J�E�J�J
	.db $25, $0D
	.db $60, $61, $72, $80, $40, $69, $92, $62, $65, $92
;�A�C�e���P�R�J�E�@�@
	.db $25, $0D
	.db $60, $61, $72, $80, $A1, $69, $92, $62, $40, $40
;�A�C�e���Q�R�J�E�@�@
	.db $25, $0D
	.db $60, $61, $72, $80, $A2, $69, $92, $62, $40, $40
;�A�C�e���R�R�J�E�@�@
	.db $25, $0D
	.db $60, $61, $72, $80, $A3, $69, $92, $62, $40, $40

;BDCB
;����擾���b�N�}���̐F
Table_GetEqRockmanColor:
	.db $2C, $11
	.db $28, $15
	.db $20, $11
	.db $20, $19
	.db $20, $00
	.db $34, $25
	.db $34, $14
	.db $37, $18
	.db $20, $26
	.db $20, $16

;BDDF
;����擾�J�[�\����Y�ʒu
Table_GetEqCursorY:
	.db $B0, $C0

;BDE1
;����擾�J�[�\���̃X�v���C�g���
Table_GetEqCursorSprite
	.db $B0, $22, $03, $40

;BDE5
;�A�C�e�����莞�̔��m�̐F
Table_GetEqDrRightColor:
	.db $20, $10, $36

