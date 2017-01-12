;38000-3BFFF

	mBEGIN #$0E, #$8000

Reset_Continue;
	sei
	ldx #$FF
	txs
	ldx #$01
.vblankloop1
	lda $2002
	bpl .vblankloop1
.vblankloop2
	lda $2002
	bmi .vblankloop2
	dex
	bpl .vblankloop1
	lda #$00
	sta <$00
	sta <$01
	ldy #$00
.memloop
	sta [$00],y
	iny
	bne .memloop
	inc <$01
	ldx <$01
	cpx #$08
	bne .memloop
	lda #$0E
	jsr Write_Reg0_A
	lda #$01
	sta $BFFF
	lsr a
	sta $BFFF
	lsr a
	sta $BFFF
	lsr a
	sta $BFFF
	lsr a
	sta $BFFF
	lda #$1F
	sta $DFFF
	lsr a
	sta $DFFF
	lsr a
	sta $DFFF
	lsr a
	sta $DFFF
	lsr a
	sta $DFFF
	lda #$03
	sta <zLives
	lda #$00
	sta <zETanks
.restart
;	jsr BeginTitleScreen
;	lda <zRestartTitle ;タイトル画面をもう一度やるなら1
;	bne .restart
	lda <zClearFlags
	cmp #$FF
	bne StartStageSelect
	lda #$08
	sta <zStage
	bne StartStage_All
;8072
;ステージセレクト処理の後ステージ開始
StartStageSelect:
	lda #$03
	sta <zLives
	jsr ChangeBank_DoStageSelect
;8079
;ステージセレクト処理の後から
StartStage_All:
	lda <zStage
	cmp #$08
	bcc StartStage_FillingEnergy
	jsr ChangeBank_DoEnterWilyCastle
	lda <zStage
	cmp #$09
	bcs StartStage_NoEnergyRegen
;8088
;武器エネルギーを回復しつつステージ開始
StartStage_FillingEnergy:
	ldx #nEnergySize - 1
	lda #$1C
.regenerateloop
	sta <zEnergyArray,x
	dex
	bpl .regenerateloop
;8091
;武器エネルギー回復処理を飛ばしてステージ開始
StartStage_NoEnergyRegen:
	ldx #$00
	lda <zStage
	and #$08
	beq .notcastle
	ldx #$03
.notcastle
	stx <zContinuePoint
	lda #$14
	ldx #$1F
.itemloop
	sta aItemLife,x
	dex
	bpl .itemloop
	lda #$00
	sta <zBossRushProg
;80AB
;死亡時のコンティニュー位置
StartStage_Continue:
	mMOV #$40, <zConveyorRVec
	mMOV #%00010000, <z2000, $2000
	mMOV #%00000110, <z2001
	jsr LoadStageGraphics
	mMOV #$1C, aObjLife
	jsr ChangeBodyColor
	jsr SetContinuePoint
	lda #$00
	sta <zConveyorLVec
	sta <zStopFlag
	sta <zEquipment
	sta <zGravityhi
	sta <zHScroll
	sta <zHScrolllo
	sta <zVScroll
;	sta <zVScrolllo
	sta <zVScrollApparentlo
	sta <zVScrollApparenthi
	sta <zHScrollApparentlo
	sta <zHScrollApparenthi
	sta <zRoomApparent
	sta aObjX
	sta aObjXlo
	sta <zPaletteIndex
	sta <zPaletteTimer
	sta <zBossBehaviour
	sec
	lda <zRoom
	sbc #$02
	ldx #$00
	ldy #$41
	jsr DrawRoom
	jsr ClearSprites
	lda <z2001
	ora #%00011110
	sta <z2001
	lda <z2000
	ora #%10000000
	sta <z2000
	sta $2000
	sta <zIsLag
	mMOV #$40, <zGravity
	ldx <zStage
	mPLAYTRACK Table_StageMusic,x
	ldx #$13
.spriteloop
	mMOV Table_SpriteREADY,x, aSprite,x
	dex
	bpl .spriteloop
	mMOV #$C0, <zWait2
.readyloop
	ldy #$60
	ldx #$10
	lda <zWait2
	and #$08
	bne .blink
	ldy #$F8
.blink
	tya
	sta aSpriteY,x
	dex
	dex
	dex
	dex
	bpl .blink
	jsr FrameAdvance1C
	dec <zWait2
	bne .readyloop
	jsr ClearSprites
	mMOV #$DF, <zJumpPowerlo
	mMOV #$04, <zJumpPowerhi
	jsr EraseEnemiesByScroll
	jsr Rockman_Warp_to_Land
	lda <zStage
	cmp #$0C
	bne MainLoop
	jmp MainLoopBossRush
