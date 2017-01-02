;3C000-3CFFF

	mBEGIN #$0F, #$C000
;20 00 C0
ChangeBank:
	sta <zBank
	sta <zBankCopy
	inc <zPostProcSemaphore
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	mMOV #$00, <zPostProcSemaphore
	lda <zPostProcessSound
	bne .PostProcess
	rts


.PostProcess:
	.ifdef ___BUGFIX
	tya
	pha
	.endif
	lda #$0C
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	lsr a
	sta $FFF0
	jsr $8000
.loop_postsound
	ldx <zSoundQueue
	beq .end_postsound
	lda aSoundQueue - 1,x
	jsr $8003
	dec <zSoundQueue
	bne .loop_postsound
.end_postsound
	mMOV #$00, <zPostProcessSound
	lda <zBankCopy
	.ifdef ___BUGFIX
	pla
	tay
	.endif
	jmp ChangeBank

;20 51 C0
PlayTrack:
	ldy <zSoundQueue
	cpy #$10
	bcs .skip_playtrack
	sta aSoundQueue,y
	inc <zSoundQueue
.skip_playtrack
	rts

;20 5D C0
Write_Reg0_A:
	sta $9FFF
	lsr a
	sta $9FFF
	lsr a
	sta $9FFF
	lsr a
	sta $9FFF
	lsr a
	sta $9FFF
	rts

;20 71 C0
;ワイリー城入場イベント
ChangeBank_DoEnterWilyCastle:
	mCHANGEBANK #$0D
	jsr Bank0D_BeginEnterWilyCastle
	mCHANGEBANK #$0E, 1
	;rts

;20 7F C0
FrameAdvance1C:
	mMOV <zKeyDown, <zKeyDownPrev
	.ifdef ___2P
	mMOV <zKeyDown2P, <zKeyDownPrev2P
	.endif
	jsr DoPaletteAnimation
	mMOV #$00, <zIsLag
.wait_for_NMI
	lda <zIsLag
	beq .wait_for_NMI
	jsr GetPadInfo
	lda <zKeyDown
	eor <zKeyDownPrev
	and <zKeyDown
	sta <zKeyPress
	.ifdef ___2P
	lda <zKeyDown2P
	eor <zKeyDownPrev2P
	and <zKeyDown2P
	sta <zKeyPress2P
	.endif
	mCHANGEBANK #$0E, 1
	;rts

;20 AB C0
FrameAdvance1A:
	mMOV <zKeyDown, <zKeyDownPrev
	.ifdef ___2P
	mMOV <zKeyDown2P, <zKeyDownPrev2P
	.endif
	jsr DoPaletteAnimation
	lda #$00
	sta <zIsLag
.wait_for_NMI
	lda <zIsLag
	beq .wait_for_NMI
	jsr GetPadInfo
	lda <zKeyDown
	eor <zKeyDownPrev
	and <zKeyDown
	sta <zKeyPress
	.ifdef ___2P
	lda <zKeyDown2P
	eor <zKeyDownPrev2P
	and <zKeyDown2P
	sta <zKeyPress2P
	.endif
	mCHANGEBANK #$0D, 1
	;rts

;20 D7 C0 Water Lagging
FrameAdvanceWater:
	lda <zKeyDown
	pha
	.ifdef ___2P
	lda <zKeyDown2P
	pha
	.endif
	lda <zKeyPress
	pha
;	.ifdef ___2P
;	lda <zKeyPress2P
;	pha
;	.endif
	lda #$1E
	ora <z2001
	sta <z2001
	sta $2001
	lda #$00
	sta <zIsLag
.wait_for_NMI
	lda <zIsLag
	beq .wait_for_NMI
;	.ifdef ___2P
;	pla
;	sta <zKeyPress2P
;	.endif
	pla
	sta <zKeyPress
	.ifdef ___2P
	pla
	sta <zKeyDown2P
	.endif
	pla
	sta <zKeyDown
	mCHANGEBANK #$0E, 1
	;rts

	.ifdef ___WAITFRAMES
;20 00 C1 Wait regA frames
FrameAdvance1C_Multi:
	pha
	jsr FrameAdvance1C
	pla
	sec
	sbc #$01
	bne FrameAdvance1C_Multi
	rts
	.endif

;4C 0B C1 Die Now!!!
DieRockman:
	mPLAYTRACK #$41
	mPLAYTRACK #$FF
	lda <zStatus
	bne .isfail
	sta <zShootPoseTimer
.loop_tiwninit
	and #$01
	bne .jump
	lda <zShootPoseTimer
	and #$07
	tax
	ldy #$01
.loop_tiwnround
	mMOV #$25, aObjAnim + $0E,y
	mMOV #%10000000, aObjFlags + $0E,y
	clc
	lda aObjX
	adc .tiwnround_x,x
	sta aObjX + $0E,y
	lda aObjRoom
	adc .tiwnround_xh,x
	sta aObjRoom + $0E,y
	lda aObjY
	adc .tiwnround_y,x
	sta aObjY + $0E,y
	lda #$01
	sta aObjFrame + $0E,y
	lda #$00
	sta aObjVXlo + $0E,y
	sta aObjVX + $0E,y
	sta aObjVYlo + $0E,y
	sta aObjVY + $0E,y
	sta aObjWait + $0E,y
	inx
	dey
	bpl .loop_tiwnround
.jump
	jsr MainRoutine_WhileDeath
	inc <zShootPoseTimer
	lda <zShootPoseTimer
	cmp #$10
	bcc .loop_tiwninit
	lsr aObjFlags + $0E
	lsr aObjFlags + $0F
	jsr SpawnTiwnRound
	lda #$A0
	bne .continue_tiwn
.isfail
	lda #$E0
.continue_tiwn
	sta <zShootPoseTimer
.wait_tiwn
	lsr aObjFlags
	jsr MainRoutine_WhileDeath
	dec <zShootPoseTimer
	bne .wait_tiwn

	mMOV #$10, $2000
	mMOV #$06, $2001
	lda <zStage
	and #$07
	jsr ChangeBank
	ldx #$00
	lda aObjRoom
.loop_checkpoint
	cmp $BB07,x ;-----------------
	bcc .checkpoint
	inx
	cpx #$05
	bne .loop_checkpoint
.checkpoint
	stx <zContinuePoint
	ldx #$FF
	txs
	mCHANGEBANK #$0E
	dec <zLives
	bne .notgameover
	mSTZ <zETanks
	mCHANGEBANK #$0D
	jsr Bank0D_BeginGameOver
	mCHANGEBANK #$0E
	lda <$FD
	bne .stageselect
	jmp StartStage_FillingEnergy ;ゲームオーバー→コンティニュー
.stageselect
	jmp StartStageSelect ;ゲームオーバー→ステージセレクト
.notgameover
	jmp StartStage_Continue ;残機がまだある


.tiwnround_y
	.db $F8, $08, $FB, $05, $00, $00, $05, $FB
.tiwnround_x
	.db $00, $00, $FB, $05, $FB, $08, $FB, $05
.tiwnround_xh
	.db $00, $00, $FF, $00, $FF, $00, $FF, $00


;4C F0 C1
DieBoss:
	jsr BossDeadInit
	inc <zNoDamage
.loop
	jsr SpawnBoss_Loop_Begin
	lda <zStage
	cmp #$08
	bne .notwily1
	lda <zScrollFlag
	cmp #$03
	bne .notwily1
	mSTZ <zNoDamage
	mMOV #$01, <zStatus
	jmp DieRockman
