;34000-37FFF

	mBEGIN #$0D, #$8000
	
Bank0D_BeginStageSelect:
	jmp ___Bank0D_BeginSelectStage ;�X�e�[�W�Z���N�g��ʊJ�n
Bank0D_BeginWeaponMenu:
	jmp ___Bank0D_BeginWeaponMenu ;����I����ʕ\���̏����J�n
Bank0D_BeginEnterWilyCastle:
	jmp ___Bank0D_BeginEnterWilyCastle ;���C���[��˓��̏����J�n
Bank0D_BeginTitleScreen:
	jmp ___Bank0D_BeginTitleScreen ;�^�C�g����ʊJ�n
Bank0D_BeginGameOver:
	jmp ___Bank0D_BeginGameOver ;�Q�[���I�[�o�[��ʊJ�n
Bank0D_BeginEnding:
	jmp ___Bank0D_BeginEnding ;�G���f�B���O�J�n
Bank0D_BeginGetEquipment:
	jmp ___Bank0D_BeginGetEquipment ;����擾�J�n

;8015
;�X�e�[�W�Z���N�g��ʊJ�n
___Bank0D_BeginSelectStage:
	.include "src/selectstage.asm"

;829E
;$8499+X-$1F �` $8499+X���p���b�g�ɏ�������
WritePaletteX_1A:
	ldy #$1F
.loop_palette_specified
	lda Table_PaletteData1A,x
	sta aPalette,y
	dex
	dey
	bpl .loop_palette_specified
	rts

;82AB
SelectBossFocus:
	lda <zKeyPress
	lsr a
	lsr a
	lsr a
	lsr a
	beq .end
	cmp #$09
	bcs .end
	sta <$00
	dec <$00
	lda <zStage
	asl a
	asl a
	asl a
	clc
	adc <$00
	tax
	lda Table_SelectBoss_CursorRelationship,x
	sta <zStage
.end
	rts
;82CA
;�����L�[�ƃ{�X�g�I���̊֌W�e�[�u��
Table_SelectBoss_CursorRelationship:
	.db $02, $06, $00, $08, $00, $00, $00, $04
	.db $01, $08, $01, $01, $01, $01, $01, $02
	.db $02, $00, $02, $01, $02, $02, $02, $03
	.db $03, $04, $03, $02, $03, $03, $03, $03
	.db $03, $05, $04, $00, $04, $04, $04, $04
	.db $04, $05, $05, $06, $05, $05, $05, $05
	.db $00, $06, $06, $07, $06, $06, $06, $05
	.db $08, $07, $07, $07, $07, $07, $07, $06
	.db $01, $07, $08, $08, $08, $08, $08, $00
;8312
;�{�X�I���̑I��g�X�v���C�g���Z�b�g
SelectBoss_SetFocusSprite:
.dx = $08
.dy = $09
	lda <zFrameCounter
	and #$08
	bne .hide_selectsprite
	ldy <zStage
	lda Table_SelectBoss_CursorSpritesY,y
	sta <.dy
	lda Table_SelectBoss_CursorSpritesX,y
	sta <.dx
	ldx #$00
.loop
	clc
	lda Table_SelectBoss_CursorSprites,x
	adc <.dy
	sta aSprite + $E0,x
	inx
	lda Table_SelectBoss_CursorSprites,x
	sta aSprite + $E0,x
	inx
	lda Table_SelectBoss_CursorSprites,x
	sta aSprite + $E0,x
	inx
	clc
	lda Table_SelectBoss_CursorSprites,x
	adc <.dx
	sta aSprite + $E0,x
	inx
	cpx #$10
	bne .loop
	rts
.hide_selectsprite
	lda #$F8
	ldx #$0F
.loop_hide_selectsprite
	sta aSprite + $E0,x
	dex
	bpl .loop_hide_selectsprite
	rts

;8358
;�{�X�Љ�̐��X�v���C�g���ړ�����
SelectBoss_MoveIntroStar:
	ldy #$50
	ldx #$00
	lda #$30
	sta <$00
	lda #$02
	sta <$03
.loop
	sty <$04
	stx <$05
	lda aObjFlags
	beq .skip
	lda #$80
	sta <$00
	lda <zFrameCounter
	and #$04
	bne .skip
	inc <$00
.skip
	ldx <$03
	lda .table_introstar_num,x
	sta <$01
	clc
	lda aObjXlo + 1,x
	adc .table_introstar_vxlo,x
	sta aObjXlo + 1,x
	lda aObjX + 1,x
	adc .table_introstar_vxhi,x
	sta aObjX + 1,x
	sta <$02
	ldx <$05
	ldy <$04
	jsr .introstar_sprite_setup
	inc <$00
	dec <$03
	bpl .loop
	rts
;83A3
.table_introstar_num ;���̑傫�����Ƃ̐�
	.db $07, $0D, $15
.table_introstar_vxlo
	.db $00, $47, $41
.table_introstar_vxhi
	.db $04, $01, $00
;83AC
.introstar_sprite_setup
	lda Table_SelectBoss_IntroStarPos,x
	sta aSprite,y
	iny
	lda <$00
	sta aSprite,y
	iny
	lda aObjFlags
	beq .ispipi
	lda #$40 ;�s�s�܂݂�̏ꍇ�A���E���]���ĉE�����ɂ���
.ispipi
	sta aSprite,y
	iny
	clc
	lda Table_SelectBoss_IntroStarPos + 1,x
	adc <$02
	sta aSprite,y
	iny
	inx
	inx
	dec <$01
	bne .introstar_sprite_setup
	rts
;83D5
;�{�X�Љ�̃{�X�̃A�j���[�V����������
SelectBoss_AnimateBossIntro:
	ldx <zStage
	inc aObjWait
	lda aObjWait
	cmp Table_SelectBoss_IntroAnimWait,x
	bcc .wait_animation_bossintro
	lda #$00
	sta aObjWait
	inc aObjFrame
	lda Table_SelectBoss_IntroAnimFrames,x
	cmp aObjFrame
	bcs .wait_animation_bossintro
	sta aObjFrame
.wait_animation_bossintro
	lda Table_SelectBoss_AnimationPtr,x
	clc
	adc aObjFrame
	tax
	ldy Table_SelectBoss_AnimationData,x
	lda Table_SelectBoss_AnimFramelo,y
	sta <zPtrlo
	lda Table_SelectBoss_AnimFramehi,y
	sta <zPtrhi
	ldy #$00
	lda [zPtr],y
	sta <$00 ;�X�v���C�g�̐�
	iny
	ldx #$00
.loop
	clc
	lda aObjY
	adc [zPtr],y
	sta aSprite,x
	iny
	inx
	lda [zPtr],y
	sta aSprite,x
	iny
	inx
	lda [zPtr],y
	sta aSprite,x
	iny
	inx
	clc
	lda aObjX
	adc [zPtr],y
	sta aSprite,x
	inx
	iny
	dec <$00
	bne .loop
	rts

;843C
LoadNameTable843C:
	lda #$00
	jsr LoadGraphicsSet
	lda #$20
	sta $2006
	ldy #$00
	sty $2006
	lda #$AE
	sta <$09
	lda #$0B
	jsr LoadScreenData
	ldy #$1F
.loop2
	lda Table_Unknown863F,y
	ldx #$20
.loop
	sta $2007
	dex
	bne .loop
	dey
	bpl .loop2
	rts

;8465
SelectBoss_ResetObjX:
	ldx #$02
	lda #$00
.loop
	sta aObjX + 1,x
	sta aObjXlo + 1,x
	dex
	bpl .loop
	rts

;8473
;�X�v���C�g����������
ClearSprite1A:
	ldx #$00
	lda #$F8
.loop
	sta aSprite,x
	inx
	bne .loop
	rts

;847E
;�X�N���[���ʒu�ƃp���b�g�A�j���[�V��������0�ɏ�����
ResetScrollPosition1A:
	lda #$00
	sta <zHScroll
	sta <zRoom
	sta <zVScroll
	sta <zVScrolllo
	sta <zVScrollApparentlo
	sta <zVScrollApparenthi
	sta <zHScrollApparentlo
	sta <zHScrollApparenthi
	sta <zRoomApparent
	sta aPaletteAnim
	sta aPaletteAnimWait
	rts

;8499
;Table_PaletteData1A:
	.include "src/selectstage_data.asm"


;90EC
;����I����ʕ\���̏����J�n
___Bank0D_BeginWeaponMenu:
	.include "src/weaponmenu.asm"


;9678
;���C���[��˓����̏���
___Bank0D_BeginEnterWilyCastle:
	.include "src/enterwilycastle.asm"

;9EE7
;�^�C�g����ʂ̏���
___Bank0D_BeginTitleScreen:
	.include "src/titlescreen.asm"

;A4EB
;��ʂ�ON�ɂ���
EnableScreen1A:
	lda <z2001
	ora #%00011000
	sta <z2001
	lda <z2000
	ora #%10000000
	sta <z2000
	sta $2000
	rts

;A4FB
;��ʂ�OFF�ɂ���
DisableScreen1A:
	lda #%00010000
	sta <z2000
	sta $2000
	lda #%00000110
	sta <z2001
	sta $2001
	rts

;A50A
;�\�񂳂ꂽPPU��`�������݂����s����(���OFF���Ɏ��s�\)
WritePPUSquare1A:
	lda <$08
	pha
	lda <$09
	pha
	lda <zPPUSqr
	jsr WritePPUSquare
	clc
	pla
	sta <$09
	pla
	sta <$08
	inc <$08
	inc <zNTPointer
	rts

;A521
;$FD�Ŏw�肵���I�[�v�j���O�̃Z���t����������
WriteOpeningQuotes:
	ldx <$FD
	ldy #$00
.loop
	lda Table_Opening_Quotes,x
	sta aPPULinearData,y
	inx
	iny
	cpy #$15
	bne .loop
	sty <zPPULinear
	stx <$FD
	rts

;A536
;�I�[�v�j���O�㏸���A�^�C�g����ʂ��������ޏ���
;�c�X�N���[���l��$00�ɕۑ����A���ꂪ��Ȃ瑮���e�[�u���̏������݁A
;�����Ȃ�l�[���e�[�u���̏������݂��s���B
Opening_WriteTitleScreenByScroll:
	sta <$00
	lda <$00
	and #$01
	beq .writenametable
	lda <$00
	eor #$3F
	tax
	lda Table_TitleScreen,x
	sta aPPULinearData + 1
	lda Table_TitleScreen + 1,x
	sta aPPULinearData
	lda #$23
	sta aPPULinearhi
	ldx <$00
	dex
	txa
	ora #$C0
	sta aPPULinearlo
	lda #$02
	sta <zPPULinear
	rts

;A562
;�I�[�v�j���O�㏸���A�^�C�g����ʂ̃l�[���e�[�u���������������ށB
.writenametable
	lda <$00
	lsr a
	cmp #$1E
	bcc .do
	rts
.do
	asl a
	asl a
	asl a
	asl a
	rol <zPtrlo
	asl a
	rol <zPtrlo
	sta aPPULinearlo
	lda <zPtrlo
	and #$03
	ora #$20
	sta aPPULinearhi
	lda <$00
	lsr a
	eor #$1F
	sta <zPtrhi
	lda #$00
	lsr <zPtrhi
	ror a
	lsr <zPtrhi
	ror a
	lsr <zPtrhi
	ror a
	sta <zPtrlo
	clc
	lda <zPtrlo
	adc #LOW(Table_TitleScreen)
	sta <zPtrlo
	lda <zPtrhi
	adc #HIGH(Table_TitleScreen)
	sta <zPtrhi
	ldy #$1F
.loop
	lda [zPtr],y
	sta aPPULinearData,y
	dey
	bpl .loop
	lda #$20
	sta <zPPULinear
	rts

;A5AF
;�^�C�g����ʂ́A���b�N�}���̔����Ȃт��A�j���[�V���������
Opening_DoRockmanAnimationHair:
	dec aObjWait10
	bne .end
	lda #$05
	sta aObjWait10
	inc aObjAnim10
	lda aObjAnim10
	cmp #$02
	bne .end
	lda #$00
	sta aObjAnim10
.end
	rts

;A5C9
;�^�C�g�����S�́AN�̃X�v���C�g�ŕ���Ă��镔����\������
Titlelogo_ShowSprites:
	ldx #$14
.loop
	lda Table_Title_Sprites_N,x
	sta aSprite + $EC,x
	dex
	bpl .loop
	rts

;A5D5
;�I�[�v�j���O�A�r���̓ˋN���Ƒ��̃X�v���C�g�ړ�����
Opening_MoveBuildingSprites:
	ldx #$02
.loop
;���ƓˋN���̈ړ��Ɖ�ʊO���聨���ł܂�
	stx <zObjIndex
	lda aObjAnim,x
	beq .skip
	clc
	lda aObjYlo,x
	adc aObjVYlo
	sta aObjYlo,x
	lda aObjY,x
	adc aObjVY
	sta aObjY,x
	lda aObjRoom,x
	adc #$00
	sta aObjRoom,x
	bne .skip
	lda aObjY,x
	cmp #$E8
	bcc .skip
	lda #$00
	sta aObjAnim,x
.skip
	ldx <zObjIndex
	inx
	cpx #$0F
	bne .loop
	lda <zScreenMod
	bne .skip_ascend
	lda <zVScroll
	cmp #$A8
	bcc .skip_1
.skip_ascend
;�㏸���A�����o�����鏈��
	sec
	lda aObjYlo
	sbc aObjVYlo
	sta aObjYlo
	lda aObjY
	sbc aObjVY
	sta aObjY
	bcs .skip_0
	lda #$01
	jsr Opening_SpawnDetail
	lda #$00
	sta aObjYlo
	lda #$48
	sta aObjY
.skip_0
;�㏸���A�ˋN�����o�����鏈��
	sec
	lda aObjYlo + 1
	sbc aObjVYlo
	sta aObjYlo + 1
	lda aObjY + 1
	sbc aObjVY
	sta aObjY + 1
	bcs .skip_1
	lda #$02
	jsr Opening_SpawnDetail
	lda #$00
	sta aObjYlo + 1
	lda #$48
	sta aObjY + 1
.skip_1
;��������
	clc
	lda aObjVYlo
	adc #$02
	sta aObjVYlo
	lda aObjVY
	adc #$00
	sta aObjVY
	cmp #$02
	bne .accel_max
	lda #$00
	sta aObjVYlo
.accel_max
;���b�N�}���̈ړ�
	clc
	lda aObjY10
	adc aObjVY
	sta aObjY10
	lda aObjRoom10
	adc #$00
	sta aObjRoom10
	rts

;A68D
;$02��X��$0F�͈̔͂ɃI�[�v�j���O�̃r���̃f�B�e�[�����o��������
Opening_SpawnDetail:
	sta <$00
	ldx #$02
.loop
	lda aObjAnim,x
	beq .found
	inx
	cpx #$0F
	bne .loop
	rts
;A69C
;�X�v���C�g���o��������
.found
	lda <$00
	sta aObjAnim,x
	lda #$FF
	sta aObjRoom,x
	lda #$E0
	sta aObjY,x
	lda #$00
	sta aObjYlo,x
	rts

;A6B1
;�I�[�v�j���O�̌����f�B�e�[��������`�悷��
Opening_DrawBuildingSprites:
	jsr ClearSprite1A
	lda #$00
	sta <$00
	ldx #$02
.loop_obj
	stx <zObjIndex
	lda aObjAnim,x
	beq .skip_obj
	ldy aObjY,x
	sty <$08
	ldy aObjRoom,x
	sty <$09
	ldx #$00
	ldy #$0C
	cmp #$01
	beq .iswindow
	ldy #$04
	ldx #$30
.iswindow
	sty <$02
	ldy <$00
.loop
	clc
	lda <$08
	adc Table_BuildingSprites,x
	sta aSprite,y
	lda <$09
	adc #$00
	beq .hide
	lda #$F8
	sta aSprite,y
	bne .skip
.hide
	lda Table_BuildingSprites + 1,x
	sta aSprite + 1,y
	lda Table_BuildingSprites + 2,x
	sta aSprite + 2,y
	lda Table_BuildingSprites + 3,x
	sta aSprite + 3,y
	iny
	iny
	iny
	iny
.skip
	inx
	inx
	inx
	inx
	dec <$02
	bne .loop
	sty <$00
.skip_obj
	ldx <zObjIndex
	inx
	cpx #$0F
	bne .loop_obj
	rts

;A719
;�^�C�g����ʂ̃��b�N�}����`��
Opening_DrawRockman:
	ldx aObjAnim10
	lda Table_Title_RockmanSpriteslo,x
	sta <zPtrlo
	lda Table_Title_RockmanSpriteshi,x
	sta <zPtrhi
	ldy #$00
	lda [zPtr],y
	sta <$01
	ldx <$00
	beq .end
	iny
.loop
	clc
	lda aObjY10
	adc [zPtr],y
	sta aSprite,x
	lda aObjRoom10
	adc #$00
	beq .hide
	iny
	iny
	iny
	iny
	lda #$F8
	sta aSprite,x
	bne .continue_loop
.hide
	iny
	lda [zPtr],y
	sta aSprite + 1,x
	iny
	lda [zPtr],y
	sta aSprite + 2,x
	iny
	lda [zPtr],y
	sta aSprite + 3,x
	iny
.continue_loop
	inx
	inx
	inx
	inx
	beq .end
	dec <$01
	bne .loop
.end
	rts

;A76A
;�I�[�v�j���O���X�L�b�v�����ꍇ�����֔��
Opening_Skipped:
	jsr DisableScreen1A
	mMOV #$50, <$FD
	mSTZ aPPULinearlo, <$FE
	mMOV #$10, aPPULinearhi
	mMOV #$B0, <$FF
.loop_loadbg
	jsr WriteTableToPPULinear
	jsr WritePPULinear
	clc
	lda aPPULinearlo
	adc #$20
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	clc
	lda <$FE
	adc #$20
	sta <$FE
	lda <$FF
	adc #$00
	sta <$FF
	dec <$FD
	bne .loop_loadbg
	mMOVW #Table_TitleScreen + $400 - $20, <zPtr
	lda #$20
	sta $2006
	ldy #$00
	sty $2006
	ldx #$1E
.loop_write_titlescreen
	ldy #$00
.loop_write_titlescreen_line
	lda [zPtr],y
	sta $2007
	iny
	cpy #$20
	bne .loop_write_titlescreen_line
	sec
	lda <zPtrlo
	sbc #$20
	sta <zPtrlo
	lda <zPtrhi
	sbc #$00
	sta <zPtrhi
	dex
	bne .loop_write_titlescreen
	ldy #$3F
.loop_bg_attr
	lda Table_TitleScreen,y
	sta $2007
	dey
	bpl .loop_bg_attr
	ldx #$1F
.loop_bg_palette1
	lda Table_Opening_Palette,x
	sta aPalette,x
	dex
	bpl .loop_bg_palette1
	ldx #$0F
.loop_bg_palette2
	lda Table_Title_Palette,x
	sta aPalette,x
	dex
	bpl .loop_bg_palette2
	ldx #$1F
	lda #$00
.loop_init_obj
	sta aObjRoom,x
	sta aObjAnim,x
	dex
	bpl .loop_init_obj
	lda #$67
	sta aObjY10
	lda #$00
	sta aObjAnim10
	lda #$08
	sta aObjWait10
	lda #$01
	sta aObjAnim + 2
	lda #$B0
	sta aObjY + 2
	lda #$02
	sta aObjAnim + 3
	sta aObjAnim + 4
	lda #$88
	sta aObjY + 3
	lda #$D2
	sta aObjY + 4
	jsr EnableScreen1A
	lda #$00
	sta <zKeyPress
	sta <zVScroll
	sta <zScreenMod
	jmp BeginTitleScreenSkipped

;A840
;$08~$09�Ŏ������}�b�v�A�h���X����}�b�v��ǂݍ���
WriteMapAddressOffScreen1A;
	lda #$00
	sta <zNTPointer
	sta <zPPUSqr
.loop
	jsr WriteNameTableByScroll_AnyBank
	inc <$08
	inc <zNTPointer
	jsr WriteNameTableByScroll_AnyBank
	jsr WritePPUSquare1A
	lda <$08
	and #$3F
	bne .loop
	rts

;A85A
;BG�p���b�g#2�A�X�v���C�g�̃p���b�g�S���������Ȃ�܂Ńt�F�[�h�A�E�g������
FadeoutPalette_BG2_Spr:
	lda #$04
	sta <$FD
.loop_wait
	lda <zFrameCounter
	and #$03
	bne .wait
	jsr .fadeout
	dec <$FD
	bmi .rts
.wait
	jsr FrameAdvance1A
	jmp .loop_wait
.rts
	rts
;X�`(A+1)�܂ł̃p���b�g��1�i�K�t�F�[�h�A�E�g������B
.fadeout
	ldx #$07
	lda #$04
	jsr .fadeout_palette
	ldx #$1F
	lda #$0F
	mJSR_NORTS .fadeout_palette
.fadeout_palette
	sta <$00
.loop_palette
	sec
	lda aPalette,x
	sbc #$10
	bpl .write
	lda #$0F
.write
	sta aPalette,x
	dex
	cpx <$00
	bne .loop_palette
	rts

;A896
;�p���b�g���t�F�[�h�C��������
FadeinPaletteA896:
	lda #$04
	sta <$FD
.loop
	lda <zFrameCounter
	and #$03
	bne .wait
	jsr .fadein
	dec <$FD
	bmi .rts
.wait
	jsr FrameAdvance1A
	jmp .loop
.rts
	rts
.fadein
	ldx #$07
	ldy #$07
	lda #$04
	jsr FadeinPaletteSpecified
	ldx #$1F
	ldy #$1F
	lda #$0F
	mJSR_NORTS FadeinPaletteSpecified
;A8C1
FadeinPaletteSpecified:
	sta <$01
.loop_fadein
	lda aPalette,x
	cmp #$0F
	bne .notblack
	lda Table_Password_Palette,y
	and #$0F
	jmp .write
.notblack
	clc
	lda aPalette,x
	adc #$10
	cmp Table_Password_Palette,y
	beq .write
	bcs .dontwrite
.write
	sta aPalette,x
.dontwrite
	dey
	dex
	cpx <$01
	bne .loop_fadein
	rts

;A8E9
;�p�X���[�h���͉�ʂ́A�J�[�\���Ɛԋʂ�`��
Password_DrawCursorStones:
.dx = $08
.dy = $09
	ldx aObjFrame
	lda Table_PasswordCursorPositionY,x
	sta <.dy
	lda Table_PasswordCursorPositionX,x
	sta <.dx
	ldx #$0F
.loopcursor
	clc
	lda Table_PasswordCursorSprites,x
	adc <.dx
	sta aSprite + $30,x
	dex
	lda Table_PasswordCursorSprites,x
	sta aSprite + $30,x
	dex
	lda Table_PasswordCursorSprites,x
	sta aSprite + $30,x
	dex
	clc
	lda Table_PasswordCursorSprites,x
	adc <.dy
	sta aSprite + $30,x
	dex
	bpl .loopcursor

	lda <zFrameCounter
	lsr a
	and #$07
	tax
	lda Table_PasswordCursorColor,x ;cursor color table
	sta aPaletteSpr + 6
	clc
	lda aObjWait
	adc #$24
	sta aSprite + $2C + 1
	ldx #$00
	ldy #$40
.loop_stones
	lda aObjFlags,x
	bne .hide
	lda #$F8
	bne .write
.hide
	lda #$3F
.write
	sta aSprite + 1,y
	iny
	iny
	iny
	iny
	inx
	cpx #$19
	bne .loop_stones
	rts

;A94D
;X�Ŏw�肵���������݈ʒu�A�T�C�Y�A�f�[�^��ǂݎ����PPU�֓]��
WriteKeyword1A:
	lda Table_Keywords_ptr,x
	tax
	lda Table_Keywords,x
	sta aPPULinearhi
	inx
	lda Table_Keywords,x
	sta aPPULinearlo
	inx
	lda Table_Keywords,x
	sta <zPPULinear
	inx
	ldy #$00
.loop
	lda Table_Keywords,x
	sta aPPULinearData,y
	inx
	iny
	cpy <zPPULinear
	bne .loop
	rts

;A974
;��ʈʒu���w�肵�A�X�N���[���ʒu�����Z�b�g���āA�p���b�g���������ށB
;����ɃX�v���C�g�������ĉ�ʕ\����L���ɂ���B�Ȃ񂾂���B
Password_SetScreenPalette:
	sta <zRoom
	lda #$00
	sta <zHScroll
	sta <zVScroll
	ldx #$21
.loop
	lda Table_Password_PaletteData,x
	sta aPaletteAnim,x
	dex
	bpl .loop
	jsr ClearSprite1A
	mJSR_NORTS EnableScreen1A

;A98E
;�p�X���[�h��ʂŁA�E�փX�N���[������
Password_ScrollRight:
	clc
	lda <zHScroll
	adc #$08
	sta <zHScroll
	php
	lda <zRoom
	adc #$00
	sta <zRoom
	plp
	beq .rts
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jmp Password_ScrollRight
.rts
	rts

;A9AC
;$08~$09�Ŏw�肵���}�b�v�A�h���X����}�b�v��ǂݍ���
WriteMapAddressOnScreen1A:
	lda #$00
	sta <zPPUSqr
	sta <zNTPointer
.loop
	lda <$FD
	sta <$08
	lda <$FE
	sta <$09
	jsr WriteNameTableByScroll_AnyBank
	inc <$FD
	inc <zNTPointer
	jsr FrameAdvance1A
	lda <$FD
	and #$3F
	bne .loop
	rts

;A9CB
;�p�X���[�h��ʂŁA���ɃX�N���[������
Password_ScrollLeft:
	sec
	lda <zHScroll
	sbc #$08
	sta <zHScroll
	beq .rts
	lda <zRoom
	sbc #$00
	sta <zRoom
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jmp Password_ScrollLeft
.rts
	rts

;A9E7
;�ԋʃX�v���C�g������������
Password_InitStones:
	ldx #$00
	ldy #$40
.loop
	clc
	lda Table_PasswordCursorPositionY,x
	adc #$04
	sta aSprite,y
	iny
	lda #$0F
	sta aSprite,y
	iny
	lda #$00
	sta aSprite,y
	iny
	clc
	lda Table_PasswordCursorPositionX,x
	adc #$04
	sta aSprite,y
	iny
	inx
	cpx #$19
	bne .loop
	rts

;AA11
;�I�[�v�j���O�̔w�i�̃t�F�[�h�C���e�[�u��
;Table_Opening_PaletteFadein:
	.include "src/titlescreen_data.asm"


;B01A
;�Q�[���I�[�o�[��ʏ����J�n
___Bank0D_BeginGameOver:
	.include "src/gameover.asm"

;B20A
;�^�C�g����ʂ̃f�[�^
Table_TitleScreen:
	.incbin "src/bin/titlescreen.bin"


;B60A
;�G���f�B���O�̏���
___Bank0D_BeginEnding:
	.include "src/ending.asm"


;B9F9
;����擾����
___Bank0D_BeginGetEquipment:
	.include "src/geteq.asm"