MainLoop:
	lda <zItemInterrupt
	beq .noitem
	jsr ItemInterrupt
.noitem
	lda <zKeyPress
	and #$08
	beq .submenu
	jsr OpenSubMenu
.submenu
	jsr CountBlockableObjects
	jsr DoRockman
	jsr WeaponObjectProcess
	jsr SpawnEnemyByScroll
	jsr DoBossBehaviour
	jsr DoEnemyObjects
	jsr SpriteSetup
	lda <zScrollFlag
	beq .scroll
	jsr DoScroll
.scroll
	lda <zWaterLevel
	beq .nolag
	inc <zWaterWait
	cmp <zWaterWait
	beq .lag
	bcs .nolag
.lag
	jsr FrameAdvanceWater
	mSTZ <zWaterWait
.nolag
	jsr FrameAdvance1C
	jmp MainLoop

Table_Unknown81B6:
	.db $10, $10, $10, $15, $15, $10

;81BC
Table_SpriteREADY:
	.db $60, $96, $01, $6C, $60, $97, $01, $74
	.db $60, $98, $01, $7C, $60, $99, $01, $84
	.db $60, $9A, $01, $8C

;81D0
Table_StageMusic:
	.db $03, $04, $01, $07, $06, $00, $05, $02
	.db $08, $08, $09, $09, $09, $FF

;81DE
PlaceBossRushCapsule:
	lda <zBossRushProg
	cmp #$FF
	bne .eight
	ldx #$00
	stx <zObjIndex
	lda #$7E
	ldx #$0E
	jsr CreateEnemyHere_Middle
	lda #$3B
	sta aObjY10 + $0E
	lda #$80
	sta aObjX10 + $0E
.eight
	lda #$00
	sta <zObjIndex
	sta <$02
	lda <zBossRushProg
	sta <$03
.loop
	lsr <$03
	bcs .skip
	lda #$7C
	ldx <$02
	jsr CreateEnemyHere_Middle
	lda Table_BossRushCapsuleY,y
	sta aObjY10,y
	lda Table_BossRushCapsuleX,y
	sta aObjX10,y
.skip
	inc <$02
	lda <$02
	cmp #$08
	bne .loop
	rts

;8223
MainLoopBossRush:
	jsr PlaceBossRushCapsule
.loop
	lda <zItemInterrupt
	beq .noitem
	jsr ItemInterrupt
.noitem
	lda <zKeyPress
	and #$08
	beq .submenu
	jsr OpenSubMenu
.submenu
	jsr CountBlockableObjects
	jsr DoRockman
	jsr WeaponObjectProcess
	;jsr SpawnEnemyByScroll
	jsr DoBossBehaviour
	jsr DoEnemyObjects
	jsr SpriteSetup
	lda <zScrollFlag
	beq .scroll
	jsr DoScroll
.scroll
	lda <zWaterLevel
	beq .nolag
	inc <zWaterWait
	cmp <zWaterWait
	beq .lag
	bcs .nolag
.lag
	jsr FrameAdvanceWater
	lda #$00
	sta <zWaterWait
.nolag
	jsr FrameAdvance1C
	jmp .loop

;8268
Table_BossRushCapsuleY:
	.db $3B, $7B, $BB, $BB, $BB, $3B, $7B, $BB

;8270
Table_BossRushCapsuleX:
	.db $20, $20, $20, $70, $90, $E0, $E0, $E0

;20 B2 C7: 棒状になって降りてきて着地まで
Rockman_Warp_to_Land:
	mMOV #%11000000, aObjFlags
	mMOV #$80, aObjX
	mMOV #$14, aObjY
	mMOV #$1A, aObjAnim
.loop
	mSTZ aObjWait, aObjFrame
	clc
	lda aObjY
	adc #$10
	sta aObjY
	adc #$10
	cmp #$80
	bcc .skip
	sta <$0A
	mMOV aObjX, <$08
	mMOV aObjRoom, <$09
	jsr PickupBlock
	lda <$00
	and #$08
	bne .onland
.skip
	jsr SpriteSetup
	jsr FrameAdvance1C
	jmp .loop
.onland
	mPLAYTRACK #$30
	mSTZ <zStatus, <zSliplo, <zSliphi
	mMOV #$40, <zMoveVec
	mMOV #$FF, aObjVY
	rts
	