.notwily1
	lda <zBossBehaviour
	cmp #$FF
	bne .loop
	mSTZ <zNoDamage
	lda #$10
	sta <z2000
	sta $2000
	lda #$06
	sta <z2001
	sta $2001
	mSTZ <zContinuePoint
	ldx #$FF
	txs
	mCHANGEBANK #$0E
	ldx <zStage
	cpx #$08
	bcs .iswily
	lda StageBitTable,x
	ora <zClearFlags
	sta <zClearFlags
	lda ItemBitTable,x
	ora <zItemFlags
	sta <zItemFlags
	mCHANGEBANK #$0D
	jsr Bank0D_BeginGetEquipment
	mCHANGEBANK #$0E
	lda <zClearFlags
	cmp #$FF
	beq .gotowily
	jmp $8076 ;------------------------
.gotowily
	mMOV #$07, <zStage
.iswily
	inc <zStage
	lda <zStage
	cmp #$0E
	bne .isnotwily7
	mCHANGEBANK #$0D
	jsr Bank0D_BeginEnding
	lda #$0E
	jmp $F290 ;------------------------
.isnotwily7
	jmp $8079 ;------------------------

;C279
StageBitTable:
	.db $01, $02, $04, $08, $10, $20, $40, $80
;C281
ItemBitTable:
	.db $01, $02, $00, $00, $00, $04, $00, $00

;20 89 C2
BossDeadInit:
	lda #$00
	sta aBossDeath
	sta aBossVar1
	sta aBossVar2
	sta aBossInvincible
	sta <zStopFlag
	lda #$FE
	sta <zBossBehaviour
	rts

;20 9E C2
Unknown_C29E
	mSTZ <$FD
	mMOV #$02, aPaletteAnim
	mMOV #$04, aPaletteAnimWait
	mMOV #$BB, <$FD
.loop_wait2
	jsr Unknown_C386
	dec <$FD
	bne .loop_wait2
	lda #$00
	sta aPaletteAnimWait
	sta aPaletteAnim
	ldx #$02
.loop2
	lda C29E_Palette,x
	sta $0357,x
	dex
	bpl .loop2
	lda #$86
	sta <$FF
	lda #$00
	sta <$FE
.loop
	mCHANGEBANK #$09
	lda <$FD
	lsr a
	tax
	mMOV Unknown_C324,x, aPPULinearhi
	mMOV Unknown_C33B,x, aPPULinearlo
	lda <$FD
	and #$01
	beq .begin_ppu
	lda aPPULinearlo
	ora #$20
	sta aPPULinearlo
.begin_ppu
	ldy #$20
.loop_ppu
	lda [$FE],y
	sta aPPULinearData,y
	dey
	bpl .loop_ppu
	mMOV #$20, <zPPULinear
	clc
	lda <$FE
	adc #$20
	sta <$FE
	lda <$FF
	adc #$00
	sta <$FF
	jsr Unknown_C386
	inc <$FD
	lda <$FD
	cmp #$2E
	bne .loop
	mCHANGEBANK #$0E, 1
	;rts

;C321
C29E_Palette:
	.db $28, $18, $2C

Unknown_C324:
	.db $10, $1A, $1A, $1B, $1B, $1B, $1B, $1C
	.db $1C, $1C, $1C, $1D, $1D, $1D, $1D, $1E
	.db $1E, $1E, $1E, $1F, $1F, $1F, $1F
Unknown_C33B:
	.db $00, $80, $C0, $00, $40, $80, $C0, $00
	.db $40, $80, $C0, $00, $40, $80, $C0, $00
	.db $40, $80, $C0, $00, $40, $80, $C0

;C352
MainRoutine_WhileDeath:
	mCHANGEBANK #$0E
	mSTZ aObjWait
	mMOV #$01, <zInvincible
	jsr WeaponObjectProcess
	jsr SpawnEnemyByScroll
	jsr DoBossBehaviour
	jsr DoEnemyObjects
___MainRoutine_WhileDeath:
	jsr SpriteSetup
	lda <zWaterLevel
	beq .isntwater
	inc <zWaterWait
	cmp <zWaterWait
	beq .lag
	bcs .isntwater
.lag
	jsr FrameAdvanceWater
	mSTZ <zWaterWait
.isntwater
	.ifndef ___NORTS
	jsr FrameAdvance1C
	rts
	.else
	jmp FrameAdvance1C
	.endif

;C386
Unknown_C386:
	ldx #$1F
	lda #$00
.loop
	sta aObjWait,x
	dex
	bpl .loop
	jmp ___MainRoutine_WhileDeath

;C393
SpawnTiwnRound:
	mMOV aObjRoom, <$09
	mMOV aObjX, <$08
	mMOV aObjY, <$0A
	mMOV #$25, <$0B
	ldx #$0D
	ldy #$0B
.loop
	lda #%10000000
	ora TiwnRoundVector,y
	sta aObjFlags,x
	mMOV <$0B, aObjAnim,x
	mMOV <$09, aObjRoom,x
	mMOV <$08, aObjX,x
	mMOV <$0A, aObjY,x
	mMOV TiwnRoundVXlo,y, aObjVXlo,x
	mMOV TiwnRoundVXhi,y, aObjVX,x
	mMOV TiwnRoundVYlo,y, aObjVYlo,x
	mMOV TiwnRoundVYhi,y, aObjVY,x
	lda #$00
	sta aObjWait,x
	sta aObjFrame,x
	dex
	dey
	bpl .loop
	rts

TiwnRoundVXlo:
	.db $00, $00, $00, $00, $60, $60, $60, $60
	.db $00, $C0, $00, $E0
TiwnRoundVXhi:
	.db $00, $02, $00, $02, $01, $01, $01, $01
	.db $00, $00, $00, $00
TiwnRoundVYlo:
	.db $00, $00, $00, $00, $60, $A0, $A0, $60
	.db $C0, $00, $40, $00
TiwnRoundVYhi:
	.db $02, $00, $FE, $00, $01, $FE, $FE, $01
	.db $00, $00, $FF, $00
TiwnRoundVector:
	.db $00, $40, $00, $00, $40, $40, $00, $00
	.db $00, $40, $00, $00

;20 27 C4
DoPaletteAnimation:
	lda <zStopFlag
	bne .isnoanim
	lda aPaletteAnimWait
	beq .isnoanim
	inc <zPaletteTimer
	cmp <zPaletteTimer
	bcs .isnoanim
	mSTZ <zPaletteTimer
	inc <zPaletteIndex
	lda <zPaletteIndex
	cmp aPaletteAnim
	bcc .noloop
	mSTZ <zPaletteIndex
.noloop
	asl a
	asl a
	asl a
	asl a
	tax
	ldy #$00
.loop
	mMOV aPaletteAnimBuf,x, aPalette,y
	inx
	iny
	cpy #$10
	bne .loop
	inc <$3A
.isnoanim
	rts


;20 5D C4
LoadStageGraphics:
.ptr = $0A
.ptrlo = $0A
.ptrhi = $0B
	lda <zStage
	and #$07
	jsr ChangeBank
	mMOVW $BC00, <.ptrlo
	lda <zStage
	and #$08
	beq .is8bosses
	inc <.ptrhi
.is8bosses
	ldy #$00
	mMOV [.ptr],y, <$00
	lda #$00
	sta $2006
	sta $2006
	sta <zPtrlo
	iny
	sty <$01
.loop3
	ldy <$01
	mMOV [.ptr],y, <zPtrhi
	iny
	mMOV [.ptr],y, <$02
	iny
	lda [.ptr],y
	iny
	sty <$01
	jsr ChangeBank
.loop2
	ldy #$00
.loop
	mMOV [zPtr],y, $2007
	iny
	bne .loop
	inc <zPtrhi
	dec <$02
	bne .loop2
	lda <zStage
	and #$07
	jsr ChangeBank
	dec <$00
	bne .loop3
	inc <.ptrhi
	inc <.ptrhi
	ldy #$61
