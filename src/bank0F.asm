;3C000-3CFFF
	.beginregion "EmptySpace38000"
	mBEGIN #$0F, #$C000
	.endregion "EmptySpace38000"
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
	mSTZ <zPostProcSemaphore
	lda <zPostProcessSound
	bne .PostProcess
	rts

;NMI後の音処理(バンク切り替え中の割り込みで呼び出し)
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
	mSTZ <zPostProcessSound
	.ifdef ___BUGFIX
	pla
	tay
	.endif
	lda <zBankCopy
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
;1フレーム経過するまで待ってから、バンク0Eに切り替えて戻る
FrameAdvance1C:
	mMOV <zKeyDown, <zKeyDownPrev
	.ifdef ___2P
	mMOV <zKeyDown2P, <zKeyDownPrev2P
	.endif
	jsr DoPaletteAnimation
	mSTZ <zIsLag
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

;20 AB C0
;1フレーム経過するまで待ってから、バンク0Dに切り替えて戻る
FrameAdvance1A:
	mMOV <zKeyDown, <zKeyDownPrev
	.ifdef ___2P
	mMOV <zKeyDown2P, <zKeyDownPrev2P
	.endif
	jsr DoPaletteAnimation
	mSTZ <zIsLag
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

;20 D7 C0
;水中でラグを発生させるための処理
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
	mORA #$1E, <z2001, <z2001, $2001
	mSTZ <zIsLag
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
;20 00 C1
;Aレジスタで指定したフレーム数だけ経過させる
FrameAdvance1C_Multi:
	pha
	jsr FrameAdvance1C
	pla
	sec
	sbc #$01
	bne FrameAdvance1C_Multi
	rts
	.endif

;4C 0B C1
;ロックマンの死亡処理
DieRockman:
	mPLAYTRACK #$41 ;ティウン音
	mPLAYTRACK #$FF ;曲停止
	lda <zStatus
	bne .isfall
.TiwnroundAngle = zShootPoseTimer
	sta <.TiwnroundAngle ;{TiwnroundAngle|0 ≦ TiwnroundAngle < F}
.loop_tiwninit
	and #$01
	bne .wait_tiwnround
	lda <.TiwnroundAngle
	and #$07
	tax
	ldy #$01
.loop_tiwnround
	mMOV #$25, aObjAnim+$E,y
	mMOV #%10000000, aObjFlags+$E,y
	clc
	lda aObjX
	adc Table_TiwnBalldx,x
	sta aObjX + $0E,y
	lda aObjRoom
	and #$0F
	adc Table_TiwnBalldr,x
	sta aObjRoom + $0E,y
	lda aObjY
	adc Table_TiwnBalldy,x
	sta aObjY + $0E,y
	lda aObjRoom
	php
	lsr a
	lsr a
	lsr a
	lsr a
	plp
	adc Table_TiwnBalldyh,x
	asl a
	asl a
	asl a
	asl a
	adc aObjRoom + $0E,y
	sta aObjRoom + $0E,y

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
.wait_tiwnround
	jsr MainRoutine_WhileDeath
	inc <.TiwnroundAngle
	lda <.TiwnroundAngle
	cmp #$10
	bcc .loop_tiwninit
;爆散開始
	lsr aObjFlags + $0E
	lsr aObjFlags + $0F
	jsr SpawnTiwnRound
	lda #$A0 ;ティウン時の復活待ち時間
	bne .continue_tiwn
.isfall
	lda #$E0 ;落下死の時の復活待ち時間
.continue_tiwn
	sta <zShootPoseTimer
.wait_tiwn
	lsr aObjFlags
	jsr MainRoutine_WhileDeath
	dec <zShootPoseTimer
	bne .wait_tiwn
;爆散終了
	mMOV #$10, $2000
	mMOV #$06, $2001
	ldx #$FF
	txs
	dec <zLives
	bne .notgameover
;ゲームオーバー
	mSTZ <zETanks
	mCHANGEBANK #$0D
	jsr Bank0D_BeginGameOver
	mCHANGEBANK #$0E
	lda <$FD ;ゲームオーバー画面での選択が入っている
	bne .stageselect
	jmp StartStage_FillingEnergy ;ゲームオーバー→コンティニュー
.stageselect
	jmp StartStageSelect ;ゲームオーバー→ステージセレクト
.notgameover
	jmp StartStage_Continue ;残機がまだある


Table_TiwnBalldy:
	.db $F8, $08, $FB, $05, $00, $00, $05, $FB
Table_TiwnBalldyh:
	.db $FF, $00, $FF, $00, $00, $00, $00, $FF
Table_TiwnBalldx:
	.db $00, $00, $FB, $05, $FB, $08, $FB, $05
Table_TiwnBalldr:
	.db $00, $00, $FF, $00, $FF, $00, $FF, $00


;4C F0 C1
;ボスの死亡処理
DieBoss:
	jsr BossDeadInit
	inc <zNoDamage
.loop
	jsr SpawnBoss_Loop_Begin
	lda <zStage
	cmp #$08
	bne .notwily1
;メカドラゴン戦の時
	lda <zScrollFlag
	cmp #$03
	bne .notwily1
;ボス撃破後も落下死する可能性がある
	mSTZ <zNoDamage
	mMOV #$01, <zStatus
	jmp DieRockman
.notwily1
	lda <zBossBehaviour
	cmp #$FF
	bne .loop
	mSTZ <zNoDamage
	mMOV #$10, <z2000, $2000
	mMOV #$06, <z2001, $2001
	mSTZ <zContinuePoint
	ldx #$FF
	txs
	mCHANGEBANK #$0E
	ldx <zStage
	cpx #$08
	bcs .iswily
	mORA StageBitTable,x, <zClearFlags, <zClearFlags
	mORA ItemBitTable,x, <zItemFlags, <zItemFlags
	mCHANGEBANK #$0D
	jsr Bank0D_BeginGetEquipment
	mCHANGEBANK #$0E
	lda <zClearFlags
	cmp #$FF
	beq .gotowily
	jmp StartStageSelect_NoResetLives ;ステージセレクトへ
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
	jmp Reset_JMP ;エンディング終了 → リセット
.isnotwily7
	jmp StartStage_All ;ワイリーステージ続行

;C279
StageBitTable:
	.db $01, $02, $04, $08, $10, $20, $40, $80
;C281
ItemBitTable:
	.db $01, $02, $00, $00, $00, $04, $00, $00

;20 89 C2
BossDeadInit:
	mSTZ aBossDeath, aBossVar1, aBossVar2, aBossInvincible, <zStopFlag
	mMOV #$FE, <zBossBehaviour
	rts

