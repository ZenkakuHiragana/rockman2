
;939B
;ガッツtンク
GutsTank:
	dex
	mMOV Table_GutsTankBehaviourlo,x, <zPtrlo
	mMOV Table_GutsTankBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;93A9
;1, ガッツタンク 登場時
GutsTank1:
	jsr BossBehaviour_ChargeLifeWily
	lda aObjVar + 1
	bne .0
	mMOV #%00001100, <zScrollClipFlag
	mMOV <zRoom, <zScrollClipRoom
	mMOV #$02, aPaletteAnim, <zPaletteOffset
	mMOV #$04, aPaletteAnimWait
	mMOVWB $B200, aBossPtrhi, aBossPtrlo
	mMOVWB $1100 - $40, aPPULinearhi
	mMOV #$35, <zBossVar
	mMOV #$20, <$FD
	inc aObjVar + 1
.0 ;BG読み込み
	lda <$FD
	beq .skip_nt
	lda #$A9
	jsr WriteMapAddress18
	dec <$FD
	bpl .rts
.skip_nt
	lda aObjVar + 1
	cmp #$01
	bne .2
	lda #$0B
	jsr LoadBossBG
	dec <zBossVar
	beq .1
.rts
	rts
.1
	inc aObjVar + 1
	mMOV #$10, aBossVar1
	rts
.2 ;NT書き込み(連続部分)
	cmp #$02
	bne .4
	ldx <zBossVar
	cpx #$0B
	beq .3
	mMOV Table_GutsTankNTPtrhi,x, aPPULinearhi
	mMOV Table_GutsTankNTPtrlo,x, aPPULinearlo
	mMOV Table_GutsTankNTSize,x, <zPPULinear
	ldy #$00
.loop_nt
	mMOV aBossVar1, aPPULinearData,y
	inc aBossVar1
	iny
	cpy <zPPULinear
	bne .loop_nt
	inx
	stx <zBossVar
	rts
.3
	mMOVWB $2600 - $20, aPPULinearhi
	mSTZ <zBossVar
	inc aObjVar + 1
.4 ;NT書き込み(非連続部分)
	lda aObjVar + 1
	cmp #$03
	bne .6
	clc
	mMOV #$20, <zPPULinear
	adc aPPULinearlo
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	ldx <zBossVar
	cpx #$B0
	beq .5
	ldy #$00
.loop_nt2
	mMOV Table_GutsTankNTRaw,x, aPPULinearData,y
	inx
	iny
	cpy #$16
	bne .loop_nt2
	stx <zBossVar
	rts
.5
	mMOVWB $27C0, aPPULinearhi
	mSTZ <zBossVar
	inc aObjVar + 1
.6 ;属性書き込み
	clc
	lda aPPULinearlo
	adc #$08
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	mMOV #$06, <zPPULinear
	ldx <zBossVar
	cpx #$1E
	beq .7
	ldy #$00
.loop_attr
	mMOV Table_GutsTankAttr,x, aPPULinearData,y
	inx
	iny
	cpy #$06
	bne .loop_attr
	stx <zBossVar
	rts
.7
	mSTZ <zPPULinear, aObjVar + 1
	mMOV #%10001011, aBossVar1
	inc <zBossBehaviour
	rts

;94AD
;2, ガッツタンク スクロールして出現する
GutsTank2:
	lda aObjFlags + 1
	bmi .exist
	mMOV #$FF, aObjX + 1
.exist
	ldx aObjVar + 1
	lda <zHScrollApparenthi
	cmp Table_GutsTankSpawnLine,x
	bne .move
	cpx #$01
	bne .spawn_others
	mMOV #%10001011, aObjFlags + 1
	mMOV <zHScrollApparentlo, aObjXlo + 1
	jmp .boss_done
.spawn_others
	mMOV Table_GutsTankSpawnY,x, <$01
	mMOV Table_GutsTankSpawnCollision,x, <$02
	lda Table_GutsTankSpawnType,x
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	mMOV <$01, aObjY10,y
	mMOV #$FF, aObjX10,y
	mMOV <zHScrollApparentlo, aObjXlo10,y
	mMOV <$02, aObjCollision10,y
.boss_done
	inc aObjVar + 1
	lda aObjVar + 1
	cmp #$04
	bne .move
	mMOV #$3F, aObjVar + 1
	inc <zBossBehaviour
.move
	mJSR_NORTS WilyBoss_MoveWithBG

;950D
;ガッツタンクのオブジェクトを生成するX位置
Table_GutsTankSpawnLine:
	.db $D7, $C7, $A7, $8C
;9511
;ガッツタンクに付属するオブジェクト番号(2番めはボス本体)
Table_GutsTankSpawnType:
	.db $69, $00, $63, $67
;9515
;ガッツタンクのオブジェクトを生成するY位置
Table_GutsTankSpawnY:
	.db $7F, $00, $A8, $68
