
;20 55 D6
SpawnEnemyByScroll:
.seek    = $00 ;敵リストシーク位置
.seek_r  = $01 ;画面位置シーク位置（左上 + (0, 0)～(1, 1)）
.room    = $02 ;現在探索対象の画面位置 = YYYY XXXX
.num     = $03 ;探索すべき敵・アイテムの数
.spawn_y = $0A ;生成物のY座標
	lda <zStage
	and #$07
	jsr ChangeBank

;アイテム出現処理
	ldy #$00
.loop_room_item
	sty <.seek_r
	clc
	mADD <zRoom, SpawnEnemy_RoomList,y, <.room ; = zRoom + 00/01/10/11
	tax
	
	lda Stage_DefMap16,x
	tax ;現在探索対象の画面番号 = 00～3F
	asl a
	bmi .skip_room_item
	lda Stage_DefItemsAmount,x
	beq .skip_room_item
	sta <.num ; = 探索対象の画面に存在するアイテムの数
	
	ldy Stage_DefItemsPtr,x
.loop_seek_item
	sty <.seek
	lda aItemLife - 1,y
	beq .skip_seek_item
	
	mMOV Stage_DefItemsY - 1,y, <.spawn_y
	lda Stage_DefItemsX - 1,y
	jsr SpawnEnemy_CheckOffscreen
	bcs .skip_seek_item
	
;アイテムが出現する
	ldy <.seek
	jsr CreateItem
.skip_seek_item
	ldy <.seek
	iny
	dec <.num
	bne .loop_seek_item
.skip_room_item
	ldy <.seek_r
	iny
	cpy #$04
	bne .loop_room_item

;敵出現処理
	ldy #$00
.loop_room
	sty <.seek_r
	clc
	mADD <zRoom, SpawnEnemy_RoomList,y, <.room
	tax
	
	lda Stage_DefMap16,x
	tax
	asl a
	bmi .skip_room
	lda Stage_DefEnemiesAmount,x
	beq .skip_room
	sta <.num
	
	ldy Stage_DefEnemiesPtr,x
.loop_seek
	sty <.seek
	
	mMOV Stage_DefEnemiesY - 1,y, <.spawn_y
	lda Stage_DefEnemiesX - 1,y
	jsr SpawnEnemy_CheckOffscreen
	bcs .skip_seek
	
;敵が出現する
	ldy <.seek
	lda Stage_DefEnemies - 1,y
	bpl .sendchr
	jsr SpawnEnemy_SendCommand
	jmp .skip_seek
.sendchr
	jsr CreateEnemy
.skip_seek
	ldy <.seek
	iny
	dec <.num
	bne .loop_seek
.skip_room
	ldy <.seek_r
	iny
	cpy #$04
	bne .loop_room
.rts
	mCHANGEBANK #$0E, 1

;オブジェクト生成判定 Cフラグが立つ時生成中止
;A = 生成物のX座標
SpawnEnemy_CheckOffscreen:
.room      = $02 ;生成物の画面位置
.hscroll   = $04 ;横スクロール値退避
.vscroll   = $05 ;縦スクロール値退避
.roomstash = $06 ;画面位置退避
.spawn_y   = $0A ;生成物のY座標 -> 画面外判定関数ルーチンへ
.x         = $08 ;引数x -+
.r         = $09 ;引数r  |- 画面外判定関数ルーチン
.y         = $0A ;引数y -+
	sta <.x
	ldx #$00
	lda <zHScroll
	cmp <zHScrollPrev
	beq .check_hscroll
	inx
.check_hscroll
	lda <zVScroll
	cmp <zVScrollPrev
	beq .check_vscroll
	inx
.check_vscroll
	txa
	beq .skip_seek ;全くスクロールしていない時、判定をスキップ

	mMOV <.room, <.r
	jsr CheckOffscreenPoint
	bcs .rts ;今のスクロール値で画面外なら生成中止

	;スクロール値退避
	mMOV <zHScroll, <.hscroll
	mMOV <zVScroll, <.vscroll
	mMOV <zRoom, <.roomstash

	;スクロール前の値をセット
	mMOV <zHScrollPrev, <zHScroll
	mMOV <zVScrollPrev, <zVScroll
	mMOV <zRoomPrev, <zRoom
	jsr CheckOffscreenPoint

	;復元
	mMOV <.hscroll, <zHScroll
	mMOV <.vscroll, <zVScroll
	mMOV <.roomstash, <zRoom
	bcc .skip_seek ;スクロール前も画面内なら生成中止
	clc
	rts