;20 9E C2
; Unknown_C29E
; 	mSTZ <$FD
; 	mMOV #$02, aPaletteAnim
; 	mMOV #$04, aPaletteAnimWait
; 	mMOV #$BB, <$FD
; .loop_wait2
; 	jsr Unknown_C386
; 	dec <$FD
; 	bne .loop_wait2
; 	mSTZ aPaletteAnimWait, aPaletteAnim
; 	ldx #$02
; .loop2
; 	mMOV C29E_Palette,x, aPalette + 1,x ;第一BGパレット → C29E_Palette
; 	dex
; 	bpl .loop2
; 	mMOV #$86, <$FF
; 	mSTZ <$FE
; .loop
; 	mCHANGEBANK #$09
; 	lda <$FD
; 	lsr a
; 	tax
; 	mMOV Unknown_C324,x, aPPULinearhi
; 	mMOV Unknown_C33B,x, aPPULinearlo
; 	lda <$FD
; 	and #$01
; 	beq .begin_ppu
; 	mORA aPPULinearlo, #%00100000, aPPULinearlo
; .begin_ppu
; 	ldy #$20
; .loop_ppu
; 	mMOV [$FE],y, aPPULinearData,y
; 	dey
; 	bpl .loop_ppu
; 	mMOV #$20, <zPPULinear
; 	clc
; 	mADD <$FE, #$20
; 	mADD <$FF
; 	jsr Unknown_C386
; 	inc <$FD
; 	lda <$FD
; 	cmp #$2E
; 	bne .loop
; 	mCHANGEBANK #$0E, 1

;C321
; C29E_Palette:
; 	.db $28, $18, $2C

; Unknown_C324:
; 	.db $10, $1A, $1A, $1B, $1B, $1B, $1B, $1C
; 	.db $1C, $1C, $1C, $1D, $1D, $1D, $1D, $1E
; 	.db $1E, $1E, $1E, $1F, $1F, $1F, $1F
; Unknown_C33B:
; 	.db $00, $80, $C0, $00, $40, $80, $C0, $00
; 	.db $40, $80, $C0, $00, $40, $80, $C0, $00
; 	.db $40, $80, $C0, $00, $40, $80, $C0

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
	dec <zWaterWait
	bmi .lag
	bpl .isntwater
.lag
	jsr FrameAdvanceWater
	mMOV #WaterLagInterval, <zWaterWait
.isntwater
	.ifndef ___NORTS
	jsr FrameAdvance1C
	rts
	.else
	jmp FrameAdvance1C
	.endif

;C386
; Unknown_C386:
; 	ldx #$1F
; 	lda #$00
; .loop
; 	sta aObjWait,x
; 	dex
; 	bpl .loop
; 	jmp ___MainRoutine_WhileDeath

;C393
SpawnTiwnRound:
	mMOV aObjRoom, <$09
	mMOV aObjX, <$08
	mMOV aObjY, <$0A
	mMOV #$25, <$0B
	ldx #$0D
;C3A8
SpawnTiwnRound_Specified:
	ldy #$0B
.loop
	mORA #%10000000, TiwnRoundVector,y, aObjFlags,x
	mMOV <$0B, aObjAnim,x
	mMOV <$09, aObjRoom,x
	mMOV <$08, aObjX,x
	mMOV <$0A, aObjY,x
	mMOV TiwnRoundVXlo,y, aObjVXlo,x
	mMOV TiwnRoundVXhi,y, aObjVX,x
	mMOV TiwnRoundVYlo,y, aObjVYlo,x
	mMOV TiwnRoundVYhi,y, aObjVY,x
	mSTZ aObjWait,x, aObjFrame,x
	dex
	dey
	bpl .loop
	rts

TiwnRoundVXlo:
	.ifndef ___BUGFIX
	.db $00, $00, $00, $00, $60, $60, $60, $60, $00, $C0, $00, $E0
	.else
	.db $00, $00, $00, $00, $60, $60, $60, $60, $00, $C0, $00, $C0
	.endif
TiwnRoundVXhi:
	.db $00, $02, $00, $02, $01, $01, $01, $01, $00, $00, $00, $00
TiwnRoundVYlo:
	.db $00, $00, $00, $00, $60, $A0, $A0, $60, $C0, $00, $40, $00
TiwnRoundVYhi:
	.db $02, $00, $FE, $00, $01, $FE, $FE, $01, $00, $00, $FF, $00
TiwnRoundVector:
	.db $00, $40, $00, $00, $40, $40, $00, $00, $00, $40, $00, $00

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
	lda <zBank
	pha
	lda <zStage
	and #$07
	jsr ChangeBank
	ldy #$00
.loop
	lda aPaletteOverride,y
	bpl .skip
	lda <zStage
	and #$08
	bne .wily
	lda Stage_PaletteAnim,x
	bpl .skip
.wily
	lda Stage_PaletteAnimWily,x
.skip
	sta aPalette,y
	inx
	iny
	cpy #$10
	bne .loop

	inc <z3A ;------------------------
	pla
	jmp ChangeBank
.isnoanim
	rts


;20 5D C4
LoadStageGraphics:
.ptr = $0A
.ptrlo = $0A
.ptrhi = $0B
	mCHANGEBANK #$00
	lda #$90
	sta <.ptrhi
	ldy #$00
	sty <.ptr
	sty $2006
	sty $2006
;ロックマン画像読み込み
.loop_rockman
	mMOV [.ptr],y, $2007
	iny
	bne .loop_rockman
	inc <.ptrhi
	lda <.ptrhi
	cmp #$9A
	bcc .loop_rockman

;敵キャラ画像読み込み
	lda <zStage
	and #$07
	jsr ChangeBank
	ldx #$00
	stx <.ptr
	lda <zStage
	and #$08
	beq .is8bosses
	ldx #$10
.is8bosses
	lda Stage_DefGraphics,x
	sta <$00
	ldy #$00
.loop_graphics
	lda <zStage
	and #$07
	jsr ChangeBank
	inx
	lda Stage_DefGraphics,x
	sta <$01
	inx
	lda Stage_DefGraphics,x
	sta <.ptrhi
	inx
	lda Stage_DefGraphics,x
	jsr ChangeBank
.loop_gr
	mMOV [.ptr],y, $2007
	iny
	bne .loop_gr
	inc <.ptrhi
	dec <$01
	bne .loop_gr
	dec <$00
	bne .loop_graphics

	mCHANGEBANK #$09
	mMOV #$80, <.ptrhi
	jsr LoadGraphicsLZ77
	lda <zStage
	and #$07
	jsr ChangeBank
	mMOV #$A0, <.ptrhi
	jsr LoadGraphicsLZ77
;パレット書き込み
	ldy #$21
.loop_palette
	mMOV Stage_Palette - 2,y, aPalette - 2,y
	dey
	bpl .loop_palette
	jsr WritePalette
	mCHANGEBANK #$0E, 1
	;rts

;背景画像読み込み
LoadGraphicsLZ77:
.buffer = $300
.bufferptr = $09
.ptr = $0A
.ptrhi = $0B
.op = $0C
.amount = $0D
	ldy #$00
	sty <.bufferptr