;8278
;スクロール方向$37 - 1 = 0, 1, 2, 3 → 左右上下
;スクロール先画面番号$38
DoScroll:
	;bmi .done
	jsr Scroll_GoForward
	
	ldx <zStage
	lda <zRoom
	cmp Table_BossRoom,x
	bne .notspawnboss
	jsr SpawnBoss
.notspawnboss
	mSTZ <zScrollFlag
	jmp SpawnEnemiesAll

;82D5
ItemInterrupt:
	sec
	lda <zItemInterrupt
	sbc #$76
	tay
	lda #$00
	sta <zItemInterrupt
	lda Table_ItemInterruptlo,y
	sta <zPtrlo
	lda Table_ItemInterrupthi,y
	sta <zPtrhi
	jmp [zPtr]

;82EC
Item_RecoverLifeBig:
	lda #$0A
	bne Item_RecoverLifeStart
Item_RecoverLifeSmall:
	lda #$02
Item_RecoverLifeStart:
	sta <$FD
	lda aObjLife
	cmp #$1C
	bcs .done
	lda #$07
	sta <zStopFlag
.loop
	ldx <zEquipment
	lda aObjLife
	cmp #$1C
	bcs .end
	lda <zFrameCounter
	and #$07
	bne .skip
	dec <$FD
	bmi .end
	inc aObjLife
	mPLAYTRACK #$28
.skip
	jsr SpriteSetup
	jsr FrameAdvance1C
	jmp .loop
.end
	jmp Item_RecoverEnd
.done
	rts

;8327
Item_RecoverEnergyBig:
	lda #$0A
	bne Item_RecoverEnergyStart
Item_RecoverEnergySmall:
	lda #$02
Item_RecoverEnergyStart:
	sta <$FD
	lda <zEquipment
	beq Item_RecoverEnd_Done
	ldx <zEquipment
	lda <zEnergyArray - 1,x
	cmp #$1C
	beq Item_RecoverEnd_Done
	lda #$07
	sta <zStopFlag
.loop
	ldx <zEquipment
	lda <zEnergyArray - 1,x
	cmp #$1C
	bcs Item_RecoverEnd
	lda <zFrameCounter
	and #$07
	bne .skip
	dec <$FD
	bmi Item_RecoverEnd
	inc <zEnergyArray - 1,x
	mPLAYTRACK #$28
.skip
	jsr SpriteSetup
	jsr FrameAdvance1C
	jmp .loop
;8361
Item_RecoverEnd:
	lda #$00
	sta <$FD
	sta <zStopFlag
	lda #$03
	sta <zStatus
	jsr SetRockmanAnimation
Item_RecoverEnd_Done:
	rts

;836F
Item_GetETank:
	lda <zETanks
	cmp #$04
	bcs .done
	inc <zETanks
.done
	mPLAYTRACK #$42
	rts

;837D
Item_GetExLife:
	lda <zLives
	cmp #$63
	bcs .done
	inc <zLives
	mPLAYTRACK #$42
.done
	rts

;838B
Item_TeleporterIn:
	jsr Item_IntoCapsule
	lda #$00
	sta <$FD
	ldx <zBossRushStage
	lda .teleporter_patterntable - 1,x
	sta <$FE
	dex
	stx <zStage
	jsr Item_DrawEnemyPattern
	lda #$0C
	sta <zStage
	ldx #$05
	lda <zBossRushStage
	cmp #$04
	bne .notbubble
	ldx #$02
.notbubble
	jsr Item_SetBossRushBG
	inc <zRoom
	inc aObjRoom
	inc <zScrollNumber
	inc <zScrollLeft
	inc <zScrollRight
	lda #$20
	sta aObjX
	lda #$B4
	sta aObjY
	jsr Item_OutofCapsule
	mPLAYTRACK #$0B
	lda <zBossRushStage
	sta <zBossType
	dec <zBossType
	mJSR_NORTS SpawnBoss_BossRushBegin
;83D7
;ボスラッシュのカプセルに入った時、パターンテーブルの書き換えを指定
;ステージごとのスクロール番号を指定する
.teleporter_patterntable
	.db $06, $04, $0D, $07, $11, $09, $04, $10

;83DF
;カプセルに入った時のアニメーション処理
Item_IntoCapsule:
	mPLAYTRACK #$30
	lda #$0B
	sta <zStatus
	jsr SetRockmanAnimation
	jsr EraseEnemiesByScroll
