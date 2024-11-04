;34000-37FFF

	mBEGIN #$0D, #$8000

Bank0D_BeginStageSelect:
	jmp ___Bank0D_BeginSelectStage ;ステージセレクト画面開始
Bank0D_BeginWeaponMenu:
	jmp ___Bank0D_BeginWeaponMenu ;武器選択画面表示の処理開始
Bank0D_BeginEnterWilyCastle:
	jmp ___Bank0D_BeginEnterWilyCastle ;ワイリー城突入の処理開始
Bank0D_BeginTitleScreen:
	jmp ___Bank0D_BeginTitleScreen ;タイトル画面開始
Bank0D_BeginGameOver:
	jmp ___Bank0D_BeginGameOver ;ゲームオーバー画面開始
Bank0D_BeginEnding:
	jmp ___Bank0D_BeginEnding ;エンディング開始
Bank0D_BeginGetEquipment:
	jmp ___Bank0D_BeginGetEquipment ;武器取得開始

;8015
;ステージセレクト画面開始
___Bank0D_BeginSelectStage:
	.include "src/selectstage.asm"

;829E
;$8499+X-$1F ～ $8499+Xをパレットに書き込み
WritePaletteX_1A:
	ldy #$1F
.loop_palette_specified
	mMOV Table_PaletteData1A,x, aPalette,y
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
	mMOV Table_SelectBoss_CursorRelationship,x, <zStage
.end
	rts
;82CA
;方向キーとボス枠選択先の関係テーブル
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
;ボス選択の選択枠スプライトをセット
SelectBoss_SetFocusSprite:
.dx = $08
.dy = $09
	lda <zFrameCounter
	and #$08
	bne .hide_selectsprite
	ldy <zStage
	mMOV Table_SelectBoss_CursorSpritesY,y, <.dy
	mMOV Table_SelectBoss_CursorSpritesX,y, <.dx
	ldx #$00
.loop
	clc
	mADD Table_SelectBoss_CursorSprites,x, <.dy, aSprite + $E0,x
	inx
	mMOV Table_SelectBoss_CursorSprites,x, aSprite + $E0,x
	inx
	mMOV Table_SelectBoss_CursorSprites,x, aSprite + $E0,x
	inx
	clc
	mADD Table_SelectBoss_CursorSprites,x, <.dx, aSprite + $E0,x
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
;ボス紹介の星スプライトを移動する
SelectBoss_MoveIntroStar:
	ldy #$50
	ldx #$00
	mMOV #$30, <$00
	mMOV #$02, <$03
.loop
	sty <$04
	stx <$05
	.ifndef ___DISABLE_INTRO_PIPI
	lda aObjFlags
	beq .skip
	mMOV #$80, <$00
	lda <zFrameCounter
	and #$04
	bne .skip
	inc <$00
.skip
	.endif
	ldx <$03
	mMOV .table_introstar_num,x, <$01
	clc
	mADD aObjXlo + 1,x, .table_introstar_vxlo,x, aObjXlo + 1,x
	mADD aObjX + 1,x, .table_introstar_vxhi,x, aObjX + 1,x, <$02
	ldx <$05
	ldy <$04
	jsr .introstar_sprite_setup
	inc <$00
	dec <$03
	bpl .loop
	rts
;83A3
.table_introstar_num ;星の大きさごとの数
	.db $07, $0D, $15
.table_introstar_vxlo
	.db $00, $47, $41
.table_introstar_vxhi
	.db $04, $01, $00
;83AC
.introstar_sprite_setup
	mMOV Table_SelectBoss_IntroStarPos,x, aSprite,y
	iny
	mMOV <$00, aSprite,y
	iny
	.ifndef ___DISABLE_INTRO_PIPI
	lda aObjFlags
	beq .ispipi
	lda #$40 ;ピピまみれの場合、左右反転して右向きにする
.ispipi
	.else
	lda #$00
	.endif
	sta aSprite,y
	iny
	clc
	mADD Table_SelectBoss_IntroStarPos + 1,x, <$02, aSprite,y
	iny
	inx
	inx
	dec <$01
	bne .introstar_sprite_setup
	rts
