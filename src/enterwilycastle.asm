
;9678
;
;___Bank0D_BeginEnterWilyCastle:
	lda #$10
	sta <z2000
	sta $2000
	lda #$06
	sta <z2001
	sta $2001
	lda #$0F
	jsr Write_Reg0_A
	jsr ResetScrollPosition1A
	lda #$01
	jsr LoadGraphicsSet
	lda #$20
	sta $2006
	ldy #$00
	sty $2006
.loop_skybg2
	lda .table_skybg,y
	ldx #$40
.loop_skybg
	sta $2007
	dex
	bne .loop_skybg
	iny
	cpy #$10
	bne .loop_skybg2
	lda #$28
	sta $2006
	ldy #$00
	sty $2006
	lda #$AC
	sta <$09
	lda #$03
	jsr LoadScreenData
	ldx #$1F
.loop_palette_begin
	lda .table_palette_wilycastle,x
	sta aPalette,x
	dex
	bpl .loop_palette_begin
	jsr ClearSprite1A
	lda <zStage
	cmp #$09
	bcc .begin_ufo
	jsr .enter_wilycastle_2nd
	jmp .beginflashcastle
;96DA
;UFOが飛んでいく
.begin_ufo
	mPLAYTRACK #$12
	jsr EnableScreen1A
	lda #$FF
	sta aObjRoom
	sta aObjRoom + 1
	lda #$D0
	sta aObjX
	sta aObjX + 1
	lda #$68
	sta aObjY
	lda #$80
	sta aObjY + 1
	lda #$00
	sta aObjAnim
	sta aObjWait + 1
	sta aObjXlo
	sta aObjXlo + 1
	sta aObjYlo
	sta aObjYlo + 1
	lda #$01
	sta aObjAnim + 1
.loop_move_ufo
	clc
	lda aObjXlo
	adc #$40
	sta aObjXlo
	lda aObjX
	adc #$01
	sta aObjX
	sta aObjX + 1
	lda aObjRoom
	adc #$00
	sta aObjRoom
	sta aObjRoom + 1
	bne .skip_stopufo
	lda aObjX
	cmp #$68
	bcs .stopufo
.skip_stopufo
	jsr .animate_ufo
	jsr ClearSprite1A
	ldx #$00
	stx <$00
	jsr .show_sprite_ufo
	ldx #$01
	jsr .show_sprite_ufo
	jsr FrameAdvance1A
	jmp .loop_move_ufo
;UFO停止
.stopufo
	jsr ClearSprite1A
	ldx #$00
	stx <$00
	jsr .show_sprite_ufo
	ldx #$01
	jsr .show_sprite_ufo
	lda #$3E
	sta <$FD
.loop_wait_ufo
	jsr .animate_ufo
	ldx #$00
	stx <$00
	jsr .show_sprite_ufo
	ldx #$01
	jsr .show_sprite_ufo
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_ufo
;釜が開く
	lda #$04
	sta aObjAnim + 2
	lda #$6C
	sta aObjX + 2
	lda #$70
	sta aObjY + 2
	lda #$00
	sta aObjRoom + 2
	lda #$50
	sta <$FD
.loop_open_ufo
	sec
	lda aObjYlo
	sbc #$80
	sta aObjYlo
	lda aObjY
	sbc #$00
	sta aObjY
	jsr .animate_ufo
	jsr .show_ufo_all
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_open_ufo
;眉毛
	lda #$FA
	sta <$FD
.loop_eyebrows
	inc aObjWait + 2
	lda aObjWait + 2
	cmp #$08
	bcc .skip_eyebrows
	lda #$00
	sta aObjWait + 2
	inc aObjAnim + 2
	lda aObjAnim + 2
	cmp #$06
	bcc .skip_eyebrows
	lda #$04
	sta aObjAnim + 2
.skip_eyebrows
	jsr .animate_ufo
	jsr .show_ufo_all
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_eyebrows
;釜が閉じる
	lda #$50
	sta <$FD
.loop_close_ufo
	clc
	lda aObjYlo
	adc #$80
	sta aObjYlo
	lda aObjY
	adc #$00
	sta aObjY
	jsr .animate_ufo
	jsr .show_ufo_all
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_close_ufo
;横に揺れる
	mPLAYTRACK #$FD
	
	lda #$06
	sta aObjAnim
	lda #$01
	sta aObjFrame
	lda #$00
	sta <$FD
	sta aObjVXlo
	lda #$04
	sta aObjVX