.loop_bg
	lda [.ptr],y
	cmp #$FF
	beq .end
	sta <.op
	iny
	bne .skip_incptr_begin
	inc <.ptrhi
.skip_incptr_begin
	and #$3F
	sta <.amount
;連続データ書き込み/非圧縮書き込み
.loop_continuous
	bit <.op
	bvc .write_ptr ;使い回し書き込みの時
	clc
	lda <.bufferptr
	sbc [.ptr],y
	tax
	lda .buffer,x
	jmp .write
.write_ptr
	lda [.ptr],y
.write
	sta $2007
	ldx <.bufferptr
	sta .buffer,x
	lda <.amount ;連続データ書き込みであっても最後にiny
	beq .incptr
	lda <.op ;連続データ書き込みの時、inyを省略
	bpl .skip_incptr
.incptr
	iny
	bne .skip_incptr
	inc <.ptrhi
.skip_incptr
	inc <.bufferptr ;書き込みバッファ位置 + 1
	dec <.amount
	bpl .loop_continuous
	bmi .loop_bg
.end
	rts

;20 CD C4
SetContinuePoint:
	lda <zStage
	and #$07
	jsr ChangeBank
	lda <zContinuePoint
	beq .first
	ldx #$00
.loop
	cmp Stage_DefMap16,x
	beq .get
	inx
	bne .loop
.get
	beq .do
.first
	ldx #$00
	lda <zStage
	and #$08
	beq .8boss
	inx
.8boss
	stx <$70
	lda Stage_BeginPoint,x
.do
	sta <zRoom
	sta aObjRoom
	mCHANGEBANK #$0E, 1

;20 57 C5
;タイトルスクリーンの開始
BeginTitleScreen:
	mCHANGEBANK #$0D
	jsr Bank0D_BeginTitleScreen
	mCHANGEBANK #$0E, 1
	;rts

;20 65 C5
;ステージセレクト処理の開始
ChangeBank_DoStageSelect
	mCHANGEBANK #$0D
	jsr Bank0D_BeginStageSelect
	mCHANGEBANK #$0E, 1
	;rts

;20 73 C5
;武器選択メニューを開く
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
	jsr Bank0B_DoBossBehaviour
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
	mSTZ <zObjIndex
	lda #$7D
	ldx #$0F
	jsr CreateEnemyHere_Middle
	mMOV #$20, aObjX10 + $0F
	mMOV #$AB, aObjY10 + $0F
	bne .jump
.notbossrush
	jmp DieBoss
.jump
	rts

;20 F1 C5
LoadBossBG:
	pha
	mMOV aBossPtrhi, <$09
	mMOV aBossPtrlo, <$08
	pla
	jsr WritePPUData
	clc
	mADD aPPULinearlo, #$20
	mADD aPPULinearhi
	clc
	mADD aBossPtrlo, #$20
	mADD aBossPtrhi
	mCHANGEBANK #$0B, 1
	;rts

;20 28 C6
;バンクAに切り替えて、[zPtr]からのテーブルを$400バイトPPUへ書き込み
;ネームテーブル書き換え用かな
LoadScreenData:
	jsr ChangeBank
	mSTZ <zPtrlo
	ldx #$04
.loop
	mMOV [zPtr],y, $2007
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
	mMOV Table_GraphicsSetNum,x, <$01
	mMOV Table_GraphicsBeginPointer,x, <$02
	mSTZ <zPtrlo, $2006, $2006
.loop2
	ldx <$02
	mMOV Table_GraphicsPosition,x, <zPtrhi
	mMOV Table_GraphicsAmount,x, <$03
	mCHANGEBANK Table_GraphicsBank,x
	ldy #$00
.loop
	mMOV [zPtr],y, $2007
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
	.db $05, $08
	.db $06, $09
	.db $06, $09
	.db $00, $09, $08, $09, $08, $09
	.db $03, $03, $04, $04, $06, $04, $05, $05, $05, $07, $07, $02, $08, $07
	.db $05, $08, $09, $08
	.db $00, $06, $07, $07, $07, $02, $02, $09
Table_GraphicsPosition:
	.db $90, $88
	.db $90, $90
	.db $90, $A0
	.db $98, $AC, $80, $AC, $84, $9F
	.db $99, $9C, $9D, $9B, $B2, $97, $93, $96, $9C, $9D, $9F, $95
	.db $A4, $B2
	.db $90, $88, $9F, $8C
	.db $98, $B2, $9D, $9F, $AE, $96, $94, $AC
Table_GraphicsAmount:
	.db $10, $10
	.db $10, $10
	.db $10, $10
	.db $0E, $02, $04, $02, $04, $06
	.db $02, $01, $01, $01, $02, $01, $01, $02, $01, $01, $01, $02, $0C, $02
	.db $10, $03, $01, $0C
	.db $08, $01, $01, $01, $01, $01, $01, $02

;20 09 C7
;[$08],yから0x20バイト分をPPU書き込み予約 Aにバンク
WritePPUData:
	jsr ChangeBank
	ldy #$1F
.loop
	mMOV [zPtr],y, aPPULinearData,y
	dey
	bpl .loop
	mMOV #$20, <zPPULinear
	mCHANGEBANK #$0D, 1

	.ifndef ___DISABLE_INTRO_PIPI
;20 20 C7
SelectStage_LoadPipiGraphics:
	mCHANGEBANK #$01
	ldx #$1F
.loop
	mMOV $9CD0,x, aPPULinearData,x
	dex
	bpl .loop
	mMOVWB $0800, aPPULinearhi, aPPULinearlo
	mMOV #$20, <zPPULinear
	mCHANGEBANK #$0D, 1
	.endif

;20 44 C7
;$FE~$FFのアドレスにある値を#$20バイト分$3B8～$3D8へ書き込み
WriteTableToPPULinear:
	mCHANGEBANK #$09
	ldy #$1F
.loop
	mMOV [$FE],y, aPPULinearData,y
	dey
	bpl .loop
	mMOV #$20, <zPPULinear
	mCHANGEBANK #$0D, 1

;20 5D C7
Unknown_C75D:
	mMOV <$FD, <zPtrhi
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
	mMOV [zPtr],y, aPPULinearData,y
	dey
	bpl .loop
	mMOV #$20, <zPPULinear
	mCHANGEBANK #$0D, 1

;20 05 C8
SpawnBoss:
	lda <zStage
	sta <zBossType
SpawnBoss_BossRushBegin:
	mCHANGEBANK #$0B
	jsr $8000
	mCHANGEBANK #$0E
SpawnBoss_Loop_Begin:
.loop
	mSTZ <zKeyDown, <zKeyPress
	jsr DoRockman
	jsr WeaponObjectProcess
	jsr SpawnEnemyByScroll
	jsr DoBossBehaviour
	jsr DoEnemyObjects
	jsr SpriteSetup
	lda <zWaterLevel
	beq .nolag
	dec <zWaterWait
	bmi .lag
	bpl .nolag