;83D5
;ボス紹介のボスのアニメーションをする
SelectBoss_AnimateBossIntro:
	ldx <zStage
	inc aObjWait
	lda aObjWait
	cmp Table_SelectBoss_IntroAnimWait,x
	bcc .wait_animation_bossintro
	mSTZ aObjWait
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
	mMOV Table_SelectBoss_AnimFramelo,y, <zPtrlo,
	mMOV Table_SelectBoss_AnimFramehi,y, <zPtrhi
	ldy #$00
	mMOV [zPtr],y, <$00 ;スプライトの数
	iny
	ldx #$00
.loop
	clc
	mADD aObjY, [zPtr],y, aSprite,x
	iny
	inx
	mMOV [zPtr],y, aSprite,x
	iny
	inx
	mMOV [zPtr],y, aSprite,x
	iny
	inx
	clc
	mADD aObjX, [zPtr],y, aSprite,x
	inx
	iny
	dec <$00
	bne .loop
	rts

;843C
LoadNameTable843C:
	lda #$00
	jsr LoadGraphicsSet
	mMOVWB $2000, $2006, $2006
	mMOV #LOW(Table_StageSelectNameTable), <$0A
	mMOV #HIGH(Table_StageSelectNameTable), <$0B
	ldx #BANK(Table_StageSelectNameTable) / 2
	jsr LoadGraphicsCompressedAnyBank
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
;スプライト情報を初期化
ClearSprite1A:
	ldx #$00
	lda #$F8
.loop
	sta aSprite,x
	inx
	bne .loop
	rts

;847E
;スクロール位置とパレットアニメーション情報を0に初期化
ResetScrollPosition1A:
	lda #$00
	sta <zHScroll
	sta <zRoom
	sta <zVScroll
	; sta <zVScrolllo
	sta <zVScrollApparentlo
	sta <zVScrollApparenthi
	sta <zHScrollApparentlo
	sta <zHScrollApparenthi
	sta <zRoomApparent
	sta <zPaletteOffset
	sta aPaletteAnim
	sta aPaletteAnimWait
	rts

;8499
;Table_PaletteData1A:
	.include "src/selectstage_data.asm"


;90EC
;武器選択画面表示の処理開始
___Bank0D_BeginWeaponMenu:
	.include "src/weaponmenu.asm"


;9678
;ワイリー城突入時の処理
___Bank0D_BeginEnterWilyCastle:
	.include "src/enterwilycastle.asm"

;9EE7
;タイトル画面の処理
___Bank0D_BeginTitleScreen:
	.include "src/titlescreen.asm"

;A4EB
;画面をONにする
EnableScreen1A:
	mORA <z2001, #%00011000,
	mORA <z2000, #%10000000, <z2000, $2000
	rts

;A4FB
;画面をOFFにする
DisableScreen1A:
	mMOV #%00010000, <z2000, $2000
	mMOV #%00000110, <z2001, $2001
	rts

;A50A
;予約されたPPU矩形書き込みを実行する(画面OFF時に実行可能)
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
;$FDで指定したオープニングのセリフを書き込む
WriteOpeningQuotes:
	ldx <$FD
	ldy #$00
.loop
	mMOV Table_Opening_Quotes,x, aPPULinearData,y
	inx
	iny
	cpy #$15
	bne .loop
	sty <zPPULinear
	stx <$FD
	rts

;A536
;オープニング上昇時、タイトル画面を書き込む処理
;縦スクロール値を$00に保存し、それが奇数なら属性テーブルの書き込み、
;偶数ならネームテーブルの書き込みを行う。
Opening_WriteTitleScreenByScroll:
	sta <$00
	lda <$00
	and #$01
	beq .writenametable
	lda <$00
	eor #$3F
	tax
	mMOV Table_TitleScreen,x, aPPULinearData + 1
	mMOV Table_TitleScreen + 1,x, aPPULinearData
	mMOV #$23, aPPULinearhi
	ldx <$00
	dex
	txa
	ora #$C0
	sta aPPULinearlo
	mMOV #$02, <zPPULinear
	rts