.loop
	lda aObjFrame
	cmp #$03
	beq .done
	jsr SpriteSetup
	jsr FrameAdvance1C
	jmp .loop
.done
	lda #%00000000
	sta aObjFlags
	mJSR_NORTS SpriteSetup

;8407
;カプセルから出てきた時のアニメーション処理
Item_OutofCapsule:
	lda #%11000000
	sta aObjFlags
	lda #$00
	sta <zShootPoseTimer
	sta <zStatus
	mJSR_NORTS SetRockmanAnimation

;8416
;$FD = #$60までパターンテーブルに敵の画像を転送
Item_DrawEnemyPattern:
	jsr Unknown_CB09
	jsr FrameAdvance1C
	lda <$FD
	cmp #$60
	bne Item_DrawEnemyPattern
	rts

;8423
Item_TeleporterOut:
	jsr Item_IntoCapsule
	ldx <zBossType
	lda <zBossRushProg
	ora StageBitTable,x
	sta <zBossRushProg
	cmp #$FF
	bne .remaining
	lda #$00
	sta <$FD
	lda #$14
	sta <$FE
	jsr Item_DrawEnemyPattern
	lda #$28
	jsr DrawRoom
	lda #$28
	sta <zRoom
	sta aObjRoom
	sta <zScrollLeft
	sta <zScrollRight
	bne .done
.remaining
	dec <zRoom
	dec aObjRoom
	dec <zScrollNumber
	dec <zScrollLeft
	dec <zScrollRight
.done
	ldx #$08
	jsr Item_SetBossRushBG
	lda #$00
	sta <zBossBehaviour
	ldx <zBossType
	clc
	lda Table_BossRushCapsuleY,x
	adc #$07
	sta aObjY
	lda Table_BossRushCapsuleX,x
	sta aObjX
	jsr Item_OutofCapsule
	mPLAYTRACK #$09
	mJSR_NORTS PlaceBossRushCapsule

;8481
Item_SetBossRushBG:
	ldy #$02
.loop
	lda Table_BossRushBGColor,x
	sta aPalette + $09,y
	sta aPaletteAnimBuf + $09,y
	sta aPaletteAnimBuf + $19,y
	sta aPaletteAnimBuf + $29,y
	sta aPaletteAnimBuf + $39,y
	dex
	dey
	bpl .loop
	rts

;849A
Table_BossRushBGColor:
	.db $21, $11, $01
	.db $19, $09, $0A
	.db $19, $09, $21

;84A3
Item_TeleporterWily:
	jsr Item_IntoCapsule
	lda #$29
	jsr DrawRoom
	lda #$29
	sta <zRoom
	sta aObjRoom
	sta <zScrollLeft
	sta <zScrollRight
	lda #$00
	sta <$FD
	lda #$15
	sta <$FE
	jsr Item_DrawEnemyPattern
	lda #$2A
	jsr DrawRoom
	lda #$B4
	sta aObjY
	lda #$28
	sta aObjX
	jsr Item_OutofCapsule
	mPLAYTRACK #$0B
	mJSR_NORTS SpawnBoss

;84DC
Table_ItemInterruptlo:
	.db LOW(Item_RecoverLifeBig)
	.db LOW(Item_RecoverLifeSmall)
	.db LOW(Item_RecoverEnergyBig)
	.db LOW(Item_RecoverEnergySmall)
	.db LOW(Item_GetETank)
	.db LOW(Item_GetExLife)
	.db LOW(Item_TeleporterIn)
	.db LOW(Item_TeleporterOut)
	.db LOW(Item_TeleporterWily)
;84E5
Table_ItemInterrupthi:
	.db HIGH(Item_RecoverLifeBig)
	.db HIGH(Item_RecoverLifeSmall)
	.db HIGH(Item_RecoverEnergyBig)
	.db HIGH(Item_RecoverEnergySmall)
	.db HIGH(Item_GetETank)
	.db HIGH(Item_GetExLife)
	.db HIGH(Item_TeleporterIn)
	.db HIGH(Item_TeleporterOut)
	.db HIGH(Item_TeleporterWily)

;84EE
;ロックマン状態別の処理
DoRockman:
	.include "src/dorockman.asm"

;8F39
;「進む」スクロールの処理
Scroll_GoForward:
	jsr EraseEnemiesByScroll
.loop
	ldx #$00
	lda <zVScroll
	beq .skip
	bmi .1
	inx
.1
	and #$07
	bne .skip_nt
	ldy #$01
	sty <$01
	dey
	sty <$00
	stx <$02
	jsr WriteNameTableByScroll