.loop_palette
	mMOV [.ptr],y, aPaletteAnim,y
	dey
	bpl .loop_palette
	jsr WritePalette
	mCHANGEBANK #$0E, 1
	;rts

;20 CD C4
SetContinuePoint:
	lda <zStage
	and #$07
	jsr ChangeBank
	ldy <zContinuePoint
	lda $BB06,y ;-----------------------
	sta <zRoom
	sta aObjRoom
	lda $BB0C,y ;-----------------------
	sta <zEnemyIndexPrev
	sta <zEnemyIndexNext
	lda $BB12,y ;-----------------------
	sta <zItemIndexPrev
	sta <zItemIndexNext
	lda $BB18,y ;-----------------------
	sta <zNTPrevhi
	lda $BB1E,y ;-----------------------
	sta <zNTPrevlo
	lda $BB24,y ;-----------------------
	sta <zNTNexthi
	lda $BB2A,y ;-----------------------
	sta <zNTNextlo
	lda $BB30,y ;-----------------------
	sta <zScrollNumber
	lda $BB36,y ;-----------------------
	sta <zScrollLeft
	lda $BB3C,y ;-----------------------
	sta <zScrollRight
	ldx <zScrollNumber
	jsr Unknown_CB61
	tya
	clc
	adc #$0B
	tay
	ldx #$0C
.loop_pha
	lda $B460,y ;-----------------------
	pha
	dey
	dex
	bne .loop_pha
	lda #$0A
	sta $2006
	lda #$00
	sta $2006
	sta <zPtrlo
	lda #$06
	sta <$00
.loop_enemygraphics
	pla
	sta <zPtrhi
	pla
	jsr ChangeBank
	ldy #$00
.loop
	lda [zPtr],y
	sta $2007
	iny
	bne .loop
	dec <$00
	bne .loop_enemygraphics
	mCHANGEBANK #$0E
	lda <zContinuePoint
	cmp #$02
	bne .isnot_02
	jsr $9115 ;-------------------------
.isnot_02
	rts

;20 57 C5
BeginTitleScreen:
	mCHANGEBANK #$0D
	jsr Bank0D_BeginTitleScreen
	mCHANGEBANK #$0E, 1
	;rts

;20 65 C5
ChangeBank_DoStageSelect
	mCHANGEBANK #$0D
	jsr Bank0D_BeginStageSelect
	mCHANGEBANK #$0E, 1
	;rts

;20 73 C5
OpenSubMenu:
	ldx #$0F
.loop_check
	lda aObjFlags,x
	bmi .skip
	dex
	cpx #$01
	bne .loop_check
	lda <zPPULinear
	beq .notreserved
	jsr FrameAdvance1C
.notreserved
	lda aPPULinearhi
	pha
	lda aPPULinearlo
	pha
	mPLAYTRACK #$32
	mCHANGEBANK #$0D
	jsr Bank0D_BeginWeaponMenu
	pla
	sta aPPULinearlo
	pla
	sta aPPULinearhi
	lda #$0E
	jsr ChangeBank
.skip
	rts

;20 A9 C5
DoBossBehaviour:
	lda <zBossBehaviour
	beq .jump
	mCHANGEBANK #$0B
	jsr $8003
	mCHANGEBANK #$0E
	lda aBossDeath
	beq .jump
	lda <zStage
	cmp #$0C
	bne .notbossrush
	lda <zBossRushProg
	cmp #$FF
	beq .notbossrush
	ldx #$0F
.loop_erase
	lsr aObjFlags10,x
	dex
	bpl .loop_erase
	jsr BossDeadInit
	lda #$00
	sta <zObjIndex
	lda #$7D
	ldx #$0F
	jsr CreateEnemyHere_Middle
	lda #$20
	sta aObjX10 + $0F
	lda #$AB
	sta aObjY10 + $0F
	bne .jump
.notbossrush
	jmp DieBoss
.jump
	rts

;20 F1 C5
LoadBossBG:
	pha
	lda aBossPtrhi
	sta <$09
	lda aBossPtrlo
	sta <$08
	pla
	jsr WritePPUData
	clc
	lda aPPULinearlo
	adc #$20
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	clc
	lda aBossPtrlo
	adc #$20
	sta aBossPtrlo
	lda aBossPtrhi
	adc #$00
	sta aBossPtrhi
	mCHANGEBANK #$0B, 1
	;rts

;20 28 C6
;バンクAに切り替えて、[zPtr]からのテーブルを$400バイトPPUへ書き込み
;ネームテーブル書き換え用かな
LoadScreenData:
	jsr ChangeBank
	lda #$00
	sta <zPtrlo
	ldx #$04
.loop
	lda [zPtr],y
	sta $2007
	iny
	bne .loop
	inc <zPtrhi
	dex
	bne .loop
	mCHANGEBANK #$0D, 1
	;rts

;20 44 C6
LoadGraphicsSet:
	sta <$00
	tax
	lda Table_GraphicsSetNum,x
	sta <$01
	lda Table_GraphicsBeginPointer,x
	sta <$02
	lda #$00
	sta <zPtrlo
	sta $2006
	sta $2006
.loop2
	ldx <$02
	lda Table_GraphicsPosition,x
	sta <zPtrhi
	lda Table_GraphicsAmount,x
	sta <$03
	lda Table_GraphicsBank,x
	jsr ChangeBank
	ldy #$00
.loop
	lda [zPtr],y
	sta $2007
	iny
	bne .loop
	inc <zPtrhi
	dec <$03
	bne .loop
	inc <$02
	dec <$01
	bne .loop2
	mCHANGEBANK #$0D, 1
	;rts

Table_GraphicsSetNum:
	.db $02, $02, $02, $06, $0E, $04, $08
Table_GraphicsBeginPointer:
	.db $00, $02, $04, $06, $0C, $1A, $1E
Table_GraphicsBank:
	.db $05, $08, $06, $09, $06, $09, $00, $09
	.db $08, $09, $08, $09, $03, $03, $04, $04
	.db $06, $04, $05, $05, $05, $07, $07, $02
	.db $08, $07, $05, $08, $09, $08, $00, $06
	.db $07, $07, $07, $02, $02, $09
Table_GraphicsPosition:
	.db $90, $88, $90, $90, $90, $A0, $98, $AC
	.db $80, $AC, $84, $9F, $99, $9C, $9D, $9B
	.db $B2, $97, $93, $96, $9C, $9D, $9F, $95
	.db $A4, $B2, $90, $88, $9F, $8C, $98, $B2
	.db $9D, $9F, $AE, $96, $94, $AC
Table_GraphicsAmount:
	.db $10, $10, $10, $10, $10, $10, $0E, $02
	.db $04, $02, $04, $06, $02, $01, $01, $01
	.db $02, $01, $01, $02, $01, $01, $01, $02
	.db $0C, $02, $10, $03, $01, $0C, $08, $01
	.db $01, $01, $01, $01, $01, $02

;20 09 C7
;[$08],yから0x20バイト分をPPU書き込み予約 Aにバンク
WritePPUData:
	jsr ChangeBank
	ldy #$1F
.loop
	lda [zPtr],y
	sta aPPULinearData,y
	dey
	bpl .loop
	lda #$20
	sta <zPPULinear
	mCHANGEBANK #$0D, 1
	;rts

	.ifndef ___DISABLE_INTRO_PIPI
;20 20 C7
SelectStage_LoadPipiGraphics:
	mCHANGEBANK #$01
	ldx #$1F
.loop
	lda $9CD0,x ;----------------------------
	sta aPPULinearData,x
	dex
	bpl .loop
	lda #$08
	sta aPPULinearhi
	lda #$00
	sta aPPULinearlo
	lda #$20
	sta <zPPULinear
	mCHANGEBANK #$0D, 1
	;rts
	.endif

