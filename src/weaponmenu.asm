
	.beginregion "Weapon Menu"
;90EC
;武器選択画面表示の処理開始
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
	lda aPalette - 2,x
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
	lda <zBossType
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
;	sta aPaletteAnimBuf + $05,x
;	sta aPaletteAnimBuf + $15,x
;	sta aPaletteAnimBuf + $25,x
	dex
	bpl .loop_blackout_gutstank
.not_gutstank
	clc
	lda <zHScroll
	adc #$80
	and #%11100000
	sta <$52 ;-----------------------------------------------
	lda <zRoom
	adc #$00
	sta <$53 ;-----------------------------------------------
	lda <zVScroll
	lsr a
	lsr a
	lsr a
	and #%00011110
	adc #$06
	cmp #$20
	bcc .add_voffset
	adc #$02
	pha
	lda <$53
	adc #$10
	sta <$53
	pla
.add_voffset
	and #%00011100
	ora <$52
	sta <$52
	ldx #$00
.loop_drawmenu_open
	stx <$FD
	jsr .write_ppuaddr_loop
	lda #$00
	sta <zPPUSqr
	jsr SetPPUSquareInfo
	ldy <$FD
	ldx .table_menubg_map,y
	cpx #$08
	beq .add_drawmenu_offset
	cpx #$1C
	beq .add_drawmenu_offset
	cpx #$30
	bne .skip_drawmenu_offset
.add_drawmenu_offset
	lda <$52
	and #%00011100
	cmp #$0C
	bne .skip_drawmenu_offset
	txa
	adc #$08 - 1
	tax
.skip_drawmenu_offset
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
	inc <zPPUSqr
	ldy #$9A
	ldx #$00
	jsr Unknown_C75D ;---------------
	jsr FrameAdvance1A
	ldx <$FD
	inx
	cpx #$0F
	bne .loop_drawmenu_open
	stx <$FD
	ldy #$9A
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
;セットアップ終了
;920B
.startloop_menu
.cursor = $FD     ;カーソル位置
.2ndscrflag = $FE ;裏面フラグ
.curwait = $FF    ;カーソル押しっぱなし移動のカウンタ
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
;カーソルが下へ移動
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
;カーソルが上へ移動
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
;キーが押されなかった場合
.skip
	lda #$00
	sta <.curwait
.done
	jsr .showsprites
	jsr FrameAdvance1A
	jmp .loop_menu

;9281
;選択時
.decided
	lda <.cursor
	bne .isnotnext
;NEXTを押した
	lda <.2ndscrflag
	eor #$01
	sta <.2ndscrflag
	jmp .skip
.isnotnext
	cmp #$07
	bne .isweapondecided
;E缶使用
	lda <zETanks
	beq .skip
	lda aObjLife
	cmp #$1C
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
;武器を選択
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
	jsr .write_ppuaddr_loop
	lda #$00
	sta <zPPUSqr
	jsr SetPPUSquareInfo

	ldx <$FD
	; mMOV <$53, <$09
	lda <$08
	lsr a
	lsr a
	sta <$03
	jsr WriteNameTable_WeaponMenu
	inc <zPPUSqr

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
	bcs .isnotweapon
	ldx #$05
	bne .loadweapongraphs
.loadrockmangraphs
	ldy #$90
.isnotweapon
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
;	sta aPaletteAnimBuf + $05,x
;	sta aPaletteAnimBuf + $15,x
;	sta aPaletteAnimBuf + $25,x
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

;ループ中のPPU書き込み開始位置の指定
.write_ppuaddr_loop
	clc
	lda <$52 ;A = XXXY YY00
	tay
	adc .table_menubg_writepos_x,x
	and #%11100000
	sta <$08
	lda <$53
	adc #$00
	sta <$09
	tya
	and #%00011100
	adc .table_menubg_writepos_y,x
	cmp #%00100000
	and #%00011100
	ora <$08
	sta <$08
	bcc .add_voffset_loop
	lda <$09
	adc #$10 - 1
	sta <$09
.add_voffset_loop
	rts

;9393
.table_gutstank_palette
	.db $27, $11, $16