.skip_nt
	ldy <zVScroll
	bmi .godown
	dey
	bpl .write
.godown
	iny
	cpy #$F0
	bne .write
	ldy #$00
.write
	sty <zVScroll
	jsr SpriteSetup
	jsr FrameAdvance1C
	jmp .loop
.skip
	lda <zScrollNumber
	jsr GetScrollTo
	txa
	sta <zScrollNumber
	sec
	sbc #$02
	ldx #$80
	ldy #$20
	jsr DrawRoom
	mMOV #$19, <$FD
;シャッターの処理
.loop_open
	ldx <zStage
	lda <zScrollFlag
	bpl .vertical
	lda <$FD
	and #$07
	bne .skip_open
	mPLAYTRACK #$34
	lda <zRoom
	sta <$09
	lda #$F0
	sta <$08
	lda <$FD
	asl a
	adc Table_ShutterHeight,x
	sta <$0A
	jsr SetPPUPos
	jsr SetPPUPos_Attr
	lda #$80
	sta <zPPUShutterFlag
	inc <zPPULaser
.skip_open
	jsr FrameAdvance1C
	dec <$FD
	bpl .loop_open
	mPLAYTRACK #$FE
.vertical
	jsr DoScroll_Loop
	inc <zRoom
	jsr FrameAdvance1C
	lda <zScrollFlag
	and #$01
	bne .done
	sec
	lda <zScrollNumber
	sta <zRoom
	sta aObjRoom
	sbc #$02
	ldx #$00
	ldy #$10
	jsr DrawRoom
	sec
	lda <zScrollNumber
	sbc #$01
	ldx #$80
	ldy #$10
	jsr DrawRoom
;シャッター閉じる処理
	lda #$00
	sta <$FD
	sta <$FE
.loop_close
	lda <zScrollFlag
	bpl .done
	ldx <zStage
	lda <zRoom
	cmp Table_BossRoom,x
	bne .notboss
	mPLAYTRACK #$0B
	lda <zStage
	cmp #$0B
	beq .notboss
	cmp #$08
	bcs .done
.notboss
	lda <$FD
	and #$07
	bne .skip_close
	mPLAYTRACK #$34
	lda <zRoom
	sta <$09
	lda #$00
	sta <$08
	lda <$FD
	asl a
	adc Table_ShutterHeight,x
	sta <$0A
	jsr SetPPUPos
	ldx <zStage
	lda Table_ShutterAttr,x
	jsr SetPPUPos_Attr
	inc <zPPUShutterFlag
	inc <zPPULaser
.skip_close
	jsr FrameAdvance1C
	inc <$FD
	lda <$FD
	cmp #$19
	bne .loop_close
	mPLAYTRACK #$FE
.done
	lda #$40
	sta <zMoveVec
	mJSR_NORTS SpawnEnemyByScroll

;9045
;ステージごとのシャッターの高さ
Table_ShutterHeight:
	.db $60, $40, $40, $40, $40, $40, $40, $40
	.db $00, $00, $80, $80, $00, $80

;9053
;ステージごとのシャッターの色
Table_ShutterAttr:
	.db $00, $55, $AA, $00, $00, $55, $00, $AA
	.db $00, $00, $00, $00, $00, $00

;9061
;シャッター配置位置
Table_ShutterStart:
	.db $15, $13, $15, $13, $15, $11, $13, $11
	.db $00, $00, $26, $25, $00, $1E

;906F
;ボスの居る画面数
Table_BossRoom:
	.db $63, $43, $5F, $15, $17, $13, $15, $13
	.db $00, $27, $27, $26, $00, $1F

;907D
;次の画面を描画
;DrawRoom_ByVertical
DrawRoom:
	sta <$FF
	lda <zRoom
	pha
	lda <zHScroll
	pha
	lda <$FF
	sta <zRoom
	stx <zHScroll
	;y = num of loops
	sty <$FD
.loop
	mSTZ <$01, <$02
	mMOV #$01, <$00
	jsr WriteNameTableByScroll
	lda <z2000
	and #%10000000
	beq .nowait
	lda <zHScroll
	sta <$FE
	lda <zRoom
	sta <$FF
	pla
	sta <zHScroll
	pla
	sta <zRoom
	jsr FrameAdvance1C
	lda <zRoom
	pha
	lda <zHScroll
	pha
	lda <$FF
	sta <zRoom
	lda <$FE
	sta <zHScroll
	jmp .wait
