
;20 55 D6
;SpawnEnemyByScroll
.seek = $00
.seek_r = $01
.room = $02
.num = $03
	lda <zStage
	and #$07
	jsr ChangeBank
	
	mSTZ <.seek_r
.loop_room
	lda <$20
	ldy <.seek_r
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
	
;横の画面外判定
	sec
	lda Stage_DefEnemiesX - 1,y
	sbc <zHScroll
	ldx <$05
	beq .inv_x
	clc
	eor #$FF
	adc #$01
.inv_x
	cmp #$08
	bcc .spawn
;縦の画面外判定
	sec
	lda Stage_DefEnemiesY - 1,y
	sbc <zVScroll
	ldx <$04
	beq .inv_y
	clc
	eor #$FF
	adc #$01
.inv_y
	cmp #$08
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
	inc <.seek_r
	ldy <.seek_r
	cpy #$04
	bne .loop_room
	mCHANGEBANK #$0E, 1

.room_list
	.db $00, $01, $10, $11

;20 50 D7
;敵順序番号Yを生成
CreateEnemy:
	ldx #$0F
	tya
.loopseek
	cmp aEnemyOrder10,x
	beq InvalidCreateObject
	dex
	bpl .loopseek
	
	jsr GetEnemyPointer
	bcs InvalidCreateObject
	tya
	sta aEnemyOrder10,x
	mMOV Stage_DefEnemiesRoom - 1,y, aObjRoom10,x
	sta <$70
	mMOV Stage_DefEnemiesX - 1,y, aObjX10,x
	mMOV Stage_DefEnemiesY - 1,y, aObjY10,x
	lda Stage_DefEnemies - 1,y
	sta <$71
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
	pha
	sta aItemOrder10,x
	lda $BA00,y ;-------------item page
	sta aObjRoom10,x
	lda $BA40,y ;-------------item x
	sta aObjX10,x
	lda $BA80,y ;-------------item y
	sta aObjY10,x
	lda $BAC0,y ;-------------item number
	jsr CreateObjectHere
	pla
	sta aItemLifeOffset10,x
	tay
	lda aItemLife,y
	sta aObjLife10,x
	rts
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