.lag
	jsr FrameAdvanceWater
	mMOV #WaterLagInterval, <zWaterWait
.nolag
	jsr FrameAdvance1C
	lda <zBossBehaviour
	cmp #$02
	bcc .loop
	rts

;20 4B C8 Random: $04 = math.random(0, $02)
;$01 / $02 = $03×$02 + $04
Divide8:
	mSTZ <$03, <$04
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
	mSTZ <$11, <$10
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
	mMOV <.B, <.Ahi
	mMOV <$10, <.A
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
	mORA <$0B, #$03, aPPUSqrAttrhi,x
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
	mMOV <$0B, aPPULaserhi,x
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
	sta aPPUShutterAttrlo,x
	ldy #$23
	lda <$09
	and #$01
	beq .left
	ldy #$27
.left
	tya
	sta aPPUShutterAttrhi,x
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
	and Table_ShutterAttrMask,y
	sta aPPUShutterMask,x
	mEOR Table_ShutterAttrMask,y, #$FF, aPPUShutterMask2,x
	rts

;1EC964
Table_ShutterAttrMask:
	.db $03, $0C, $30, $C0

;マップをBGへ書き込み・新形式
;$00 横書き込み量
;$01 縦書き込み量
;$02 スクロール方向フラグ: L... ...U
;$03 32x32タイル位置
;$04 16x16タイル位置
;$05 8x8タイル位置
;$06 PPUデータ書き込みポインタ
;$07 PPUデータ書き込みポインタ始点
;$08 横スクロール始点
;$09 画面単位始点
;$0A~$0B 画面定義へのポインタ
;$0C~$0D 32x32タイル定義へのポインタ
;$0E~$0F 16x16タイル定義へのポインタ
;$10 縦スクロール始点
;$11 縦スクロール時、$09をバックアップ
WriteNameTableByScroll:
.xscroll = $00
.yscroll = $01
.f = $02
	lda <zStage
	and #$07
	jsr ChangeBank
;書き込み開始位置の設定
	ldx <zRoom
	clc
	lda <zHScroll
	adc #$E8
	bcc .carry_x_init
	inx
.carry_x_init
	sta <$08
	lsr a
	lsr a
	and #$38
	sta <$03 ;$03: 00XX X000
	stx <$09

	lda <zVScroll
	sta <$10

	lda <$08
	and #$08
	lsr a
	lsr a
	tay ;Y = 0, 2
	lda <$08
	and #$10
	lsr a
	lsr a
	lsr a
	tax ;X = 0, 2
	lda <$10
	asl a
	rol a
	rol a
	rol a
	bpl .iny_8
	iny
.iny_8
	bcc .iny_16
	inx
.iny_16
	and #$07
	ora <$03
	sta <$03 ;$03: 00XX XYYY
	stx <$04 ;$04: 32x32 LT LB RT RB
	sty <$05 ;$05: 16x16 LT LB RT RB

;横スクロール
	lda <.xscroll
	sta <zPPUHScr
	bne .do_h
	jmp .skip_xscroll
.do_h
	lda <$03
	pha
	txa
	pha
	tya
	pha
	lda <$08
	pha
	lda <$09
	pha
	lda <$10
	pha

	lda <$02
	bmi .horizontal_v ;右スクロール時
	sec
	lda <$08
	sbc #$C0
	sta <$08
	bcs .carry_h_v
	dec <$09
.carry_h_v
;	tya ;横の書き込み開始位置を-8[dot]
;	eor #$02
;	tay
;	and #$02
;	beq .horizontal_v
;	txa
;	eor #$02
;	tax
;	and #$02
;	beq .horizontal_v
	inc <$09
	clc
	lda <$03
	adc #$10
	and #$3F
	sta <$03
	bpl .done_h
.horizontal_v
	dec <$09
.done_h
	stx <$04
	sty <$05

;ネームテーブル書き込み位置指定
	lda <$09
	lsr a
	lda #$20
	bcc .left_room_h
	lda #$2C
.left_room_h
	sta aPPUHScrhi
	lda <$08
	lsr a
	lsr a
	lsr a
	sta aPPUHScrlo ;0～1F, PPU dx
;属性データ書き込み位置指定
	lsr a
	lsr a
	clc
	adc #$C0
	ldx #$00
.loop_attr
	tay
	mSTZ aPPUHScrAttr,x
	tya
	sta aPPUHScrAttrlo,x
	adc #$08
	inx
	inx
	cpx #$10
	bne .loop_attr
	lda aPPUHScrhi
	ora #$03
	sta aPPUHScrAttrhi
;画面切り分け位置の指定
	lda <$10
	lsr a
	lsr a
	lsr a
	sta <$06 ;$06: ppu write data index
	sta <$07 ;$07: ppu write data index

;ネームテーブル書き込み
.loop_nt_h
	jsr WriteNameTable_GetMapPtr
.loop_nt_h_32
	jsr WriteNameTable_GetChip32
;属性データ書き込み
	ldx <$06
	cpx <$07
	bne .notfirstattr_h
	lda <$04
	lsr a
	lda #%11110000
	bcc .notlastattr_h
	bcs .write_attr_h
.notfirstattr_h
	inx
	cpx <$07
	bne .notlastattr_h
	lda <$04
	lsr a
	lda #%00001111
	bcc .write_attr_h
.notlastattr_h
	lda #%11111111
.write_attr_h
	pha
	lda <$06
	lsr a
	and #$FE
	tax
	pla
	and Stage_Def32Pal,y
	ora aPPUHScrAttr,x
	sta aPPUHScrAttr,x

.loop_nt_h_16
	jsr WriteNameTable_GetTile16
.loop_nt_h_8
	ldy <$05 ;$05: 16x16 LT LB RT RB
	ldx <$06
	lda [$0E],y
	sta aPPUHScrData,x

	inc <$06
	inx
	cpx <$07
	beq .skip_xscroll_pla
	cpx #$1E
	bcs .end_ptr_h
	tya
	lsr a
	bcs .go_down16 ;16x16定義を1つ下のものへ
	inc <$05
	bne .loop_nt_h_8
.go_down16
	dec <$05
	lda <$04
	lsr a
	bcs .go_down32 ;32x32定義を1つ下のものへ
	inc <$04
	bne .loop_nt_h_16
.go_down32
	dec <$04
	inc <$03
	bne .loop_nt_h_32
.end_ptr_h
	lda <$07
	beq .skip_xscroll_pla
	lda <$03
	and #$38
	sta <$03
	clc
	lda <$09
	adc #$10
	sta <$09
	lda <$05
	and #$02
	sta <$05
	lda <$04
	and #$02
	sta <$04
	mSTZ <$06
	jmp .loop_nt_h
.skip_xscroll_pla
	pla
	sta <$10
	pla
	sta <$09
	pla
	sta <$08
	pla
	sta <$05
	pla
	sta <$04
	pla
	sta <$03