.nowait
	jsr WritePPUScroll
.wait
	clc
	lda <zHScroll
	adc #$08
	bcc .carry_nt
	inc <zRoom
.carry_nt
	sta <zHScroll
	
	dec <$FD
	bne .loop
	pla
	sta <zHScroll
	pla
	sta <zRoom
	rts

;90C9
;実際にループしてスクロールさせる処理を呼ぶ
DoScroll_Loop:
;	lda <zScrollFlag
;	and #$01
;	beq .right
;	jmp DoVerticalScroll_Loop
;.right
	;jsr PaletteChange_RightScroll
	mSTZ <zSliplo, <zSliphi, <$FD
	ldy #$3F
.loop_right
	tya
	pha
	clc
	lda <zHScroll
	adc #$04
	sta <zHScroll
	clc
	lda aObjXlo
	adc #$C0
	sta aObjXlo
	lda aObjX
	adc #$00
	sta aObjX
	lda <zEquipment
	cmp #$01
	bne .skipatomic
	jsr FixAtomicFireObject
.skipatomic
	jsr SpriteSetup
	;jsr Unknown_CB09
	jsr FrameAdvance1C
	pla
	tay
	dey
	bne .loop_right
	sty <zHScroll
	rts

;9115
PaletteChange_RightScroll:
	ldx <zStage
	cpx #$03
	bne .bubble
	ldy <zScrollNumber
	cpy #$04
	beq .skip
.bubble
	ldy .ptr,x
	beq .skip
	lda .size,x
	sta <$FD
	lda .begin,x
	tax
.loop
	lda .data,x
	sta aPalette,y
	sta aPaletteAnimBuf,y
	sta aPaletteAnimBuf + $10,y
	sta aPaletteAnimBuf + $20,y
	sta aPaletteAnimBuf + $30,y
	dex
	dey
	dec <$FD
	bne .loop
.skip
	rts
;9148
;右スクロール時のパレット変更・書き込み位置
.ptr
	.db $00, $0B, $00, $0B, $00, $00, $00, $0F
	.db $00, $00, $03, $00, $00, $0B
;9156
;右スクロール時のパレット変更・データ開始位置
.begin
	.db $00, $02, $00, $05, $00, $00, $00, $0C
	.db $00, $00, $0F, $00, $00, $12
;9164
;右スクロール時のパレット変更・書き込みサイズ
.size
	.db $00, $03, $00, $03, $00, $00, $00, $07
	.db $00, $00, $03, $00, $00, $03
;9172
;右スクロール時のパレット変更・書き込むデータ
.data
	.db $2B, $1B, $0B ;エアーマンステージ(未使用)
	.db $21, $01, $0F ;バブルマンステージ(ボス前の網模様壁)
	.db $39, $18, $01, $0F, $39, $18, $0F ;クラッシュマンステージ(星空)
	.db $27, $37, $30 ;W3(ガッツタンク用)
	.db $0F, $0F, $0F ;W6(エイリアン戦前背景暗転)

;9185
;上下スクロールの実行処理
;DoVerticalScroll_Loop:
;.counter = $39
;	lda <zScrollFlag
;	lsr a
;	bne .down
;;上スクロール
;	ldx #$09
;	stx <zStatus
;	pha
;	jsr SetRockmanAnimation
;	pla
;.down
;	tax
;	lda Table_VScrollCounter_Init,x
;	sta <.counter
;	lda Table_VScroll_Init,x
;	sta <zVScroll
;	lda #$00
;	sta <$FD
;.loop
;	txa
;	pha
;	jsr SpriteSetup
;	jsr VerticalScroll_DrawNT
;	jsr Unknown_CB09
;	jsr FrameAdvance1C
;	pla
;	tax
;	lda <zEquipment
;	cmp #$01
;	bne .skipatomic
;	jsr FixAtomicFireObject
;.skipatomic
;	clc
;	lda aObjYlo
;	adc Table_VScroll_dylo,x
;	sta aObjYlo
;	lda aObjY
;	adc Table_VScroll_dy,x
;	sta aObjY
;	lda <zOffscreen
;	adc Table_VScroll_dOffscreen,x
;	sta <zOffscreen
;	clc
;	lda <zVScroll
;	adc Table_VScroll_dyhi,x
;	sta <zVScroll
;	clc
;	lda <.counter
;	adc Table_VScrollCounter_Delta,x
;	sta <.counter
;	bmi .done
;	cmp #$3C
;	beq .done
;	bne .loop
;.done
;	lda #$00
;	sta <zVScrolllo
;	sta <zVScroll
;	sta aObjYlo
;	mJSR_NORTS SpriteSetup