;9396
;武器選択メニューのスプライト表示処理
.showsprites
.basex = $08
.basey = $05
.shrinky = $06
.x = $01
.y = $02
	jsr ClearSprites
	lda <$52
	and #$E0
	sec
	sbc <zHScroll
	sta <.basex
	lda <$52
	and #$1C
	cmp #$0C
	lda #$00
	ror a
	sta <.shrinky ; = ($52 & #$1C) ≧ #$0C
	lda <zVScroll
	cmp #$D0
	bcc .add_basey
	sbc #$10
.add_basey
	eor #$1F
	and #$1F
	cmp #$10
	bcc .skip_basey
	sbc #$20
.skip_basey
	sta <.basey

	ldy #$00
.loop_next ;$962C($00≦Y＜$14) →NEXTを描く
	lda .table_next,y
	sta aSprite,y
	iny
	cpy #$14
	bne .loop_next
;$07に武器取得フラグとアイテム取得フラグを格納
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
;-------------最適化コード-----------
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
	lda #$44 ;武器の頭文字の一番上Y座標
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
	lda .table_1upicon,x ;$964C($00≦X＜$04) Eの文字
	sta aSprite,y
	iny
	inx
	cpx #$04
	bne .loop_e
	sty <$00
	lda #$44 ;ロックマンの体力バーY位置
	sta <.y
	lda aObjLife
	jsr .drawbars_specified
	lda <$07
	lsr a
	sta <$04
	ldx #$00
	lda #$54 ;特殊武器エネルギー量(1番上)Y位置
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
;E缶の●を描画
	ldy <$00
	lda <zETanks
	beq .notanks
	sta <$02
	lda #$1C ;E缶の●X位置左端
.loop_tanks
	sta <.x
	lda #$A4 ;E缶の●Y位置
	sta aSprite,y
	lda #$13 ;E缶の●タイル番号
	sta aSprite + 1,y
	lda #$00 ;パレット番号と属性
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
;裏面
.is2nd_showbars
	ldx #$04
.basesprites2 ;$964C($04≦X＜$17) 1UPの顔と:を描く
	bit <.shrinky
	bpl .skip_basesprites2
	txa
	and #$03
	bne .skip_basesprites2
	lda #$F5
	bne .shrink_basesprites2
.skip_basesprites2
	lda #$00
.shrink_basesprites2
	clc
	adc .table_1upicon,x
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
;処理合流
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
.loop_movexy
	clc
	lda aSprite + 3,x
	adc <.basex
	sta aSprite + 3,x
	lda aSprite + 0,x
	cmp #$F8
	bcs .skip_movey
	bit <.shrinky
	bpl .skip_shrinky
	ldy aSprite + 1,x ;1UP表示は別に調整
	cpy #$8D
	beq .skip_shrinky
	cpy #$8E
	beq .skip_shrinky
	cpy #$1E
	beq .skip_shrinky
	sbc #$10
	lsr a
	lsr a
	lsr a
	lsr a
	eor #$FF
	adc aSprite + 0,x
	clc
.skip_shrinky
	adc <.basey
	sta aSprite + 0,x
.skip_movey
	inx
	inx
	inx
	inx
	bne .loop_movexy
	rts
;9519
;なんだろこれ
.unknown9519
	.db $2C, $3C, $4C, $5C, $6C, $7C, $8C, $9C
	.db $3C, $4C, $5C, $6C, $7C, $8C, $9C, $AC
;9529
;エネルギー残量のバーを表示
;$01に量, $02にY位置
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
;4未満の時
	ldy <$01
	lda #$00
	sta <$01
	lda .table_bars_sprite,y
	ldy <$00
	jmp .merge_drawbars
.over4
;4以上の時
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
;エネルギー残量バーのスプライト位置X
.table_bars_posx
	.db $4C, $44, $3C, $34, $2C, $24, $1C
;956C
;エネルギー残量バーのスプライト番号(3～0)
.table_bars_sprite
	.db $94, $93, $92, $91
;9570
;武器メニューBG部分のマップ定義
.table_menubg_map
	.db $00, $28, $14
	.db $04, $2C, $18
	.db $04, $2C, $18
	.db $04, $2C, $18
	.db $08, $30, $1C
;957F
;武器メニューのBG部分の書き込み位置
.table_menubg_writepos_x
	.db $00 & $E0, $20 & $E0, $40 & $E0
	.db $04 & $E0, $24 & $E0, $44 & $E0
	.db $08 & $E0, $28 & $E0, $48 & $E0
	.db $0C & $E0, $2C & $E0, $4C & $E0
	.db $10 & $E0, $30 & $E0, $50 & $E0
.table_menubg_writepos_y
	.db $00 & $1C, $20 & $1C, $40 & $1C
	.db $04 & $1C, $24 & $1C, $44 & $1C
	.db $08 & $1C, $28 & $1C, $48 & $1C
	.db $0C & $1C, $2C & $1C, $4C & $1C
	.db $10 & $1C, $30 & $1C, $50 & $1C
;958E
;武器メニューBG部分のタイル定義
.table_menubg_tile
	.db $02, $02, $02, $02 ; 左上
	.db $02, $03, $03, $03 ; 左
	.db $02, $03, $03, $03 ; 左下
	.db $02, $03, $03, $03
	.db $02, $03, $03, $03
	.db $02, $02, $02, $02 ; 右上
	.db $03, $03, $03, $02 ; 右
	.db $03, $03, $03, $02 ; 右下
	.db $03, $03, $03, $02
	.db $03, $03, $03, $02
	.db $02, $02, $02, $02 ; 上
	.db $03, $03, $03, $03 ; 中央
	.db $03, $03, $03, $03 ; 下
	.db $03, $03, $03, $03
	.db $03, $03, $03, $03
	.db $02, $02, $02, $02
;961E
;ステージごとの武器メニューの属性テーブル
.table_menubg_attr
	.db $00, $55, $AA, $00, $AA, $00, $00, $00
	.db $00, $00, $55, $AA, $00, $00
;962C
;→NEXT スプライトテーブル
.table_next
	.db $34, $11, $01, $0C
	.db $34, $95, $01, $1C, $34, $96, $01, $24
	.db $34, $97, $01, $2C, $34, $98, $01, $34
;9640
;武器の頭文字 P, H, A, W, B, Q, F, M, C, 1, 2, 3
.table_weapon_letters
	.db $1F
	.db $9F, $9B, $99, $9D, $9C, $9A, $9E, $10
	.db $15, $16, $17
;964C
;E缶のEと、1UP頭と:
.table_1upicon
	.db $A4, $96, $01, $0C
	.db $A0, $8D, $00, $18, $A0, $8D, $40, $20
	.db $A8, $8E, $01, $18, $A8, $8E, $41, $20
	.db $A4, $1E, $01, $2C
;9664
;武器グラフィックへのアドレス上位
.table_weapongraphs_ptr
	.db $98, $9A, $99, $9C, $98, $98, $9A, $98, $9B, $AF, $AF, $AF
;9670
;カーソル移動可能フラグ
.table_cursor_allowflag
	.db $00, $01, $02, $04, $08, $10, $20, $40



;9678
	.endregion "Weapon Menu"