.skip_xscroll
;縦スクロール
	lda <.yscroll
	sta <zPPUVScr
	bne .do_yscroll
	jmp .end_scroll
.do_yscroll

	ldx <$04
	ldy <$05
	lda <$02
	lsr a
	bcs .up_dy ;下スクロールの時
	lda <$10 ;縦の書き込み開始位置-8[dot]
	sbc #$07
	sta <$10
	bcs .borrow_nt
	sbc #$0F
	sta <$10
	lda <$09
	sbc #$10
	sta <$09
.borrow_nt
	tya
	eor #$01
	tay
	lsr a
	bcc .up_dy
	txa
	eor #$01
	tax
	lsr a
	bcc .up_dy
	lda <$03
	sbc #$01
	and #$3F
	sta <$03
.up_dy
	stx <$04
	sty <$05

	ldy <$09
	dey
	tya
	asl <.f
	bne .up_nt
	clc
	adc #$10
.up_nt
	sta <$09
	sta <$11

	lda <$08
	lsr a
	lsr a
	lsr a
	tay
	lda <$09
	lsr a
	tya
	bcc .boundary_left
	ora #$20
.boundary_left
	and #$3F
	sta <$06 ;$06: ppu write data index
	sta <$07 ;$07: ppu write data index
	mMOV #$20 >> 2, aPPUVScrhi
	mSTZ aPPUVScrlo
	lda <$10
	asl a
	rol aPPUVScrhi
	asl a
	rol aPPUVScrhi
	and #$E0
	sta aPPUVScrlo

	and #$10 << 2
	bne .attr
	lda #%11110000
	.db $2C
.attr
	lda #%00001111
	cmp #%11110000
	ldy <.f
	beq .skip
	ror a ;上スクロール時、逆条件
	eor #%10000000
	rol a
.skip
	bcs .write_all
	lda #%00000000 ;属性テーブルの上側を書く時、マスクなし
.write_all
	sta aPPUVScrAttrMask
;属性データ書き込み位置指定
	lda <$10
	lsr a
	lsr a
	and #$38
	ora #$C0
	sta aPPUVScrAttr
;ネームテーブル書き込み
.loop_nt_v
	jsr WriteNameTable_GetMapPtr
.loop_nt_v_32
	jsr WriteNameTable_GetChip32
;属性データ書き込み
	lda <$06
	lsr a
	lsr a
	tax
	lda aPPUVScrAttrMask
	eor #%11111111
	and Stage_Def32Pal,y
	sta aPPUVScrAttrData,x

.loop_nt_v_16
	jsr WriteNameTable_GetTile16
.loop_nt_v_8
	ldy <$05 ;$05: 16x16 LT LB RT RB
	ldx <$06
	lda [$0E],y
	sta aPPUVScrData,x

	inc <$06
	inx
	cpx <$07
	beq .skip_yscroll ;横スクロール境界
	cpx #$40
	bcs .end_ptr_v ;ネームテーブル右端
	cpx #$20
	beq .end_ptr_v ;ネームテーブル右端
;	bne .go_right16 ;16x16定義を1つ右のものへ
	tya
	eor #$02
	sta <$05
	and #$02
	bne .loop_nt_v_8
.go_right16
	lda <$04
	eor #$02
	sta <$04
	and #$02
	bne .loop_nt_v_16

	clc
	lda <$03
	adc #$08
	sta <$03
	bne .loop_nt_v_32
.end_ptr_v
	cpx #$40
	bcc .noreset
	mSTZ <$06
	lda <$07
	beq .skip_yscroll
.noreset
	inc <$09
	sec
	lda <$03
	and #$07
	sta <$03
	lda <$05
	and #$FD
	sta <$05
	lda <$04
	and #$FD
	sta <$04
	jmp .loop_nt_v
.skip_yscroll
;属性テーブルをora

	lda <$11
	ldx <.f
	sec
	bne .skip3
	sbc #$20
	sec
.skip3
	sbc #$F0
	sta <$09
	lda <$07
	lsr a
	lsr a
	sta <$07
	tax
.loop_attr_y
	jsr WriteNameTable_GetMapPtr
.loop_attr_y_32
	jsr WriteNameTable_GetChip32
	lda aPPUVScrAttrMask
	and Stage_Def32Pal,y
	ora aPPUVScrAttrData,x
	sta aPPUVScrAttrData,x

	inx
	cpx <$07
	beq .end_scroll
	cpx #$10
	bcs .end_ptr
	cpx #$08
	beq .end_ptr_noreset
	clc
	lda <$03
	adc #$08
	sta <$03
	bne .loop_attr_y_32
.end_ptr
	ldx <$07
	beq .end_scroll
	ldx #$00
.end_ptr_noreset
	inc <$09
	lda <$03
	and #$07
	sta <$03
	bpl .loop_attr_y
.end_scroll
	mCHANGEBANK #$0E, 1

;スクロール位置の補正
WriteNameTable_GetOrigin:

;画面位置に対応する画面定義へのポインタを返す
;$09 = 画面位置 = YYYY XXXX
;=> $0A~$0B = 画面定義へのポインタ
WriteNameTable_GetMapPtr:
	ldy <$09
	mSTZ <$0A
	lda Stage_DefMap16,y
	and #$3F
	lsr a
	ror <$0A
	lsr a
	ror <$0A
	adc #HIGH(Stage_DefRoom)
	sta <$0B ;$0A~$0B: room ptr
	rts
;32x32チップ定義へのポインタを返す
;$03 = オフセット, #$00～#$3F
;$0A~$0B = 画面定義へのポインタ
;=> $0C~$0D = 32x32チップ定義へのポインタ
;=> y = 32x32タイル番号
WriteNameTable_GetChip32:
	ldy <$03
	clc
	lda [$0A],y
	tay
	adc #LOW(Stage_Def32x32 >> 2)
	sta <$0C
	lda #HIGH(Stage_Def32x32 >> 2)
	adc #$00
	asl <$0C
	rol a
	asl <$0C
	rol a
	sta <$0D ;$0C~$0D: 32x32 chip
	rts
;16x16タイル定義へのポインタを返す
;$04 = オフセット, 0～3
;    0  2
;    1  3
;$0C~$0D = 32x32チップ定義へのポインタ
;=> $0E~$0F = 16x16タイル定義へのポインタ
WriteNameTable_GetTile16:
	ldy <$04
	mMOV #HIGH(Stage_Def16x16 >> 1), <$0F
	lda [$0C],y
	asl a
	asl a
	rol <$0F
	sta <$0E ;$0E~$0F: 16x16 chip
	rts

;20 08 CA
WriteNameTableByScroll_AnyBank:
	lda <zBank
	pha
	jsr WriteNameTableByScroll
	pla
	mJSR_NORTS ChangeBank