.loop_shake
	lda aObjFrame
	bne .go_right
	ldx #$00
	lda aObjX
	cmp #$68
	bcs .slowdown_left
	inx
.slowdown_left
	clc
	lda aObjVXlo
	adc .table_ufo_accel_lo,x
	sta aObjVXlo
	lda aObjVX
	adc .table_ufo_accel_hi,x
	sta aObjVX
	sec
	lda aObjXlo
	sbc aObjVXlo
	sta aObjXlo
	lda aObjX
	sbc aObjVX
	sta aObjX
	cmp #$18
	bcs .wait_shake
	bcc .invert_vector_shake
.go_right
	ldx #$00
	lda aObjX
	cmp #$68
	bcc .slowdown_right
	inx
.slowdown_right
	clc
	lda aObjVXlo
	adc .table_ufo_accel_lo,x
	sta aObjVXlo
	lda aObjVX
	adc .table_ufo_accel_hi,x
	sta aObjVX
	clc
	lda aObjXlo
	adc aObjVXlo
	sta aObjXlo
	lda aObjX
	adc aObjVX
	sta aObjX
	cmp #$68
	bcc .wait_shake
	ldx <$FD
	lda .table_ufo_anim,x
	sta aObjAnim
	lda aObjX
	cmp #$B8
	bcc .wait_shake
.invert_vector_shake
	lda #$00
	sta aObjVX
	sta aObjVXlo
	lda aObjFrame
	php
	eor #$01
	sta aObjFrame
	plp
	beq .wait_shake
	inc <$FD
	lda <$FD
	cmp #$03
	bne .wait_shake
	mPLAYTRACK #$11
.wait_shake
	jsr ClearSprite1A
	ldx #$00
	stx <$00
	jsr .show_sprite_ufo
	lda aObjAnim
	bne .skip_shake
	lda aObjX
	sta aObjX + 1
	jsr .animate_ufo
	ldx #$01
	jsr .show_sprite_ufo
.skip_shake
	jsr .scroll_vertical
	jsr .show_wilylogo
	jsr FrameAdvance1A
	lda <$FD
	cmp #$05
	beq .end_shake
	jmp .loop_shake
;98EE
;横に揺れるの終わり
.end_shake
	lda #$0A
	sta aObjAnim
.end_shake1
	clc
	lda aObjVXlo
	adc #$18
	sta aObjVXlo
	lda aObjVX
	adc #$00
	sta aObjVX
	sec
	lda aObjXlo
	sbc aObjVXlo
	sta aObjXlo
	lda aObjX
	sbc aObjVX
	sta aObjX
	cmp #$68
	bcc .end_shake2
	jsr ClearSprite1A
	ldx #$00
	stx <$00
	jsr .show_sprite_ufo
	jsr .scroll_vertical
	jsr .show_wilylogo
	jsr FrameAdvance1A
	jmp .end_shake1
.end_shake2
	jsr ClearSprite1A
	jsr .show_wilylogo
	lda #$3E
	sta <$FD
.loop_wait
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait
	jsr ClearSprite1A
;9945
;色変更→背景が白く光る
.beginflashcastle
	ldx #$1F
.loop_palette
	lda .table_palette_wilycastle_flash,x
	sta aPalette,x
	dex
	bpl .loop_palette
	lda #$37
	sta <$FD
.loop_flashcastle
	ldx #$0F
	lda <$FD
	and #$08
	beq .flash
	ldx #$30
.flash
	stx aPaletteSpr
	jsr FrameAdvance1A
	dec <$FD
	bpl .loop_flashcastle
	ldx <zStage
	lda .table_castlemap_startptr - 8,x
	sta <$FD
	lda #$3E
	sta <$FE
.loop_wait_castle
	lda <$FD
	sta <$00
	jsr .show_waypoint
	jsr FrameAdvance1A
	dec <$FE
	bne .loop_wait_castle
;道が進み始める
.loop_castlemap
	lda <zFrameCounter
	and #$03
	bne .wait_castlemap
	mPLAYTRACK #$28
	clc
	lda <$FD
	adc #$04
	sta <$FD
	ldx <zStage
	cmp .table_castlemap_startptr - 8 + 1,x
	beq .end_castlemap
