
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
	mJSR_NORTS $97F8
.3
	inc aObjVar + 1
	mSTZ <zBossVar
	mMOV #$5C, aBossVar1
	rts
.4
	ldx <zBossVar
	cpx #$0E
	bcs .5
	mJSR_NORTS $97D4
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
	mMOV #%10000011, aObjFlags + 1, aBossVar1
	jsr $9A10
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
	sta aObJX10,y
.wait
;ワイリーマシンの運転席部分の描画
	lda aObjVar + 1
	bne .1
	mMOV #$73, aObjAnim + 1
	mMOVWB $27CB, aPPULinearhi
	mMOV #$14, <zBossVar
	inc aObjVar + 1
.1
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
	

;997B
;7, ワイリーマシン
WilyMachine7:
	

;9A10
;ワイリーマシン パレット変更/装備武器により弾く/その他
WilyMachine_Misc:
	

;9B1C
;ワイリーマシン行動アドレス下位
Table_WilyMachineBehaviourlo:
	.db LOW(WilyMachine1)
	.db LOW(WilyMachine2)
	.db LOW(WilyMachine3)
	.db LOW(WilyMachine4)
	.db LOW(WilyMachine5)
	.db LOW(WilyMachine6)
	.db LOW(WilyMachine7)

;9B23
;ワイリーマシン行動アドレス上位
Table_WilyMachineBehaviourhi:
	.db HIGH(WilyMachine1)
	.db HIGH(WilyMachine2)
	.db HIGH(WilyMachine3)
	.db HIGH(WilyMachine4)
	.db HIGH(WilyMachine5)
	.db HIGH(WilyMachine6)
	.db HIGH(WilyMachine7)