.skip_seek
	sec
.rts
	rts

;敵画像読み込みセットの設定
SpawnEnemy_SendCommand:
.room = $02
.temp = $07
	and #$7F
	bcc .is_scroll
	cmp #$0F
	bcs .rts2
.is_scroll
	cmp #$7F
	beq .set_continuepoint
	cmp #$40
	bcc .1
	and #$3F
	sta <zScrollNumber ;敵番号C0～FE: スクロール移動先の設定
.rts2
	rts
.set_continuepoint ;敵番号FF: 中間ポイントの設定
	mMOV <.room, <zContinuePoint
	lda Stage_DefEnemiesY - 1,y
	and #$0F
	asl a
	asl a
	asl a
	asl a
	sta <zContinuePointY
	lda Stage_DefEnemiesX - 1,y
	and #$0F
	sta <zContinuePaletteOffset
	rts
.1
	cmp #$3F
	beq .set_scrollclip
	cmp #$3E
	beq .2
	cmp #$30 ;敵番号B0～BB: シャッター高さの設定
	bcc .3
	sbc #$30
	asl a
	asl a
	asl a
	asl a
	sta <zShutterHeight
	rts
.set_scrollclip ;敵番号BF: スクロール制限の開始
	lda Stage_DefEnemiesY - 1,y
	and #%00000011
	sta <zScrollClipFlag
	lda Stage_DefEnemiesX - 1,y
	and #%00000111
	asl a
	asl a
	ora <zScrollClipFlag
	bit SpawnEnemiesAll.bit_00010000
	beq .noset_n
	ora #%10000000
.noset_n
	sta <zScrollClipFlag
	mMOV <.room, <zScrollClipRoom
	rts
.2 ;敵番号BE: 敵番号 0XXX YYYY を消滅エフェクトにする
	mAND Stage_DefEnemiesY - 1,y, #%00001111, <.temp
	lda Stage_DefEnemiesX - 1,y
	and #%00000111
	asl a
	asl a
	asl a
	asl a
	ora <.temp ;A = 0XXX YYYY
	sta <.temp
	ldy #$0F
.loop_findobj
	lda aObjFlags10,y
	bpl .skip_findobj
	lda aObjAnim10,y
	cmp <.temp
	bne .skip_findobj
	mMOV #$06, aObjAnim10,y
	mSTZ aObjFrame10,y, aObjWait10,y
.skip_findobj
	dey
	bpl .loop_findobj
	rts
.3
	tay ;敵番号80～8F: パターンテーブル転送の適用
SetupEnemySprites:
	mSTZ <zPPUObjlo
	mMOV Stage_LoadGraphicsPtr,y, <zPPUObjhi
	mMOV Stage_LoadGraphicsOrg,y, <zPPUObjPtr
	lda Stage_LoadGraphicsNum,y
	cmp #$80
	ldy #$00
	bcc .write_secondpalette
	ldy #$04
.write_secondpalette
	and #$7F
	sta <zPPUObjNum
	asl a
	adc <zPPUObjPtr
	tax
.loop_palette
	lda Stage_LoadGraphics,x
	bmi .rts
	sta aPaletteSpr + 8 + 2,y
	inx
	iny
	cpy #$02
	bne .loop_palette1
	iny
	iny
.loop_palette1
	cpy #$06
	bne .loop_palette
.rts
	rts

SpawnEnemy_RoomList:
	.db $00, $01, $10, $11

;スクロール処理で使用, 指定した画面内の制御オブジェクトを強制的に出現
SpawnCommandsAll:
	ldy #$01
	.db $2C
;指定した画面内の敵を強制的に出現
SpawnEnemiesAll:
.seek = $00
.ptr = $01
.room = $02
.num = $03
	ldy #$00
	sty <zObjItemFlag
	lda <zStage
	and #$07
	jsr ChangeBank
	dey
	bpl .skip_item
