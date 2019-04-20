
;96C0
;ワイリーマシン
WilyMachine:
	dex
	mMOV Table_WilyMachineBehaviourlo,x, <zPtrlo
	mMOV Table_WilyMachineBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;96CE
;1, ワイリーマシン 登場時
;5, ワイリーマシン
WilyMachine1:
	mSTZ aObjWait + 1
	lda aObjVar + 1
	bne .init
	mMOV #$02, aPaletteAnim
	mMOV #$04, aPaletteAnimWait
	mMOV #$B0, aBossVar1
	mSTZ aBossVar2, aPaletteAnim, aPaletteAnimWait
	lda #$0F
	ldx #$0B
.loop_palette_init
	sta aPalette + 4,x
	dex
	bpl .loop_palette_init
	mMOVWB $15A0, aPPULinearhi
	mMOV #$52, <zBossVar
	inc aObjVar + 1
;背景画像読み込み
.init
	lda aObjVar + 1
	cmp #$01
	bne .2
	lda #$08
	jsr LoadBossBG
	dec <zBossVar
	beq .1
	rts
.1
	inc aObjVar + 1
	mSTZ <zBossVar
	mMOVWB $27CB, aPPULinearhi
	rts
.2 ;NT書き込み
	cmp #$02
	bne .4
	ldx <zBossVar
	cpx #$14
	beq .3
	mJSR_NORTS WilyMachine_WriteAttr
.3
	inc aObjVar + 1
	mSTZ <zBossVar
	mMOV #$5C, aBossVar1
	rts
.4
	ldx <zBossVar
	cpx #$0E
	bcs .5
	mJSR_NORTS WilyMachine_WriteNameTable
.5
	cpx #$13
	bcs .6
	lda <zFrameCounter
	and #$03
	bne .6
	lda #$04
	ldy #$0B
	ldx #$0F
	jsr WilyMachine_Fadein
	lda #$18
	ldy #$13
	ldx #$1F
	jsr WilyMachine_Fadein
	inc <zBossVar
	rts
.6
	jsr BossBehaviour_ChargeLifeWily
	lda aObjLife + 1
	cmp #$1C
	bne .rts
	inc <zBossBehaviour
	lda #$56
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	mMOV #%10101011, aObjFlags10,y
	mMOV #$B0, aObjX10,y
	mMOV #$80, aObjY10,y
	mMOV #$3E, <zBossVar
.rts
	rts

;979B
;ワイリーマシン フェードインする
WilyMachine_Fadein:
	sta <$00
.loop
	lda aPalette,x
	cmp #$0F
	bne .fadein
	lda Table_WilyMachinePalette,y
	and #$0F
	jmp .write
.fadein
	clc
	adc #$10
	cmp Table_WilyMachinePalette,y
	beq .write
	bcs .skip
.write
	sta aPalette,x
.skip
	dex
	dey
	cpx <$00
	bne .loop
	rts

;97C0
;ワイリーマシンの色
Table_WilyMachinePalette:
	.db $0F, $15, $17, $35
	.db $0F, $27, $17, $07
	.db $0F, $15, $17, $07
	
	.db $0F, $0F, $11, $2C
	.db $0F, $0F, $25, $15

;97D4
;ワイリーマシン ネームテーブル書き込み
WilyMachine_WriteNameTable:
	mMOV Table_WilyMachineNThi,x, aPPULinearhi
	mMOV Table_WilyMachineNTlo,x, aPPULinearlo
	mMOV Table_WilyMachineNTSize,x, <zPPULinear
	ldy #$00
.loop
	mMOV aBossVar1, aPPULinearData,y
	inc aBossVar1
	iny
	cpy <zPPULinear
	bne .loop
	inc <zBossVar
	rts

;97F8
;ワイリーマシン 属性テーブル書き込み
WilyMachine_WriteAttr:
	ldy #$00
.loop
	mMOV Table_WilyMachineAttr,x, aPPULinearData,y
	inx
	iny
	cpy #$05
	bne .loop
	sty <zPPULinear
	stx <zBossVar
	clc
	lda aPPULinearlo
	adc #$08
	sta aPPULinearlo
	rts

;9814
;2, ワイリーマシン 
WilyMachine2:
WilyMachine5:
	lda aObjX + 1
	cmp #$38
	bcs .change_behaviour
	inc <zBossBehaviour
.change_behaviour
	lda #%10000011