;9519
;ガッツタンクのオブジェクトに設定する当たり判定番号
Table_GutsTankSpawnCollision:
	.db $09, $00, $14, $06

;951D
;3, ガッツタンク
GutsTank3:
	lda <zHScrollApparenthi
	cmp #$30
	bne .change_behaviour
	mMOV #$7D, <zBossVar
	inc <zBossBehaviour
.change_behaviour
	lda #%10001011
;952B
;ガッツタンク合流
GutsTank_SetMoveVector:
	sta aBossVar1
	mMOV #$60, aObjVXlo + 1
	mJSR_NORTS GutsTank_Passive

;9537
;5, ガッツタンク
GutsTank5:
	lda <zHScrollApparenthi
	cmp #$80
	bne .change_behaviour
	mMOV #$7D, <zBossVar
	inc <zBossBehaviour
.change_behaviour
	lda #%11001011
	bne GutsTank_SetMoveVector
;9547
;4, ガッツタンク
GutsTank4:
	lda #$05
	bne GutsTank_SetBehaviour
;954B
;6, ガッツタンク
GutsTank6:
	lda #$03
;954D
;ガッツタンク合流
GutsTank_SetBehaviour:
	sta <$00
	dec <zBossVar
	bne .wait
	mMOV <$00, <zBossBehaviour
.wait
	mSTZ aObjVX + 1, aObjVXlo + 1
	mJSR_NORTS GutsTank_Passive
;9563
;ガッツタンク
GutsTank_Passive:
	dec aObjVar + 1
	beq .do
	jmp .wait
.do
	mMOV #$3F, aObjVar + 1
	jsr BossBehaviour_FaceTowards
	lda <$00
	cmp #$38
	bcc .near
;メットール射出
	lda #$69
	jsr BossBehaviour_CheckExistence
	mMOV #$01, aObjVar10,y ;腕を上げる
	mMOV #$02, <$02
	mMOV #$34, <$00
	ldy #$0F
.loop_find
	jsr BossBehaviour_CheckExistenceSpecified
	bcs .notfound
	dec <$02
	beq .wait
	dey
	bpl .loop_find
.notfound
	lda #$34
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .wait
	mMOV #%10000111, aObjFlags10,y
	clc
	lda aObjY10,y
	adc #$30
	sta aObjY10,y
	mMOV #$C4, aObjVXlo10,y
	mMOV #$01, aObjVX10,y
	mMOV #$02, aObjVY10,y
	mMOV #$D4, aObjVYlo10,y
	bne .wait
;上から豆の速度値設定
.near
	sec
	lda <$00
	sbc #$10
	bcs .borrow
	lda #$00
.borrow
	sta <$08
	lda #$00
	asl <$08
	rol a
	asl <$08
	rol a
	asl <$08
	rol a
	sta <$09
	lda #$69
	jsr BossBehaviour_CheckExistence
	mSTZ aObjVar10,y ;腕を下ろす
	lda #$35
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	bcs .wait
	mMOV #%10000101, aObjFlags10,y
	clc
	lda aObjY10,y
	adc #$10
	sta aObjY10,y
	mMOV #$04, aObjVY10,y
	mMOV <$09, aObjVX10,y
	mMOV <$08, aObjVXlo10,y
	mMOV #$01, aObjFrame + 1
.wait
	lda aObjFrame + 1
	bne .waitanim
	sta aObjWait + 1
.waitanim
	mMOV #$0F, aPaletteSpr
	jsr BossBehaviour_BossTakeDamage
	bcc GutsTank_IsAlive
;9625
;ワイリーマシンの撃破時にここに来る
WilyBoss_DefeatedStart:
	mSTZ aPaletteAnim, aPaletteAnimWait
	mMOV #$0D, <zBossVar
	mSTZ aObjVYlo + 1, aObjVY + 1, aObjVXlo + 1, aObjVX + 1
	inc aBossDeath
	mMOV #$07, <zBossBehaviour
	bne GutsTank_End
GutsTank_IsAlive:
	lda <$02
	cmp #$01
	bne GutsTank_End
	mMOV #$30, aPaletteSpr
GutsTank_End:
	mMOV aBossVar1, aObjFlags + 1
	jsr WilyBoss_MoveWithBG
	mMOV #%10000011, aObjFlags + 1
	rts

;9662
;ガッツタンク行動アドレス下位
Table_GutsTankBehaviourlo:
	.db LOW(GutsTank1)
	.db LOW(GutsTank2)
	.db LOW(GutsTank3)
	.db LOW(GutsTank4)
	.db LOW(GutsTank5)
	.db LOW(GutsTank6)

;9668
;ガッツタンク行動アドレス上位
Table_GutsTankBehaviourhi:
	.db HIGH(GutsTank1)
	.db HIGH(GutsTank2)
	.db HIGH(GutsTank3)
	.db HIGH(GutsTank4)
	.db HIGH(GutsTank5)
	.db HIGH(GutsTank6)