;アイテムの出現
	ldy <zRoom
	sty <.room
	ldx Stage_DefMap16,y
	lda Stage_DefItemsAmount,x
	beq .skip_item
	sta <.num
	ldy Stage_DefItemsPtr,x
.loop_item
	sty <.ptr
	jsr CreateItem
	ldy <.ptr
	iny
	dec <.num
	bne .loop_item
;敵の出現
.skip_item
	ldy <zRoom
	sty <.room
	ldx Stage_DefMap16,y
	lda Stage_DefEnemiesAmount,x
	beq .skip
	sta <.num
	ldy Stage_DefEnemiesPtr,x
.loop
	sty <.ptr
	lda <zObjItemFlag
	lsr a
	lda Stage_DefEnemies - 1,y
.bit_00010000 .public
	bpl .sendchr
	jsr SpawnEnemy_SendCommand
	jmp .1
.sendchr
	bcs .1 ;C = true if SpawnCommandsAll
	jsr CreateEnemy
.1
	ldy <.ptr
	iny
	dec <.num
	bne .loop
.skip
	mCHANGEBANK #$0E, 1

;20 50 D7
;敵順序番号Yを生成
CreateEnemy:
	tya
	ldx #$0F
.loopseek
	cmp aEnemyOrder10,x
	beq InvalidCreateObject
	dex
	bpl .loopseek
	
	jsr GetEnemyPointer
	bcs InvalidCreateObject
	tya
	sta aEnemyOrder10,x
	mMOV <$02, aObjRoom10,x
	mMOV Stage_DefEnemiesX - 1,y, aObjX10,x
	mMOV Stage_DefEnemiesY - 1,y, aObjY10,x
	lda Stage_DefEnemies - 1,y
	clc
CreateObjectHere: ; Object is item -> carry set
	sta aObjAnim10,x
	tay
	pha
	mMOV Table_ObjectInitialFlags,y, aObjFlags10,x
	mMOV Table_ObjectInitalCollisionSize,y, aObjCollision10,x
	mMOV #$14, aObjLife10,x
	lda Table_ObjectInitialVX,y
	tay
	mMOV Table_InitialVX,y, aObjVX10,x
	mMOV Table_InitialVX + 1,y, aObjVXlo10,x
	pla
	tay
	lda Table_ObjectInitialVY,y
	tay
	mMOV Table_InitialVY,y, aObjVY10,x
	mMOV Table_InitialVY + 1,y, aObjVYlo10,x
	lda #$00
	sta aObjFrame10,x
	sta aObjWait10,x
	sta aObjVar10,x
	sta aObjXlo10,x
	sta aObjYlo10,x
	sta aEnemyFlash10,x
	bcs InvalidCreateObject
	sta aEnemyVar10,x
InvalidCreateObject:
	rts

;20 C9 D7
;アイテム順序番号Yを生成
CreateItem:
	tya
	ldx #$0F
.loopseek
	cmp aItemOrder10,x
	beq InvalidCreateObject
	dex
	bpl .loopseek
	
	jsr GetEnemyPointer
	bcs InvalidCreateObject
	tya
	sta aItemOrder10,x
	sta aEnemyVar10,x
	mMOV aItemLife,y, aObjLife10,x
	mMOV <$02, aObjRoom10,x
	mMOV Stage_DefItemsX - 1,y, aObjX10,x
	mMOV Stage_DefItemsY - 1,y, aObjY10,x
	lda Stage_DefItems - 1,y ;-------------item number
	sec
	mJSR_NORTS CreateObjectHere

;D802
Table_ObjectInitialFlags:
	.incbin "src/bin/obj/InitialFlags.bin"
;D882
Table_ObjectInitialVX:
	.incbin "src/bin/obj/InitialVX.bin"
;D8FE
Table_ObjectInitialVY:
	.incbin "src/bin/obj/InitialVY.bin"
;D97E
Table_ObjectInitalCollisionSize:
	.incbin "src/bin/obj/InitialCollision.bin"

;D9FE
Table_InitialVX:
	.incbin "src/bin/InitialVXList.bin"
;DA1E
Table_InitialVY:
	.incbin "src/bin/InitialVYList.bin"

;DA3F ...?
	.db $00, $20