;20 44 C7
;$FE~$FFのアドレスにある値を#$20バイト分$3B8～$3D8へ書き込み
WriteTableToPPULinear:
	mCHANGEBANK #$09
	ldy #$1F
.loop
	lda [$FE],y
	sta aPPULinearData,y
	dey
	bpl .loop
	lda #$20
	sta <zPPULinear
	mCHANGEBANK #$0D, 1
	;rts

;20 5D C7
Unknown_C75D:
	lda <$FD
	sta <zPtrhi
	lda #$00
	lsr <zPtrhi
	ror a
	lsr <zPtrhi
	ror a
	lsr <zPtrhi
	ror a
	sta aPPULinearlo
	sta <zPtrlo
	lda <$FD
	cmp #$08
	bcc .jump
	lda <zPtrhi
	jmp .jump2
.jump
	lda <zPtrhi
	adc #$09
.jump2
	sta aPPULinearhi
	clc
	tya
	adc <zPtrhi
	sta <zPtrhi
	txa
	jsr ChangeBank
	ldy #$1F
.loop
	lda [zPtr],y
	sta aPPULinearData,y
	dey
	bpl .loop
	lda #$20
	sta <zPPULinear
	mCHANGEBANK #$0D, 1
	;rts

;20 A1 C7
GetScrollInfo:
	lda <zStage
	and #$07
	jsr ChangeBank
	lda $B400,y ;----------------------
	tay
	mCHANGEBANK #$0E, 1
	;rts

;20 B2 C7: 棒状になって降りてきて着地まで
Rockman_Warp_to_Land:
	lda #%11000000
	sta aObjFlags
	lda #$80
	sta aObjX
	lda #$14
	sta aObjY
	lda #$1A
	sta aObjAnim
.loop
	lda <zStage
	and #$07
	jsr ChangeBank
	lda #$00
	sta aObjWait
	sta aObjFrame
	clc
	lda aObjY
	adc #$10
	sta aObjY
	ldx <zContinuePoint
	cmp $BB00,x ;----------------------
	beq .onland
	jsr SpriteSetup
	jsr FrameAdvance1C
	jmp .loop
.onland
	mPLAYTRACK #$30
	lda #$00
	sta <zStatus
	sta <zSliplo
	sta <zSliphi
	lda #$40
	sta <zMoveVec
	mCHANGEBANK #$0E, 1
	;rts


;20 05 C8
SpawnBoss:
	lda <zStage
	sta <zBossKind
SpawnBoss_BossRushBegin:
	mCHANGEBANK #$0B
	jsr $8000
	mCHANGEBANK #$0E
SpawnBoss_Loop_Begin:
.loop
	lda #$00
	sta <zKeyDown
	sta <zKeyPress
	jsr DoRockman
	jsr WeaponObjectProcess
	jsr SpawnEnemyByScroll
	jsr DoBossBehaviour
	jsr DoEnemyObjects
	jsr SpriteSetup
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
	lda <zBossBehaviour
	cmp #$02
	bcc .loop
	rts

;20 4B C8 Random: $04 = math.random(0, $02)
;$01 / $02 = $03×$02 + $04
Divide8:
	lda #$00
	sta <$03
	sta <$04
	lda <$01
	ora <$02
	bne .jump
	sta <$03
	rts
.jump
	ldy #$08
.loop
	asl <$03
	rol <$01
	rol <$04
	sec
	lda <$04
	sbc <$02
	bcc .jump2
	sta <$04
	inc <$03
.jump2
	dey
	bne .loop
	rts

;20 71 C8 Divide $0F~$0E = $0B~$0A / $0D~$0C
;A = B / C
Divide:
.A = $0E
.Ahi = $0F
.B = $0A
.Bhi = $0B
.C = $0C
.Chi = $0D
	lda #$00
	sta <$11
	sta <$10
	lda <.Bhi
	ora <.B
	ora <.Chi
	ora <.C
	bne .isvalid
	sta <.Ahi
	sta <.A
	rts
.isvalid
	ldy #$10
.loop
	asl <$10
	rol <.B
	rol <.Bhi
	rol <$11
	sec
	lda <.Bhi
	sbc <.C
	tax
	lda <$11
	sbc <.Chi
	bcc .cc
	
	.ifdef ___BUGFIX
	stx <.Bhi
	.else
	stx <$09
	.endif
	
	sta <$11
	inc <$10
.cc
	dey
	bne .loop
	lda <.B
	sta <.Ahi
	lda <$10
	sta <.A
	rts

;20 AE C8: $300, $304, $308, $30C = 画面$09, 位置$08
SetPPUSquareInfo:
	ldx <zPPUSqr
	ldy #$20
	lda <$09
	and #$01
	beq .left
	ldy #$24
.left
	sty <$0B
	lda <$08
	lsr a
	lsr a
	pha
	lsr a
	and #$03
	ora <$0B
	sta aPPUSqrhi,x
	pla
	pha
	ror a
	and #$FC
	sta aPPUSqrlo,x
	lda <$0B
	ora #$03
	sta aPPUSqrAttrhi,x
	pla
	sta <$0A
	lsr a
	lsr a
	lsr a
	asl <$0A
	asl <$0A
	asl <$0A
	ora <$0A
	ora #$C0
	sta aPPUSqrAttrlo,x
	rts

;20 EC C8: $3B6, $3BC = 画面$09, 横$08, 縦$0A
SetPPUPos:
	ldx <zPPULaser
	ldy #$08
	lda <$09
	and #$01
	beq .left
	ldy #$09
.left
	sty <$0B
	lda <$0A
	and #$F8
	asl a
	rol <$0B
	asl a
	rol <$0B
	sta aPPULaserlo,x
	lda <$08
	lsr a
	lsr a
	lsr a
	ora aPPULaserlo,x
	sta aPPULaserlo,x
	lda <$0B
	sta aPPULaserhi,x
	rts

;20 18 C9
;シャッターの属性テーブルの設定かな……？
SetPPUPos_Attr:
	pha
	lda <$08
	pha
	ldx <zPPULaser
	lda <$0A
	and #$E0
	lsr a
	lsr a
	sta <$0B
	asl <$08
	rol a
	asl <$08
	rol a
	asl <$08
	rol a
	ora <$0B
	ora #$C0
	sta $03C8,x
	ldy #$23
	lda <$09
	and #$01
	beq .left
	ldy #$27
.left
	tya
	sta $03C2,x
	ldy #$00
	pla
	and #$10
	beq .jump
	iny
.jump
	lda <$0A
	and #$10
	beq .jump2
	iny
	iny
.jump2
	pla
	and Table_C918,y
	sta $03CE,x
	lda Table_C918,y
	eor #$FF
	sta $03D4,x
	rts

;1EC964
Table_C918:
	.db $03, $0C, $30, $C0

;20 68 C9
;ロックマンの進み具合に応じてマップをBGへ書き込み
WriteNameTableByScroll:
	lda <zStage
	and #$07
	jsr ChangeBank
	lda #$20
	sta <$0B
	ldy #$00
	lda [zPtr],y
	tax
	tay
	lda $8400,y
	pha
	txa
	asl a
	rol <$0B
	asl a
	rol <$0B
	sta <$0A
	lda <zPPUSqr
	asl a
	asl a
	asl a
	asl a
	tax
	pha
	ldy #$00
.loop
	clc
	pla
	pha
	adc Table_C968,y
	tax
	lda [$0A],y
	asl a
	asl a
	clc
	sta aPPUSqrData,x
	adc #$01
	sta aPPUSqrData + 4,x
	adc #$01
	sta aPPUSqrData + 1,x
	adc #$01
	sta aPPUSqrData + 5,x
	iny
	cpy #$04
	bne .loop
	pla
	ldy #$20
	lda <$08
	and #$40
	beq .jump
	ldy #$24
