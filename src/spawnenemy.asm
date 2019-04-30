
;20 55 D6
;SpawnEnemyByScroll
.seek = $00
.seek_r = $01
.room = $02
.num = $03
.spawn_y = $07
	lda <zStage
	and #$07
	jsr ChangeBank

;アイテム出現処理
	ldy #$00
.loop_room_item
	sty <.seek_r
	lda <$20
	clc
	adc SpawnEnemy_RoomList,y
	sta <.room
	tax
	
	lda Stage_DefMap16,x
	tax
	asl a
	bmi .skip_room_item
	lda Stage_DefItemsAmount,x
	beq .skip_room_item
	sta <.num
	
	tya
	and #$01
	sta <$05
	tya
	and #$02
	sta <$04
	
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
.spawn_item
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
	lda <$20
	clc
	adc SpawnEnemy_RoomList,y
	sta <.room
	tax
	
	lda Stage_DefMap16,x
	tax
	asl a
	bmi .skip_room
	lda Stage_DefEnemiesAmount,x
	beq .skip_room
	sta <.num
	
	tya
	and #$01
	sta <$05
	tya
	and #$02
	sta <$04
	
	ldy Stage_DefEnemiesPtr,x
.loop_seek
	sty <.seek
	
	mMOV Stage_DefEnemiesY - 1,y, <.spawn_y
	lda Stage_DefEnemiesX - 1,y
	jsr SpawnEnemy_CheckOffscreen
	bcs .skip_seek
	
;敵が出現する
.spawn
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
	lda <zPPUObjPtrEnd
	bne .writeobj
.rts
	mCHANGEBANK #$0E, 1
;画像書き換え
.writeobj
	lda <zPPUHScr
	ora <zPPUVScr
	bne .rts
	ldx <zPPUObjPtr
	lda Stage_LoadGraphics,x
	sta <zPtrhi
	lda <zPPUObjlo
	sta <zPtrlo
	inx
	mCHANGEBANK Stage_LoadGraphics,x
	inx
	ldy #$40
	sty <zPPULinear
	dey
.loop
	lda [zPtr],y
	sta aPPULinearData,y
	dey
	bpl .loop
	
	clc
	lda <zPPUObjlo
	sta aPPULinearlo
	adc #$40
	sta <zPPUObjlo
	lda <zPPUObjhi
	sta aPPULinearhi
	bcc .rts
	inc <zPPUObjhi
	stx <zPPUObjPtr
	dec <zPPUObjPtrEnd
	bne .rts
	lda <zStage
	and #$07
	jsr ChangeBank
.skip_palette
	iny
.loop_palette
	cpy #$03
	beq .skip_palette
	
	lda Stage_LoadGraphics,x
	bmi .rts
	sta aPaletteSpr + 9,y
	inx
	iny
	cpy #$07
	bne .loop_palette
	beq .rts

;オブジェクト生成判定 Cフラグが立つ時生成中止
SpawnEnemy_CheckOffscreen:
.spawnflag = $06
.spawn_y = $07
	ldx #$00
	stx <.spawnflag
	ldx <zPrevX
	cpx aObjX
	beq .spawnflag_set
;横の画面外判定
	sec
	sbc <zHScroll
	bit <zMoveVec
	bvc .inv_x
	eor #$FF
.inv_x
	ldx <$05
	bcc .borrow_x
	bne .skip_seek
	beq .cont_x
.borrow_x
	beq .skip_seek
.cont_x
	cmp #SpawnEnemyBoundaryX
	bcc .skip_seek
	cmp #SpawnEnemyBoundaryX + 8
	bcs .spawnflag_set
	inc <.spawnflag
.spawnflag_set

;縦の画面外判定
	sec
	lda <zPrevY
	sbc aObjY
	ora <.spawnflag
	beq .skip_seek
	sec
	lda <.spawn_y
	sbc <zVScroll
	ldx aObjVY
	bpl .inv_y
	eor #$FF
.inv_y
	ldx <$04
	bcc .borrow_y
	bne .skip_seek
	beq .cont_y
.borrow_y
	beq .skip_seek
.cont_y
	cmp #SpawnEnemyBoundaryY
	bcc .skip_seek
	ldx <.spawnflag
	bne .spawn
	cmp #SpawnEnemyBoundaryY + 8
	bcs .skip_seek
.spawn
	clc
	rts
.skip_seek
	sec
	rts

;敵画像読み込みセットの設定
SpawnEnemy_SendCommand:
.room = $02
	and #$7F
	cmp #$40
	bcc .1
	and #$3F ;敵番号C0～FF: スクロール移動先の設定
	sta <zScrollNumber
	bpl .rts
.1
	cmp #$30 ;敵番号B0～BF: シャッター高さの設定
	bcc .2
	sbc #$30
	asl a
	asl a
	asl a
	asl a
	sta <zShutterHeight
	bcc .rts
.2
	cmp #$0F ;敵番号8F: 中間ポイントの設定
	bne .3
	ldy <.room
	sty <zContinuePoint
	rts
.3
	cmp #$0E ;敵番号8E: スクロール制限の開始
	bne .4
	lda Stage_DefEnemiesY - 1,y
	lsr a
	lda Stage_DefEnemiesX - 1,y
	rol a
	and #$03
	sta <zScrollClipFlag
	mMOV <.room, <zScrollClipRoom
	rts
.4
	tay ;敵番号80～8B: パターンテーブル転送の適用
	mSTZ <zPPUObjlo
	lda Stage_LoadGraphicsPtr,y
	sta <zPPUObjhi
	lda Stage_LoadGraphicsOrg,y
	sta <zPPUObjPtr
	lda Stage_LoadGraphicsNum,y
	sta <zPPUObjPtrEnd
.rts
	rts

SpawnEnemy_RoomList:
	.db $00, $01, $10, $11

;指定した画面内の敵を強制的に出現
SpawnEnemiesAll:
.seek = $00
.ptr = $01
.room = $02
.num = $03
	lda <zStage
	and #$07
	jsr ChangeBank
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
	sta <$70
	ldy <zRoom
	sty <.room
	ldx Stage_DefMap16,y
	lda Stage_DefEnemiesAmount,x
	beq .skip
	sta <.num
	ldy Stage_DefEnemiesPtr,x
.loop
	sty <.ptr
	lda Stage_DefEnemies - 1,y
	bpl .sendchr
	jsr SpawnEnemy_SendCommand
	jmp .1
.sendchr
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
CreateObjectHere:
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
	sta aEnemyVar10,x
	sta aObjXlo10,x
	sta aObjYlo10,x
	sta aEnemyFlash10,x
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
	mMOV aItemLife,y, aObjLife10,x
	mMOV <$02, aObjRoom10,x
	mMOV Stage_DefItemsX - 1,y, aObjX10,x
	mMOV Stage_DefItemsY - 1,y, aObjY10,x
	lda Stage_DefItems - 1,y ;-------------item number
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