;91FA
;アトミックファイヤーオブジェクトの位置修正
FixAtomicFireObject:
	lda aObjX
	sta aObjX + 2
	lda aObjRoom
	sta aObjRoom + 2
	lda aObjY
	sta aObjY + 2
	lda #$00
	sta aObjWait + 2
	rts

;9212
;上下スクロールカウンター初期値
Table_VScrollCounter_Init:
	.db $3B, $00
;9214
;上下スクロールカウンター増減値
Table_VScrollCounter_Delta:
	.db $FF, $01
;9216
;ロックマンY位置loFix@上下スクロール
Table_VScroll_dylo:
	.db $BF, $41
;9218
;ロックマンY位置hiFix@上下スクロール
Table_VScroll_dy:
	.db $03, $FC
;921A
;画面位置Fix@上下スクロール
Table_VScroll_dyhi:
	.db $FC, $04
;921C
;初期画面位置@上下スクロール
Table_VScroll_Init:
	.db $EF, $00
;921E
;画面外フラグ増減値@上下スクロール
Table_VScroll_dOffscreen:
	.db $00, $FF

;9220
;スクロール時に敵を消す
EraseEnemiesByScroll:
	ldx #$00
	lda <zEquipment
	cmp #$06
	beq .timestopper
	cmp #$01
	bne .skipatomic
.timestopper
	ldx aObjFlags + 2
.skipatomic
	txa
	pha
	lda #%00000000
	ldx #$1F
.loop_del
	sta aObjFlags,x
	dex
	bne .loop_del
	sta aWeaponPlatformW
	sta aWeaponPlatformW + 1
	sta aWeaponPlatformW + 2
	pla
	sta aObjFlags + 2
	ldx #$0F
.loop_order
	lda #$FF
	sta aEnemyOrder10,x
	sta aItemOrder10,x
	lda #$00
	sta aPlatformWidth10,x
	dex
	bpl .loop_order
	rts

;925B
;敵の挙動
DoEnemyObjects:
	sec
	lda aObjX
	sbc <zHScroll
	sta <zRScreenX
	lda <zStopFlag
	beq .do_normal
	cmp #$04
	bne .stopping
.do_normal
	ldx #$10
	stx <zObjIndex
.loop_normal
	lda aObjFlags,x
	bpl .return
	sec
	lda aObjX,x
	sbc <zHScroll
	sta <zEScreenX
	lda aObjRoom,x
	sbc <zRoom
	sta <zEScreenRoom
	ldy aObjAnim,x
	lda .enemyaddr_lo,y
	sta <zPtrlo
	lda .enemyaddr_hi,y
	sta <zPtrhi
	lda #HIGH(.return - 1)
	pha
	lda #LOW(.return - 1)
	pha
	jmp [zPtr]
.return
	inc <zObjIndex
	ldx <zObjIndex
	cpx #$20
	bne .loop_normal
	rts
;92A2
;時間停止中
.stopping
	ldx #$10
	stx <zObjIndex
.loop_stopping
	lda aObjFlags,x
	bpl .return_stopping
	sec
	lda aObjX,x
	sbc <zHScroll
	sta <zEScreenX
	lda aObjRoom,x
	sbc <zRoom
	sta <zEScreenRoom
	lda #HIGH(.return_stopping - 1)
	pha
	lda #LOW(.return_stopping - 1)
	pha
	ldy aObjAnim,x
	lda .stoppingindex,y
	bne .specify
	ldy aObjAnim,x
	lda .enemyaddr_lo,y
	sta <zPtrlo
	lda .enemyaddr_hi,y
	sta <zPtrhi
	jmp [zPtr]
.specify
	tay
	dey
	lda .stoppingaddrlo,y
	sta <zPtrlo
	lda .stoppingaddrhi,y
	sta <zPtrhi
	jmp [zPtr]
.return_stopping
	inc <zObjIndex
	ldx <zObjIndex
	cpx #$20
	bne .loop_stopping
	rts