;武器メニューを閉じる時のネームテーブル書き込み
WriteNameTable_WeaponMenu:
	lda <zStage
	and #$07
	jsr ChangeBank
	jsr WriteNameTable_GetMapPtr
	jsr WriteNameTable_GetChip32
	mMOV Stage_Def32Pal,y, aPPUSqrAttrData
	mMOV #$0F, <$00
	mMOV #$03, <$04
.loop_16
	jsr WriteNameTable_GetTile16
	ldy #$03
.loop_8
	ldx <$00
	lda .ppu_map,x
	dex
	stx <$00
	tax
	lda [$0E],y
	sta aPPUSqrData,x
	dey
	bpl .loop_8
	dec <$04
	bpl .loop_16
	mCHANGEBANK #$0D, 1
.ppu_map
	.db $00, $04, $01, $05, $08, $0C, $09, $0D
	.db $02, $06, $03, $07, $0A, $0E, $0B, $0F

;その画面位置にスクロール可能かを調べる
;X 画面位置
;Y = 0 → 横スクロールで侵入可能か, 1 → 縦スクロールで侵入可能か
ChangeBank_GetScrollable:
	lda <zStage
	and #$07
	jsr ChangeBank
	lda Stage_DefMap16,x
	dey
	bpl .vertical
;横スクロールで侵入可能か
	ldy <zVScroll
	beq .merge
	tay
	txa
	clc
	adc #$10
	tax
	tya
	jmp .merge
;縦スクロールで侵入可能か
.vertical
	ldy <zHScroll
	beq .merge
	inx
.merge
	ora Stage_DefMap16,x
	asl a
	tay
	mCHANGEBANK #$0E, 1

;画面数Aがどの画面位置に存在するかを返す
GetScrollTo:
	pha
	lda <zStage
	and #$07
	jsr ChangeBank
	pla
	ldx #$00
.loop
	cmp Stage_DefMap16,x
	beq .end
	inx
	bne .loop
.end
	mCHANGEBANK #$0E, 1

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
	jsr SetEnemyPalette
	clc
	pla
	adc $B42C,x
	tax
	mMOV $B460,x, <$09
	mCHANGEBANK $B461,x
	ldy #$1F
.loop
	mMOV [zPtr],y, aPPULinearData,y
	dey
	bpl .loop
	mMOV #$20, <zPPULinear
	inc <$FD
	inc <$FD
	pla
	jsr ChangeBank
	rts

;20 61 CB
;おそらく、スクロール番号Xから敵パレットを設定する
SetEnemyPalette:
	ldy $B42C,x
	mMOV $B46C,y, aPaletteSpr + $09 ;敵パレット1
	mMOV $B46D,y, aPaletteSpr + $0A ;
	mMOV $B46E,y, aPaletteSpr + $0B ;
	mMOV $B46F,y, aPaletteSpr + $0D ;敵パレット2
	mMOV $B470,y, aPaletteSpr + $0E ;
	mMOV $B471,y, aPaletteSpr + $0F ;
	rts

;20 89 CB
CountBlockableObjects:
	ldx #$0F
	ldy #$00
.loop
	lda aObjFlags10,x
	bpl .notexist
	and #$10
	beq .notexist
	stx <zBlockObjIndex,y
	iny
.notexist
	dex
	bpl .loop
	sty <zBlockObjNum
	rts

;20 9F CB
;$08, $0A = (X, Y)
;$09: YYYYXXXX: screen
;$00 result(0～7)
PickupBlock:
	ldy <zBlockObjNum
.loop
	dey
	bmi PickupMap
	ldx <zBlockObjIndex,y
	lda <$08
	and aObjBlockW10,x
	cmp aObjBlockX10,x
	bne .loop
	lda <$0A
	and aObjBlockH10,x
	cmp aObjBlockY10,x
	bne .loop
	mMOV aObjVar10,x, <$00
	rts

;20 C0 CB
PickupMap:
.result = $00
.X = $08 ;position X
.R = $09 ;Room
.Y = $0A ;position Y
.ptr = $0C
.ptrhi = $0D
	lda <zStage
	and #$07
	jsr ChangeBank

	mSTZ <.ptr
	ldx <.Y
	ldy <.R
	lda Stage_DefMap16,y
	bmi .skip ;壁判定扱いにする
	jsr WriteNameTable_GetMapPtr
	mMOV <$0A, <.ptr
	mMOV <$0B, <.ptrhi
	stx <.Y

;y = X * $8 + Y
	ldx #$00
	lda <.Y
	asl a
	rol a
	rol a
	rol a
	and #$07
	sta <.result
	bcc .y_jmp
	inx
.y_jmp
;$00 = 0000 0YYY
	lda <.X
	lsr a
	lsr a
	and #$38
	ora <.result
	tay
;x = 0, 1
;y = 00XX XYYY
	lda [.ptr],y ;a = 32x32 chip index
	asl a
	tay
	lda <.X
	and #$10
	beq .x_jmp
	iny
.x_jmp
	bcs .greater
	lda Stage_Def32Attr,y
	bcc .attr
.greater
	lda Stage_Def32Attr + $100,y
.attr
	dex
	beq .y_shift
	lsr a
	lsr a
	lsr a
	lsr a
.y_shift
	and #$0F
.offscreenblock
	sta <.result
.block
	mCHANGEBANK #$0E, 1
.skip
	and #$3F
	bpl .offscreenblock

;1ECC44
; Table_Terrain:
; 	.db $02, $03 ;ヒートマン
; 	.db $02, $03 ;エアーマン
; 	.db $02, $00 ;ウッドマン
; 	.db $04, $03 ;バブルマン
; 	.db $00, $03 ;クイックマン
; 	.db $02, $07 ;フラッシュマン
; 	.db $05, $06 ;メタルマン
; 	.db $02, $03 ;クラッシュマン

; 	.db $02, $00 ;ワイリーステージ1
; 	.db $02, $03 ;ワイリーステージ2
; 	.db $04, $03 ;ワイリーステージ3
; 	.db $02, $03 ;ワイリーステージ4
; 	.db $00, $00 ;ワイリーステージ5
; 	.db $00, $00 ;ワイリーステージ6

;20 60 CC
PickupMap_BossBank:
	jsr PickupBlock
	mCHANGEBANK #$0B, 1

	.beginregion "SpriteSetup"
;20 69 CC
ClearSprites:
	lda #$F8
	ldx #$00
.loop
	sta aSprite,x
	inx
	inx
	inx
	inx
	bne .loop
	rts

;20 74 CC
SpriteSetup:
	.include "src/sprites.asm"
	.endregion "SpriteSetup"
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
	mMOV Table_BodyColor,x, aPaletteSpr,y
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
	mSTZ <zShootPose, <zShootPoseTimer
	mMOV #$02, <zStatus
	jsr SetRockmanAnimation
	mMOV #$01, aObjFrame
	mMOV #$6F, <zInvincible
	mMOVWB $0140, aObjVY, aObjVYlo
	mMOVWB $0090, aObjVX, aObjVXlo
	lsr aObjFlags + $0F
	mSTZ <zStopFlag
	ldx #$0E