.wait_castlemap
	lda <$FD
	sta <$00
	jsr .show_waypoint
	jsr FrameAdvance1A
	jmp .loop_castlemap
.end_castlemap
	lda #$7D
	sta <$FE
.loop_wait_beginwilystage
	lda <$FD
	sta <$00
	jsr .show_waypoint
	jsr FrameAdvance1A
	dec <$FE
	bne .loop_wait_beginwilystage
	jsr DisableScreen1A
	lda #$00
	sta <zScreenMod
	lda #$0E
	mJSR_NORTS Write_Reg0_A
;99C6
;UFOが回るアニメーションをやる
.animate_ufo
	inc aObjWait + 1
	lda aObjWait + 1
	cmp #$06
	bcc .skip_animate_ufo
	lda #$00
	sta aObjWait + 1
	inc aObjAnim + 1
	lda aObjAnim + 1
	cmp #$04
	bcc .skip_animate_ufo
	lda #$01
	sta aObjAnim + 1
.skip_animate_ufo
	rts
;99E5
;UFOのスプライトを3つ(フタ、博士、乗るところ)表示
.show_ufo_all
	jsr ClearSprite1A
	ldx #$00
	stx <$00
.loop_show_ufo_all
	stx <zObjIndex
	jsr .show_sprite_ufo
	ldx <zObjIndex
	inx
	cpx #$03
	bne .loop_show_ufo_all
	rts
;99F9
;画面をスクロールさせる
.scroll_vertical
	lda <zVScroll
	bne .skip_screenmod
	lda <zScreenMod
	bne .end_scroll
.skip_screenmod
	clc
	lda <zVScrolllo
	adc #$80
	sta <zVScrolllo
	lda <zVScroll
	adc #$00
	cmp #$F0
	bne .skip_move_page
	lda #$02
	sta <zScreenMod
	lda #$00
.skip_move_page
	sta <zVScroll
	.ifndef ___OPTIMIZE
	lda <zVScroll
	bne .end_scroll
	.endif
.end_scroll
	rts
;9A1D
;Dr.Wロゴ表示
.show_wilylogo
	lda <zScreenMod
	bne .castleshown
	sec
	lda #$5F
	sbc <zVScroll
	sta <$01
	lda #$01
	sbc #$00
	beq .castleshown_scroll
	rts
.castleshown
	lda #$6F
	sta <$01
.castleshown_scroll
	lda #$05
	sta <$02
	ldx #$00
.loop_wilylogo
	clc
	lda .table_wily_logo,x
	adc <$01
	bcs .skip_wilylogo
	cmp #$F0
	bcs .skip_wilylogo
	sta aSprite + $EC,x
	lda .table_wily_logo + 1,x
	sta aSprite + $EC + 1,x
	lda .table_wily_logo + 2,x
	sta aSprite + $EC + 2,x
	lda .table_wily_logo + 3,x
	sta aSprite + $EC + 3,x
.skip_wilylogo
	inx
	inx
	inx
	inx
	dec <$02
	bne .loop_wilylogo
	rts
;9A63
;ワイリー城マップ表示・点とドクロの部分
.show_waypoint
	jsr ClearSprite1A
	ldx #$23
.loop_sprite_castlemap_waypoint
	lda .table_castlemap_waypoint,x
	sta aSprite,x
	dex
	bpl .loop_sprite_castlemap_waypoint
	lda <$00
	beq .skip_castlemap
	ldy #$00
.loop_sprite_castlemap_way
	lda .table_castlemap_route,y
	sta aSprite + $24,y
	iny
	inx
	dec <$00
	bne .loop_sprite_castlemap_way
	lda <zFrameCounter
	and #$08
	bne .skip_castlemap
	lda <zStage
	cmp #$0C
	bcs .afterbossrush
	sec
	lda <zStage
	sbc #$07
	asl a
	asl a
	tax
	lda #$73
	sta aSprite + 1,x
	lda #$03
	sta aSprite + 2,x
.afterbossrush
	lda #$77
	sta aSprite + $14 + 1
	sta aSprite + $18 + 1
	lda #$78
	sta aSprite + $1C + 1
	sta aSprite + $20 + 1
	lda <zStage
	cmp #$0D
	bne .skip_castlemap
	lda #$77
	sta aSprite + $F4 + 1
	sta aSprite + $E8 + 1
	lda #$78
	sta aSprite + $EC + 1
	sta aSprite + $F0 + 1
