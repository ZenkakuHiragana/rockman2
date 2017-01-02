
;90EC
;����I����ʕ\���̏����J�n
;___Bank0D_BeginWeaponMenu:
	jsr ClearSprites
	lda #$00
	jsr ChangeBodyColor_Specified
	lda <zVScrollApparentlo
	pha
	lda <zVScrollApparenthi
	pha
	lda <zHScrollApparentlo
	pha
	lda <zHScrollApparenthi
	pha
	lda <zRoomApparent
	pha
	lda <zRoom
	pha
	lda <zHScroll
	pha
	ldx #$11
.loop_backup_palette
	lda aPalette -2,x
	sta aPaletteBackup,x
	dex
	bpl .loop_backup_palette
	lda #$00
	sta <zHScrollApparenthi
	sta <zHScrollApparentlo
	sta <zVScrollApparentlo
	sta <zVScrollApparenthi
	lda <zStage
	cmp #$04
	bne .not_quickman_stage
	lda <zScrollNumber
	cmp #$03
	bcc .not_quickman_stage
	cmp #$0F
	bcs .not_quickman_stage
	cmp #$07
	beq .not_quickman_stage
	ldx #$0F
	txa
.loop_blackout_quickman
	sta aPalette,x
	dex
	bpl .loop_blackout_quickman
	inc <zRoom
.not_quickman_stage
	lda <zBossBehaviour
	beq .not_wily_boss
	lda <zBossKind
	cmp #$08
	bcc .not_wily_boss
	ldx #$00
	stx <zHScroll
	cmp #$0A
	beq .not_wily_boss
	cmp #$0B
	beq .not_wily_boss
	inc <zRoom
.not_wily_boss
	lda #$0A
	cmp <zStage
	bne .not_gutstank
	lda <zBossBehaviour
	beq .not_gutstank
	lda #$0F
	ldx #$02
.loop_blackout_gutstank
	sta aPalette + $05,x
	sta aPaletteAnimBuf + $05,x
	sta aPaletteAnimBuf + $15,x
	sta aPaletteAnimBuf + $25,x
	dex
	bpl .loop_blackout_gutstank
.not_gutstank
	clc
	lda <zHScroll
	adc #$80
	and #$E0
	ora #$04
	sta <$52 ;-----------------------------------------------
	lda <zRoom
	adc #$00
	sta <$53 ;-----------------------------------------------
	ldx #$00
.loop_drawmenu_open
	stx <$FD
	clc
	lda <$52
	adc .table_menubg_writepos,x
	sta <$08
	lda <$53
	adc #$00
	sta <$09
	lda #$00
	sta <zPPUSqr
	jsr SetPPUSquareInfo
	.ifndef ___OPTIMIZE
	ldx <$FD
	lda .table_menubg_map,x
	asl a
	asl a
	asl a
	asl a
	tax
	.else
	ldy <$FD
	ldx .table_menubg_map,y
	.endif
	ldy #$00
.loop_drawmenuppu_open
	lda .table_menubg_tile,x
	sta aPPUSqrData,y
	inx
	iny
	cpy #$10
	bne .loop_drawmenuppu_open
	ldx <zStage
	lda .table_menubg_attr,x
	sta aPPUSqrAttrData
	lda #$01
	sta <zPPUSqr
	ldy #$99
	ldx #$00
	jsr Unknown_C75D ;---------------
	jsr FrameAdvance1A
	ldx <$FD
	inx
	cpx #$0F
	bne .loop_drawmenu_open
	stx <$FD
	ldy #$99
	ldx #$00
	jsr Unknown_C75D
	lda #$00
	sta <$FE
	sta <$FF
	ldx <zEquipment
	inx
	cpx #$07
	bcc .start2ndscreenflag
	txa
	sbc #$06
	tax
	inc <$FE
.start2ndscreenflag
	stx <$FD