.jump
	sty <$0D
	lda <zNTPointer
	sta <$0C
	lsr a
	ror <$0C
	lda <$0C
	pha
	and #$03
	ora <$0D
	sta <$0D
	pla
	and #$FC
	ldx <zPPUSqr
	sta aPPUSqrlo,x
	lda <$0D
	sta aPPUSqrhi,x
	lda <$0D
	ora #$03
	sta aPPUSqrAttrhi,x
	lda <zNTPointer
	sta <$0C
	lsr a
	lsr a
	lsr a
	asl <$0C
	asl <$0C
	asl <$0C
	ora #$C0
	ora <$0C
	sta aPPUSqrAttrlo,x
	pla
	sta aPPUSqrAttrData,x
	inc <zPPUSqr
	mCHANGEBANK #$0E, 1
	;rts

;1ECA04
Table_C968:
	.db $00, $08, $02, $0A

;20 08 CA
WriteNameTableByScroll_AnyBank:
	lda <zBank
	pha
	jsr WriteNameTableByScroll
	pla
	jsr ChangeBank
	rts

;20 13 CA: 上下スクロール時のNameTableの描画に密接に関わる
VerticalScroll_DrawNT:
.VertScrollCounter = $39
	lda <zStage
	and #$07
	jsr ChangeBank
	lda <.VertScrollCounter
	lsr a
	lsr a
	lsr a
	lsr a
	sta aPPUSqrhi
	lda <.VertScrollCounter
	asl a
	asl a
	asl a
	pha
	and #$18
	sta aPPUSqrhi + 1
	pla
	asl a
	and #$C0
	ora aPPUSqrhi + 1
	sta aPPUSqrhi + 1
	lda <.VertScrollCounter
	and #$F8
	ora #$C0
	sta aPPUSqrData + 3
	lda <.VertScrollCounter
	and #$03
	asl a
	ora aPPUSqrData + 3
	sta aPPUSqrData + 3
	ldx #$20
	lda <zRoom
	and #$01
	beq .left
	ldx #$24
.left
	txa
	ora aPPUSqrhi
	sta aPPUSqrhi
	txa
	ora #$03
	sta aPPUSqrData + 2
	lda #$00
	sta <$00
	lda <.VertScrollCounter
	and #$3B
	lsr a
	ror <$00
	lsr a
	ror <$00
	lsr a
	ror <$00
	lsr <$00
	ora <$00
	sta <$00
	lda aObjRoom
	ldx #$00
	stx <zPtrlo
	lsr a
	ror <zPtrlo
	lsr a
	ror <zPtrlo
	clc
	adc #$85
	sta <zPtrhi
	stx <$01
.loop2
	ldy <$00
	lda [zPtr],y
	sta <$03
	sta <$0A
	lda #$20
	asl <$0A
	rol a
	asl <$0A
	rol a
	sta <$0B
	ldy #$00
	lda <.VertScrollCounter
	and #$04
	beq .jump
	iny
.jump
	lda #$02
	sta <$02
.loop
	lda [$0A],y
	asl a
	asl a
	clc
	sta aPPUSqrhi + 2,x
	adc #$01
	sta aPPUSqrAttrhi + 2,x
	adc #$01
	sta aPPUSqrhi + 3,x
	adc #$01
	sta aPPUSqrAttrhi + 3,x
	inx
	inx
	iny
	iny
	dec <$02
	bne .loop
	lda <.VertScrollCounter
	ldy #$0F
	and #$04
	beq .jump2
	ldy #$F0
.jump2
	sty aPPUSqrData + 4
	ldy <$03
	lda $8400,y
	and aPPUSqrData + 4
	ldy <$01
	sta aPPUSqrData + 5,y
	lda <$00
	ora #$08
	sta <$00
	inc <$01
	lda <$01
	cmp #$02
	beq .jump3
	jmp .loop2
.jump3
	lda #$80
	sta <zPPUSqr
	lda #$FF
	eor aPPUSqrData + 4
	sta aPPUSqrData + 4
	mCHANGEBANK #$0E, 1
	;rts

;20 09 CB
;上下スクロール時のパターンテーブル描画に密接に関わる
Unknown_CB09:
	lda <$FD
	cmp #$60
	bcc .do
	rts
.do
	lda <zBank
	pha
	lda <$FD
	and #$F0
	lsr a
	lsr a
	lsr a
	pha
	lsr a
	clc
	adc #$0A
	sta aPPULinearhi
	lda <$FD
	asl a
	asl a
	asl a
	asl a
	sta aPPULinearlo
	sta <$08
	lda <zStage
	and #$07
	jsr ChangeBank
	ldx <$FE
	jsr Unknown_CB61
	clc
	pla
	adc $B42C,x
	tax
	lda $B460,x
	sta <$09
	lda $B461,x
	jsr ChangeBank
	ldy #$1F
.loop
	lda [zPtr],y
	sta aPPULinearData,y
	dey
	bpl .loop
	lda #$20
	sta <zPPULinear
	inc <$FD
	inc <$FD
	pla
	jsr ChangeBank
	rts

;20 61 CB
Unknown_CB61:
	ldy $B42C,x
	lda $B46C,y
	sta aPaletteSpr + $09 ;現Pal[19]
	lda $B46D,y
	sta aPaletteSpr + $0A ;現Pal[1A]
	lda $B46E,y
	sta aPaletteSpr + $0B ;現Pal[1B]
	lda $B46F,y
	sta aPaletteSpr + $0D ;現Pal[1D]
	lda $B470,y
	sta aPaletteSpr + $0E ;現Pal[1E]
	lda $B471,y
	sta aPaletteSpr + $0F ;現Pal[1F]
	rts

;20 89 CB
CountBlockableObjects:
	ldx #$0F
	ldy #$00
.loop
	lda aObjFlags10,x
	bpl .notexist
	and #$10
	beq $CB99
	stx <zBlockObjIndex,y
	iny
.notexist
	dex
	bpl .loop
	sty <zBlockObjNum
	rts

;20 9F CB
PickupBlock:
	ldy <zBlockObjNum
.loop
	dey
	bmi PickupMap
	ldx <zBlockObjIndex,y ;
	lda <$08
	and aObjBlockW10,x
	cmp aObjBlockX10,x
	bne .loop
	lda <$0A
	and aObjBlockH10,x
	cmp aObjBlockY10,x
	bne .loop
	lda aObjVar10,x
	sta <$00
	rts

;20 C0 CB
PickupMap:
.result = $00
.X = $08
.Xhi = $09
.Y = $0A
.Yhi = $0B
.ptr = $0C
.ptrhi = $0D
	lda <zStage
	and #$07
	jsr ChangeBank
	lda #$00
	sta <.result
	lda <.Yhi
	beq .do
	bmi .above
	jmp .skip
;上にはみ出しているときはY=0に補正して処理
.above
	lda #$00
	sta <.Y
;処理を開始
.do
	lda <.X
	lsr a
	lsr a
	and #$38
	sta <.result
	lda <.Y
;$00=00XX X000
	asl a
	rol a
	rol a
	rol a
	and #$07
	ora <.result
	sta <.result
;$00=00XX XYYY
	lda #$00
	sta <.ptr
	lda <.Xhi
	lsr a
	ror <.ptr
	lsr a
	ror <.ptr
	clc
	adc #$85
	sta <.ptrhi
	ldy <.result
	lda [.ptr],y
	sta <.ptr
	lda #$20
	asl <.ptr
	rol a
	asl <.ptr
	rol a
	sta <.ptrhi
	ldy #$00
	lda <.X
	and #$10
	beq .yzero
	iny
	iny