.loop
	lda aObjFlags,x
	bpl .isvalid
	dex
	cpx #$01
	bne .loop
	rts
.isvalid
	mMOV #%10000000, aObjFlags,x
	mMOV #$24, aObjAnim,x
	mMOV aObjRoom, aObjRoom,x
	mMOV aObjX, aObjX,x
	mMOV aObjY, aObjY,x
	mMOV #$08, aObjVYlo,x
	mSTZ aObjVY,x, aObjVXlo,x, aObjVX,x, aObjWait,x, aObjFrame,x
	rts

;20 A5 D3
SetRockmanAnimation:
	lda <zShootPoseTimer
	beq .noshoot
	dec <zShootPoseTimer
	bne .shoot
.noshoot
	sta <zShootPose
.shoot
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
	rts

;D3D1
Table_RockmanAnimation:
	.db $1A, $19, $18, $00, $04, $08, $0C, $10
	.db $14, $1B, $1F, $26

;20 DD D3
CreateWeaponObject:
	mMOV Table_WeaponObjectAnim,y, aObjAnim,x
	lda aObjFlags
	and #%01000000
	php
	ora Table_WeaponObjectFlags,y
	sta aObjFlags,x
	plp
	bne .right
	sec
	mSUB aObjX, Table_WeaponObjectdx,y, aObjX,x
	mSUB aObjRoom, #$00, aObjRoom,x
	jmp .do
.right
	clc
	mADD aObjX, Table_WeaponObjectdx,y, aObjX,x
	mADD aObjRoom, #$00, aObjRoom,x
.do
	mMOV aObjY, aObjY,x
	mMOV Table_WeaponObjectVXlo,y, aObjVXlo,x
	mMOV Table_WeaponObjectVXhi,y, aObjVX,x
	mMOV Table_WeaponObjectVYlo,y, aObjVYlo,x
	mMOV Table_WeaponObjectVYhi,y, aObjVY,x
	mMOV Table_WeaponObjectCollision,y, aWeaponCollision,x
	mSTZ aObjFrame,x, aObjWait,x, aObjVar,x, aObjLife,x
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
	jsr Bank09_ShowEndingSprites
ChangeBank_ShowEndingRockman_JMP:
	mCHANGEBANK #$0D, 1
	;rts

;20 34 D6
DrawStaffRollBossName:
	mCHANGEBANK #$09
	jsr Bank09_WriteEndingBossname
	jmp ChangeBank_ShowEndingRockman_JMP

;20 3F D6
;スタッフロール用。$6A0に従いスタッフロールの文字を描くための準備
InitStaffRollText:
	mCHANGEBANK #$09
	jsr Bank09_InitStaffLine
	jmp ChangeBank_ShowEndingRockman_JMP

;20 4A D6
;スタッフロール用。$6A0に従いスタッフロールの文字を描く
;画面スクロールもやる
DrawStaffRollText:
	mCHANGEBANK #$09
	jsr Bank09_ScrollStaffLine
	jmp ChangeBank_ShowEndingRockman_JMP

;20 55 D6
SpawnEnemyByScroll:
	.include "src/spawnenemy.asm"

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
	.db $2C
;20 98 EE
MoveEnemy:
	lda #$00
	sta <zObjItemFlag
;20 CD EE
MoveObjectForWeapon:
;縦移動
	sec
	mSUB aObjYlo,x, aObjVYlo,x
	mSUB aObjY,x, aObjVY,x
	ldy aObjVY,x
	bmi .godown_movey
	bcs .continue_y
	sbc #$10 - 1
	sta aObjY,x
	lda aObjRoom,x
	sbc #$10
	jmp .movey
.godown_movey
	cmp #$F0
	bcc .continue_y
	adc #$10 - 1
	sta aObjY,x
	lda aObjRoom,x
	adc #$10 - 1
.movey
	sta aObjRoom,x
.continue_y
;重力加速度の適用
	lda aObjFlags,x
	and #%00000100
	beq .gravity
	clc
	mSUB aObjVYlo,x, <zGravity
	mSUB aObjVY,x, <zGravityhi
.gravity
;横移動
	lda aObjFlags,x
	asl a
	bmi .right
	sec
	mSUB aObjXlo,x, aObjVXlo,x
	mSUB aObjX,x, aObjVX,x
	bcs .borrow_x
	dec aObjRoom,x
.borrow_x
	jmp .done
.right
	clc
	mADD aObjXlo,x, aObjVXlo,x
	mADD aObjX,x, aObjVX,x
	bcc .done
	inc aObjRoom,x
.done
	cpx #$10
	bcc .weapon
	jmp CheckOffscreenEnemy.jump
.weapon
	jmp CheckOffscreenEnemy.do

;20 8D EF
CheckOffscreenItem:
	lda #$01
	.db $2C
;20 91 EF
CheckOffscreenEnemy:
	lda #$00
	sta <zObjItemFlag
.jump .public
	lda aObjFlags,x
	and #%00000011
	beq .do
	lsr a
	php
	bcc .checkdmg
	jsr RockmanTakeDamage
.checkdmg
	plp
	beq .do
	jsr EnemyTakeDamage
	bcc .do
;撃破時
.break .public
	jsr CreateItemFromEnemy
	mMOV #$06, aObjAnim,x
	mMOV #%10000000, aObjFlags,x
	mSTZ aObjWait,x, aObjFrame,x
	beq PostSafeRemoveEnemy
.do .public ;画面外判定
.x = $08
.r = $09
.y = $0A
	mMOV aObjX,x, <.x
	mMOV aObjRoom,x, <.r
	mMOV aObjY,x, <.y
	jsr CheckOffscreenPoint
	bcc PostSafeRemoveEnemy.rts
;画面外に出たオブジェクトを消去する
SafeRemoveEnemy:
	lsr aObjFlags,x
PostSafeRemoveEnemy:
	cpx #$10
	bcc .isweapon
	lda <zObjItemFlag
	bne .isitem
	sta aEnemyOrder,x
.isweapon
	sec
.rts .public
	rts
.isitem
	ldy aItemOrder,x
	mSTZ aItemOrder,x
	mMOV aObjLife,x, aItemLife - 1,y
	sec
	rts

;画面外判定を行う 画面外ならキャリーフラグON
;$08: X座標, $09: 画面位置, $0A: Y座標
CheckOffscreenPoint:
.tmp = $0B ;縦の相対画面位置 = 0 or 1
.x = $08
.r = $09
.y = $0A
	sec
	lda <.r
	sbc <zRoom
	tay
	and #%11101110
	bne .is_offscreen
	tya
	and #%00010001
	tay
	lsr a
	lsr a
	lsr a
	lsr a
	sta <.tmp ;縦の相対画面位置 = 0 or 1
	tya
	and #$01
	tay ;横の相対画面位置 = 0 or 1