;A562
;オープニング上昇時、タイトル画面のネームテーブル部分を書き込む。
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
	mADD <zPtrlo, #LOW(Table_TitleScreen)
	mADD <zPtrhi, #HIGH(Table_TitleScreen)
	ldy #$1F
.loop
	mMOV [zPtr],y, aPPULinearData,y
	dey
	bpl .loop
	mMOV #$20, <zPPULinear
	rts

;A5AF
;タイトル画面の、ロックマンの髪がなびくアニメーションをやる
Opening_DoRockmanAnimationHair:
	dec aObjWait10
	bne .end
	mMOV #$05, aObjWait10
	inc aObjAnim10
	lda aObjAnim10
	cmp #$02
	bne .end
	mSTZ aObjAnim10
.end
	rts

;A5C9
;タイトルロゴの、Nのスプライトで補っている部分を表示する
Titlelogo_ShowSprites:
	ldx #$14
.loop
	mMOV Table_Title_Sprites_N,x, aSprite + $EC,x
	dex
	bpl .loop
	rts

;A5D5
;オープニング、ビルの突起部と窓のスプライト移動処理
Opening_MoveBuildingSprites:
	ldx #$02
.loop
;窓と突起部の移動と画面外判定→消滅まで
	stx <zObjIndex
	lda aObjAnim,x
	beq .skip
	clc
	mADD aObjYlo,x, aObjVYlo
	mADD aObjY,x, aObjVY
	mADD aObjRoom,x
	bne .skip
	lda aObjY,x
	cmp #$E8
	bcc .skip
	mSTZ aObjAnim,x
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
;上昇中、窓が出現する処理
	sec
	mSUB aObjYlo, aObjVYlo
	mSUB aObjY, aObjVY
	bcs .skip_0
	lda #$01
	jsr Opening_SpawnDetail
	mMOVW $4800, aObjYlo, aObjY
.skip_0
;上昇中、突起部が出現する処理
	sec
	mSUB aObjYlo + 1, aObjVYlo
	mSUB aObjY + 1, aObjVY
	bcs .skip_1
	lda #$02
	jsr Opening_SpawnDetail
	mMOVW $4800, aObjYlo + 1, aObjY + 1
.skip_1
;加速する
	clc
	mADD aObjVYlo, #$02,
	mADD aObjVY
	cmp #$02
	bne .accel_max
	mSTZ aObjVYlo
.accel_max
;ロックマンの移動
	clc
	mADD aObjY10, aObjVY
	mADD aObjRoom10
	rts

;A68D
;$02≦X≦$0Fの範囲にオープニングのビルのディテールを出現させる
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
;スプライトを出現させる
.found
	mMOV <$00, aObjAnim,x
	mMOV #$FF, aObjRoom,x
	mMOVWB $E000, aObjY,x, aObjYlo,x
	rts

;A6B1
;オープニングの建物ディテール部分を描画する
Opening_DrawBuildingSprites:
	jsr ClearSprite1A
	mSTZ <$00
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
	mADD <$08, Table_BuildingSprites,x, aSprite,y
	lda <$09
	adc #$00
	beq .hide
	mMOV #$F8, aSprite,y
	bne .skip
.hide
	mMOV Table_BuildingSprites + 1,x, aSprite + 1,y
	mMOV Table_BuildingSprites + 2,x, aSprite + 2,y
	mMOV Table_BuildingSprites + 3,x, aSprite + 3,y
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
;タイトル画面のロックマンを描く
Opening_DrawRockman:
	ldx aObjAnim10
	mMOV Table_Title_RockmanSpriteslo,x, <zPtrlo
	mMOV Table_Title_RockmanSpriteshi,x, <zPtrhi
	ldy #$00
	mMOV [zPtr],y, <$01
	ldx <$00
	beq .end
	iny
.loop
	clc
	mADD aObjY10, [zPtr],y, aSprite,x
	lda aObjRoom10
	adc #$00
	beq .hide
	iny
	iny
	iny
	iny
	mMOV #$F8, aSprite,x
	bne .continue_loop