.yzero
	lda <.Y
	and #$10
	beq .jump
	iny
.jump
	lda [.ptr],y
	sta <.result
	asl <.result
	rol a
	asl <.result
	rol a
	and #$03
	sta <.result
	lsr a
	beq .skip
	dec <.result
	dec <.result
	lda <zStage
	asl a
	adc <.result
	tax
	lda Table_Terrain,x ;ステージ
	sta <.result
.skip
	mCHANGEBANK #$0E, 1
	;rts

;1ECC44
Table_Terrain:
	.db $02, $03 ;ヒートマン
	.db $02, $03 ;エアーマン
	.db $02, $00 ;ウッドマン
	.db $04, $03 ;バブルマン
	.db $00, $03 ;クイックマン
	.db $02, $07 ;フラッシュマン
	.db $05, $06 ;メタルマン
	.db $02, $03 ;クラッシュマン

	.db $02, $00 ;ワイリーステージ1
	.db $02, $03 ;ワイリーステージ2
	.db $04, $03 ;ワイリーステージ3
	.db $02, $03 ;ワイリーステージ4
	.db $00, $00 ;ワイリーステージ5
	.db $00, $00 ;ワイリーステージ6

;20 60 CC
Unknown_CC60:
	jsr PickupBlock
	mCHANGEBANK #$0B, 1
	;rts

;20 69 CC
ClearSprites:
	lda #$F8
	ldx #$00
.loop
	sta aSprite,x
	inx
	bne .loop
	rts

;20 74 CC
SpriteSetup:
	.include "src/sprites.asm"

;CFED NMI Inturrupt
NMI_Start:
	.include "src/NMI.asm"

;20 EA D2
ChangeBodyColor:
	lda <zEquipment
ChangeBodyColor_Specified:
	asl a
	asl a
	tax
	inx
	ldy #$01
.loop
	lda Table_BodyColor,x
	sta aPaletteSpr,y
	iny
	inx
	cpy #$04
	bne .loop
	rts

;D2FF
Table_BodyColor:
	.db $0F, $0F, $2C, $11 ;ロックバスター
	.db $0F, $0F, $28, $15 ;アトミックファイヤー
	.db $0F, $0F, $30, $11 ;エアーシューター
	.db $0F, $0F, $30, $19 ;リーフシールド
	.db $0F, $0F, $30, $00 ;バブルリード
	.db $0F, $0F, $34, $25 ;クイックブーメラン
	.db $0F, $0F, $34, $14 ;タイムストッパー
	.db $0F, $0F, $37, $18 ;メタルブレード
	.db $0F, $0F, $30, $26 ;クラッシュボム
	.db $0F, $0F, $30, $16 ;アイテム1号
	.db $0F, $0F, $30, $16 ;アイテム2号
	.db $0F, $0F, $30, $16 ;アイテム3号

;20 2F D3
DamageRockman:
	mPLAYTRACK #$26
	lda #$00
	sta <zShootPose
	sta <zShootPoseTimer
	lda #$02
	sta <zStatus
	jsr SetRockmanAnimation
	lda #$01
	sta aObjFrame
	lda #$6F
	sta <zInvincible
	lda #$01
	sta aObjVY
	lda #$40
	sta aObjVYlo
	lda #$00
	sta aObjVX
	lda #$90
	sta aObjVXlo
	lsr aObjFlags + $0F
	lda #$00
	sta <zStopFlag
	ldx #$0E
.loop
	lda aObjFlags,x
	bpl .isvalid
	dex
	cpx #$01
	bne .loop
	rts
.isvalid
	lda #%10000000
	sta aObjFlags,x
	lda #$24
	sta aObjAnim,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjX
	sta aObjX,x
	lda aObjY
	sta aObjY,x
	lda #$08
	sta aObjVYlo,x
	lda #$00
	sta aObjVY,x
	sta aObjVXlo,x
	sta aObjVX,x
	sta aObjWait,x
	sta aObjFrame,x
	rts

;20 A5 D3
SetRockmanAnimation:
	ldx <zStatus
	clc
	lda Table_RockmanAnimation,x
	adc <zShootPose
	cmp aObjAnim
	beq .same
	ldx #$00
	stx aObjFrame
	stx aObjWait
.same
	sta aObjAnim
	lda <zShootPoseTimer
	beq .noshoot
	dec <zShootPoseTimer
	rts
.noshoot
;D3C4
	lda #$00
	sta <zShootPose
	ldx <zStatus
	lda Table_RockmanAnimation,x
	sta aObjAnim
	rts

;D3D1
Table_RockmanAnimation:
	.db $1A, $19, $18, $00, $04, $08, $0C, $10
	.db $14, $1B, $1F, $26

;20 DD D3
CreateWeaponObject:
	lda Table_WeaponObjectAnim,y
	sta aObjAnim,x
	lda aObjFlags
	and #%01000000
	php
	ora Table_WeaponObjectFlags,y
	sta aObjFlags,x
	plp
	bne .right
	sec
	lda aObjX
	sbc Table_WeaponObjectdx,y
	sta aObjX,x
	lda aObjRoom
	sbc #$00
	sta aObjRoom,x
	jmp .do
.right
	clc
	lda aObjX
	adc Table_WeaponObjectdx,y
	sta aObjX,x
	lda aObjRoom
	adc #$00
	sta aObjRoom,x
.do
	lda aObjY
	sta aObjY,x
	lda Table_WeaponObjectVXlo,y
	sta aObjVXlo,x
	lda Table_WeaponObjectVXhi,y
	sta aObjVX,x
	lda Table_WeaponObjectVYlo,y
	sta aObjVYlo,x
	lda Table_WeaponObjectVYhi,y
	sta aObjVY,x
	lda Table_WeaponObjectCollision,y
	sta aWeaponCollision,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	sta aObjVar,x
	sta aObjLife,x
	rts

;D44C
Table_WeaponObjectAnim:
	.db $23, $30, $31, $32, $33, $34, $35, $36
	.db $37, $38, $39, $3A, $2F, $3E, $3F, $74
	.db $79, $7C
;D45E
Table_WeaponObjectFlags:
	.db $81, $83, $83, $82, $87, $83, $83, $81
	.db $82, $82, $82, $86, $81, $82, $80, $80
	.db $80, $80
;D470
Table_WeaponObjectdx:
	.db $10, $00, $10, $00, $10, $10, $10, $00
	.db $00, $20, $20, $00, $00, $00, $00, $00
	.db $00, $00
;D482
Table_WeaponObjectVXlo:
	.db $00, $00, $00, $00, $00, $71, $00, $00
	.db $0F, $00, $00, $27, $00, $00, $00, $00
	.db $00, $00
;D494
Table_WeaponObjectVXhi:
	.db $04, $00, $00, $00, $01, $04, $04, $00
	.db $00, $00, $00, $01, $00, $00, $00, $00
	.db $00, $00
;D4A6
Table_WeaponObjectVYlo:
	.db $00, $00, $40, $00, $00, $AA, $00, $00
	.db $00, $41, $00, $76, $00, $00, $00, $C0
	.db $00, $00
;D4B8
Table_WeaponObjectVYhi:
	.db $00, $00, $00, $00, $02, $02, $00, $00
	.db $00, $00, $00, $03, $00, $00, $00, $FE
	.db $00, $00
;D4CA
Table_WeaponObjectCollision:
	.db $01, $01, $02, $04, $02, $01, $02, $02
	.db $00, $00, $00, $00, $02, $00, $00, $00
	.db $00, $00
;D4DC
Table_WeaponCollisionOffset:
	.db $00, $20, $40, $60, $80