;横の画面外判定
	sec
	lda <.x
	sbc <zHScroll
	dey
	bcs .borrow_x
	bmi .is_offscreen
	bpl .continue_x
.borrow_x
	bpl .is_offscreen
.continue_x
;縦の画面外判定
	sec
	lda <.y
	sbc <zVScroll
	dec <.tmp
	bcs .borrow_y
	bmi .is_offscreen
	bpl .continue_y
.borrow_y
	bpl .is_offscreen
.continue_y
	clc
	rts
.is_offscreen
	sec
	rts

;20 CC EF
FaceTowards:
	mAND aObjFlags,x, #%10111111
	sec
	mSUB <zEScreenX, <zRScreenX, <$00
	bcs .left
	mNEG <$00
	mORA #%01000000, aObjFlags,x, aObjFlags,x
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
.r = $09
.y = $0A
.r2 = $07 ;画面位置バックアップ用
	ldy aObjRoom,x
	lda aObjVY,x
	bpl .up
	clc
	mADD aObjY,x, <.dy, <.y
	cmp #$F0
	bcc .merge_y
	adc #$10 - 1
	sta <.y
	tya
	adc #$10
	tay
.skip_addy
	jmp .merge_y
.up
	sec
	mSUB aObjY,x, <.dy, <.y
	bcs .merge_y
	sbc #$10 - 1
	sta <.y
	tya
	sbc #$10
	tay
.merge_y
	sty <.r2
	clc
	mADD aObjX,x, <.dx, <.x
	bcc .skip_addx
	iny
.skip_addx
	sty <.r
	jsr PickupMap
	lda <.result
	and #$08
	sta <$02
	ldx <zObjIndex
	ldy <.r2
	sec
	mSUB aObjX,x, <.dx, <.x
	bcs .skip_subx
	dey
.skip_subx
	sty <.r
	jsr PickupMap
	ldx <zObjIndex
	lda <.result
	and #$08
	ora <$02
	sta <.result
	beq .inair
	lda aObjVY,x
	bmi .down
	lda <.y
	and #$0F
	eor #$0F
	sec
	adc aObjY,x
	sta aObjY,x
	cmp #$F0
	bcc .carry_sety_up
	adc #$10 - 1
	sta aObjY,x
	lda <.r2
	adc #$10
	sta aObjRoom,x
.carry_sety_up
	jmp .write_pos
.down
	lda aObjY,x
	pha
	mAND <.y, #$0F, <.dy
	pla
	sec
	sbc <.dy
.write_pos
	sta aObjY,x
	mSTZ aObjYlo,x
	lda aObjFlags,x
	and #%00000100
	beq .nogravity
	mMOVW $FFC0, aObjVYlo,x, aObjVY,x
.nogravity
.inair
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
	mMOV aObjY,x, <.y
	mSTZ <.yhi
	lda aObjFlags,x
	and #%01000000
	php
	beq .left
	sec
	mADD aObjX,x, <.dx, <.x
	lda aObjRoom,x
	adc #$00
	jmp .write
.left
	clc
	mSUB aObjX,x, <.dx, <.x
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
	lda <.result
	and #$08
	sta <.res_h
	beq .nohitwall
	plp
	beq .left_wallfix
	mAND <.x, #$0F, <$00
	sec
	mSUB aObjX,x, <$00
	mSUB aObjRoom,x
	jmp WallCollisionY
.left_wallfix
	lda <.x
	and #$0F
	eor #$0F
	sec
	adc aObjX,x
	sta aObjX,x
	mADD aObjRoom,x
	jmp WallCollisionY
.nohitwall
	plp
	jmp WallCollisionY
;WallCollision_Terrain:
;	.db $00, $01, $00, $01, $00, $01, $01, $01, $01

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
	mMOV aObjXlo,x, aObjXlo10,y
	mMOV aObjX,x, aObjX10,y
	mMOV aObjRoom,x, aObjRoom10,y
	mMOV aObjYlo,x, aObjYlo10,y
	mMOV aObjY,x, aObjY10,y
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
	bcs .inv_x
	eor #$FF
	adc #$01
	ldy #$00
.inv_x
	sta <.lx
	lda aObjFlags,x
	and #%10111111
	sta aObjFlags,x
	tya
	ora aObjFlags,x
	sta aObjFlags,x
	sec
	lda aObjY,x
	sbc <zVScroll
	sta <.ly
	sec
	lda aObjY
	sbc <zVScroll
	sbc <.ly
	php
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	sta <.ly
	cmp <.lx
	bcs .vertical
	mMOV <.vhi, <$0D, aObjVX,x
	mMOV <.vlo, <$0C, aObjVXlo,x
	mMOV <.lx, <$0B
	mSTZ <$0A
	jsr Divide
	mMOV <$0F, <$0D
	mMOV <$0E, <$0C
	mMOV <.ly, <$0B
	mSTZ <$0A
	jsr Divide
	ldx <zObjIndex
	mMOV <$0F, aObjVY,x
	mMOV <$0E, aObjVYlo,x
	jmp .done
.vertical
	mMOV <.vhi, <$0D, aObjVY,x
	mMOV <.vlo, <$0C, aObjVYlo,x
	mMOV <.ly, <$0B
	mSTZ <$0A
	jsr Divide
	mMOV <$0F, <$0D
	mMOV <$0E, <$0C
	mMOV <.lx, <$0B
	mSTZ <$0A
	jsr Divide
	ldx <zObjIndex
	mMOV <$0F, aObjVX,x
	mMOV <$0E, aObjVXlo,x
.done
	plp
	bcc .inv_v
	mNEG aObjVYlo,x
	mNEGhi aObjVY,x
.inv_v
	rts

;20 38 F2
;Obj[10-1F]の位置にランダムで回復アイテムを生成する。
CreateItemFromEnemy:
	lda <zBossBehaviour
	beq .create
	rts
.create
	mMOV <zRand, <$01
	mMOV #$64, <$02
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
	mMOV #%10000100, aObjFlags10,y
	mMOV #$02, aObjVY10,y
	mMOV #$01, aObjVar10,y
.invalid
	rts

;20 90 F2
Reset_JMP:
	mMOV #%00010000, $2000
	mMOV #%00000110, $2001
	mCHANGEBANK #$0E
	jmp $8000
;zPtrに示すアドレスへjsr
IndirectJSR:
	jmp [zPtr]
	.beginregion "EmptySpace3C000"
	.org Table_AnimationPointer_Low
	.endregion "EmptySpace3C000"
	.include "src/animations.asm"

	.org Reset_Start
	sei
	inc $FFE1
	lda #%00000111
	sta $4001
	sta $4005
	jmp Reset_JMP

	.org NMI_VECTOR
	.dw NMI_Start
	.dw Reset_Start
	.dw Reset_Start