.hide
	iny
	mMOV [zPtr],y, aSprite + 1,x
	iny
	mMOV [zPtr],y, aSprite + 2,x
	iny
	mMOV [zPtr],y, aSprite + 3,x
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
;オープニングをスキップした場合ここへ飛ぶ
Opening_Skipped:
	jsr DisableScreen1A
	mMOV #$40, <$FD
	mSTZ aPPULinearlo, <$FE
	mMOV #$10, aPPULinearhi
	mMOV #$B0, <$FF
.loop_loadbg
	jsr WriteTableToPPULinear
	jsr WritePPULinear
	clc
	mADD aPPULinearlo, #$20
	mADD aPPULinearhi
	clc
	mADD <$FE, #$20
	mADD <$FF
	dec <$FD
	bne .loop_loadbg
	mMOVW #Table_TitleScreen + $400 - $20, <zPtr
	mMOV #$20, $2006
	ldy #$00
	sty $2006
	ldx #$1E
.loop_write_titlescreen
	ldy #$00
.loop_write_titlescreen_line
	mMOV [zPtr],y, $2007
	iny
	cpy #$20
	bne .loop_write_titlescreen_line
	sec
	mSUB <zPtrlo, #$20
	mSUB <zPtrhi
	dex
	bne .loop_write_titlescreen
	ldy #$3F
.loop_bg_attr
	mMOV Table_TitleScreen,y, $2007
	dey
	bpl .loop_bg_attr
	ldx #$1F
.loop_bg_palette1
	mMOV Table_Opening_Palette,x, aPalette,x
	dex
	bpl .loop_bg_palette1
	ldx #$0F
.loop_bg_palette2
	mMOV Table_Title_Palette,x, aPalette,x
	dex
	bpl .loop_bg_palette2
	ldx #$1F
	lda #$00
.loop_init_obj
	sta aObjRoom,x
	sta aObjAnim,x
	dex
	bpl .loop_init_obj
	mMOV #$67, aObjY10
	mMOV #$00, aObjAnim10
	mMOV #$08, aObjWait10
	mMOV #$01, aObjAnim + 2
	mMOV #$B0, aObjY + 2
	mMOV #$02, aObjAnim + 3, aObjAnim + 4
	mMOV #$88, aObjY + 3
	mMOV #$D2, aObjY + 4
	jsr EnableScreen1A
	mSTZ <zKeyPress, <zVScroll, <zScreenMod
	jmp BeginTitleScreenSkipped

;A840
;Aで示したマップアドレスからマップを読み込む
WriteMapAddressOffScreen1A:
	sec
	sbc #$02
	sta <zRoom
	mMOV #$F8, <zHScroll
	mSTZ <zVScroll
	mMOV #$20, <$FD
.loop
	ldy #$01
	sty <$00
	dey
	sty <$01
	sty <$02
	jsr WriteNameTableByScroll_AnyBank
	jsr WritePPUScroll
	clc
	mADD <zHScroll, #$08
	bcc .carry_nt
	inc <zRoom
.carry_nt
	dec <$FD
	bne .loop
	rts

;A85A
;BGパレット#2、スプライトのパレット全部を黒くなるまでフェードアウトさせる
FadeoutPalette_BG2_Spr:
	mMOV #$04, <$FD
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
;X～(A+1)までのパレットを1段階フェードアウトさせる。
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
;パレットをフェードインさせる
FadeinPaletteA896:
	mMOV #$04, <$FD
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
;パスワード入力画面の、カーソルと赤玉を描画
Password_DrawCursorStones:
.dx = $08
.dy = $09
	ldx aObjFrame
	mMOV Table_PasswordCursorPositionY,x, <.dy
	mMOV Table_PasswordCursorPositionX,x, <.dx
	ldx #$0F