.skip_castlemap
	rts
;9AC8
;UFOのスプライト表示
.show_sprite_ufo
	ldy aObjAnim,x
	lda .table_sprite_ufo_lo,y
	sta <zPtrlo
	lda .table_sprite_ufo_hi,y
	sta <zPtrhi
	lda aObjX,x
	sta <$0A
	lda aObjRoom,x
	sta <$0B
	lda aObjY,x
	sta <$0C
	ldy #$00
	lda [zPtr],y
	iny
	sta <$0D
	ldx <$00
.loop_sprite_ufo
	clc
	lda [zPtr],y
	adc <$0C
	sta aSprite,x
	iny
	lda [zPtr],y
	sta aSprite + 1,x
	iny
	lda [zPtr],y
	sta aSprite + 2,x
	iny
	clc
	lda [zPtr],y
	adc <$0A
	sta <$01
	lda <$0B
	adc #$00
	beq .clipx
	lda #$F8
	sta aSprite,x
	bne .continue
.clipx
	lda <$01
	sta aSprite + 3,x
	inx
	inx
	inx
	inx
.continue
	iny
	dec <$0D
	bne .loop_sprite_ufo
	stx <$00
	rts
;9B27
;ワイリー城2回め以降
.enter_wilycastle_2nd
	ldx #$1F
	lda #$0F
.loop_palette_fadein_init
	sta aPalette,x
	dex
	bpl .loop_palette_fadein_init
	lda #$02
	sta <zScreenMod
	jsr EnableScreen1A
	jsr .show_wilylogo
	ldx #$00
	stx <$FD
	lda #$08
	sta <$FE
.loop_fadein
	dec <$FE
	bne .wait_fadein
	lda #$08
	sta <$FE
	ldx <$FD
	ldy #$00
.loop_palette_fadein
	lda .table_palette_fadein,x
	sta aPalette,y
	inx
	iny
	cpy #$20
	bne .loop_palette_fadein
	cpx #$60
	beq .end_fadein
	stx <$FD
.wait_fadein
	jsr FrameAdvance1A
	jmp .loop_fadein
.end_fadein
	mPLAYTRACK #$11
	lda #$02
	sta <$FE
.wait_wilycastle2
	lda #$A0
	sta <$FD
.wait_wilycastle1
	jsr FrameAdvance1A
	dec <$FD
	bne .wait_wilycastle1
	dec <$FE
	bne .wait_wilycastle2
	mJSR_NORTS ClearSprite1A
;9B83
;空のグラフィック情報
.table_skybg
	.db $E8, $E8, $E8, $E8, $E8, $E8, $E8, $E8
	.db $E8, $E8, $E8, $E8, $E8, $E8, $E8, $00
;9B93
;ワイリー城のパレット
.table_palette_wilycastle
	.db $0F, $20, $21, $11, $0F, $20, $10, $00
	.db $0F, $20, $26, $15, $0F, $17, $21, $07
	.db $0F, $16, $29, $09, $0F, $0F, $30, $38
	.db $0F, $0F, $30, $28, $0F, $0F, $12, $2C
;9BB3
;ワイリー城のパレット(2)
.table_palette_wilycastle_flash
	.db $0F, $11, $11, $11, $0F, $11, $11, $11
	.db $0F, $11, $11, $11, $0F, $17, $11, $07
	.db $0F, $16, $29, $09, $0F, $0F, $30, $38
	.db $0F, $0F, $28, $30, $0F, $0F, $12, $2C
;9BD3
;UFOのスプライト情報格納アドレス下位
.table_sprite_ufo_lo
	.db LOW(.table_ufo0)
	.db LOW(.table_ufo1)
	.db LOW(.table_ufo2)
	.db LOW(.table_ufo3)
	.db LOW(.table_ufo4)
	.db LOW(.table_ufo5)
	.db LOW(.table_ufo6)
	.db LOW(.table_ufo7)
	.db LOW(.table_ufo8)
	.db LOW(.table_ufo9)
	.db LOW(.table_ufoa)