;D4E1
CollisionSizeRX = $06 ;ロックマンの当たり判定サイズ
CollisionSizeRY = $08
CollisionSizeW0 = $04 ;武器の当たり判定サイズ
CollisionSizeW1 = $08
CollisionSizeW2 = $0C
CollisionSizeW3 = $10
CollisionDataLength = $20 ;当たり判定データの長さ

;CollisionSizeRX[$0A] = $06 -> $09
;CollisionSizeW1[$10] = $0C -> $0A
Table_CollisionSizeX:
	_collisionx CollisionSizeRX
	_collisionx CollisionSizeW0
	_collisionx CollisionSizeW1
	_collisionx CollisionSizeW2
	_collisionx CollisionSizeW3
;D581
Table_CollisionSizeY:
	_collisiony CollisionSizeRY
	_collisiony CollisionSizeW0
	_collisiony CollisionSizeW1
	_collisiony CollisionSizeW2
	_collisiony CollisionSizeW3

;20 21 D6
;エンディングの歩くロックマンの表示
ChangeBank_ShowEndingRockman:
	ldy aObjAnim
ChangeBank_ShowEndingRockmanY:
	sty <$01
	mCHANGEBANK #$09
	jsr $8600 ;-----------------------
ChangeBank_ShowEndingRockman_JMP:
	mCHANGEBANK #$0D, 1
	;rts

;20 34 D6
DrawStaffRollBossName:
	mCHANGEBANK #$09
	jsr $8603 ;-----------------------
	jmp ChangeBank_ShowEndingRockman_JMP

;20 3F D6
;スタッフロール用。$6A0に従いスタッフロールの文字を描く
DrawStaffRollText:
	mCHANGEBANK #$09
	jsr $8606 ;-----------------------
	jmp ChangeBank_ShowEndingRockman_JMP

;20 4A D6
Unknown_D64A:
	mCHANGEBANK #$09
	jsr $8609 ;-----------------------
	jmp ChangeBank_ShowEndingRockman_JMP

;20 55 D6
SpawnEnemyByScroll:
	.include "src/spawnenemy.asm"

;20 4E DA
;武器の発射処理/武器オブジェクトの挙動
FireWeapon:
	.include "src/weapons.asm"

;20 57 E5
;Obj[x]のロックマンへの接触処理/x破壊
RockmanTakeDamage:
	.include "src/damageinfo.asm"

;EDB6
;タイムストッパーで止められている間の敵の挙動
	.include "src/obj/behaviour_stopping.asm"

;20 94 EE
MoveItem:
	lda #$01
	bne MoveEnemy_Start
;20 98 EE
MoveEnemy:
	lda #$00
MoveEnemy_Start:
	sta <zObjItemFlag
	lda aObjFlags,x
	and #%00000011
	beq MoveObjectForWeapon
	pha
	and #%00000001
	beq .checkdmg
	jsr RockmanTakeDamage
.checkdmg
	pla
	and #%00000010
	beq MoveObjectForWeapon
	jsr EnemyTakeDamage
	bcc MoveObjectForWeapon
;撃破時
	jsr CreateItemFromEnemy
;20 B8 EE
MoveEnemy_Break:
	lda #$06
	sta aObjAnim,x
	lda #$80
	sta aObjFlags,x
	lda #$00
	sta aObjWait,x
	sta aObjFrame,x
	jmp PostSafeRemoveEnemy
;20 CD EE
MoveObjectForWeapon:
	sec
	lda aObjYlo,x
	sbc aObjVYlo,x
	sta aObjYlo,x
	lda aObjY,x
	sbc aObjVY,x
	sta aObjY,x
	cmp #$F0
	bcc .continue
;縦画面外判定
	jmp SafeRemoveEnemy
.continue
	lda aObjFlags,x
	and #%00000100
	beq .gravity
	clc
	lda aObjVYlo,x
	sbc <zGravity
	sta aObjVYlo,x
	lda aObjVY,x
	sbc <zGravityhi
	sta aObjVY,x
.gravity
	lda aObjFlags,x
	and #%01000000
	bne .right
	sec
	lda aObjXlo,x
	sbc aObjVXlo,x
	sta aObjXlo,x
	lda aObjX,x
	sbc aObjVX,x
	sta aObjX,x
	lda aObjRoom,x
	sbc #$00
	sta aObjRoom,x
	sec
	lda aObjX,x
	sbc <zHScroll
	sta <$08
	lda aObjRoom,x
	sbc <zRoom
	bne SafeRemoveEnemy
	lda <$08
	cmp #$08
	bcc SafeRemoveEnemy
	bcs .done
.right
	clc
	lda aObjXlo,x
	adc aObjVXlo,x
	sta aObjXlo,x
	lda aObjX,x
	adc aObjVX,x
	sta aObjX,x
	lda aObjRoom,x
	adc #$00
	sta aObjRoom,x
	sec
	lda aObjX,x
	sbc <zHScroll
	sta <$08
	lda aObjRoom,x
	sbc <zRoom
	bne SafeRemoveEnemy
	lda <$08
	cmp #$F8
	bcs SafeRemoveEnemy
.done
	clc
	rts
SafeRemoveEnemy:
	lsr aObjFlags,x
PostSafeRemoveEnemy:
	cpx #$10
	bcc .weapons
	lda <zObjItemFlag
	bne .isitem
	lda #$FF
	sta aEnemyOrder,x
.weapons
	sec
	rts
.isitem
	lda #$FF
	sta aItemOrder,x
	lda aItemLifeOffset,x
	tay
	lda aObjLife,x
	sta aItemLife,y
	sec
	rts

;20 8D EF
CheckOffscreenItem:
	lda #$01
	bne CheckOffscreenEnemy_Start
;20 91 EF
CheckOffscreenEnemy:
	lda #$00
CheckOffscreenEnemy_Start:
	sta <zObjItemFlag
	lda aObjFlags,x
	and #%00000011
	beq .check
	pha
	and #%00000001
	beq .checkdmg
	jsr RockmanTakeDamage
.checkdmg
	pla
	and #%00000010
	beq .check
	jsr EnemyTakeDamage
	bcc .check
;撃破時
	jsr CreateItemFromEnemy
	lda #$06
	sta aObjAnim,x
	lda #$80
	sta aObjFlags,x
	lda #$00
	sta aObjWait,x
	sta aObjFrame,x
	jmp PostSafeRemoveEnemy
.check
	lda <zEScreenRoom
	bne SafeRemoveEnemy
	clc
	rts

;20 CC EF
FaceTowards:
	lda aObjFlags,x
	and #%10111111
	sta aObjFlags,x
	sec
	lda <zEScreenX
	sbc <zRScreenX
	sta <$00
	bcs .left
	lda <$00
	eor #$FF
	adc #$01
	sta <$00
	lda #%01000000
	ora aObjFlags,x
	sta aObjFlags,x
.left
	rts

;20 EE EF
FindObject:
	sta <$00
	ldy #$0F
;20 F2 EF
FindObjectY:
	lda <$00
.loop
	cmp aObjAnim10,y
	beq .ok
	dey
	bpl .loop
	sec
	rts
.ok
	lda aObjFlags10,y
	bmi .found
	dey
	bpl FindObjectY
	sec
	rts
.found
	clc
	rts

;20 0A F0
;地形とのヒット処理(ΔＸ=$01,±ΔＹ=$02) 縦
WallCollisionY:
.result = $00
.dx = $01
.dy = $02
.x = $08
.xhi = $09
.y = $0A
.yhi = $0B
	lda #$00
	sta <.yhi
	lda aObjVY,x
	php
	bpl .up
	clc
	lda aObjY,x
	adc <.dy
	jmp .write