.loopcursor
	clc
	mADD Table_PasswordCursorSprites,x, <.dx, aSprite + $30,x
	dex
	mMOV Table_PasswordCursorSprites,x, aSprite + $30,x
	dex
	mMOV Table_PasswordCursorSprites,x, aSprite + $30,x
	dex
	clc
	mADD Table_PasswordCursorSprites,x, <.dy, aSprite + $30,x
	dex
	bpl .loopcursor

	lda <zFrameCounter
	lsr a
	and #$07
	tax
	mMOV Table_PasswordCursorColor,x, aPaletteSpr + 6
	clc
	mMOV aObjWait, aSprite + $2C + 1
	ldx #$00
	ldy #$40
.loop_stones
	lda aObjFlags,x
	bne .show
	lda #$0E
	.db $2C
.show
	lda #$19
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
;Xで指定した書き込み位置、サイズ、データを読み取ってPPUへ転送
WriteKeyword1A:
	lda Table_Keywords_ptr,x
	tax
	mMOV Table_Keywords,x, aPPULinearhi
	inx
	mMOV Table_Keywords,x, aPPULinearlo
	inx
	mMOV Table_Keywords,x, <zPPULinear
	inx
	ldy #$00
.loop
	mMOV Table_Keywords,x, aPPULinearData,y
	inx
	iny
	cpy <zPPULinear
	bne .loop
	rts

;A974
;画面位置を指定しつつ、スクロール位置をリセットして、パレットを書き込む。
;さらにスプライトを消して画面表示を有効にする。なんだこれ。
Password_SetScreenPalette:
	sta <zRoom
	mSTZ <zHScroll, <zVScroll
	ldx #$21
.loop
	mMOV Table_Password_PaletteData,x, aPaletteAnim,x
	dex
	bpl .loop
	jsr ClearSprite1A
	mJSR_NORTS EnableScreen1A

;A98E
;パスワード画面で、右へスクロールする
Password_ScrollRight:
	clc
	mADD <zHScroll, #$08
	php
	mADD <zRoom
	plp
	beq .rts
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jmp Password_ScrollRight
.rts
	rts

;A9AC
;Aで指定したマップアドレスからマップを読み込む
WriteMapAddressOnScreen1A:
.target = $FF
.hscroll = $FE
.counter = $FD
.roomstash = $FC
	sta <.target
	mMOV #$18, <.hscroll
	mMOV #$20, <.counter
	mMOV <zRoom, <.roomstash
.loop
	ldy #$01
	sty <$00
	dey
	sty <$01
	stx <$02
	mMOV <.hscroll, <zHScroll
	mMOV <.target, <zRoom
	jsr WriteNameTableByScroll_AnyBank
	mSTZ <zHScroll
	mMOV <.roomstash, <zRoom
	clc
	mADD <.hscroll, #$08
	bcc .carry_nt
	inc <.target
.carry_nt
	jsr FrameAdvance1A
	dec <.counter
	bne .loop
	rts

;A9CB
;パスワード画面で、左にスクロールする
Password_ScrollLeft:
	sec
	mSUB <zHScroll, #$08
	beq .rts
	mSUB <zRoom
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jsr FrameAdvance1A
	jmp Password_ScrollLeft
.rts
	rts

;A9E7
;赤玉スプライトを初期化する
Password_InitStones:
	ldx #$00
	ldy #$40
.loop
	clc
	mADD Table_PasswordCursorPositionY,x, #$04, aSprite,y
	iny
	mMOV #$0E, aSprite,y
	iny
	mSTZ aSprite,y
	iny
	clc
	mADD Table_PasswordCursorPositionX,x, #$04, aSprite,y
	iny
	inx
	cpx #$19
	bne .loop
	rts

;AA11
;オープニングの背景のフェードインテーブル
;Table_Opening_PaletteFadein:
	.include "src/titlescreen_data.asm"


;B01A
;ゲームオーバー画面処理開始
___Bank0D_BeginGameOver:
	.include "src/gameover.asm"

;B20A
;タイトル画面のデータ
Table_TitleScreen:
	.incbin "src/bin/titlescreen.bin"


;B60A
;エンディングの処理
___Bank0D_BeginEnding:
	.include "src/ending.asm"


;B9F9
;武器取得処理
___Bank0D_BeginGetEquipment:
	.include "src/geteq.asm"