.loop_menu
	lda <zClearFlags
	asl a
	ora #$41
	sta <$07
	lda <$FE
	beq .startloop_menu
	lda <zClearFlags
	sta <$07
	lda <zItemFlags
	asl <$07
	rol a
	asl <$07
	rol a
	asl <$07
	rol a
	sta <$07
;�Z�b�g�A�b�v�I��
;920B
.startloop_menu
.cursor = $FD     ;�J�[�\���ʒu
.2ndscrflag = $FE ;���ʃt���O
.curwait = $FF    ;�J�[�\���������ςȂ��ړ��̃J�E���^
	lda <zKeyPress
	and #$08
	beq .do
	jmp .decided
.do
	lda <zKeyPress
	and #$30
	bne .movecursor
	lda <zKeyDown
	and #$30
	beq .skip
	sta <$00
	lda <zKeyDownPrev
	and #$30
	cmp <$00
	bne .skip
	inc <.curwait
	lda <.curwait
	cmp #$18
	bcc .done
	lda #$08
	sta <.curwait
.movecursor
	ldx #$07
	lda <.2ndscrflag
	beq .2ndscreen_bottom
	dex
.2ndscreen_bottom
	mPLAYTRACK #$2F
	lda <zKeyDown
	and #$30
	and #$10
	bne .goup
;�J�[�\�������ֈړ�
.loop_godown
	inc <.cursor
	cpx <.cursor
	bcs .overflow_godown
	lda #$00
	sta <.cursor
.overflow_godown
	ldy <.cursor
	beq .done
	lda .table_cursor_allowflag,y
	and <$07
	beq .loop_godown
	bne .done
;�J�[�\������ֈړ�
.goup
	dec <.cursor
	bpl .overflow_goup
	stx <.cursor
.overflow_goup
	ldy <.cursor
	beq .done
	lda .table_cursor_allowflag,y
	and <$07
	beq .goup
	bne .done
;�L�[��������Ȃ������ꍇ
.skip
	lda #$00
	sta <.curwait
.done
	jsr .showsprites
	jsr FrameAdvance1A
	jmp .loop_menu

;9281
;�I����
.decided
	lda <.cursor
	bne .isnotnext
;NEXT��������
	lda <.2ndscrflag
	eor #$01
	sta <.2ndscrflag
	jmp .skip
.isnotnext
	cmp #$07
	bne .isweapondecided
;E�ʎg�p
	lda <zETanks
	beq .skip
	dec <zETanks
.loop_etank
	lda aObjLife
	cmp #$1C
	beq .skip
	lda <zFrameCounter
	and #$03
	bne .wait_etank
	inc aObjLife
	mPLAYTRACK #$28
.wait_etank
	jsr .showsprites
	jsr FrameAdvance1A
	jmp .loop_etank
.isweapondecided
;�����I��
	lda <.cursor
	beq .skip
	cmp #$07
	beq .skip
	tax
	dex
	lda <.2ndscrflag
	beq .is1st
	clc
	txa
	adc #$06
	tax
.is1st
	stx <zEquipment
	jsr ClearSprites
	lda <zNTPointer
	pha
	ldx #$00
.loop_endmenu
	stx <$FD
	clc
	lda <$52
	adc .table_menubg_writepos,x
	sta <$08
	lda <$53
	adc #$00
	sta <$09
	lda <$08
	lsr <$09
	ror a
	lsr <$09
	ror a
	sta <$08
	and #$3F
	sta <zNTPointer
	clc
	lda <$09
	adc #$85
	sta <$09
	lda #$00
	sta <zPPUSqr
	jsr WriteNameTableByScroll_AnyBank
	lda <$FD
	cmp #$08
	bcs .loadrockmangraphs
	ldx <zEquipment
	.ifndef ___OPTIMIZE
	lda .table_weapongraphs_ptr,x
	tay
	.else
	ldy .table_weapongraphs_ptr,x
	.endif
	cpx #$09
	bcc .isweapon
	ldx #$00
	beq .loadweapongraphs
.isweapon
	ldx #$05
	bne .loadweapongraphs
.loadrockmangraphs
	ldy #$90
	ldx #$00
.loadweapongraphs
	jsr Unknown_C75D
	jsr FrameAdvance1A
	ldx <$FD
	inx
	cpx #$0F
	bne .loop_endmenu
	stx <$FD
	ldy #$90
	ldx #$00
	jsr Unknown_C75D
	jsr ChangeBodyColor
	jsr FrameAdvance1A
	pla
	sta <zNTPointer
	lda <zStage
	cmp #$0A
	bne .not_gutstank_endmenu
	lda <zBossBehaviour
	beq .not_gutstank_endmenu
	ldx #$02
.loop_gutstank_palette
	lda .table_gutstank_palette,x
	sta aPalette + $05,x
	sta aPaletteAnimBuf + $05,x
	sta aPaletteAnimBuf + $15,x
	sta aPaletteAnimBuf + $25,x
	dex
	bpl .loop_gutstank_palette
.not_gutstank_endmenu
	ldx #$11
.loop_palette_restore
	lda aPaletteBackup,x
	sta aPalette - 2,x
	dex
	bpl .loop_palette_restore
	pla
	sta <zHScroll
	pla
	sta <zRoom
	pla
	sta <zRoomApparent
	pla
	sta <zHScrollApparenthi
	pla
	sta <zHScrollApparentlo
	pla
	sta <zVScrollApparenthi
	pla
	sta <zVScrollApparentlo
	lda #$00
	sta <zWeaponEnergy
	sta <zStatus
	sta aObjWait
	sta aObjFrame
	lda #$1A
	sta aObjAnim
	lda #$03
	sta <zStopFlag
	lda #$30
	mJSR_NORTS PlayTrack

;9393
.table_gutstank_palette
	.db $27, $11, $16

;9396
;����I�����j���[�̃X�v���C�g�\������
.showsprites
.basex = $08
.x = $01
.y = $02
	jsr ClearSprites
	lda <$52
	and #$E0
	sec
	sbc <zHScroll
	sta <.basex
	ldy #$00
.loop_next ;$962C($00��Y��$14) ��NEXT��`��
	lda .table_next,y
	sta aSprite,y
	iny
	cpy #$14
	bne .loop_next
;$07�ɕ���擾�t���O�ƃA�C�e���擾�t���O���i�[
	.ifndef ___OPTIMIZE
	lda <zClearFlags
	asl a
	ora #$01
	sta <$07
	lda #$05
	sta <$01
	ldx #$00
	lda <.2ndscrflag
	beq .showsprites_2nd
	ldx #$06
	lda <zClearFlags
	sta <$07
	lda <zItemFlags
	asl <$07
	rol a
	asl <$07
	rol a
	asl <$07
	rol a
	sta <$07
.showsprites_2nd
	lda <$07
;-------------�œK���R�[�h-----------
	.else
	lda #$05
	sta <$01
	lda <zClearFlags
	sec
	ldx <.2ndscrflag
	beq .showsprites_2nd
	ldx #$06
	lda <zClearFlags
	sta <$07
	lda <zItemFlags
	asl <$07
	rol a
	asl <$07
	rol a
	asl <$07
.showsprites_2nd
	rol a
	sta <$07
	.endif
;-------------------------------------
	sta <$02
	lda #$44 ;����̓������̈�ԏ�Y���W
	sta <$00
.loop_showweaponicon
	sta aSprite,y
	lsr <$02
	bcs .showweaponicon
	lda #$F8
	sta aSprite,y
.showweaponicon
	lda .table_weapon_letters,x
	sta aSprite + 1,y
	lda #$01
	sta aSprite + 2,y
	lda #$0C
	sta aSprite + 3,y
	clc
	lda <$00
	adc #$10
	sta <$00
	iny
	iny
	iny
	iny
	inx
	dec <$01
	bpl .loop_showweaponicon
	lda <.2ndscrflag
	bne .is2nd_showbars
	ldx #$00
.loop_e
	lda .table_1upicon,x ;$964C($00��X��$04) E�̕���
	sta aSprite,y
	iny
	inx
	cpx #$04
	bne .loop_e
	sty <$00
	lda #$44 ;���b�N�}���̗̑̓o�[Y�ʒu
	sta <.y
	lda aObjLife
	jsr .drawbars_specified
	lda <$07
	lsr a
	sta <$04
	ldx #$00
	lda #$54 ;���ꕐ��G�l���M�[��(1�ԏ�)Y�ʒu
.loop_bars1
	stx <$03
	sta <.y
	lsr <$04
	bcc .donthaveweapon1st
	jsr .drawbars
.donthaveweapon1st
	clc
	lda <.y
	adc #$10
	ldx <$03
	inx
	cpx #$05
	bne .loop_bars1
;E�ʂ́���`��
	ldy <$00
	lda <zETanks
	beq .notanks
	sta <$02
	lda #$1C ;E�ʂ́�X�ʒu���[
.loop_tanks
	sta <.x
	lda #$A4 ;E�ʂ́�Y�ʒu
	sta aSprite,y
	lda #$13 ;E�ʂ́��^�C���ԍ�
	sta aSprite + 1,y
	lda #$00 ;�p���b�g�ԍ��Ƒ���
	sta aSprite + 2,y
	lda <.x
	sta aSprite + 3,y
	iny
	iny
	iny
	iny
	clc
	lda <.x
	adc #$10
	dec <$02
	bne .loop_tanks
.notanks
	jmp .postdrawbars
;����
.is2nd_showbars
	ldx #$04
.basesprites2 ;$964C($04��X��$17) 1UP�̊��:��`��
	lda .table_1upicon,x
	sta aSprite,y
	iny
	inx
	cpx #$18
	bne .basesprites2
	sty <$00
	lda <$07
	sta <$04
	ldx #$05
	lda #$44
.loop_bars2
	stx <$03
	sta <.y
	lsr <$04
	bcc .donthaveweapon2
	jsr .drawbars
.donthaveweapon2
	clc
	lda <.y
	adc #$10
	ldx <$03
	inx
	cpx #$0B
	bne .loop_bars2
	lda <zLives
	sta <$01
	dec <$01
	lda #$0A
	sta <$02
	jsr Divide8
	ldy <$00
	lda #$A5
	sta aSprite,y
	sta aSprite + 4,y
	clc
	lda <$03
	adc #$14
	sta aSprite + 1,y
	clc
	lda <$04
	adc #$14
	sta aSprite + 4 + 1,y
	lda #$01
	sta aSprite + 2,y
	sta aSprite + 4 + 2,y
	lda #$38
	sta aSprite + 3,y
	lda #$40
	sta aSprite + 4 + 3,y
;94DD
;��������
.postdrawbars
	ldy #$00
	lda <zFrameCounter
	and #$08
	bne .blinkcursor
	ldy #$20
.blinkcursor
	sty <$00
	ldx <.cursor
	bne .notnextselected
	lda <$00
	beq .movex
	lda #$F8
	sta aSprite
	jmp .movex
	
.notnextselected
	dex
	txa
	asl a
	asl a
	tay
	lda <$00
	beq .movex
	lda #$F8
	sta aSprite + $14,y
.movex
	ldx #$00
.loop_movex
	clc
	lda aSprite + 3,x
	adc <.basex
	sta aSprite + 3,x
	inx
	inx
	inx
	inx
	bne .loop_movex
	rts
;9519
;�Ȃ񂾂낱��
.unknown9519
	.db $2C, $3C, $4C, $5C, $6C, $7C, $8C, $9C
	.db $3C, $4C, $5C, $6C, $7C, $8C, $9C, $AC
;9529
;�G�l���M�[�c�ʂ̃o�[��\��
;$01�ɗ�, $02��Y�ʒu
.drawbars
	lda <zEnergyArray,x
.drawbars_specified
	sta <$01
	ldx #$06
.loop_drawbars
	lda <.y
	sta aSprite,y
	sec
	lda <$01
	sbc #$04
	bcs .over4
;4�����̎�
	ldy <$01
	lda #$00
	sta <$01
	lda .table_bars_sprite,y
	ldy <$00
	jmp .merge_drawbars
.over4
;4�ȏ�̎�
	sta <$01
	lda #$90
.merge_drawbars
	sta aSprite + 1,y
	lda #$01
	sta aSprite + 2,y
	lda .table_bars_posx,x
	sta aSprite + 3,y
	iny
	iny
	iny
	iny
	sty <$00
	dex
	bpl .loop_drawbars
	rts
;9565
;�G�l���M�[�c�ʃo�[�̃X�v���C�g�ʒuX
.table_bars_posx
	.db $4C, $44, $3C, $34, $2C, $24, $1C
;956C
;�G�l���M�[�c�ʃo�[�̃X�v���C�g�ԍ�(3�`0)
.table_bars_sprite
	.db $94, $93, $92, $91
;9570
;���탁�j���[BG�����̃}�b�v��`
.table_menubg_map
	.ifndef ___OPTIMIZE
	.db 0, 1, 2
	.db 3, 4, 5
	.db 3, 4, 5
	.db 3, 4, 5
	.db 6, 7, 8
	.else
	.db $00, $10, $20
	.db $30, $40, $50
	.db $30, $40, $50
	.db $30, $40, $50
	.db $60, $70, $80
	.endif
;957F
;���탁�j���[��BG�����̏������݈ʒu
.table_menubg_writepos
	.db $00, $20, $40
	.db $04, $24, $44
	.db $08, $28, $48
	.db $0C, $2C, $4C
	.db $10, $30, $50
;958E
;���탁�j���[BG�����̃^�C����`
.table_menubg_tile
	.db $40, $40, $40, $40
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	
	.db $40, $40, $40, $40
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	
	.db $40, $40, $40, $40
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	.db $40, $41, $41, $41
	.db $40, $40, $40, $40
	
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	.db $41, $41, $41, $41
	.db $40, $40, $40, $40
	
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	.db $41, $41, $41, $40
	.db $40, $40, $40, $40
;961E
;�X�e�[�W���Ƃ̕��탁�j���[�̑����e�[�u��
.table_menubg_attr
	.db $00, $55, $AA, $00, $AA, $00, $00, $00
	.db $00, $00, $55, $AA, $00, $00
;962C
;��NEXT �X�v���C�g�e�[�u��
.table_next
	.db $34, $11, $01, $0C
	.db $34, $95, $01, $1C, $34, $96, $01, $24
	.db $34, $97, $01, $2C, $34, $98, $01, $34
;9640
;����̓����� P, H, A, W, B, Q, F, M, C, 1, 2, 3
.table_weapon_letters
	.db $1F, $9F, $9B, $99, $9D, $9C, $9A, $9E, $10, $15, $16, $17
;964C
;E�ʂ�E�ƁA1UP����:
.table_1upicon
	.db $A4, $96, $01, $0C
	.db $A0, $8D, $00, $18, $A0, $8D, $40, $20
	.db $A8, $8E, $01, $18, $A8, $8E, $41, $20
	.db $A4, $1E, $01, $2C
;9664
;����O���t�B�b�N�ւ̃A�h���X���
.table_weapongraphs_ptr
	.db $98, $9A, $99, $9C, $98, $98, $9A, $98, $9B, $9B, $9B, $9B
;9670
;�J�[�\���ړ��\�t���O
.table_cursor_allowflag
	.db $00, $01, $02, $04, $08, $10, $20, $40



;9678