.enemyaddr_lo
	_enemyptrlo 00, 01, 02, 03, 04, 05, 06, 07
	_enemyptrlo 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	_enemyptrlo 10, 11, 12, 13, 14, 15, 16, 17
	_enemyptrlo 18, 19, 1A, 1B, 1C, 1D, 1E, 1F
	_enemyptrlo 20, 21, 22, 23, 24, 25, 26, 27
	_enemyptrlo 28, 29, 2A, 2B, 2C, 2D, 2E, 2F
	_enemyptrlo 30, 31, 32, 33, 34, 35, 36, 37
	_enemyptrlo 38, 39, 3A, 3B, 3C, 3D, 3E, 3F
	_enemyptrlo 40, 41, 42, 43, 44, 45, 46, 47
	_enemyptrlo 48, 49, 4A, 4B, 4C, 4D, 4E, 4F
	_enemyptrlo 50, 51, 52, 53, 54, 55, 56, 57
	_enemyptrlo 58, 59, 5A, 5B, 5C, 5D, 5E, 5F
	_enemyptrlo 60, 61, 62, 63, 64, 65, 66, 67
	_enemyptrlo 68, 69, 6A, 6B, 6C, 6D, 6E, 6F
	_enemyptrlo 70, 71, 72, 73, 74, 75, 76, 77
	_enemyptrlo 78, 79, 7A, 7B, 7C, 7D, 7E, 7F
.enemyaddr_hi
	_enemyptrhi 00, 01, 02, 03, 04, 05, 06, 07
	_enemyptrhi 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	_enemyptrhi 10, 11, 12, 13, 14, 15, 16, 17
	_enemyptrhi 18, 19, 1A, 1B, 1C, 1D, 1E, 1F
	_enemyptrhi 20, 21, 22, 23, 24, 25, 26, 27
	_enemyptrhi 28, 29, 2A, 2B, 2C, 2D, 2E, 2F
	_enemyptrhi 30, 31, 32, 33, 34, 35, 36, 37
	_enemyptrhi 38, 39, 3A, 3B, 3C, 3D, 3E, 3F
	_enemyptrhi 40, 41, 42, 43, 44, 45, 46, 47
	_enemyptrhi 48, 49, 4A, 4B, 4C, 4D, 4E, 4F
	_enemyptrhi 50, 51, 52, 53, 54, 55, 56, 57
	_enemyptrhi 58, 59, 5A, 5B, 5C, 5D, 5E, 5F
	_enemyptrhi 60, 61, 62, 63, 64, 65, 66, 67
	_enemyptrhi 68, 69, 6A, 6B, 6C, 6D, 6E, 6F
	_enemyptrhi 70, 71, 72, 73, 74, 75, 76, 77
	_enemyptrhi 78, 79, 7A, 7B, 7C, 7D, 7E, 7F
	
.stoppingindex
	.incbin "src/bin/obj/StoppingBehaviourIndex.bin"
.stoppingaddrlo
	.db LOW(CheckOffscreenEnemy)
	.db LOW(CheckOffscreenItem)
	.db LOW(EnemyBehaviour_Stopping1)
	.db LOW(EnemyBehaviour_Stopping2)
	.db LOW(EnemyBehaviour_Stopping3)
	.db LOW(EnemyBehaviour_Stopping4)
	.db LOW(EnemyBehaviour_Stopping4)
	.db LOW(EnemyBehaviour_Stopping5)
	.db LOW(EnemyBehaviour_Stopping6)
	.db LOW(EnemyBehaviour_Stopping6)
	.db LOW(EnemyBehaviour_Stopping6)
	.db LOW(EnemyBehaviour_Stopping6)
	.db LOW(EnemyBehaviour_Stopping6)
	.db LOW(EnemyBehaviour_Stopping6)
	.db LOW(EnemyBehaviour_Stopping6)
.stoppingaddrhi
	.db HIGH(CheckOffscreenEnemy)
	.db HIGH(CheckOffscreenItem)
	.db HIGH(EnemyBehaviour_Stopping1)
	.db HIGH(EnemyBehaviour_Stopping2)
	.db HIGH(EnemyBehaviour_Stopping3)
	.db HIGH(EnemyBehaviour_Stopping4)
	.db HIGH(EnemyBehaviour_Stopping4)
	.db HIGH(EnemyBehaviour_Stopping5)
	.db HIGH(EnemyBehaviour_Stopping6)
	.db HIGH(EnemyBehaviour_Stopping6)
	.db HIGH(EnemyBehaviour_Stopping6)
	.db HIGH(EnemyBehaviour_Stopping6)
	.db HIGH(EnemyBehaviour_Stopping6)
	.db HIGH(EnemyBehaviour_Stopping6)
;	.db HIGH(EnemyBehaviour_Stopping6)

	.include "src/obj/behaviour_normal.asm"