.up
	sec
	lda aObjY,x
	sbc <.dy
.write
	sta <.y
	clc
	lda aObjX,x
	adc <.dx
	sta <.x
	lda aObjRoom,x
	adc #$00
	sta <.xhi
	cpx #$0F
	bcs .isenemy_right
	jsr PickupBlock
	jmp .result_right
.isenemy_right
	jsr PickupMap
.result_right
	ldy <.result
	lda WallCollision_Terrain,y
	sta <$02
	ldx <zObjIndex
	sec
	lda aObjX,x
	sbc <.dx
	sta <.x
	lda aObjRoom,x
	sbc #$00
	sta <.xhi
	cpx #$0F
	bcs .isenemy_left
	jsr PickupBlock
	jmp .result_left
.isenemy_left
	jsr PickupMap
.result_left
	ldx <zObjIndex
	ldy <.result
	lda WallCollision_Terrain,y
	ora <$02
	sta <.result
	beq .inair
	plp
	bmi .down
	lda <.y
	and #$0F
	eor #$0F
	sec
	adc aObjY,x
	jmp .write_pos
.down
	lda aObjY,x
	pha
	lda <.y
	and #$0F
	sta <.dy
	pla
	sec
	sbc <.dy
.write_pos
	sta aObjY,x
	lda #$00
	sta aObjYlo,x
	lda aObjFlags,x
	and #%00000100
	beq .nogravity
	lda #$C0
	sta aObjVYlo,x
	lda #$FF
	sta aObjVY,x
.nogravity
	rts
.inair
	plp
	rts

;20 AD F0
;地形とのヒット処理(ΔＸ=$01,±ΔＹ=$02) 縦横
WallCollisionXY:
.result = $00
.res_v = $00
.res_h = $03
.dx = $01
.dy = $02
.x = $08
.xhi = $09
.y = $0A
.yhi = $0B
	lda aObjY,x
	sta <.y
	lda #$00
	sta <.yhi
	lda aObjFlags,x
	and #%01000000
	php
	beq .left
	sec
	lda aObjX,x
	adc <.dx
	sta <.x
	lda aObjRoom,x
	adc #$00
	jmp .write
.left
	clc
	lda aObjX,x
	sbc <.dx
	sta <.x
	lda aObjRoom,x
	sbc #$00
.write
	sta <.xhi
	cpx #$0F
	bcs .isenemy_h
	jsr PickupBlock
	jmp .result_h
.isenemy_h
	jsr PickupMap
.result_h
	ldx <zObjIndex
	ldy <.result
	lda WallCollision_Terrain,y
	sta <.res_h
	beq .nohitwall
	plp
	beq .left_wallfix
	lda <.x
	and #$0F
	sta <$00
	sec
	lda aObjX,x
	sbc <$00
	sta aObjX,x
	lda aObjRoom,x
	sbc #$00
	sta aObjRoom,x
	jmp WallCollisionY
.left_wallfix
	lda <.x
	and #$0F
	eor #$0F
	sec
	adc aObjX,x
	sta aObjX,x
	lda aObjRoom,x
	adc #$00
	sta aObjRoom,x
	jmp WallCollisionY
.nohitwall
	plp
	jmp WallCollisionY
WallCollision_Terrain:
	.db $00, $01, $00, $01, $00, $01, $01, $01, $01

;20 37 F1
CreateEnemyHere:
	pha
	jsr GetEnemyPointer
	bcs CreateEnemyHere_Error
	pla
CreateEnemyHere_Middle:
	jsr CreateObjectHere
	txa
	tay
	ldx <zObjIndex
	lda aObjFlags,x
	and #%01000000
	ora aObjFlags10,y
	sta aObjFlags10,y
	lda aObjXlo,x
	sta aObjXlo10,y
	lda aObjX,x
	sta aObjX10,y
	lda aObjRoom,x
	sta aObjRoom10,y
	lda aObjYlo,x
	sta aObjYlo10,y
	lda aObjY,x
	sta aObjY10,y
	clc
	rts
CreateEnemyHere_Error:
	pla
	ldx <zObjIndex
	sec
	rts

;20 75 F1
;速さ$09~$08で、ロックマンの方向に速度を変更
SetVelocityAtRockman:
.lx = $00
.ly = $01
.vlo = $08
.vhi = $09
	ldy #$40
	sec
	lda <zRScreenX
	sbc <zEScreenX
	sta <.lx
	bcs .inv_x
	lda <.lx
	eor #$FF
	adc #$01
	ldy #$00
	sta <.lx
.inv_x
	lda aObjFlags,x
	and #%10111111
	sta aObjFlags,x
	tya
	ora aObjFlags,x
	sta aObjFlags,x
	sec
	lda aObjY
	sbc aObjY,x
	php
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	sta <.ly
	cmp <.lx
	bcs .vertical
	lda <.vhi
	sta <$0D
	sta aObjVX,x
	lda <.vlo
	sta <$0C
	sta aObjVXlo,x
	lda <.lx
	sta <$0B
	lda #$00
	sta <$0A
	jsr Divide
	lda <$0F
	sta <$0D
	lda <$0E
	sta <$0C
	lda <.ly
	sta <$0B
	lda #$00
	sta <$0A
	jsr Divide
	ldx <zObjIndex
	lda <$0F
	sta aObjVY,x
	lda <$0E
	sta aObjVYlo,x
	jmp .done
.vertical
	lda <.vhi
	sta <$0D
	sta aObjVY,x
	lda <.vlo
	sta <$0C
	sta aObjVYlo,x
	lda <.ly
	sta <$0B
	lda #$00
	sta <$0A
	jsr Divide
	lda <$0F
	sta <$0D
	lda <$0E
	sta <$0C
	lda <.lx
	sta <$0B
	lda #$00
	sta <$0A
	jsr Divide
	ldx <zObjIndex
	lda <$0F
	sta aObjVX,x
	lda <$0E
	sta aObjVXlo,x
.done
	plp
	bcc .inv_v
	lda aObjVYlo,x
	eor #$FF
	adc #$01
	sta aObjVYlo,x
	lda aObjVY,x
	eor #$FF
	adc #$00
	sta aObjVY,x
.inv_v
	rts

;20 38 F2
;Obj[10-1F]の位置にランダムで回復アイテムを生成する。
CreateItemFromEnemy:
	lda <zBossBehaviour
	beq .create
	rts
.create
	lda <zRand
	sta <$01
	lda #$64
	sta <$02
	jsr Divide8
	lda <$04
	cmp #$30
	bcc .noitem
	cmp #$49
	bcc .weapon_small
	cmp #$58
	bcc .health_small
	cmp #$5D
	bcc .weapon_large
	cmp #$61
	bcc .health_large
	cmp #$62
	beq .extralife
.noitem
	rts
.weapon_small
	lda #$79
	bne .do
.health_small
	lda #$77
	bne .do
.weapon_large
	lda #$78
	bne .do
.health_large
	lda #$76
	bne .do
.extralife
	lda #$7B
	bne .do
.etank
	lda #$7A
	bne .do
.do
	jsr CreateEnemyHere
	bcs .invalid
	lda #%10000100
	sta aObjFlags10,y
	lda #$02
	sta aObjVY10,y
	lda #$01
	sta aObjVar10,y
.invalid
	rts

;20 90 F2
Reset_JMP:
	lda #$10
	sta $2000
	lda #$06
	sta $2001
	mCHANGEBANK #$0E
	jmp $8000

	.include "src/animations.asm"

	mBEGINRAW #$1E, Reset_Start
	sei
	inc $FFE1
	jmp Reset_JMP
	
	mBEGINRAW #$1E, NMI_VECTOR
	.dw NMI_Start
	.dw Reset_Start
	.dw Reset_Start