;	.db $E9, $2A, $5B, $8C, $BD, $E6, $0F, $0F, $50, $61, $6A
;9BDE
;UFOのスプライト情報格納アドレス上位
.table_sprite_ufo_hi
	.db HIGH(.table_ufo0)
	.db HIGH(.table_ufo1)
	.db HIGH(.table_ufo2)
	.db HIGH(.table_ufo3)
	.db HIGH(.table_ufo4)
	.db HIGH(.table_ufo5)
	.db HIGH(.table_ufo6)
	.db HIGH(.table_ufo7)
	.db HIGH(.table_ufo8)
	.db HIGH(.table_ufo9)
	.db HIGH(.table_ufoa)
;	.db $9B, $9C, $9C, $9C, $9C, $9C, $9D, $9D, $9D, $9D, $9D
;9BE9
;UFOのスプライトデータ開始
;[0]フタ
.table_ufo0
	.db $10
	.db $00, $48, $03, $08, $00, $49, $03, $10, $00, $49, $43, $18, $00, $48, $43, $20
	.db $08, $4A, $03, $00, $08, $4B, $03, $08, $08, $4C, $03, $10, $08, $4C, $43, $18
	.db $08, $4B, $43, $20, $08, $4A, $43, $28, $10, $4D, $03, $00, $10, $4E, $03, $08
	.db $10, $4F, $03, $10, $10, $4F, $43, $18, $10, $4E, $43, $20, $10, $4D, $43, $28
;[1]乗るところ(黒いところは真ん中)
.table_ufo1
	.db $0C
	.db $00, $50, $02, $00, $00, $51, $02, $08, $00, $52, $02, $10, $00, $52, $42, $18
	.db $00, $51, $42, $20, $00, $50, $42, $28, $08, $53, $02, $00, $08, $54, $02, $08
	.db $08, $55, $02, $10, $08, $55, $42, $18, $08, $54, $42, $20, $08, $53, $42, $28
;[2]乗るところ(黒いところは左)
.table_ufo2
	.db $0C
	.db $00, $56, $02, $00, $00, $57, $02, $08, $00, $58, $02, $10, $00, $59, $02, $18
	.db $00, $5A, $02, $20, $00, $5B, $02, $28, $08, $53, $02, $00, $08, $54, $02, $08
	.db $08, $55, $02, $10, $08, $55, $42, $18, $08, $54, $42, $20, $08, $53, $42, $28
;[3]乗るところ(黒いところは右)
.table_ufo3
	.db $0C
	.db $00, $5B, $42, $00, $00, $5A, $42, $08, $00, $59, $42, $10, $00, $58, $42, $18
	.db $00, $57, $42, $20, $00, $56, $42, $28, $08, $53, $02, $00, $08, $54, $02, $08
	.db $08, $55, $02, $10, $08, $55, $42, $18, $08, $54, $42, $20, $08, $53, $42, $28
;[4]博士(眉毛は下)
.table_ufo4
	.db $0A
	.db $00, $69, $03, $00, $00, $40, $01, $08, $00, $41, $01, $10, $00, $42, $01, $18
	.db $00, $69, $43, $20, $08, $6A, $03, $00, $08, $43, $01, $08, $08, $44, $01, $10
	.db $08, $45, $01, $18, $08, $6A, $43, $20
;[5]博士(眉毛は上)
.table_ufo5
	.db $0A
	.db $00, $69, $03, $00, $00, $46, $01, $08, $00, $47, $01, $10, $00, $42, $01, $18
	.db $00, $69, $43, $20, $08, $6A, $03, $00, $08, $43, $01, $08, $08, $44, $01, $10
	.db $08, $45, $01, $18, $08, $6A, $43, $20
;[6]UFO(小さめ)
;[7]UFO(小さめ)
.table_ufo6
.table_ufo7
	.db $10
	.db $08, $5C, $03, $08, $08, $5D, $03, $10, $08, $5D, $43, $18, $08, $5C, $43, $20
	.db $10, $5E, $03, $08, $10, $5F, $03, $10, $10, $5F, $43, $18, $10, $5E, $43, $20
	.db $18, $60, $02, $08, $18, $61, $02, $10, $18, $61, $42, $18, $18, $60, $42, $20
	.db $20, $62, $02, $08, $20, $63, $02, $10, $20, $63, $42, $18, $20, $62, $42, $20
;[8]UFO(もっと小さい)
.table_ufo8
	.db $04
	.db $10, $64, $03, $10, $10, $64, $43, $18, $18, $65, $02, $10, $18, $65, $42, $18
;[9]UFO(点)
.table_ufo9
	.db $02
	.db $10, $66, $03, $14, $18, $67, $02, $14