WilyMachine_SetMoveVector:
	sta aObjFlags + 1
	sta aBossVar1
	jsr WilyMachine_Misc
	mMOV #%10000011, aObjFlags + 1
	dec <zBossVar
	bne .rts
	mMOV #$3E, <zBossVar
	lda aObjX + 1
	pha
	clc
	adc #$28
	sta aObjX + 1
	jsr BossBehaviour_FaceTowards
	pla
	sta aObjX + 1
	mMOV <$00, <$0B
	mMOV #$1A, <$0D
	mSTZ <$0A, <$0C
	jsr Divide
	lda #$6B
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .rts
	clc
	lda aObjX + 1
	adc #$28
	sta aObjX10,y
	clc
	lda aObjY + 1
	adc #$36
	sta aObjY10,y
	mMOV <$0F, aObjVX10,y
	mMOV <$0E, aObjVXlo10,y
	lda <zBossBehaviour
	cmp #$04
	bcc .rts
	lda aObjFlags10,y
	ora #%00000100
	sta aObjFlags10,y
	mSTZ aObjVY10,y, aObjVYlo10,y
	mMOV #$01, aObjVX10,y
	mMOV #$1E, aObjVXlo10,y
.rts
	mMOV #%10000011, aObjFlags + 1
	rts

;98A2
;3, ワイリーマシン
;6, ワイリーマシン
WilyMachine3:
WilyMachine6
	lda aObjX + 1
	cmp #$98
	bcc .change_behaviour
	dec <zBossBehaviour
.change_behaviour
	lda #%11000011
	jmp WilyMachine_SetMoveVector
;98B0
;4, ワイリーマシン 第二形態移行時
WilyMachine4:
	jsr BossBehaviour_ChargeLifeWily
	mSTZ aObjWait + 1, aObjFrame + 1
	dec aBossVar3
	bne .wait
	mMOV #$0C, aBossVar3
	mMOV <zRand, <$01
	mMOV #$18, <$02
	jsr Divide8
	mMOV <$04, <$08
	mMOV <zRand, <$01
	mMOV #$30, <$02
	jsr Divide8
	mMOV <$04, <$09
	lda #$6C
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .wait
	sec
	lda aObjY + 1
	sbc #$18
	clc
	adc <$09
	sta aObjY10,y
	clc
	lda aObjX + 1
	adc <$08
	sta aObjX10,y
.wait
;ワイリーマシンの運転席部分の描画
	lda aObjVar + 1
	bne .1
	mMOV #$73, aObjAnim + 1
	mMOVWB $27CB, aPPULinearhi
	mMOV #$14, <zBossVar
	inc aObjVar + 1
.1
	lda aObjVar + 1
	cmp #$02
	bcs .3
	ldx <zBossVar
	cpx #$28
	beq .2
	mJSR_NORTS WilyMachine_WriteAttr
.2
	mMOV #$0E, <zBossVar
	mSTZ aBossVar2
	inc aObjVar + 1
.3
	ldx <zBossVar
	cpx #$16
	bcs .4
	mMOV Table_WilyMachineNThi,x, aPPULinearhi
	mMOV Table_WilyMachineNTlo,x, aPPULinearlo
	mMOV Table_WilyMachineNTSize,x, <zPPULinear
	ldy #$00
	ldx aBossVar2
.loop
	mMOV Table_WilyMachineNT2,x, aPPULinearData,y
	inx
	iny
	cpy <zPPULinear
	bne .loop
	stx aBossVar2
	inc <zBossVar
	rts
.4
	lda aObjLife + 1
	cmp #$1C
	beq .5
	rts
.5
	inc <zBossBehaviour
	mMOV #$3E, <zBossVar
	mMOV #$A3, aObjVXlo + 1
	rts

;997B
;7, ワイリーマシン 撃破時
WilyMachine_Defeated:
	lda aObjVar + 1
	beq .1
	lda aObjY
	cmp #$E0
	bcs .fallplayer
	inc aObjY
	inc aObjY
	rts
.fallplayer
	mSTZ aObjFlags
	dec <zBossVar
	bne .rts
	mMOV #$FF, <zBossBehaviour
.rts
	rts
.1
	jsr WilyBoss_Defeated_FlashScreen
	lda aObjY + 1
	beq .goupufo
	sec
	lda aObjYlo + 1
	sbc #$80
	sta aObjYlo + 1
	lda aObjY + 1
	sbc #$00
	sta aObjY + 1
	bne .goupufo
	sta aObjFlags + 1
.goupufo
	mMOV <zRand, <$01
	mMOV #$20, <$02
	jsr Divide8
	lda #$06
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .invalid
	lda <zRand
	asl a
	lda <zRand
	rol a
	rol a
	rol a
	rol a
	ora #$08
	sta aObjX10,y
	clc
	lda <$04
	adc #$C8
	sta aObjY10,y
.invalid
	inc <zBossVar
.done
	lda <zBossVar
	cmp #$FD
	beq .2
	rts
.2
	lda #$0F
	ldx #$10
