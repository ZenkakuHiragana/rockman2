
;20 55 D6
;SpawnEnemyByScroll
.seek = $00
.seek_r = $01
.room = $02
.num = $03
.spawnflag = $06
	lda <zStage
	and #$07
	jsr ChangeBank
	
	ldy #$00
.loop_room
	sty <.seek_r
	lda <$20
	beq .skip_1st
	clc
	adc .room_list,y
.skip_1st
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
	mSTZ <.spawnflag
	
;横の画面外判定
	sec
	lda Stage_DefEnemiesX - 1,y
	sbc <zHScroll
	ldx <$05
	dex
	bcc .borrow_x
	bpl .skip_seek
	bmi .cont_x
.borrow_x
	bmi .skip_seek
	eor #$FF
.cont_x
	
	cmp #$08
	bcc .skip_seek
	cmp #$10
	bcs .spawnflag_set
	inc <.spawnflag
.spawnflag_set
;縦の画面外判定
	sec
	lda Stage_DefEnemiesY - 1,y
	sbc <zVScroll
	ldx <$04
	dex
	bcc .borrow_y
	bpl .skip_seek
	bmi .cont_y
.borrow_y
	bmi .skip_seek
	eor #$FF
.cont_y
	
	cmp #$08
	bcc .skip_seek
	ldx <.spawnflag
	bne .spawn
	cmp #$10
	bcs .skip_seek
;敵が出現する
.spawn
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
	
;アイテム出現処理
	ldy #$00
.loop_room_item
	sty <.seek_r
	lda <$20
	beq .skip_1st_item
	clc
	adc .room_list,y
.skip_1st_item
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
	lda aItemLife,y
	beq .skip_seek_item
	mSTZ <.spawnflag
	
;横の画面外判定
	sec
	lda Stage_DefEnemiesX - 1,y
	sbc <zHScroll
	ldx <$05
	dex
	bcc .borrow_x_item
	bpl .skip_seek_item
	bmi .cont_x_item
.borrow_x_item
	bmi .skip_seek_item
	eor #$FF
.cont_x_item
	
	cmp #$08
	bcc .skip_seek_item
	cmp #$10
	bcs .spawnflag_set_item
	inc <.spawnflag
.spawnflag_set_item
;縦の画面外判定
	sec
	lda Stage_DefEnemiesY - 1,y
	sbc <zVScroll
	ldx <$04
	dex
	bcc .borrow_y_item
	bpl .skip_seek
	bmi .cont_y_item
.borrow_y_item
	bmi .skip_seek_item
	eor #$FF
.cont_y_item
	
	cmp #$08
	bcc .skip_seek_item
	ldx <.spawnflag
	bne .spawn_item
	cmp #$10
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
	mCHANGEBANK #$0E, 1

.room_list
	.db $00, $01, $10, $11

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
	sta aItemLifeOffset10,x
	sta aItemOrder10,x
	mMOV aItemLife,y, aObjLife10,x
	mMOV <$02, aObjRoom10,x
	mMOV Stage_DefItemsX,y, aObjX10,x
	mMOV Stage_DefItemsY,y, aObjY10,x
	lda Stage_DefItems,y ;-------------item number
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

;20 40 DA
GetEnemyPointer:
	ldx #$0F
.loop
	lda aObjFlags10,x
	bpl .ok
	dex
	bpl .loop
	sec
	rts
.ok
	clc
	rts