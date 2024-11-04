
;9213
;ピコピコくん
Pikopiko_kun:
	dex
	mMOV Table_Pikopiko_kunBehaviourlo,x, <zPtrlo
	mMOV Table_Pikopiko_kunBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;9221
;1, ピコピコくん 登場時
Pikopiko_kun1:
	lda <zBossVar
	bne .playtrack
	mMOV #%00001100, <zScrollClipFlag
	mMOV <zRoom, <zScrollClipRoom
	mMOV #$20, <$FD
	mMOV #$24, aPaletteSpr + 8 + 1 ;パレットの黒の部分を書き換え
	inc <zBossVar
	mPLAYTRACK #$0B
.playtrack
	jsr BossBehaviour_ChargeLifeWily
	lda <$FD
	beq .skip_nt
	lda #$FD
	jsr WriteMapAddress18
	dec <$FD
.skip_nt
	lda aObjLife + 1
	cmp #$1C
	bne .rts
	mMOV #$6F, aObjVar + 1
	inc <zBossBehaviour
	mSTZ <zBossVar
.rts .public
	rts

;9245
;2, ピコピコくん 破壊までのループ
Pikopiko_kun2:
	dec aObjVar + 1
	bne Pikopiko_kun1.rts
	mMOV #$1F, aObjVar + 1
	lda #$6A
	jsr BossBehaviour_CheckExistence
	bcc Pikopiko_kun1.rts
	ldx <zBossVar
	ldy Table_PikopikoPtr,x
	ldx #$00
.loop_setup
	mMOV Table_PikopikoInfo,y, <$08,x
	iny
	inx
	cpx #$08
	bne .loop_setup
	lda <zBossVar
	asl a
	sta <$01
	ldx #$00
.loop_spawn
	stx <$02
	lda #$6A
	ldx #$01
	jsr BossBehaviour_SpawnEnemy
	ldx <$01
	mMOV Table_PikopikoY,x, aObjY10,y
	mMOV Table_PikopikoX,x, aObjX10,y
	mMOV Table_PikopikoLevel,x, aObjVar10,y
	ldx <$02
	mMOV <$08,x, aObjVY10,y
	mMOV <$0A,x, aObjVX10,y
	mMOV <$0C,x, aObjFlags10,y
	mMOV <$0E,x, aEnemyVar10,y
	inc <$01
	inx
	cpx #$02
	bne .loop_spawn
	lda <zBossVar
	asl a
	sta <$0C
.loop_nt
	ldx <$0C
	mMOV aObjRoom, <$09
	lda Table_PikopikoX,x
	and #$F0
	sta <$08
	mMOV Table_PikopikoY,x, <$0A
	jsr SetPPUPos
	lda <zPPULaser
	bne .skip
	inc <zPPULaser
	inc <$0C
	bne .loop_nt
.skip
	mMOV #$82, <zPPULaser
	inc <zBossVar
	lda <zBossVar
	cmp #$0E
	bne Pikopiko_kun2_rts
	inc <zBossBehaviour
Pikopiko_kun2_rts
	rts

WriteMapAddress18:
	tay
	lda <zHScroll
	pha
	lda <zVScroll
	pha
	lda <zRoom
	pha
	lda <$FD
	asl a
	asl a
	sbc #($02 << 2) - 1
	bcs .skip
	dey
.skip
	asl a
	sta <zHScroll
	dey
	sty <zRoom
	mSTZ <zVScroll
	ldy #$01
	sty <$00
	dey
	sty <$01
	sty <$02
	jsr WriteNameTableByScroll_AnyBank
	pla
	sta <zRoom
	pla
	sta <zVScroll
	pla
	sta <zHScroll
	rts

;92DD
;ピコピコくん出現情報参照位置(始点: Table_PikopikoInfo + Table_PikopikoPtr)
Table_PikopikoPtr:
	.db $00, $00, $00, $08, $10, $00, $00, $10
	.db $08, $00, $10, $10, $00, $10

;92EB
;ピコピコくん出現Y位置
Table_PikopikoY:
	.dw $5757, $8787, $B7B7, $C727, $C727, $7777, $3737, $C727
	.dw $C727, $A7A7, $C727, $C727, $9797, $C727

;9307
;ピコピコくん出現X位置
Table_PikopikoX:
	.dw $D828, $D828, $D828, $6858, $A8B8, $D828, $D828, $98A8
	.dw $4838, $D828, $5868, $B8C8, $D828, $3848

;9323
;ピコピコくんレベル(0～3, 追跡時の移動速度と移動時間が変わる)
Table_PikopikoLevel:
	.dw $0000, $0000, $0000, $0000, $0101, $0101, $0101, $0101
	.dw $0202, $0202, $0202, $0202, $0303, $0303

;933F
;ピコピコくん速度値YX, 状態値、合体までにかかる時間
Table_PikopikoInfo:
	.dw $0000, $0101, $8BCB, $5050
	.dw $01FF, $0000, $8BCB, $5050
	.dw $01FF, $0000, $CB8B, $5050

;9357
;3, ピコピコくん/ブービームトラップ 撃破まで待つ
WilyBoss_Wait:
	lda aObjLife + 1
	bne .rts
	mMOV #$BB, <zBossVar
	inc aBossDeath
	lda #$FF
	mJSRJMP PlayTrack
.rts
	rts

;9369
;ピコピコくん撃破時
Pikopiko_kun_Defeated:
	lda <zBossVar
	beq .2
	dec <zBossVar
	beq .1
	mJSR_NORTS WilyBoss_Defeated_FlashScreen
.1
	mMOV #$80, aBossVar1
.2
	mMOV #$0F, aPaletteSpr
	jmp BossBehaviour_DyingAfterSplash

;9382
;ワイリーステージのボス撃破時に呼び出し
WilyBoss_Defeated_FlashScreen:
	ldx #$0F
	lda <zFrameCounter
	and #$07
	bne .skip
	mPLAYTRACK #$2B
	ldx #$30
.skip
	stx aPaletteSpr
	rts

;9395
;ピコピコくん行動アドレス下位
Table_Pikopiko_kunBehaviourlo:
	.db LOW(Pikopiko_kun1)
	.db LOW(Pikopiko_kun2)
	.db LOW(WilyBoss_Wait)
;9398
;ピコピコくん行動アドレス上位
Table_Pikopiko_kunBehaviourhi:
	.db HIGH(Pikopiko_kun1)
	.db HIGH(Pikopiko_kun2)
	.db HIGH(WilyBoss_Wait)