;[A]UFO(...)
.table_ufoa
	.db $01
	.db $14, $68, $03, $14
;9D6F
;ワイリー城ロゴ
.table_wily_logo
	.db $00, $6B, $00, $60, $00, $6C, $00, $68, $00, $6D, $00, $70, $08, $6E, $00, $60
	.db $08, $6F, $00, $68
;9D83
;UFOのグラフィックがちっちゃくなるアニメーションの順番
.table_ufo_anim
	.db $00, $00, $07, $08, $09
;9D88
;UFOの加速度下位
.table_ufo_accel = $18
.table_ufo_accel_lo
	.db LOW(.table_ufo_accel), LOW(-.table_ufo_accel + 1)
;9D8A
;UFOの加速度上位
.table_ufo_accel_hi
	.db HIGH(.table_ufo_accel), HIGH(-.table_ufo_accel + 1)
;9D8C
;ワイリー城マップの点とドクロ
.table_castlemap_waypoint
	.db $C0, $73, $02, $10, $88, $73, $02, $40, $A0, $73, $02, $60, $A8, $73, $02, $88
	.db $70, $73, $02, $98, $8C, $75, $02, $B4, $8C, $75, $42, $BC, $94, $76, $02, $B4
	.db $94, $76, $42, $BC
;9DB0
;ワイリー城マップの道を示すスプライトの始点
.table_castlemap_startptr
	.db $00, $30, $48, $5C, $7C, $98, $D0
;9DB7
;ワイリー城マップのスプライト(道の部分)
.table_castlemap_route
	.db $C0, $71, $03, $18, $C0, $70, $C3, $20, $B8, $72, $03, $20, $B0, $72, $03, $20
	.db $A8, $72, $03, $20, $A0, $72, $03, $20, $98, $70, $03, $20, $98, $71, $03, $28
	.db $98, $70, $C3, $30, $90, $72, $03, $30, $88, $70, $03, $30, $88, $71, $03, $38
	
	.db $88, $70, $43, $48, $90, $70, $83, $48, $90, $70, $43, $50, $98, $72, $03, $50
	.db $A0, $70, $83, $50, $A0, $71, $03, $58
	
	.db $A0, $71, $03, $68, $A0, $70, $43, $70, $A8, $70, $83, $70, $A8, $71, $03, $78
	.db $A8, $71, $03, $80
	
	.db $A8, $70, $C3, $90, $A0, $72, $03, $90, $98, $72, $03, $90, $90, $72, $03, $90
	.db $88, $72, $03, $90, $80, $70, $03, $90, $80, $70, $C3, $98, $78, $72, $03, $98
	
	.db $70, $71, $03, $A0, $70, $70, $43, $A8, $78, $72, $03, $A8, $80, $72, $03, $A8
	.db $88, $72, $03, $A8, $90, $70, $83, $A8, $90, $71, $03, $B0
	
	.db $98, $72, $03, $B8, $A0, $72, $03, $B8, $A8, $72, $03, $B8, $B0, $72, $03, $B8
	.db $B8, $72, $03, $B8, $C0, $72, $03, $B8, $C8, $70, $83, $B8, $C8, $71, $03, $C0
	.db $C8, $71, $03, $C8, $C8, $71, $03, $D0, $C4, $75, $02, $D8, $C4, $75, $42, $E0
	.db $CC, $76, $02, $D8, $CC, $76, $42, $E0
;9E87
;2回目以降のワイリー城突入時のフェードインテーブル
.table_palette_fadein
	.db $0F, $00, $01, $0F, $0F, $00, $0F, $0F, $0F, $00, $06, $0F, $0F, $00, $01, $0F
	.db $0F, $0F, $09, $0F, $0F, $0F, $00, $08, $0F, $0F, $08, $00, $0F, $0F, $00, $0C
	.db $0F, $10, $11, $11, $0F, $10, $00, $00, $0F, $10, $16, $05, $0F, $07, $11, $00
	.db $0F, $06, $19, $00, $0F, $0F, $10, $18, $0F, $0F, $18, $10, $0F, $0F, $02, $1C
	.db $0F, $20, $21, $11, $0F, $20, $10, $00, $0F, $20, $26, $15, $0F, $17, $21, $07
	.db $0F, $16, $29, $09, $0F, $0F, $30, $38, $0F, $0F, $28, $30, $0F, $0F, $12, $2C