.loop
	sta aPalette,x
	dex
	bpl .loop
	inc aObjVar + 1
	mMOV #$0B, <zStatus
	mSTZ aObjFrame, aObjWait
	mMOV #$0C, aObjAnim
	mMOV #$3E, <zBossVar
	rts

;9A10
;ワイリーマシン パレット変更/装備武器により弾く/その他
WilyMachine_Misc:
	mMOV #$0F, aPaletteSpr
	lda <zBossBehaviour
	cmp #$04
	bcs .is2nd
;カバー脱落前
	lda <zEquipment
	cmp #$02 ;エアーシューター
	beq .deflect
	cmp #$05 ;クイックブーメラン
	beq .deflect
	bne .normal
;カバー脱落後
.is2nd
	lda <zEquipment
	cmp #$01 ;アトミックファイヤー
	bne .normal
;弾く
.deflect
	lda aObjFlags + 1
	ora #%00001000
	sta aObjFlags + 1
;弾かない
.normal
	jsr BossBehaviour_BossTakeDamage
	bcc .boss_alive
	lda <zBossBehaviour
	cmp #$04
	bcs .is2nd_defeat
;カバー脱落前
	mMOV #$04, <zBossBehaviour
	mMOV #$0C, aBossVar3
	mSTZ aObjVX + 1, aObjVXlo + 1, aObjVar + 1
	beq .move
;カバー脱落後
.is2nd_defeat
	lda #$74
	jsr SetBossAnimation
	clc
	lda aObjX + 1
	adc #$28
	sta aObjX + 1
	mMOV #$57, aObjY + 1
	mSTZ aObjVar + 1
	lda #$56
	jsr BossBehaviour_CheckExistence
	bcs .jmp
	mSTZ aObjFlags10,y
.jmp
	jmp WilyBoss_DefeatedStart
;ワイリーマシン生存
.boss_alive
	lda <$02
	cmp #$01
	bne .move
	mMOV #$30, aPaletteSpr
.move
	mJSR_NORTS WilyBoss_MoveWithBG

;9A8C
;ワイリーマシン NT書き込み位置上位
Table_WilyMachineNThi:
	.db $25, $25, $25, $25, $25, $25, $25, $25
	.db $26, $26, $26, $26, $26, $26, $25, $25
	.db $25, $25, $26, $26, $26, $26
;9AA2
;ワイリーマシン NT書き込み位置下位
Table_WilyMachineNTlo:
	.db $17, $36, $56, $71, $90, $B0, $D0, $F0
	.db $0E, $2E, $4E, $6E, $93, $B4, $90, $B0
	.db $D0, $F0, $0E, $2E, $4E, $6E
;9AB8
;ワイリーマシン NT書き込みサイズ
Table_WilyMachineNTSize:
	.db $04, $05, $06, $0B, $0D, $0D, $0D, $0D
	.db $0F, $0E, $0D, $0C, $04, $02, $04, $04
	.db $04, $04, $06, $07, $05, $04
;9ACE
;ワイリーマシン 属性テーブル
Table_WilyMachineAttr:
	.db $FF, $AF, $FF, $BF, $FF, $FF, $FD, $FF
	.db $FA, $EE, $F7, $BF, $AF, $FF, $FF, $FF
	.db $FB, $FA, $FF, $FF, $FF, $AF, $FF, $BF
	.db $FF, $FF, $EE, $FF, $FA, $EE, $FB, $BE
	.db $AF, $FF, $FF, $FF, $FB, $FA, $FF, $FF

;9AF6
;ワイリーマシン 第二形態のNTデータかな？
Table_WilyMachineNT2:
	.db $00, $E6, $E7, $E8
	.db $00, $00, $E9, $EA, $00
	.db $00, $EB, $EC, $ED, $EE, $EF
	.db $F0, $00, $00, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8
	.db $F9, $FA, $FB, $00, $00, $00, $00, $FC, $00, $00, $00, $00

;9B1C
;ワイリーマシン行動アドレス下位
Table_WilyMachineBehaviourlo:
	.db LOW(WilyMachine1)
	.db LOW(WilyMachine2)
	.db LOW(WilyMachine3)
	.db LOW(WilyMachine4)
	.db LOW(WilyMachine5)
	.db LOW(WilyMachine6)
	.db LOW(WilyMachine_Defeated)

;9B23
;ワイリーマシン行動アドレス上位
Table_WilyMachineBehaviourhi:
	.db HIGH(WilyMachine1)
	.db HIGH(WilyMachine2)
	.db HIGH(WilyMachine3)
	.db HIGH(WilyMachine4)
	.db HIGH(WilyMachine5)
	.db HIGH(WilyMachine6)
	.db HIGH(WilyMachine_Defeated)
