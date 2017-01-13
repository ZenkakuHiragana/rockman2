
;948D
;シュリンク
EN00:
EN01:
	lda aObjVar,x
	bne .skip
	sta aObjWait,x
	lda aEnemyVar,x
	bne .skip2
	lda #$01
	sta aEnemyVar,x
	lda #$14
	sta aObjVar,x
	lda #$05
	sta aObjFrame,x
	lda <zRand
	and #$03
	beq .rand
	lda #$02
	sta <$09
	lda #$0C
	sta <$08
	jsr SetVelocityAtRockman
	ldx <zObjIndex
	jmp .skip
.rand
	jsr FaceTowards
	lda Table_InitialVX
	sta aObjVX,x
	lda Table_InitialVX + 1
	sta aObjVXlo,x
	lda Table_InitialVY
	sta aObjVY,x
	lda Table_InitialVY + 1
	sta aObjVYlo,x
	bne .skip
.skip2
	lda #$00
	sta aObjFrame,x
	sta aEnemyVar,x
	lda <zRand
	and #$01
	tay
	lda .var,y
	sta aObjVar,x
	lda #$00
	sta aObjVXlo,x
	sta aObjVX,x
	lda #$3C
	sta aObjVYlo,x
	lda #$FF
	sta aObjVY,x
.skip
	dec aObjVar,x
	lda aObjFrame,x
	cmp #$04
	bcc .done
	bne .skipanim
	lda #$00
	sta aObjFrame,x
	beq .done
.skipanim
	cmp #$07
	bne .done
	lda #$00
	sta aObjWait,x
.done
	mJSR_NORTS MoveEnemy
.var
	.db $19, $4A

;9523
;シュリンク生成器
EN02:
	lda aObjVar,x
	bne .skip
	ldy #$0F
	lda #$02
	sta <$01
	lda #$01
	sta <$00
.loop_check
	jsr FindObjectY
	bcs .ok
	dec <$01
	beq .check_end
	dey
	bne .loop_check
	bne .check_end
.ok
	lda #$01
	jsr CreateEnemyHere
	lda #$31
	bne .done
.check_end
	lda #$62
.done
	sta aObjVar,x
.skip
	dec aObjVar,x
	mJSR_NORTS CheckOffscreenItem

;9555
;M-445生成器
EN03:
	lda aObjVXlo,x
	bne .do
	lda #$03
	jsr Spawner_Check
	bcc .do
	rts
.do
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjVar,x
	bne .skip
	lda #$03
	sta <$01
	lda #$04
	jsr FindObjectsA
	bcs .over
	lda #$04
	jsr CreateEnemyHere
	bcs .over
	lda aEnemyVar,x
	and #$01
	tax
	clc
	lda aObjX10,y
	adc .dx,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc .dr,x
	sta aObjRoom10,y
	ldx <zObjIndex
	inc aEnemyVar,x
.over
	lda #$4B
	sta aObjVar,x
.skip
	dec aObjVar,x
	ldy #$17
	mJSR_NORTS EN0F_ChangePalette
.dx
	.db $50, $C8
.dr
	.db $00, $FF

;95B5
;無限ジェネレータ処理/既に存在していればsecで自爆/処理するならVXloを非ゼロに
Spawner_Check:
	sta <$00
	ldy #$0F
.loop
	jsr FindObjectY
	bcs .ok
	lda aObjVXlo10,y
	beq .goto
	lsr aObjFlags,x
	lda #$00
	sta aEnemyOrder,x
	sec
	rts
.goto
	dey
	bne .loop
.ok
	lda #$01
	sta aObjVXlo,x
	clc
	rts

;95D7
;M-445
EN04:
	lda aObjVXlo,x
	bne .sinecurve
	sec
	lda aObjY
	sbc aObjY,x
	cmp #$03
	bcc .chase
	cmp #$FE
	bcc .move
.chase
	jsr FaceTowards
.sinecurve
	lda aObjVar,x
	bne .wait
	lda #$0B
	sta aObjVar,x
	lda aEnemyVar,x
	pha
	and #$07
	tay
	lda #$00
	sta aObjVX,x
	sta aObjVY,x
	lda .vxlo,y
	sta aObjVXlo,x
	lda .vylo,y
	sta aObjVYlo,x
	pla
	pha
	cmp #$04
	bcc .inv
	cmp #$0C
	bcs .inv
	lda aObjVYlo,x
	eor #$FF
	adc #$01
	sta aObjVYlo,x
	lda #$FF
	adc #$00
	sta aObjVY,x
.inv
	pla
	clc
	adc #$01
	and #$0F
	sta aEnemyVar,x
.wait
	dec aObjVar,x
.move
	mJSR_NORTS MoveEnemy
;963E
.vxlo
	.db $17, $5E, $AD, $E3, $E3, $AD, $5E, $17
;9646
.vylo
	.db $F5, $E3, $AD, $5E, $5E, $AD, $E3, $F5

;964E
;M-445生成器削除
EN05:
	lda #$03
	sta <$00
;9652
;$00で指定したオブジェクトを削除
EN05_DeleteObjects:
	ldy #$0F
.loop
	jsr FindObjectY
	bcs .notfound
	lda #%00000000
	sta aObjFlags10,y
	lda #$FF
	sta aEnemyOrder10,y
	dey
	bpl .loop
.notfound
	lda #%00000000
	sta aObjFlags,x
	lda #$FF
	sta aEnemyOrder,x
	rts

;9671
;消滅エフェクト
EN06:
	mJSR_NORTS CheckOffscreenEnemy

;9675
;クロウ生成器
EN07:
	lda aObjVXlo,x
	bne .do
	lda #$07
	jsr Spawner_Check
	bcc .do
	rts
.do
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjVar,x
	bne .wait
	lda #$02
	sta <$01
	lda #$08
	jsr FindObjectsA
	bcs .invalid
	lda #$08
	jsr CreateEnemyHere
	bcs .invalid
	lda aEnemyVar,x
	and #$01
	tax
	lda aObjX10,y
	adc .dx,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc .dr,x
	sta aObjRoom10,y
	ldx <zObjIndex
	inc aEnemyVar,x
.invalid
	lda #$5D
	sta aObjVar,x
.wait
	dec aObjVar,x
	rts
.dx
	.db $30, $E0
.dr
	.db $00, $FF

;96CF
;objAが$01個以上存在すればCフラグセット
FindObjectsA:
	sta <$00
	ldy #$0F
.loop
	jsr FindObjectY
	bcs .false
	dec <$01
	beq .true
	dey
	bne .loop
	beq .true
.false
	clc
	rts
.true
	sec
	rts

;96E5
;クロウ
EN08:
	lda #$0B
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionY
	lda aObjVar,x
	bne .land
	lda <$00
	beq .skip
	inc aObjVar,x
	lda #$76
	sta aObjVYlo,x
	lda #$03
	sta aObjVY,x
	lda aObjFlags,x
	ora #%00000100
	sta aObjFlags,x
	jsr FaceTowards
	bne .skip
.land
	cmp #$03
	beq .walk
	lda <$00
	beq .skip
	lda aObjVar,x
	cmp #$02
	beq .lastjump
	lda #$00
	sta aObjVYlo,x
	lda #$02
	sta aObjVY,x
	inc aObjVar,x
	bne .skip
.lastjump
	lda #$C0
	sta aObjVYlo,x
	lda #$FF
	sta aObjVY,x
	lda #$00
	sta aObjVX,x
	lda #$A3
	sta aObjVXlo,x
	inc aObjVar,x
	lda aObjFlags,x
	and #%11111011
	sta aObjFlags,x
	bne .skip
.walk
	lda #$0C
	lda <$00
	bne .skip
	lda #$00
	sta aObjVar,x
	sta aObjVXlo,x
	sta aObjVX,x
	lda aObjFlags,x
	ora #%00000100
	sta aObjFlags,x
.skip
	mJSR_NORTS MoveEnemy

;976F
;クロウ生成器削除
EN09:
	lda #$07
	sta <$00
	jmp EN05_DeleteObjects

;9776
;タニッシー
EN0A:
	lda aObjVar,x
	bne .noshell
	lda #$0C
	sta <$02
	lda aObjFrame,x
	cmp #$02
	bcc .loopanim
	lda #$00
	sta aObjFrame,x
.loopanim
	lda aObjLife,x
	cmp #$14
	beq .move
	lda #$0B
	jsr CreateEnemyHere
	lda aObjFlags10,y
	ora #%00000100
	eor #%01000000
	sta aObjFlags10,y
	clc
	lda aObjY,x
	adc #$08
	sta aObjY,x
	lda #$01
	sta aObjVX,x
	lda #$47
	sta aObjVXlo,x
	lda #$03
	sta aObjCollision,x
	lda #$03
	sta aObjFrame,x
	inc aObjVar,x
	bne .move
.noshell
	lda #$04
	sta <$02
	lda aObjFrame,x
	cmp #$05
	bcc .move
	lda #$03
	sta aObjFrame,x
.move
	lda aObjFlags,x
	and #%01000000
	beq .left
	clc
	lda aObjX,x
	adc #$0C
	sta <$08
	lda aObjRoom,x
	adc #$00
	jmp .merge
.left
	sec
	lda aObjX,x
	sbc #$0C
	sta <$08
	lda aObjRoom,x
	sbc #$00
.merge
	sta <$09
	lda aObjY,x
	sta <$0A
	lda #$00
	sta <$0B
	jsr PickupMap
	ldx <zObjIndex
	lda <$00
	and #$08
	bne .hit
	clc
	lda <$0A
	adc <$02
	sta <$0A
	jsr PickupMap
	ldx <zObjIndex
	lda <$00
	and #$08
	bne .done
.hit
	lda aObjFlags,x
	eor #%01000000
	sta aObjFlags,x
.done
	mJSR_NORTS MoveEnemy

;982B
;タニッシーの殻
;ロックマンの泡
;ロビットの弾
;チャンキー
;ネオメットールの弾
;ピピの卵の殻
;カミナリゴローのカミナリ
;ショットマンの弾
;バブルマンの弾
;メタルブレード
;クラッシュボムの爆風
;ボスのティウンの○
;リーフシールド
;メカドラゴンの炎
;ワイリーマシンの変形時の赤いの
;ブービームトラップの弾
EN0B:
EN0E:
EN18:
EN24:
EN35:
EN3B:
EN3F:
EN4D:
EN5A:
EN5C:
EN5F:
EN60:
EN61:
EN68:
EN6C:
EN6E:
EN6F:
	mJSR_NORTS MoveEnemy

;982F
;ケロッグ
EN0C:
	lda aObjFrame,x
	cmp #$09
	bcs .skip
	lda #$01
	sta <$01
	lda #$0D
	jsr FindObjectsA
	bcs .invalid
	lda #$09
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	jsr .move
.skip
	cmp #$0A
	bne .move
	lda aObjWait,x
	bne .move
	lda #$02
	sta <$01
.loop
	lda #$0D
	jsr CreateEnemyHere
	bcs .invalid
	ldx <$01
	lda .vxlo,x
	sta aObjVXlo10,y
	lda .vx,x
	sta aObjVX10,y
	ldx <zObjIndex
	dec <$01
	bpl .loop
.invalid
	lda aObjFrame,x
	cmp #$08
	bne .move
	lda #$00
	sta aObjFrame,x
.move
	jsr FaceTowards
	mJSR_NORTS CheckOffscreenEnemy
.vxlo
	.db $15, $8D, $A2
.vx
	.db $04, $02, $01

;988F
;子ケロッグ
EN0D:
	lda #$00
	sta aObjWait,x
	lda #$03
	sta <$01
	lda #$04
	sta <$02
	jsr WallCollisionXY
	lda aEnemyVar,x
	bne .skip
	lda <$00
	beq .move
	lda #$3E
	sta aObjVar,x
	inc aObjFrame,x
	lda #$00
	sta aObjVXlo,x
	sta aObjVX,x
	inc aEnemyVar,x
	bne .move
.skip
	dec aObjVar,x
	bne .move
	dec aObjFrame,x
	dec aEnemyVar,x
	jsr FaceTowards
	lda #$A2
	sta aObjVXlo,x
	lda #$01
	sta aObjVX,x
	lda #$E6
	sta aObjVXlo,x
	lda #$04
	sta aObjVY,x
.move
	mJSR_NORTS MoveEnemy

;89E3
;アンコウの提灯
;処理読んでないや……
EN0F:
	lda aObjVXlo,x
	bne .1
	lda aObjVar,x
	beq .nochangepalette
	ldy #$02
	cmp aObjLife,x
	beq .dmg
	ldy #$05
.dmg
	jsr EN0F_ChangePalette
.nochangepalette
	lda aObjLife,x
	sta aObjVar,x
	lda aObjRoom,x
	sta aObjVYlo,x
	jsr CheckOffscreenItem
	lda aObjLife,x
	bne .alive
	lda #%10100000
	sta aObjFlags,x
	lda #$0F
	sta aObjAnim,x
	ldx #$01
.loopdelete
	stx <$01
	lda EN0F_ObjList,x
	jsr FindObject
	bcs .notfound
	lda #%00000000
	sta aObjFlags10,y
	lda #$FF
	sta aItemOrder,y
.notfound
	ldx <$01
	dex
	bpl .loopdelete
	ldx <zObjIndex
	ldy aEnemyVar,x
	lda #$00
	sta aItemLife - 1,y
	sta aItemLife + 1,y
	sta aItemLife - 2,y
	sta aItemLife + 2,y
	lda #$0E
	sta aObjVXlo,x
	lda #$06
	sta aObjVX,x
.alive
	rts
.1
	dec aObjVX,x
	php
	lda aObjVXlo,x
	cmp #$05
	bcc .2
	ldy #$02
	plp
	beq .3
	mJSR_NORTS EN0F_ChangePalette
.3
	ldy #$05
	bne .4
.2
	plp
	bne .end
	ldy aObjVXlo,x
	lda EN0F_UnknownTable - 1,y
	tay
.4
	lda #$09
	sta aObjVX,x
	jsr EN0F_ChangePalette
	lda aObjVXlo,x
	cmp #$06
	bcs .5
	jsr EN0F_DestroyEffect
.5
	dec aObjVXlo,x
	bne .end
	lsr aObjFlags,x
.end
	rts
;998D
EN0F_ChangePalette:
	ldx #$02
.loop_changepalette
	lda EN0F_Palette,y
	sta aPalette + $09,x
	sta aPalette + $29,x
	sta aPalette + $39,x
	sta aPalette + $49,x
	dey
	dex
	bpl .loop_changepalette
	ldx <zObjIndex
	rts
;99A5
EN0F_DestroyEffect:
	lda #$04
	sta <$01
	lda aObjVXlo,x
	asl a
	asl a
	adc aObjVXlo,x
	sta <$02
	lda aObjVYlo,x
	sta <$03
.loopdestroy
	lda #$06
	jsr CreateEnemyHere
	bcs .invalideffect
	ldx <$02
	lda EN0F_DestroyEffectY - 5,x
	sta aObjY10,y
	lda <$03
	sta aObjRoom10,y
	cmp #$09
	php
	lda EN0F_DestroyEffectX - 5,x
	plp
	beq .issecond
	sec
	sbc #$20
.issecond
	sta aObjX10,y
	sec
	sbc <zHScroll
	lda <$03
	sbc <zRoom
	beq .canexists
	lda #%00000000
	sta aObjFlags10,y
.canexists
	ldx <zObjIndex
	inc <$02
	dec <$01
	bpl .loopdestroy
.invalideffect
	ldx <zObjIndex
	mPLAYTRACK #$2B
	rts
;99F9
EN0F_Palette:
	.db $20, $15, $0F
	.db $20, $20, $0F
EN0F_ObjList:
	.db $10, $02
EN0F_UnknownTable:
	.db $17, $14, $11, $0E, $31, $14, $0F, $21
	.db $13, $01, $11, $11, $01, $11, $11, $11
EN0F_DestroyEffectX:
	.db $68, $78, $88, $88, $A8, $68, $78, $98
	.db $98, $B8, $68, $78, $98, $98, $A8, $58
	.db $68, $88, $A8, $B8, $68, $78, $78, $88, $A8
EN0F_DestroyEffectY:
	.db $B8, $A8, $88, $B8, $B8, $A8, $B8, $98
	.db $B8, $A8, $98, $B8, $98, $B8, $A8, $B8
	.db $88, $98, $88, $B8, $B8, $88, $A8, $A8, $98

;9A43
;アンコウのボディ
EN10:
	lda aObjVar,x
	bne .1
	lda #$01
	sta aObjFrame,x
	lda #$70
	sta aObjVar,x
.1
	lda aObjFrame,x
	cmp #$04
	bcc .stopanim
	lda #$00
	sta aObjWait,x
.stopanim
	dec aObjVar,x
	mJSR_NORTS CheckOffscreenItem

;9A65
;アンコウのためのパレット変化
EN11:
	ldy #$02
	jsr EN0F_ChangePalette
	lda #$FF
	sta aItemOrder,x
	lsr aObjFlags,x
	rts

;9A73
;クラッシュマンステージのリフト
EN12:
	lda #$14
	sta aPlatformWidth,x
	sec
	lda aObjRoom,x
	sbc #$04
	ldy <zStage
	cpy #$07
	beq .clash
	sec
	lda aObjRoom,x
	sbc #$1B
.clash
	sta <$00
	tay
	lda .begin,y
	sta <$01
	clc
	adc aObjVar,x
	tay
	lda <$00
	cmp #$03
	bcs .wily
	lda .data - 1,y
	sta <$02
	lda .data,y
	jmp .merge
.wily
	lda .data_wily - 1,y
	sta <$02
	lda .data_wily,y
.merge
	and #$01
	bne .horizontal
	lda aObjY,x
	cmp <$02
	beq .stop
	bne .done
.horizontal
	lda aObjX,x
	cmp <$02
	bne .done
.stop
	lda #$00
	sta aObjXlo,x
	sta aObjYlo,x
	iny
	iny
	inc aObjVar,x
	inc aObjVar,x
	lda aObjVar,x
	ldx <$00
	cmp .size,x
	bne .done
	ldx <zObjIndex
	lda #$00
	sta aObjVar,x
	ldy <$01
.done
	ldx <$00
	cpx #$03
	bcs .wily_set
	lda .data,y
	jmp .merge_set
.wily_set
	lda .data_wily,y
.merge_set
	ldx <zObjIndex
	tay
	lda .vylo,y
	sta aObjVYlo,x
	lda .vy,y
	sta aObjVY,x
	lda .vx,y
	sta aObjVXlo,x
	lda .vec,y
	sta aObjFlags,x
	jsr MoveEnemy
	bcc .del
	lda #$00
	sta aPlatformWidth,x
.del
	sec
	lda aObjY,x
	sbc #$04
	sta aPlatformY,x
	rts
;9B25
.begin
	.db $00, $08, $24, $00, $44, $5C, $8C
;9B2C
.vylo
	.db $1B, $00, $E5, $00
;9B30
.vy
	.db $FF, $00, $00, $00
;9B34
.vx
	.db $00, $E5, $00, $E5
;9B38
.vec
	.db $80, $80, $C0, $C0
;9B3C
.size
	.db $08, $1C, $54, $44, $18, $30, $14, $A0
;9B44
.data
	.dw $2800, $4001, $D802, $A003, $6800, $8001, $9802, $6003
	.dw $B802, $4003, $8802, $6001, $2800, $4001, $6802, $2003
	.dw $D802, $A003, $2800, $9001, $C802, $3003, $A802, $4001
	.dw $B800, $5003, $A800, $6001, $B800, $7003, $A800, $8001
	.dw $8800, $7001, $9802, $6003, $8802, $5001, $9802, $4003
	.dw $8802, $3001, $7802, $8001, $3800, $7001, $6802, $6003
	.dw $3802, $5001, $6802, $4003, $2802, $7001, $1800, $3001
	.dw $6802, $2003, $D802, $A003

;9BBC
.data_wily
	.dw $B800, $5001, $E802, $4003, $C802, $2001, $8802, $3001
	.dw $A800, $6003, $8800, $7001, $A800, $B003, $7800, $5001
	.dw $9802, $4003, $5802, $3001, $7802, $2003, $3802, $6001
	.dw $4800, $5003, $6802, $7003, $4800, $C001, $C800, $8003
	.dw $D802, $C003, $1800, $9001, $3802, $B003, $5800, $C003
	.dw $C800, $7003, $8802, $2001, $4802, $9001, $1800, $6001
	.dw $2802, $B003, $B800, $C003, $E800, $4003, $C802, $3001
	.dw $9802, $4001, $B800, $5003, $D800, $B003, $C800, $6001
	.dw $5802, $3001, $2802, $4001, $3800, $8003, $3800, $6001
	.dw $4802, $A003, $8800, $C003, $D800, $5003, $5802
	.db $01

;9C5B
;落下ブロック
EN13:
	lda #$18
	sta aPlatformWidth,x
	lda aObjFlags,x
	and #%00000100
	bne .fall
	lda aObjVar,x
	cmp #$06
	bcs .fall
	jsr CheckOffscreenEnemy
	jmp .done
.fall
	lda aObjFlags,x
	ora #%00000100
	sta aObjFlags,x
	jsr MoveEnemy
.done
	bcc .del
	lda #$00
	sta aPlatformWidth,x
.del
	sec
	lda aObjY,x
	sbc #$08
	sta aPlatformY,x
	rts

;9C90
;レーザー出現
EN14:
	rts
	lda aObjRoom,x
	sbc #$03
	tay
	lda .lasernum,y
	sta <$02
	lda .begin,y
	sta <$01
.loop
	lda #$15
	jsr CreateEnemyHere
	ldx <$01
	lda .vector,x
	sta aObjFlags10,y
	and #%01000000
	bne .right
	lda #$FC
	bne .setx
.right
	lda #$04
.setx
	sta aObjX10,y
	lda .y,x
	sta aObjY10,y
	lda .length,x
	sta aEnemyVar10,y
	lda .timer,x
	sta aObjVar10,y
	ldx <zObjIndex
	inc <$01
	dec <$02
	bne .loop
	lsr aObjFlags,x
	lda #$00
	sta aEnemyOrder,x
	rts
.lasernum
	.db $02, $03, $04, $00, $00, $00, $00, $00
	.db $00, $0C, $0A, $05, $05, $02, $05, $04
.begin
	.db $00, $02, $05, $09, $09, $09, $09, $09
	.db $09, $09, $15, $1F, $24, $29, $2B, $30
.vector
	.db $E1, $A1, $E1, $A1, $A1, $E1, $A1, $E1
	.db $A1, $E1, $A1, $E1, $A1, $E1, $A1, $E1
	.db $A1, $E1, $A1, $E1, $A1, $E1, $A1, $E1
	.db $A1, $E1, $A1, $E1, $A1, $E1, $A1, $E1
	.db $A1, $E1, $A1, $A1, $A1, $A1, $E1, $E1
	.db $A1, $A1, $A1, $A1, $A1, $A1, $A1, $E1
	.db $A1, $A1, $E1, $A1
.y
	.db $47, $77, $57, $87, $C7, $47, $67, $87
	.db $C7, $17, $17, $37, $37, $57, $57, $77
	.db $77, $A7, $A7, $B7, $B7, $37, $37, $57
	.db $57, $77, $77, $97, $97, $B7, $B7, $17
	.db $17, $27, $27, $A7, $17, $37, $67, $87
	.db $A7, $67, $B7, $27, $47, $67, $77, $A7
	.db $17, $27, $67, $A7
.length
	.db $FF, $00, $FF, $00, $00, $FF, $A0, $60
	.db $60, $80, $80, $80, $80, $80, $80, $80
	.db $80, $80, $80, $80, $80, $80, $80, $80
	.db $80, $60, $A0, $80, $80, $80, $80, $80
	.db $80, $80, $80, $00, $00, $00, $FF, $FF
	.db $00, $00, $00, $00, $00, $80, $00, $70
	.db $00, $00, $FF, $20
.timer
	.db $01, $1F, $01, $1F, $3E, $01, $1F, $3E
	.db $5D, $01, $01, $1F, $1F, $3E, $3E, $5D
	.db $5D, $7C, $7C, $9D, $9D, $01, $01, $1F
	.db $1F, $3E, $3E, $5D, $5D, $7C, $7C, $01
	.db $01, $1F, $1F, $3E, $01, $1F, $3E, $5D
	.db $7C, $01, $1F, $01, $1F, $3E, $5D, $7C
	.db $01, $1F, $3E, $5D

;9DCE
;レーザー
EN15:
	lda aObjVar,x
	beq .do
	dec aObjVar,x
	beq .fire
	rts
.fire
	lda aObjFlags,x
	and #%11011111
	sta aObjFlags,x
	mPLAYTRACK #$27
.do
	lda aObjFlags,x
	and #%00100000
	bne .checkhit
	lda aObjFlags,x
	and #%01000000
	bne .right
	lda aObjX,x
	cmp aEnemyVar,x
	bcs .continue
	bcc .stop
.right
	lda aObjX,x
	cmp aEnemyVar,x
	bcc .continue
.stop
	lda aEnemyVar,x
	sta aObjX,x
	lda aObjFlags,x
	ora #%00100000
	sta aObjFlags,x
	bne .checkhit
.continue
	lda aObjRoom,x
	sta <$09
	lda aObjX,x
	sta <$08
	lda aObjY,x
	and #$F0
	sta <$0A
	jsr SetPPUPos
	ldy #$74
	lda aPPULaserlo,x
	and #$01
	beq .left
	ldy #$76
.left
	tya
	sta aPPULaserData,x
	inc <zPPULaser
	ldx <zObjIndex
	jsr MoveEnemy
	bcc .checkhit
	lda aObjFlags,x
	asl a
	ora #%00100000
	sta aObjFlags,x
.checkhit
	lda <zInvincible
	bne .done
	sec
	lda aObjY,x
	sbc aObjY
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp #$10
	bcs .done
	lda aObjFlags,x
	and #%01000000
	bne .right_checkhit
	lda aObjX,x
	cmp aObjX
	bcs .done
	bcc .hit
.right_checkhit
	lda aObjX,x
	cmp aObjX
	bcc .done
.hit
	lda #$00
	sta <zStatus
	jmp DieRockman
.done
	rts

;9E81
;バットン
EN16:
	lda aObjVar,x
	bne .1
	lda <zRand
	eor #$01
	sta <zRand
	and #$01
	tay
	lda EN16_wait_time,y
	sta aObjVar,x
	lda #%10001011
	sta aObjFlags,x
	bne .wait
.1
	cmp #$01
	beq .2
	cmp #$FF
	beq .3
	dec aObjVar,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
.wait
	mJSR_NORTS CheckOffscreenEnemy
.2
	lda aObjFlags,x
	and #%11110111
	sta aObjFlags,x
	lda aObjFrame,x
	cmp #$08
	bne .move
	lda #$05
	sta aObjFrame,x
	lda #$00
	sta <$09
	lda #$83
	sta <$08
	jsr SetVelocityAtRockman
.move
	jsr MoveEnemy
	lda <$01
	beq .cont
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjVYlo,x
	lda #$02
	sta aObjVY,x
	lda #$FF
	sta aObjVar,x
.cont
	rts
.3
	lda aObjFrame,x
	cmp #$08
	bne .loopanim
	lda #$05
	sta aObjFrame,x
.loopanim
	lda #$04
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionY
	lda <$00
	beq EN16_goup
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
	lda #%10001011
	sta aObjFlags,x
	lda #$3E
	sta aObjVar,x
EN16_goup:
	mJSR_NORTS MoveEnemy
EN16_wait_time:
	.db $3E, $9C

;9F22
;ロビット
EN17:
	lda aObjVY,x
	sta <$04
	lda #$0C
	sta <$01
	lda #$10
	sta <$02
	jsr WallCollisionXY
	lda aEnemyVar,x
	bne .1
	lda aObjVar,x
	bne .done
	lda #$C0
	sta aObjVXlo,x
	sta aObjVYlo,x
	lda #$04
	sta aObjVY,x
	sta <$04
	jsr FaceTowards
	inc aEnemyVar,x
	lda #$01
	sta aObjFrame,x
.1
	lda aEnemyVar,x
	cmp #$01
	bne .2
	lda <$04
	bpl .done
	lda <$00
	beq .done
	lda #$00
	sta aObjVXlo,x
	inc aEnemyVar,x
	lda #$3E
	sta aObjVar,x
	lda #$03
	sta aObjFrame,x
	bne .done
.2
	lda aObjVar,x
	bne .done
	jsr FaceTowards
	lda #$18
	jsr CreateEnemyHere
	bcs .overflow
	lda <zObjIndex
	pha
	tya
	clc
	adc #$10
	tax
	stx <zObjIndex
	lda #$02
	sta <$09
	lda #$0C
	sta <$08
	jsr SetVelocityAtRockman
	pla
	sta <zObjIndex
	tax
.overflow
	lda #$3E
	sta aObjVar,x
	inc aEnemyVar,x
	lda aEnemyVar,x
	cmp #$05
	bne .done
	lda #$00
	sta aEnemyVar,x
.done
	dec aObjVar,x
	ldy aEnemyVar,x
	lda aObjFrame,x
	cmp .waitframes,y
	bne .move
	lda #$00
	sta aObjWait,x
.move
	mJSR_NORTS MoveEnemy
.waitframes
	.db $00, $02, $00, $00, $00

;9FD1
;フレンダー出現
EN19:
.life_prev = $660
	ldy #$02
	lda aObjLife,x
	bne .dead
	jmp .die
.dead
	cmp .life_prev,x
	beq .nohit
	ldy #$05
.nohit
	sta .life_prev,x
	ldx #$0F
.looplife
	lda EN19_Palette,y
	sta aPalette,x
	dey
	dex
	cpx #$0C
	bne .looplife
	ldx <zObjIndex
	lda aObjVXlo,x
	bne .skip
	lda #$01
	sta aObjFrame,x
	
	lda #$00
;	.db $A9
;	mBEGINRAW #$1D, #$A000 ;*******************************
;	.db $00

;EN19_BEGIN_A000:
	sta aObjWait,x
	lda aObjVar,x
	bne .1
	lda #$1B
	jsr CreateEnemyHere
	bcs .overflow
	clc
	lda aObjY10,y
	adc #$0C
	sta aObjY10,y
.overflow
	lda #$02
	sta aObjVar,x
	dec aObjVX,x
	bne .done
	inc aObjVXlo,x
	bne .done
.1
	dec aObjVar,x
.skip
	lda aObjFrame,x
	bne .done
	lda #$00
	sta aObjVXlo,x
	lda #$03
	sta aObjVX,x
	lda <zRand
	and #$03
	beq .done
	asl aObjVX,x
	and #$01
	bne .done
	clc
	lda aObjVX,x
	adc #$03
	sta aObjVX,x
.done
	jsr CheckOffscreenEnemy
	bcc .rts
	lda #%10000000
	sta aObjFlags,x
	lda #$19
	sta aObjAnim,x
	lda #$00
	sta aObjVar,x
	sta aObjVXlo,x
	sta aEnemyFlash,x
.rts
	rts

;A06B
.die:
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	lda aObjVXlo,x
	beq .2
	jmp .skip3
.2
	lda aObjVar,x
	and #$03
	sta <$00
	asl a
	asl a
	adc <$00
	sta <$01
	mPLAYTRACK #$2B
	lda #$05
	sta <$02
.loop
	lda #$06
	jsr CreateEnemyHere
	bcs .overflow2
	ldx <$01
	clc
	lda aObjX10,y
	adc EN19_Destroydx,y
	sta aObjX10,y
	clc
	lda aObjY10,y
	adc EN19_Destroydy,y
	sta aObjY10,y
	inc <$01
	dec <$02
	bne .loop
.overflow2
	ldx <zObjIndex
	inc aObjVar,x
	lda aObjVar,x
	cmp #$08
	bne .skip2
	lda #$1A
	jsr FindObject
	bcs .notfound
	lda #%00000000
	sta aObjFlags10,y
	lda #$FF
	sta aEnemyOrder10,y
.notfound
	lda #$1C
	jsr FindObject
	bcs .loop_wall
	lda #$FF
	sta aObjVar10,y
.loop_wall
	lda #$2E
	jsr FindObject
	bcs .notfound2
	lda #%00000000
	sta aObjFlags10,y
	lda aItemOrder10,y
	pha
	lda #$FF
	sta aItemOrder10,y
	pla
	tay
	lda #$00
	sta aItemLife,y
	beq .loop_wall
.notfound2
	sta aEnemyOrder,x
	asl aObjFlags,x
.skip2
	lda #$08
	sta aObjVXlo,x
.skip3
	dec aObjVXlo,x
	rts
;A108
EN19_Palette:
	.db $08, $2C, $12
	.db $08, $20, $20
;A10E
EN19_Destroydx:
	.db $FC, $FC, $14, $1C, $2C, $F4, $04, $0C
	.db $14, $24, $F4, $04, $14, $2C, $2C, $04
	.db $0C, $14, $24, $24
;A122
EN19_Destroydy:
	.db $F8, $10, $08, $F0, $F8, $00, $E8, $10
	.db $F8, $08, $08, $F8, $00, $E8, $08, $00
	.db $E8, $F8, $F0, $08

;A136
;フレンダーの尻尾
EN1A:
	lda aObjVar,x
	bne .skip
	lda #$6E
	sta aObjVar,x
	lda #$01
	sta aObjFrame,x
.skip
	lda aObjFrame,x
	bne .wait
	sta aObjWait,x
.wait
	dec aObjVar,x
	mJSR_NORTS CheckOffscreenEnemy

;A154
;フレンダーの弾
EN1B:
	clc
	lda aObjVYlo,x
	adc #$40
	sta aObjVYlo,x
	lda aObjVY,x
	adc #$00
	sta aObjVY,x
	mJSR_NORTS MoveEnemy

;A169
;フレンダー本体
EN1C:
	sec
	lda aObjRoom,x
	sbc #$34
	tay
	lda .table_land,y
	cmp aObjY,x
	beq .land
	lda aObjFlags,x
	and #%11011111
	sta aObjFlags,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	mJSR_NORTS MoveEnemy
.land
	lda #$00
	sta aObjVY,x
	jsr CheckOffscreenEnemy
	lda <zPPUHScr
	ora <zPPUVScr
	ora <zPPULinear
	bne .skip_scroll
	lda aObjFrame,x
	pha
	tay
	clc
	lda aObjY,x
	adc .table_bgy,y
	and #$E0
	sta <$0A
	clc
	lda aObjX,x
	adc .table_bgx,y
	and #$E0
	sta <$08
	lda aObjRoom,x
	sta <$09
	jsr SetPPUPos
	jsr SetPPUPos_Attr
	ldy <zPPUSqr
	lda aPPULaserhi
	sta aPPUSqrhi,y
	lda aPPULaserlo
	sta aPPUSqrlo,y
	lda aPPUShutterAttrhi
	sta aPPUSqrAttrhi,y
	lda aPPUShutterAttrlo
	sta aPPUSqrAttrlo,y
	lda #$FF
	sta aPPUSqrAttrData,y
	tya
	asl a
	asl a
	asl a
	asl a
	tay
	pla
	sta <$00
	ldx <zObjIndex
	lda aObjVar,x
	cmp #$FF
	bne .skip
	clc
	lda <$00
	adc #$04
	sta <$00
.skip
	lda <$00
	asl a
	asl a
	asl a
	asl a
	tax
	lda #$10
	sta <$00
.loop
	lda .table_data,x
	sta aPPUSqrData,y
	inx
	iny
	dec <$00
	bne .loop
	inc <zPPUSqr
.skip_scroll
	ldx <zObjIndex
	lda aObjFrame,x
	cmp #$03
	bne .rts
	lda aObjVar,x
	bne .rts
	lda #$19
	jsr CreateEnemyHere
	lda #$08
	sta aObjVar10,y
	lda #$03
	sta aObjVX10,y
	lda #$14
	sta aObjYlo,x
	lda <zRand
	and #$03
	beq .velocity
	pha
	lda aObjVX10,y
	asl a
	sta aObjVX10,y
	pla
	and #$01
	bne .velocity
	clc
	lda aObjVX10,y
	adc #$03
	sta aObjVX10,y
.velocity
	lda #$1A
	jsr CreateEnemyHere
	clc
	lda aObjX10,y
	adc #$2F
	sta aObjX10,y
	sec
	lda aObjY10,y
	sbc #$0C
	sta aObjY10,y
	inc aObjVar,x
	lda #%10100000
	sta aObjFlags,x
.rts
	rts
;A269
;フレンダー着地Y座標
.table_land
	.db $88, $68, $48
;A26C
;BG書き込み相対位置Y
.table_bgy
	.db $F0, $00, $F0, $00
;A270
;BG書き込み相対位置X
.table_bgx
	.db $00, $00, $20, $20
;A274
;BG書き込みデータ
.table_data
	.db $88, $8A, $84, $86, $89, $8B, $85, $87, $84, $86, $8C, $8E, $85, $87, $8D, $8F
	.db $84, $86, $74, $76, $85, $87, $75, $77, $90, $92, $94, $96, $91, $93, $95, $97
	.db $84, $86, $84, $86, $85, $87, $85, $87, $6C, $6E, $70, $72, $6D, $6F, $71, $73
	.db $78, $7A, $7C, $7E, $79, $7B, $7D, $7F, $98, $9A, $9C, $9E, $99, $9B, $9D, $9F
	.db $88, $8A, $84, $86, $89, $8B, $85, $87, $84, $86, $84, $86, $85, $87, $85, $87
	.db $84, $86, $84, $86, $85, $87, $85, $87, $84, $86, $84, $86, $85, $87, $85, $87
	.db $84, $86, $84, $86, $85, $87, $85, $87, $84, $86, $84, $86, $85, $87, $85, $87
	.db $84, $86, $84, $86, $85, $87, $85, $87, $84, $86, $84, $86, $85, $87, $85, $87

;A2F4
;モンキング
EN1D:
	jsr FaceTowards
	lda aObjFlags,x
	and #%00100000
	beq .act
	lda <$00
	cmp #$50
	bcc .spawn
	mJSR_NORTS CheckOffscreenEnemy
.spawn
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	lda aObjFlags,x
	and #%11011111
	sta aObjFlags,x
	lda #$04
	sta aObjVY,x
.act
	lda aObjFrame,x
	bne .swing
	lda #$00
	sta aObjWait,x
	lda #$07
	sta <$01
	lda #$01
	sta <$02
	jsr WallCollisionY
	lda <$00
	bne .grab
	jmp .move
.grab
	lda #$00
	sta aObjVY,x
	inc aObjFrame,x
	jmp .move
.swing
	lda aObjFrame,x
	cmp #$02
	bne .dy
	clc
	lda aObjY,x
	adc #$05
	sta aObjY,x
	inc aObjFrame,x
.dy
	lda aObjFrame,x
	cmp #$08
	bcs .stand
	lda <$00
	cmp #$20
	bcc .attack
	inc aObjVar,x
	lda aObjVar,x
	cmp #$7D
	beq .attack
	lda aObjFrame,x
	cmp #$07
	bne .move
	lda #$03
	sta aObjFrame,x
	bne .move
.attack
	sec
	lda aObjY,x
	sbc #$20
	sta aObjY,x
	lda aObjFlags,x
	ora #%00000100
	sta aObjFlags,x
	lda #$02
	sta aObjVar,x
	lda #$08
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	bne .move
.stand
	lda #$08
	sta <$01
	lda #$10
	sta <$02
	jsr WallCollisionY
	lda #$00
	sta aObjWait,x
	lda aObjFrame,x
	cmp #$09
	beq .inair
	dec aObjVar,x
	bne .move
	lda #$03
	sta aObjVY,x
	lda #$76
	sta aObjVYlo,x
	lda #$01
	sta aObjVX,x
	lda #$7B
	sta aObjVXlo,x
	inc aObjFrame,x
	bne .move
.inair
	lda <$00
	beq .move
	lda #$08
	sta aObjFrame,x
	lda #$32
	sta aObjVar,x
	lda #$00
	sta aObjVXlo,x
	sta aObjVX,x
.move
	mJSR_NORTS MoveEnemy

;A3ED
;クック生成
EN1E:
	lda aObjVXlo,x
	bne .do
	lda #$1E
	jsr Spawner_Check
	bcc .do
	rts
.do
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjVar,x
	bne .skip
	lda #$01
	sta <$01
	lda #$1F
	jsr FindObjectsA
	bcs .overflow
	lda #$1F
	jsr CreateEnemyHere
	bcs .overflow
	clc
	lda aObjX10,y
	adc #$78
	sta aObjX10,y
	lda aObjRoom10,y
	adc #$00
	sta aObjRoom10,y
	sec
	lda aObjY
	sbc #$2C
	bcs .y
	lda #$08
.y
	sta aObjY10,y
	ldx <zObjIndex
.overflow
	lda #$1F
	sta aObjVar,x
.skip
	dec aObjVar,x
	rts

;A446
;クック
EN1F:
	lda #$08
	sta <$01
	lda #$14
	sta <$02
	jsr WallCollisionY
	lda <$00
	beq .inair
	lda aObjVar,x
	cmp #$13
	bne .skip
	lda #$04
	sta aObjVY,x
	lda #$78
	sta aObjVYlo,x
	lda #$00
	sta aObjVar,x
.skip
	inc aObjVar,x
	bne .move
.inair
	lda #$02
	sta aObjFrame,x
	lda #$03
	sta aObjWait,x
.move
	mJSR_NORTS MoveEnemy

;A47E
;クック生成器削除
EN20:
	lda #$1E
	sta <$00
	jmp EN05_DeleteObjects

;A485
;テリー生成器
EN21:
	lda aObjVar,x
	bne .skip
	lda #$03
	sta <$01
	lda #$22
	jsr FindObjectsA
	bcs .overflow
	lda #$22
	jsr CreateEnemyHere
.overflow
	lda #$DA
	sta aObjVar,x
.skip
	dec aObjVar,x
	mJSR_NORTS CheckOffscreenEnemy

;A4A6
;テリー
EN22:
	lda aObjVar,x
	bne .skip
	lda #$00
	sta <$09
	lda #$42
	sta <$08
	jsr SetVelocityAtRockman
	lda #$10
	sta aObjVar,x
.skip
	dec aObjVar,x
	mJSR_NORTS MoveEnemy

;A4C2
;チャンキーメーカー
EN23:
	lda aObjVXlo,x
	bne .do
	lda #$6E
	sta aObjVar,x
	inc aObjVXlo,x
	lda #%00000000
	sta aObjFlags,x
	lda #$01
	sta <$01
	lda #$23
	jsr FindObjectsA
	lda #%10000011
	sta aObjFlags,x
	bcs .done
	lda #$26
	jsr CreateEnemyHere
	jmp .done
.do
	lda aObjVar,x
	beq .skip
	lda aObjFrame,x
	cmp #$02
	bne .done
	lda #$00
	sta aObjFrame,x
	beq .done
.skip
	lda aObjFrame,x
	cmp #$04
	bne .done2
	lda aObjWait,x
	bne .done2
	jsr FaceTowards
	lda #$24
	jsr CreateEnemyHere
	bcs .overflow
	sec
	lda <zRand
	and #$1F
	sta <zRand
	sec
	lda <$00
	sbc <zRand
	sta <$00
	lda #$00
	asl <$00
	rol a
	asl <$00
	rol a
	asl <$00
	rol a
	sta aObjVX10,y
	lda <$00
	sta aObjVXlo10,y
.overflow
	lda <zRand
	and #$03
	tay
	lda .table_wait,y
	sta aObjVar,x
.done
	dec aObjVar,x
.done2
	jsr CheckOffscreenEnemy
	bcc .rts
	lda #$23
	jsr FindObject
	bcc .rts
	lda #$28
	mJSRJMP CreateEnemyHere
.rts
	rts
.table_wait
	.db $12, $1F, $1F, $3D

;A55A
;パレット変更・暗闇
EN25:
	lda aPalette + 1
	cmp #$0F
	beq EN25_Skip
	lda #$23
	jsr FindObject
	bcc EN25_Skip
	lda #$26
	jsr FindObject
	bcc EN25_Skip
	lda aObjVar,x
	bne EN25_Wait
	lda aObjVXlo,x
EN25_Write:
	asl a
	asl a
	sta <$00
	asl a
	clc
	adc <$00
	tax
	ldy #$00
.loop
	lda Table_EN25PaletteChange,x
	sta aPalette,y
	inx
	iny
	cpy #$0C
	bne .loop
	ldx <zObjIndex
	inc aObjVXlo,x
	lda aObjVXlo,x
	cmp #$04
EN25_Skip:
	bne .done
	lsr aObjFlags,x
	lda #$FF
	sta aEnemyOrder,x
.done
	lda #$08
	sta aObjVar,x
EN25_Wait:
	dec aObjVar,x
	rts

;A5AB
;パレット変更・チャンキー
EN26:
	lda aObjVar,x
	bne EN25_Wait
	clc
	lda aObjVXlo,x
	adc #$03
	bne EN25_Write

;A5B8
;パレット変更・元に戻す
EN27:
	lda aObjVar,x
	bne EN25_Wait
	lda aObjVXlo,x
	eor #$03
	jmp EN25_Write

;A5C5
;パレット変更・チャンキー撃破
EN28:
	lda aObjVar,x
	bne EN25_Wait
	mSEC
	lda aObjVXlo,x
	eor #$03
	clc
	adc #$03
	jmp EN25_Write

;A5D6
;パレット変更テーブル
Table_EN25PaletteChange:
	.db $0F, $2C, $10, $1C, $0F, $37, $27, $07, $0F, $28, $16, $07, $0F, $1C, $00, $0C
	.db $0F, $37, $27, $08, $0F, $17, $06, $08, $0F, $0C, $0C, $0F, $0F, $37, $27, $08
	.db $0F, $07, $07, $08, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
	.db $0F, $16, $07, $08, $0F, $37, $27, $08, $0F, $07, $07, $08, $0F, $26, $16, $06
	.db $0F, $37, $27, $08, $0F, $17, $06, $08, $0F, $36, $26, $16, $0F, $37, $27, $07
	.db $0F, $27, $16, $07

;A62A
;ピエロボット歯車
EN29:
	lda aEnemyVar,x
	bne .do
	inc aObjVar,x
	lda aObjVar,x
	cmp #$3E
	bne .skip
	lda #$2A
	jsr CreateEnemyHere
	bcs .skip
	lda #$08
	sta aObjY10,y
	lda <zObjIndex
	sta aEnemyVar10,y
	tya
	sta aEnemyVar,x
	lda #$00
	sta aObjVar,x
.skip
	mJSR_NORTS CheckOffscreenEnemy
.do
	ldy aEnemyVar,x
	cpy #$FF
	beq .nopierrot
	lda aObjVar,x
	cmp #$04
	bcs .run
	sec
	lda aObjY,x
	sbc aObjY10,y
	cmp #$20
	bcs .skip
	lda #$D4
	sta aObjVYlo10,y
	lda #$02
	sta aObjVY10,y
	inc aObjVar,x
	lda aObjVar,x
	cmp #$04
	bne .skip
	lda #%10000111
	sta aObjFlags,x
.run
	sec
	lda aObjY,x
	sbc #$20
	sta aObjY10,y
	lda aObjX,x
	sta aObjX10,y
	lda aObjRoom,x
	sta aObjRoom10,y
	lda #$00
	sta aObjVY10,y
.nopierrot
	lda #$0F
	sta <$01
	lda #$0E
	sta <$02
	jsr WallCollisionXY
	lda aObjVar,x
	cmp #$04
	bne .skip2
	lda <$00
	beq .skip2
	jsr FaceTowards
	lda #$47
	sta aObjVXlo,x
	lda #$01
	sta aObjVX,x
	inc aObjVar,x
.skip2
	lda <$03
	beq .hitwall
	lda aObjFlags,x
	eor #%01000000
	sta aObjFlags,x
.hitwall
	jsr MoveEnemy
	bcc .rts
	ldy aEnemyVar,x
	cpy #$FF
	beq .rts
	lda #$FF
	sta aEnemyVar10,y
	lda #$D4
	sta aObjVYlo10,y
	lda #$02
	sta aObjVY10,y
.rts
	rts

;A6F1
;ピエロボット
EN2A:
	jsr MoveEnemy
	bcc .rts
	ldy aEnemyVar,x
	cpy #$FF
	beq .rts
	lda #$00
	sta aObjVX,y
	lda #$A3
	sta aObjVXlo,y
	lda #$FF
	sta aEnemyVar,y
.rts
	rts

;A70D
;フライボーイ生成器
EN2B:
	lda aObjVar,x
	bne .wait
	lda #$02
	sta <$01
	lda #$2C
	jsr FindObjectsA
	bcs .skip
	lda #$2C
	jsr CreateEnemyHere
.skip
	lda #$7D
	sta aObjVar,x
.wait
	dec aObjVar,x
	mJSR_NORTS CheckOffscreenEnemy

;A72E
;フライボーイ
EN2C:
	lda aEnemyVar,x
	bne .inc
	inc aEnemyVar,x
.inc
	lda aEnemyVar,x
	cmp #$02
	bcs .skip
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	lda #$08
	sta <$01
	lda #$14
	sta <$02
	lda aObjVY,x
	php
	jsr WallCollisionXY
	plp
	bpl .move
	lda <$00
	beq .move
	mPLAYTRACK #$39
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
	sta aObjVX,x
	sta aObjVXlo,x
	lda aObjFlags,x
	and #%11111011
	sta aObjFlags,x
	inc aEnemyVar,x
.skip
	lda aEnemyVar,x
	cmp #$02
	bne .skip2
	lda aObjFrame,x
	cmp #$09
	bne .move
	lda #$E5
	sta aObjVYlo,x
	lda #$47
	sta aObjVar,x
	inc aEnemyVar,x
.skip2
	lda aObjFrame,x
	cmp #$0B
	bne .loopanim
	lda #$09
	sta aObjFrame,x
.loopanim
	dec aObjVar,x
	bne .move
	lda #%10000111
	sta aObjFlags,x
	jsr FaceTowards
	lda #$00
	asl <$00
	rol a
	asl <$00
	rol a
	asl <$00
	rol a
	sta aObjVX,x
	lda <$00
	sta aObjVXlo,x
	lda #$03
	sta aObjVY,x
	lda #$76
	sta aObjVYlo,x
	lda #$01
	sta aEnemyVar,x
.move
	mJSR_NORTS MoveEnemy

;A7D3
;シャッター壁
EN2F:
	lda #$0F
	bne Obj_BreakableWall
;A7D7
;破壊可能壁、フレンダー壁
EN2D:
EN2E:
EN57:
	lda #$08
Obj_BreakableWall:
	sta aObjVar,x
	lda aObjX,x
	and aObjBlockW,x
	sta aObjBlockX,x
	lda aObjY,x
	and aObjBlockH,x
	sta aObjBlockY,x
	mJSR_NORTS CheckOffscreenItem

;A7F2
;プレス
EN30:
	lda aEnemyVar,x
	bne .fall
	jsr FaceTowards
	lda <$00
	cmp #$28
	bcs .far
	lda #%10000111
	sta aObjFlags,x
	lda #$FF
	sta aObjVY,x
	lda #$C0
	sta aObjVYlo,x
	inc aEnemyVar,x
.far
	mJSR_NORTS CheckOffscreenEnemy
.fall
	lda #$08
	sta <$01
	sta <$02
	jsr WallCollisionY
	lda aEnemyVar,x
	cmp #$02
	bcs .reel
	lda <$00
	beq .move
	mPLAYTRACK #$21
	lda #$2B
	sta aObjVar,x
	inc aEnemyVar,x
	lda #$52
	jsr CreateEnemyHere
	sec
	lda aObjY10,y
	sbc #$28
	sta aObjY10,y
	lda #$2B
	sta aObjVar10,y
	bne .move
.reel
	lda aObjVar,x
	beq .wait
	dec aObjVar,x
	bne .move
	lda #$00
	sta aObjVY,x
	lda #$62
	sta aObjVYlo,x
	lda #%10000011
	sta aObjFlags,x
	bne .move
.wait
	lda <$00
	beq .move
	lda #$00
	sta aObjVYlo,x
	sta aEnemyVar,x
.move
	mJSR_NORTS MoveEnemy

;A877
;ブロッキーの処理の一部, 被弾時
EN31_Part:
	lda #$07
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionXY
	lda aObjFrame,x
	cmp #$0F
	bne .loopanim
	lda #$0E
	sta aObjFrame,x
.loopanim
	lda aObjVar,x
	beq .skip
	dec aObjVar,x
	bne .skip
	lda #$02
	sta <$01
.loop
	lda #$33
	jsr CreateEnemyHere
	bcs .overflow
	lda #$E0
	sta aObjY10,y
	lda #%10101000
	sta aObjFlags10,y
	ldx <$01
	lda Table_EN31PartsWait,x
	sta aObjVar10,y
	ldx <zObjIndex
	txa
	sta aEnemyVar10,y
	dec <$01
	bpl .loop
.overflow
	ldx <zObjIndex
.skip
	lda aEnemyVar,x
	cmp #$04
	bne .move
	sec
	lda aObjY,x
	sbc #$20
	sta aObjY,x
	lda #%10000111
	sta aObjFlags,x
	lda #$41
	sta aObjVXlo,x
	lda #$00
	sta aObjWait,x
	sta aObjFrame,x
	sta aEnemyVar,x
.move
	mJSR_NORTS MoveEnemy

;A8EA
;ブロッキー
EN31:
	lda aEnemyVar,x
	bne .skip
	lda #$32
	jsr CreateEnemyHere
	txa
	sta aObjVar10,y
	inc aEnemyVar,x
.skip
	lda aObjFlags,x
	and #%00001000
	beq .part
	jmp EN31_Part

;A905
;ブロッキーの処理の一部, うねうね
.part:
	lda #$07
	sta <$01
	lda #$28
	sta <$02
	sec
	lda aObjX,x
	sbc #$07
	sta <$08
	lda aObjRoom,x
	sbc #$00
	sta <$09
	clc
	lda #$00
	sta <$0B
	lda aObjY,x
	adc #$20
	sta <$0A
	jsr PickupMap
	ldx <zObjIndex
	ldy <$00
	beq .nohitwall
	lda <$08
	and #$0F
	eor #$0F
	sec
	adc aObjX,x
	sta aObjX,x
	lda aObjRoom,x
	adc #$00
	sta aObjRoom,x
.nohitwall
	jsr WallCollisionY
	lda aObjFrame,x
	cmp #$0C
	bne .loopanim
	lda #$00
	sta aObjFrame,x
.loopanim
	jsr MoveEnemy
	bcs .rts
	lda aEnemyFlash,x
	beq .rts
	lda #$0D
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	sta aObjVXlo,x
	sta aObjVX,x
	lda #$7E
	sta aObjVar,x
	jsr FaceTowards
	lda #$02
	sta <$01
.loop
	lda #$33
	jsr CreateEnemyHere
	bcs .overflow
	ldx <$01
	clc
	lda aObjY10,y
	adc .dy,x
	sta aObjY10,y
	lda .vx,x
	sta aObjVX10,y
	lda .vxlo,x
	sta aObjVXlo10,y
	lda #$04
	sta aObjVY10,y
	lda #$00
	sta aObjVYlo10,y
	lda #$FF
	sta aEnemyVar10,y
	ldx <zObjIndex
	dec <$01
	bpl .loop
.overflow
	ldx <zObjIndex
	lda #%10001111
	sta aObjFlags,x
.rts
	rts
.dy
	.db $F0, $10, $20
.vx
	.db $03, $02, $01
.vxlo
	.db $00, $40, $00
Table_EN31PartsWait:
	.db $01, $06, $0B

;A9C3
;ブロッキーの判定部分
EN32:
	ldy aObjVar,x
	lda aObjFlags,y
	bpl .del
	and #$08
	beq .do
.del
	lsr aObjFlags,x
	rts
.do
	lda aObjX,y
	sta aObjX,x
	lda aObjRoom,y
	sta aObjRoom,x
	clc
	lda aObjY,y
	adc #$08
	sta aObjY,x
	mJSR_NORTS CheckOffscreenEnemy

;A9EC
;崩れたブロッキー
EN33:
	ldy aEnemyVar,x
	bpl .skip
	lda #$07
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionXY
	lda <$00
	beq .move
	lda aObjVar,x
	beq .do
	lda #$00
	sta <zObjItemFlag
	jmp CheckOffscreenEnemy_Break
.do
	lda #$00
	sta aObjVXlo,x
	sta aObjVX,x
	sta aObjVYlo,x
	lda #$02
	sta aObjVY,x
	inc aObjVar,x
	bne .move
.skip
	lda aObjVar,x
	beq .skip2
	dec aObjVar,x
	bne .move
	lda #%10001011
	sta aObjFlags,x
	lda #$04
	sta aObjVY,x
.skip2
	lda aObjY,x
	cmp aObjY,y
	bcs .move
	clc
	lda aEnemyVar,y
	adc #$01
	sta aEnemyVar,y
	lsr aObjFlags,x
	rts
.move
	mJSR_NORTS MoveEnemy

;AA4E
;ネオメットール
EN34:
	lda <zStage
	cmp #$0A
	bne .normal
	jmp .guts
.normal
	ldy #$08
	lda aObjFrame,x
	cmp #$03
	bcc .guard
	ldy #$10
.guard
	sty <$02
	lda #$07
	sta <$01
	jsr WallCollisionXY
	lda aEnemyVar,x
	bne .skip
	jsr FaceTowards
	lda <$00
	cmp #$40
	bcs .far
	lda aObjVar,x
	bne .wait
	inc aObjFrame,x
	inc aEnemyVar,x
	lda aObjFlags,x
	and #%11110111
	sta aObjFlags,x
	lda #$3E
	sta aObjVar,x
	bne .movejmp
.wait
	dec aObjVar,x
.far
	lda #$00
	sta aObjWait,x
	sta aObjFrame,x
.movejmp
	jmp .move
.skip
	cmp #$02
	bcs .skip2
	lda aObjFrame,x
	cmp #$02
	bne .wait2
	mPLAYTRACK #$25
	lda #$02
	sta <$01
.loop
	lda #$35
	jsr CreateEnemyHere
	bcs .overflow
	ldx <$01
	lda .vylo,x
	sta aObjVYlo10,y
	lda .vy,x
	sta aObjVY10,y
	lda .vxlo,x
	sta aObjVXlo10,y
	lda .vx,x
	sta aObjVX10,y
	ldx <zObjIndex
	dec <$01
	bpl .loop
.overflow
	lda #$03
	sta aObjFrame,x
	sec
	lda aObjY,x
	sbc #$08
	sta aObjY,x
.wait2
	dec aObjVar,x
	bne .skip3
	jsr FaceTowards
	lda #$02
	sta aObjVX,x
	lda #$14
	sta aObjVar,x
	inc aEnemyVar,x
	bne .skip3
.skip2
	dec aObjVar,x
	bne .skip3
	lda #$00
	sta aObjVX,x
	sta aObjFrame,x
	sta aEnemyVar,x
	lda <zRand
	and #$03
	tay
	lda .delay,y
	sta aObjVar,x
	lda aObjFlags,x
	ora #%00001000
	sta aObjFlags,x
.skip3
	lda aObjFrame,x
	cmp #$05
	bne .move
	lda #$03
	sta aObjFrame,x
.move
	mJSR_NORTS MoveEnemy
.delay
	.db $1F, $3E, $9B, $1F
.vylo
	.db $25, $00, $DB
.vy
	.db $01, $00, $FE
.vxlo
	.db $A3, $00, $A3
.vx
	.db $01, $02, $01

;AB44
;ネオメットール(ガッツタンクから発射)
.guts
	lda aObjVar,x
	bne .skip_guts
	lda aObjY,x
	cmp #$80
	bcc .done
	inc aObjVar,x
	lda #$03
	sta aObjVY,x
.skip_guts
	lda #$08
	sta <$01
	lda #$10
	sta <$02
	jsr WallCollisionY
	lda <$00
	beq .done
	lda #$FF
	sta aObjVY,x
	lda #$01
	sta aObjVX,x
	lda #$00
	sta aObjVYlo,x
	sta aObjVXlo,x
.done
	lda aObjFrame,x
	cmp #$05
	bne .loopanim
	lda #$03
	sta aObjFrame,x
.loopanim
	mJSR_NORTS MoveEnemy

;AB89
;マタサブロー
EN36:
	sec
	lda <zRScreenX
	sbc <zEScreenX
	bcs .end
	lda #$01
	sta <zWindFlag
	lda #$00
	sta <zWindVec
	lda #$A3
	sta <zWindlo
	lda #$00
	sta <zWindhi
.end
	mJSR_NORTS CheckOffscreenEnemy

;ABA4
;ピピ生成器
EN37:
	lda aObjVXlo,x
	bne .do
	lda #$37
	jsr Spawner_Check
	bcc .do
	rts
.do
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjVar,x
	bne .wait
	lda #$BB
	sta aObjVar,x
	lda #$01
	sta <$01
	lda #$38
	jsr FindObjectsA
	bcs .wait
	lda #$02
	sta <$01
	lda #$3C
	jsr FindObjectsA
	bcs .wait
	lda #$38
	jsr CreateEnemyHere
	bcs .wait
	ldx #$00
	lda aObjFlags
	and #%01000000
	bne .right
	inx
.right
	lda .flags,x
	sta aObjFlags10,y
	clc
	lda <zHScroll
	adc .d,x
	sta aObjX10,y
	lda <zRoom
	adc #$00
	sta aObjRoom10,y
.wait
	ldx <zObjIndex
	dec aObjVar,x
	rts
.d
	.db $F8, $08
.flags
	.db %10000011, %11000011

;AC0E
;ピピの処理一部
EN38_Delete:
	lsr aObjFlags,x
	rts
;AC12
;ピピ
EN38:
	lda aEnemyVar,x
	bne .eggexists
	lda #$3A
	jsr CreateEnemyHere
	bcs EN38_Delete
	txa
	sta aEnemyVar10,y
	iny
	tya
	sta aEnemyVar,x
.eggexists
	lda aObjVar,x
	bne .doanim
	lda aObjFlags,x
	pha
	jsr FaceTowards
	pla
	sta aObjFlags,x
	ldy aEnemyVar,x
	dey
	clc
	lda aObjY,x
	adc #$10
	sta aObjY10,y
	lda aObjX,x
	sta aObjX10,y
	lda aObjRoom,x
	sta aObjRoom10,y
	lda <$00
	cmp #$30
	bcc .near
	lda aObjFrame,x
	cmp #$02
	bne .move
	lda #$00
	sta aObjFrame,x
	beq .move
.near
	lda #%10000111
	sta aObjFlags10,y
	inc aObjVar,x
	lda #$02
	sta aObjFrame,x
	sta aObjWait,x
.doanim
	lda aObjFrame,x
	cmp #$03
	bne .move
	lda #$00
	sta aObjWait,x
.move
	jsr MoveEnemy
	bcc .rts
	ldy aEnemyVar,x
	dey
	lda #$00
	sta aObjFlags10,y
.rts
	rts

;AC8F
;ピピ生成器削除
EN39:
	lda #$37
	sta <$00
	jmp EN05_DeleteObjects

;AC96
;ピピの卵
EN3A:
	lda aObjFlags,x
	and #%00000100
	bne .fall
	mJSR_NORTS CheckOffscreenEnemy
.fall
	lda #$07
	sta <$01
	sta <$02
	jsr WallCollisionY
	lda <$00
	bne .explode
	jsr MoveEnemy
	lda <$01
	bne .explode
	rts
.explode ;卵が破裂
	lda #$3B
	jsr CreateEnemyHere ;殻を2つ生成
	lda #$3B
	jsr CreateEnemyHere
	lda #%11000100
	sta aObjFlags10,y
	lda #$07
	sta <$01
.loop
	lda #$3C
	jsr CreateEnemyHere
	bcs .overflow
	ldx <$01
	lda .flags,x
	sta aObjFlags10,y
	lda .vylo,x
	sta aObjVYlo10,y
	lda .vy,x
	sta aObjVY10,y
	lda .vxlo,x
	sta aObjVXlo10,y
	lda .vx,x
	sta aObjVX10,y
	lda .var,x
	sta aObjVar10,y
	ldx <zObjIndex
	dec <$01
	bpl .loop
.overflow
	lsr aObjFlags,x
	rts
.flags
	.db $C3, $C3, $C3, $C3, $C3, $83, $83, $83
.vylo
	.db $96, $7B, $1E, $6A, $F0, $00, $E6, $9E
.vy
	.db $FE, $00, $01, $01, $01, $02, $01, $00
.vxlo
	.db $6A, $F0, $A8, $6A, $7B, $00, $9E, $E6
.vx
	.db $01, $01, $01, $01, $00, $00, $00, $01
.var
	.db $0B, $21, $1C, $0B, $21, $10, $19, $19

;AD30
;子ピピ
EN3C:
	lda aEnemyVar,x
	bne .move
	dec aObjVar,x
	bne .move
	lda #$47
	sta <$08
	lda #$01
	sta <$09
	jsr SetVelocityAtRockman
	inc aEnemyVar,x
.move
	mJSR_NORTS MoveEnemy

;AD4C
;カミナリゴロー
EN3D:
	ldy aEnemyVar,x
	lda aObjFlags,y
	bpl .del
	lda aObjAnim,y
	cmp #$3E
	bne .del
	sec
	lda aObjY,y
	sbc #$14
	sta aObjY,x
	lda aObjX,y
	sta aObjX,x
	lda aObjRoom,y
	sta aObjRoom,x
	jsr FaceTowards
	inc aObjVar,x
	lda aObjVar,x
	cmp #$9D
	bne .skip
	lda #$3F
	jsr CreateEnemyHere
	lda #$03
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	sta aObjVar,x
.skip
	lda aObjFrame,x
	cmp #$02
	bne .loopanim
	lda #$00
	sta aObjFrame,x
.loopanim
	mJSR_NORTS MoveEnemy
.del
	lsr aObjFlags,x
	rts

;ADA3
;カミナリゴローの雲
EN3E:
	lda #$18
	sta aPlatformWidth,x
	lda aObjVXlo,x
	ora aObjVYlo,x
	bne .skip
	lda #$3D
	jsr CreateEnemyHere
	bcs .skip
	txa
	sta aEnemyVar10,y
	sec
	lda aObjY,x
	sbc #$14
	sta aObjY10,y
.skip
	lda aObjVar,x
	bne .move
	lda aEnemyVar,x
	and #$0F
	tay
	clc
	adc #$01
	sta aEnemyVar,x
	lda .vylo,y
	sta aObjVYlo,x
	lda .vy,y
	sta aObjVY,x
	lda .vxlo,y
	sta aObjVXlo,x
	lda .vector,y
	sta aObjFlags,x
	lda #$2A
	sta aObjVar,x
.move
	dec aObjVar,x
	jsr MoveEnemy
	bcc .del
	lda #$00
	sta aPlatformWidth,x
.del
	sec
	lda aObjY,x
	sbc #$08
	sta aPlatformY,x
	rts
.vylo
	.db $00, $CE, $A4, $87, $75, $87, $A4, $CE, $00, $32, $5C, $79, $8B, $79, $5C, $32
.vy
	.db $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
.vxlo
	.db $8B, $79, $5C, $32, $00, $32, $5C, $79, $8B, $79, $5C, $32, $00, $32, $5C, $79
.vector
	.db $80, $80, $80, $80, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $80, $80, $80, $80

;AE49
;ゴブリン
EN40:
EN41:
	jsr FaceTowards
	sec
	lda aObjAnim,x
	sbc #$40
	tay
	lda Goblin_Palette_Delta,y
	sta <$01
	lda aObjFlags,x
	and #%00100000
	beq .hidden
	ldy <$01
	lda #$15
	cmp aPalette + 2,y
	bne .changepalette
	lda #$04
	sta aObjVXlo,x
	bne .skip
.changepalette
	lda <$00
	cmp #$60
	bcs .jmp
.skip
	lda #%10000010
	sta aObjFlags,x
.hidden
	lda aObjVXlo,x
	cmp #$04
	bcs .do
	lda aObjVar,x
	and #$03
	bne .jmp
	sta aObjVar,x
	lda aObjVXlo,x
	inc aObjVXlo,x
	asl a
	asl a
	tay
	ldx <$01
	jsr Goblin_ChangePalette
	ldx <zObjIndex
.jmp
	jmp .done
.do
	lda <$00
	cmp #$28
	bcs .dontspawn
	lda aObjVar,x
	and #$3F
	bne .dontspawn
	lda #$03
	sta <$01
	lda #$45
	jsr FindObjectsA
	bcs .dontspawn
	lda #$45
	jsr CreateEnemyHere
	bcs .dontspawn
	lda aObjVX,x
	and #$01
	tax
	lda MiniGoblin_Vector,x
	sta aObjFlags10,y
	clc
	lda aObjY10,y
	adc #$03
	sta aObjY10,y
	clc
	lda aObjX10,y
	adc Goblin_dx,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc Goblin_dr,x
	sta aObjRoom10,y
	lda #$3F
	sta aObjVar10,y
	ldx <zObjIndex
	inc aObjVX,x
.dontspawn
	lda aObjVYlo,x
	ora aObjVY,x
	bne .waithorn
	lda #$01
	sta <$01
.loop
	lda #$44
	jsr CreateEnemyHere
	bcs .overflow
	lda aObjY10,y
	sbc #$24
	sta aObjY10,y
	ldx <$01
	clc
	lda aObjX10,y
	adc Goblin_dx,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc Goblin_dr,x
	sta aObjRoom10,y
	lda #$78
	sta aObjVar10,y
	ldx <zObjIndex
	dec <$01
	bpl .loop
.overflow
	lda #$48
	sta aObjVYlo,x
	lda #$01
	sta aObjVY,x
.waithorn
	sec
	lda aObjVYlo,x
	sbc #$01
	sta aObjVYlo,x
	lda aObjVY,x
	sbc #$00
	sta aObjVY,x
.done
	inc aObjVar,x
	mJSR_NORTS CheckOffscreenEnemy

;AF4C
Goblin_ChangePalette:
	lda #$03
	sta <$02
.loop_changepalette
	lda .palette,y
	sta aPalette,x
	sta aPaletteOverride,x
;	sta aPaletteAnimBuf,x
;	sta aPaletteAnimBuf + $10,x
;	sta aPaletteAnimBuf + $20,x
;	sta aPaletteAnimBuf + $30,x
	iny
	inx
	dec <$02
	bpl .loop_changepalette
	rts
.palette
	.db $0F, $21, $21, $21
	.db $0F, $31, $35, $21
	.db $0F, $30, $25, $10
	.db $0F, $30, $15, $0F
Goblin_Palette_Delta:
	.db $08, $0C
MiniGoblin_Vector:
	.db $C3, $83
Goblin_dx:
	.db $1D, $E3
Goblin_dr:
	.db $00, $FF

;AF81
;ゴブリンを消す
EN42:
EN43:
	lsr aObjFlags,x
	ldy aItemOrder,x
	lda #$FF
	sta aItemOrder,x
	lda #$00
	sta aItemLife,y
	sec
	lda aObjAnim,x
	sbc #$42
	tay
	ldx Goblin_Palette_Delta,y
	ldy #$00
	mJSR_NORTS Goblin_ChangePalette

;AFA1
;ゴブリンの角
EN44:
	lda aObjVar,x
	bne .wait
	lda aEnemyVar,x
	cmp #$01
	bcs .skip
	lda #$3E
	sta aObjVar,x
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
	inc aEnemyVar,x
	bne .wait
.skip
	bne .del
	lda #$C0
	sta aObjVYlo,x
	lda #$FE
	sta aObjVY,x
	lda #$0B
	sta aObjVar,x
	inc aEnemyVar,x
	bne .wait
.del
	lsr aObjFlags,x
	rts
.wait
	dec aObjVar,x
	mJSR_NORTS MoveEnemy

;AFE0
;プチゴブリン
EN45:
	lda aEnemyVar,x
	cmp #$02
	bne .do
	jmp EN22
.do
	lda aObjVar,x
	bne .wait
	lda aEnemyVar,x
	bne .inc
	lda #$1A
	sta aObjVar,x
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	lda #$03
	sta aObjVY,x
	lda #$33
	sta aObjVYlo,x
	inc aEnemyVar,x
	bne .wait
.inc
	inc aEnemyVar,x
	rts
.wait
	dec aObjVar,x
	mJSR_NORTS MoveEnemy

;B01B
;スプリンガー
EN46:
	lda aEnemyVar,x
	beq .do
	jmp .attacking
.do
	ldy #$00
	sty <$0B
	lda aObjFlags,x
	and #%01000000
	bne .right
	iny
.right
	clc
	lda aObjX,x
	adc .dx,y
	sta <$08
	lda aObjRoom,x
	adc .dr,y
	sta <$09
	clc
	lda aObjY,x
	adc #$09
	sta <$0A
	jsr PickupMap
	ldx <zObjIndex
	lda <$00
	beq .inv_vector
	lda aObjY,x
	sta <$0A
	jsr PickupMap
	ldx <zObjIndex
	lda <$00
	beq .skip
.inv_vector
	lda aObjFlags,x
	eor #%01000000
	sta aObjFlags,x
.skip
	lda #$00
	sta aObjVX,x
	lda #$41
	sta aObjVXlo,x
	sec
	lda aObjY
	sbc aObjY,x
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp #$05
	bcs .end
	lda #$00
	sta aObjVXlo,x
	lda #$02
	sta aObjVX,x
	lda aObjFlags,x
	pha
	jsr FaceTowards
	pla
	sta aObjFlags,x
	lda <$00
	cmp #$11
	bcs .end
	lda #$01
	sta aObjFrame,x
	sec
	lda aObjY,x
	sbc #$08
	sta aObjY,x
	lda #$70
	sta aObjVar,x
	lda aObjFlags,x
	and #%11110111
	sta aObjFlags,x
	inc aEnemyVar,x
	bne .attacking
.end
	lda #$00
	sta aObjFrame,x
	lda #$07
	sta aObjCollision,x
	mJSR_NORTS MoveEnemy
.attacking
	lda aObjFrame,x
	cmp #$05
	bne .loopanim
	lda #$01
	sta aObjFrame,x
.loopanim
	lda #$09
	sta aObjCollision,x
	dec aObjVar,x
	bne .continue
	dec aEnemyVar,x
	lda #$00
	sta aObjFrame,x
	clc
	lda aObjY,x
	adc #$08
	sta aObjY,x
.continue
	mJSR_NORTS CheckOffscreenEnemy
.dx
	.db $08, $F8
.dr
	.db $00, $FF

;B0FA
;モール生成器
EN47:
	lda aObjVXlo,x
	bne .do
	lda #$47
	jsr Spawner_Check
	bcc .do
	rts
.do
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjVar,x
	bne .wait
	lda #$3E
	sta aObjVar,x
	lda #$06
	sta <$01
	lda #$48
	jsr FindObjectsA
	lda #$49
	jsr FindObjectsA
	bcs .wait
	lda aObjVX,x
	asl a
	sta <$01
	lda #$02
	sta <$02
.loop
	ldy <$01
	lda .objlist,y
	jsr CreateEnemyHere
	bcs .wait
	ldx <$01
	clc
	lda aObjX10,y
	adc .dx,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc #$00
	sta aObjRoom10,y
	lda .y,x
	sta aObjY10,y
	ldx <zObjIndex
	inc <$01
	dec <$02
	bne .loop
	inc aObjVX,x
	lda aObjVX,x
	cmp #$03
	bne .wait
	lda #$00
	sta aObjVX,x
.wait
	ldx <zObjIndex
	dec aObjVar,x
	rts

.objlist
	.db $49, $48, $49, $48, $49, $48
.dx
	.db $18, $58, $50, $20, $28, $60
.y
	.db $10, $D0, $10, $D0, $10, $D0

;B18A
;モール上
EN48:
	lda #$00
	sta <$01
	sec
	lda aObjY,x
	sbc #$0C
	jmp EN49_Do

;B197
;モール下
EN49:
	lda #$04
	sta <$01
	clc
	lda aObjY,x
	adc #$0C
EN49_Do:
	sta <$0A
	lda #$00
	sta <$0B
	lda aObjX,x
	sta <$08
	lda aObjRoom,x
	sta <$09
	jsr PickupMap
	ldx <zObjIndex
	lda aEnemyVar,x
	bne .skip
	lda <$00
	bne .move
	ldy <$01
	lda .vylo,y
	sta aObjVYlo,x
	lda .vy,y
	sta aObjVY,x
	inc aEnemyVar,x
	lda #$4B
	sta aObjVar,x
	bne .move
.skip
	ldy <$01
	lda aObjVar,x
	beq .do
	dec aObjVar,x
	bne .skip2
.do
	lda .vylo + 1,y
	sta aObjVYlo,x
	lda .vy + 1,y
	sta aObjVY,x
.skip2
	lda <$00
	beq .move
	lda .vylo,y
	sta aObjVYlo,x
	lda .vy,y
	sta aObjVY,x
.move
	mJSR_NORTS MoveEnemy

.vylo
	.db $41, $E5
.vy
	.db $00, 00
.vylo_down
	.db $BF, $1B
.vy_down
	.db $FF, $FF

;B20B
;モール生成器削除
EN4A:
	lda #$47
	sta <$00
	jmp EN05_DeleteObjects

;B212
;ショットマン左右
EN4B:
EN4C:
	lda aEnemyVar,x
	beq .do
	lda aObjFrame,x
	cmp #$05
	bne .jmp_end
	lda #$00
	sta aObjWait,x
	lda aObjVar,x
	bne .wait2
	lda #$00
	sta <$01
	jsr .shotman_shoot
	dec aObjVXlo,x
	beq .wait1
	lda #$1F
	sta aObjVar,x
	bne .wait2
.wait1
	dec aEnemyVar,x
.jmp_end
	jmp .end
.do
	lda aObjFrame,x
	bne .end
	lda #$00
	sta aObjWait,x
	lda aObjVar,x
	bne .wait2
	lda #$0A
	sta <$01
	jsr .shotman_shoot
	inc aObjVXlo,x
	lda aObjVXlo,x
	cmp #$06
	bne .continue_shoot
	inc aEnemyVar,x
	bne .end
.continue_shoot
	lda #$1F
	sta aObjVar,x
.wait2
	dec aObjVar,x
.end
	mJSR_NORTS CheckOffscreenEnemy
.shotman_shoot
	ldx <$01
	lda <zRand
	and .table_shotman1,x
	clc
	adc .table_shotman1 + 1,x
	sta <$0B
	lda .table_shotman1 + 2,x
	sta <$0D
	lda #$00
	sta <$0A
	sta <$0C
	jsr Divide
	ldx <zObjIndex
	mPLAYTRACK #$25
	lda #$4D
	jsr CreateEnemyHere
	bcs .skip
	ldx <$01
	lda .table_shotman1 + 3,x
	sta aObjVYlo10,y
	lda .table_shotman1 + 4,x
	sta aObjVY10,y
	lda <$0E
	sta aObjVXlo10,y
	lda <$0F
	sta aObjVX10,y
	sec
	lda aObjY10,y
	sbc .table_shotman1 + 5,x
	sta aObjY10,y
	lda aObjFlags10,y
	and #%01000000
	bne .right
	inx
	inx
.right
	clc
	lda aObjX10,y
	adc .table_shotman1 + 6,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc .table_shotman1 + 7,x
	sta aObjRoom10,y
.skip
	ldx <zObjIndex
	rts
;B2DC
;ショットマンの射撃データ
;乱数とAND演算、その後に足す値、割る値下位、縦速度下位、縦速度上位、縦の位置補正
;右の位置補正下位上位、左の位置補正
.table_shotman1
	.db $23, $18, $30, $E6, $04, $0C, $0C, $00, $F4, $FF
;B2E6
;X = $01 = #$0Aの時
.table_shotman2
	.db $1F, $60, $18, $D4, $02, $00, $08, $00, $F8, $FF

;B2F0
;スナイパーアーマー
EN4E:
	lda aEnemyVar,x
	bne .1
	lda aObjVar,x
	bne .wait1
	lda aObjFrame,x
	cmp #$02
	bne .move1
	lda #%10000111
	sta aObjFlags,x
	jsr FaceTowards
	lda #$78
	sta aObjVYlo,x
	lda #$04
	sta aObjVY,x
	lda #$C9
	sta aObjVXlo,x
	lda #$01
	sta aObjVX,x
	inc aEnemyVar,x
	bne .move1
.wait1
	lda aObjFrame,x
	bne .waitanim1
	sta aObjWait,x
.waitanim1
	dec aObjVar,x
.move1
	jsr CheckOffscreenEnemy
	bcc .rts1
	jmp .destroyed
.rts1
	rts
.jmp_move2
	jmp .move2
.1
	cmp #$01
	bne .2
	lda #$02
	sta aObjFrame,x
	lda aObjVY,x
	php
	lda #$0F
	sta <$01
	lda #$1C
	sta <$02
	jsr WallCollisionXY
	plp
	bpl .jmp_move2
	lda <$00
	beq .jmp_move2
	mPLAYTRACK #$21
	lda #$03
	sta aObjFrame,x
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjVYlo,x
	sta aObjVY,x
	sta aObjWait,x
	lda aObjFlags,x
	and #%11111011
	sta aObjFlags,x
	lda #$3E
	sta aObjVar,x
	dec aEnemyVar,x
	sec
	lda aObjY
	sbc aObjY,x
	cmp #$10
	bne .wait2
	lda #$12
	sta aObjVar,x
	lda #$02
	sta aEnemyVar,x
	bne .wait2
.2
	lda aObjFrame,x
	bne .waitanim2
	lda #$00
	sta aObjWait,x
.waitanim2
	lda aObjVar,x
	bne .wait2
	mPLAYTRACK #$25
	jsr FaceTowards
	lda #$35
	jsr CreateEnemyHere
	bcs .overflow
	lda aEnemyVar,x
	tax
	lda .vylo - 2,x
	sta aObjVYlo10,y
	lda .vy - 2,x
	sta aObjVY10,y
	lda .vxlo - 2,x
	sta aObjVXlo10,y
	lda .vx - 2,x
	sta aObjVX10,y
.overflow
	txa
	ldx <zObjIndex
	cmp #$06
	bne .continue
	lda #$00
	sta aEnemyVar,x
	lda #$3F
	sta aObjVar,x
	bne .wait2
.continue
	lda #$12
	sta aObjVar,x
	inc aEnemyVar,x
.wait2
	dec aObjVar,x
.move2
	jsr MoveEnemy
	bcc .rts2
	jmp .destroyed
.rts2
	rts
.destroyed ;破壊時の処理
	lda aObjLife,x
	bne .rts2
	lda #$4F
	jsr CreateEnemyHere
	bcs .rts2
	lda #$7E
	sta aObjVar10,y
	rts
.vylo
	.db $6A, $A0, $88, $12, $58
.vy
	.db $FB, $FC, $FD, $FE, $FF
.vxlo
	.db $8C, $4E, $9A, $C2, $D2
.vx
	.db $06, $07, $07, $07, $07

;B421
;スナイパージョー
EN4F:
	jsr FaceTowards
	lda #$00
	sta aObjWait,x
	lda #$0B
	sta <$01
	lda #$0C
	sta <$02
	jsr WallCollisionXY
	lda aObjFrame,x
	bne .shooting
	lda #$00
	sta aObjFrame,x
	lda aObjVar,x
	bne .wait
	inc aObjFrame,x
	lda #$1F
	sta aObjVar,x
	lda aObjFlags,x
	and #%11110111
	sta aObjFlags,x
.shooting
	lda aObjVar,x
	bne .wait
	mPLAYTRACK #$25
	lda #$35
	jsr CreateEnemyHere
	bcs .overflow
	lda #$02
	sta aObjVX10,y
.overflow
	inc aEnemyVar,x
	lda aEnemyVar,x
	cmp #$03
	bne .continue
	lda #$00
	sta aEnemyVar,x
	sta aObjFrame,x
	lda #$7E
	sta aObjVar,x
	lda aObjFlags,x
	ora #%00001000
	sta aObjFlags,x
	bne .wait
.continue
	lda #$1F
	sta aObjVar,x
.wait
	dec aObjVar,x
	mJSR_NORTS MoveEnemy

;B496
;スクワーム生成器
EN50:
	lda aObjVar,x
	bne .wait
	lda #$20
	sta aObjVar,x
	lda #$03
	sta <$01
	lda #$51
	jsr FindObjectsA
	bcs .wait
	jsr FaceTowards
	lda <$00
	cmp #$48
	bcs .wait
	lda #$51
	jsr CreateEnemyHere
	bcs .wait
	sec
	lda aObjY10,y
	sbc #$0C
	sta aObjY10,y
	lda #$1F
	sta aObjVar10,y
.wait
	dec aObjVar,x
	mJSR_NORTS CheckOffscreenEnemy

;B4D0
;スクワーム
EN51:
	lda aEnemyVar,x
	bne .1
	dec aObjVar,x
	bne .loopanim
	lda #%10000111
	sta aObjFlags,x
	jsr FaceTowards
	lda <zRand
	and #$1F
	sta <$01
	sec
	lda <$00
	sbc <$01
	bcs .rand
	lda #$00
.rand
	sta <$00
	lda #$00
	asl <$00
	rol a
	asl <$00
	rol a
	asl <$00
	rol a
	sta aObjVX,x
	lda <$00
	sta aObjVXlo,x
	lda #$04
	sta aObjVY,x
	inc aEnemyVar,x
	bne .loopanim
.1
	cmp #$02
	bcs .2
	lda aObjVY,x
	php
	lda #$05
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionXY
	plp
	bpl .loopanim
	lda <$00
	beq .loopanim
	lda #$5D
	sta aObjVar,x
	inc aEnemyVar,x
	bne .2
.loopanim
	lda aObjFrame,x
	cmp #$0A
	bne .move
	lda #$06
	sta aObjFrame,x
.move
	mJSR_NORTS MoveEnemy
.2
	lda aObjVar,x
	beq .wait
	dec aObjVar,x
	lda aObjFrame,x
	cmp #$0A
	bne .wait
	lda #$06
	sta aObjFrame,x
.wait
	mJSR_NORTS CheckOffscreenEnemy

;B55C
;プレスの鎖判定
EN52:
	dec aObjVar,x
	beq .del
	mJSR_NORTS CheckOffscreenEnemy
.del
	lsr aObjFlags,x
	rts

;B569
;ブーンブロック#1
EN53:
	lda #$7D
	bne EN53_55_Begin
;B56D
;ブーンブロック#2
EN54:
	lda #$BB
	bne EN53_55_Begin
;B571
;ブーンブロック#3
EN55:
	lda #$FA
;B573
;ブーンブロック共有部分
EN53_55_Begin:
.waittimer = $160
	sta <$00
	lda aEnemyVar,x
	bne .initialized
	lda <$00
	sta .waittimer,x
	inc aEnemyVar,x
	bne .wait
.initialized
	cmp #$01
	bne .boom
;消えている時
	lda .waittimer,x
	bne .wait
	lda #%10010000
	sta aObjFlags,x
	mPLAYTRACK #$3C
	lda #$7D
	sta .waittimer,x
	inc aEnemyVar,x
	lda #$00
	sta aObjWait,x
	sta aObjFrame,x
	beq .wait
;現れた時
.boom
	lda aObjFrame,x
	cmp #$05
	bne .loopanim
	lda #$00
	sta aObjWait,x
.loopanim
	lda #$08
	sta aObjVar,x
	lda aObjX,x
	and aObjBlockW,x
	sta aObjBlockX,x
	lda aObjY,x
	and aObjBlockH,x
	sta aObjBlockY,x
	lda .waittimer,x
	bne .wait
	lda #%10100000
	sta aObjFlags,x
	lda #$7D
	sta .waittimer,x
	dec aEnemyVar,x
.wait
	dec .waittimer,x
	mJSR_NORTS CheckOffscreenEnemy

;B5E5
;パレット変更・クラッシュマンステージ
EN56:
	lda <zStage
	cmp #$0C
	beq .bossrush
	lsr aObjFlags,x
	lda #$FF
	sta aEnemyOrder,x
	lda <zStage
	cmp #$0A
	beq .wily3
	sec
	lda aObjRoom,x
	sbc #$0A
	asl a
	asl a
	asl a
	tay
	ldx #$00
.loop
	lda .palette,y
	sta aPalette + 8,x
	iny
	inx
	cpx #$08
	bne .loop
	rts
.wily3
	lda #$0F
	sta aPalette + $0D
	sta aPalette + $0E
	sta aPalette + $0F
	rts
.bossrush
	lda <zStopFlag
	beq .jmp
	mJSR_NORTS CheckOffscreenEnemy
.jmp
	jmp EN65
.palette
	.db $0F, $39, $18, $12, $0F, $39, $18, $01
	.db $0F, $39, $18, $01, $0F, $39, $18, $01
	.db $0F, $39, $18, $01, $0F, $39, $18, $0F

;B641
;
EN58:
	lda aEnemyVar,x
	bne .1
	lda #$03
	sta <$01
	lda #$04
	sta <$02
	jsr WallCollisionXY
	lda <$03
	beq .do
	lsr aObjFlags,x
	rts
.do
	lda <$00
	beq .move
	lda #$04
	sta <$01
.loop
	lda #$58
	jsr CreateEnemyHere
	bcs .overflow
	ldx <$01
	lda .vylo,x
	sta aObjVYlo10,y
	lda .vy,x
	sta aObjVY10,y
	lda #$01
	sta aEnemyVar10,y
	lda #$1F
	sta aObjVar10,y
	ldx <zObjIndex
	dec <$01
	bne .loop
.overflow
	lda #%10000001
	sta aObjFlags,x
	lda #$00
	sta aObjVYlo,x
	sta aObjVY,x
	sta aObjVXlo,x
	sta aObjVX,x
	lda #$1F
	sta aObjVar,x
	inc aEnemyVar,x
.1
	lda aEnemyVar,x
	cmp #$01
	bne .2
	dec aObjVar,x
	bne .move
	clc
	lda aObjVYlo,x
	eor #$FF
	adc #$01
	sta aObjVYlo,x
	lda aObjVY,x
	eor #$FF
	adc #$00
	sta aObjVY,x
	inc aEnemyVar,x
	lda #$1F
	sta aObjVar,x
	bne .move
.2
	dec aObjVar,x
	bne .move
	lsr aObjFlags,x
	rts
.move
	mJSR_NORTS MoveEnemy
.vylo
	.db $00, $41, $82, $C4, $06
.vy
	.db $00, $00, $00, $00, $01

;B6E3
;敵クイックブーメラン
EN59:
	lda aEnemyVar,x
	bne .1
	dec aObjVar,x
	bne .move
	inc aEnemyVar,x
	lda #$1F
	sta aObjVar,x
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjVY,x
	sta aObjVYlo,x
	beq .move
.1
	cmp #$01
	bne .move
	dec aObjVar,x
	bne .move
	inc aEnemyVar,x
	lda #$00
	sta <$08
	lda #$04
	sta <$09
	jsr SetVelocityAtRockman
.move
	mJSR_NORTS MoveEnemy

;B720
;敵バブルリード
EN5B:
	lda aObjVY,x
	php
	lda #$07
	
	.ifdef ___BUGFIXENEMYBUBBLELEAD
	sta <$01
	.else
	sta <$00
	.endif
	
	lda #$08
	sta <$02
	jsr WallCollisionXY
	plp
	bpl .move
	lda <$00
	beq .move
	lda #$03
	sta aObjVY,x
	lda #$76
	sta aObjVYlo,x
.move
	lda <$03
	beq .nohitwall
	lsr aObjFlags,x
.nohitwall
	mJSR_NORTS MoveEnemy

;B74B
;敵エアーシューター
EN5D:
	lda aObjVar,x
	beq .move
	dec aObjVar,x
	bne .move
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjVYlo,x
	sta aObjVY,x
.move
	mJSR_NORTS MoveEnemy

;B767
;敵クラッシュボム
EN5E:
	lda aObjVar,x
	bne .deployed
;飛翔中
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	lda #$07
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionY
	lda <$00
	bne .hit
	jmp .move
.hit
	lda #$00
	sta aObjVXlo,x
	sta aObjVX,x
	sta aObjVYlo,x
	sta aObjVY,x
	inc aObjFrame,x
	mPLAYTRACK #$2E
	lda #$1F
	sta aEnemyVar,x
	inc aObjVar,x
	bne .move
;設置後の処理開始位置
.deployed
	cmp #$01
	bne .explode
;設置直後
	dec aEnemyVar,x
	bne .move
;爆発する瞬間
	inc aObjVar,x
	lda #$38
	sta aEnemyVar,x
;爆発している
.explode
	lda aEnemyVar,x
	and #$07
	bne .wait
	mPLAYTRACK #$2B
	lda aEnemyVar,x
	lsr a
	and #$0C
	sta <$02
	ldx #$04
	sta <$01
;爆発玉配置ループ
.loop
	lda #$5F
	jsr CreateEnemyHere
	bcs .wait
	ldx <$02
	clc
	lda aObjY10,y
	adc CrashBomb_Spawndy,x
	sta aObjY10,y
	clc
	lda aObjX10,y
	adc CrashBomb_Spawndx,x
	sta aObjX10,y
	lda aObjRoom10,y
	adc CrashBomb_Spawndr,x
	sta aObjRoom10,y
	ldx <zObjIndex
	inc <$02
	dec <$01
	bne .loop
.wait
	ldx <zObjIndex
	dec aEnemyVar,x
	bpl .move
	lsr aObjFlags,x
	rts
.move
	lda aObjFrame,x
	cmp #$04
	bne .loopanim
	lda #$02
	sta aObjFrame,x
.loopanim
	mJSR_NORTS MoveEnemy

;B818
;ウッドマンの落ちてくる葉っぱ
EN62:
	lda aObjVar,x
	bne .do
	lda #$00
	sta aObjWait,x
	mJSR_NORTS MoveEnemy
.do
	lda aObjFrame,x
	ora aObjWait,x
	bne .skip
	lda aObjFlags,x
	eor #%01000000
	sta aObjFlags,x
	lda #$FE
	sta aObjVY,x
	lda #$00
	sta aObjVYlo,x
.skip
	clc
	lda aObjVYlo,x
	adc #$20
	sta aObjVYlo,x
	lda aObjVY,x
	adc #$00
	sta aObjVY,x
	mJSR_NORTS MoveEnemy

;B855
;メカドラゴンの足場
EN63:
	lda <zStage
	cmp #$08
	beq .do
	lda #$58
	sta aPlatformWidth,x
	sec
	lda aObjY,x
	sbc #$18
	sta aPlatformY,x
	lda <zStopFlag
	bne .stopping
	jmp EN65
.do
	lda #$10
	sta aPlatformWidth,x
	sec
	lda aObjY,x
	sbc #$08
	sta aPlatformY,x
	lda <zStopFlag
	bne .stopping
	jsr MoveEnemy
	bcc .rts
	lda #$00
	sta aPlatformWidth,x
.rts
	rts
.stopping
	mJSR_NORTS CheckOffscreenEnemy

;B891
;メカドラゴン出現
EN64:
	lda aObjVar,x
	bpl .do
	rts
.do
	bne .1
	lda <zScrollRight
	sta <zScrollLeft
	inc <zScrollNumber
	lda #$07
	sta aObjLife,x
	lda #$08
	sta <zBossType
	lda #$01
	sta <zBossBehaviour
	lda #$17
	sta aPPULinearhi
	lda #$E0
	sta aPPULinearlo
	lda #$00
	sta aObjVar + 1
	sta aObjLife + 1
	sta aBossPtrlo
	sta <zBossVar
	lda #$B8
	sta aBossPtrhi
	lda #$0F
	ldx #$0F
.loop_palette
	sta aPalette,x
	dex
	bpl .loop_palette
	ldx <zObjIndex
	inc aObjVar,x
	lda #$18
	sta aEnemyVar,x
	lda #$63
	sta <$00
	ldy #$0F
.loop_platform
	jsr FindObjectY
	bcs .rts1
	lda #$01
	sta aObjVX10,y
	dey
	bpl .loop_platform
.rts1
	rts
.1
	lda #$01
	sta <zWindFlag
	lda #$00
	sta <zWindVec
	lda #$00
	sta <zWindlo
	lda #$01
	sta <zWindhi
	lda aObjVar,x
	cmp #$01
	bne .2
	dec aEnemyVar,x
	bne .rts2
	lda #$40
	sta aEnemyVar,x
	lda #$63
	jsr CreateEnemyHere
	lda #$01
	sta aObjVX10,y
	sta aObjVar10,y
	dec aObjLife,x
	bne .rts2
	inc aObjVar,x
	rts
.2
	dec aEnemyVar,x
	bne .rts2
	ldy aObjLife,x
	lda .table_wait,y
	sta aEnemyVar,x
	bmi .3
	lda .table_platformy,y
	sta <$02
	lda #$63
	jsr CreateEnemyHere
	lda <$02
	sta aObjY10,y
	lda #$01
	sta aObjVX10,y
	inc aObjLife,x
.rts2
	rts
.3
	lda #$63
	sta <$00
	ldy #$0F
.loop_stopplatform
	jsr FindObjectY
	bcs .endplatform
	lda #$00
	sta aObjVX10,y
	dey
	bpl .loop_stopplatform
.endplatform
	ldx <zObjIndex
	lda #$FF
	sta aObjVar,x
	inc <zBossBehaviour
	lda #$0B
	mJSR_NORTS PlayTrack
.table_wait
	.db $40, $01, $20, $28, $FF
.table_platformy
	.db $98, $98, $48, $78

;B97A
;メカドラゴンの羽
EN65:
	lda aObjVY + 1
	sta aObjVY,x
	lda aObjVYlo + 1
	sta aObjVYlo,x
EN65_GutsHand:
	lda aObjVX + 1
	sta aObjVX,x
	lda aObjVXlo + 1
	sta aObjVXlo,x
	lda aBossVar1
	sta aObjFlags,x
	jsr MoveEnemy
	lda <zBossType
	cmp #$08
	beq .wilyobj
	lda aObjAnim,x
	cmp #$69
	beq .wilyobj
	lda aObjFlags,x
	ora #%00100011
	sta aObjFlags,x
	rts
;メカドラゴンの時と、ガッツタンクの右手の時
.wilyobj
	lda #%10001011
	sta aObjFlags,x
	rts

;B9B7
;メカドラゴンの尻尾
EN66:
	lda #$00
	sta aObjFrame,x
	lda aBossVar1
	and #$40
	beq .skip
	inc aObjFrame,x
.skip
	lda #$00
	sta aObjWait,x
	jmp EN65

;B9CE
;メカドラゴン出現時の縦棒
EN67:
	lda <zStage
	cmp #$08
	beq .do
	jmp EN65
.do
	jsr MoveEnemy
	lda aObjY,x
	cmp #$80
	bne .wait
	lda #$00
	sta aObjVY,x
	lda aObjFrame,x
	ora aObjWait,x
	bne .rts
	inc aObjVar + 1
	lsr aObjFlags,x
.rts
	rts
.wait
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	rts

;B9FE
;ガッツタンクの右手
EN69:
	lda aObjVar,x
	bne .goup
	lda #$80
	sta aObjVYlo,x
	lda #$FF
	sta aObjVY,x
	lda aObjY,x
	cmp #$7F
	bcc .jmp
	bcs .stop
.goup
	lda #$80
	sta aObjVYlo,x
	lda #$00
	sta aObjVY,x
	lda aObjY,x
	cmp #$68
	bcs .jmp
.stop
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
.jmp
	jmp EN65_GutsHand

;BA32
;ピコピコ君
EN6A:
	lda aObjFrame,x
	bne .1
	sta aObjWait,x
	dec aEnemyVar,x
	bne .move1
	lda aObjFlags,x
	and #%01000000
	bne .right
	lsr aObjFlags,x
	rts
.right
	clc
	lda aObjX,x
	adc #$08
	sta aObjX,x
	inc aObjFrame,x
	lda #$01
	sta aPlatformY,x
	lda #$0F
	sta aEnemyVar,x
	bne .1
.move1
	mJSR_NORTS MoveEnemy
.1
	lda aPlatformY,x
	bne .skip
	dec aEnemyVar,x
	beq .2
	lda aObjX,x
	cmp #$30
	bcc .2
	cmp #$D0
	bcs .2
	lda aObjY,x
	cmp #$30
	bcc .2
	cmp #$C0
	bcc .loopanim
.2
	lda #$01
	sta aPlatformY,x
	lda #$3E
	sta aEnemyVar,x
.skip
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjVYlo,x
	sta aObjVY,x
.wait
	dec aEnemyVar,x
	bne .loopanim
	lda #%10000011
	sta aObjFlags,x
	lda #$01
	sta aObjCollision,x
	lda #$00
	sta aPlatformY,x
	ldy aObjVar,x
	lda .table,y
	sta aEnemyVar,x
	lda .vlo,y
	sta <$08
	lda .vhi,y
	sta <$09
	jsr SetVelocityAtRockman
.loopanim
	lda aObjFrame,x
	cmp #$06
	bne .move2
	lda #$04
	sta aObjFrame,x
.move2
	jsr MoveEnemy
	bcc .rts
	sec
	lda aObjLife + 1
	sbc #$02
	sta aObjLife + 1
.rts
	rts

.table
	.db $3E, $1F, $1F, $1F
.vlo
	.db $00, $68, $00, $80
.vhi
	.db $01, $01, $02, $02

;BAEF
;ワイリーマシンの弾
EN6B:
	lda <zBossBehaviour
	cmp #$04
	bcs .bounce
	clc
	lda aObjVYlo,x
	adc #$40
	sta aObjVYlo,x
	lda aObjVY,x
	adc #$00
	sta aObjVY,x
.move
	mJSR_NORTS MoveEnemy
.bounce
	lda #$07
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionY
	lda <$00
	beq .move
	lda #$04
	sta aObjVY,x
	lda #$78
	sta aObjVYlo,x
	bne .move

;BB25
;ブービームトラップ
EN6D:
	sec
	lda aObjVXlo,x
	sbc #$01
	sta aObjVXlo,x
	tay
	lda aObjVX,x
	sbc #$00
	sta aObjVX,x
	bne .loopanim
	cpy #$00
	beq .fire
	cpy #$3E
	bcs .loopanim
;点滅
	lda aObjFrame,x
	cmp #$06
	bne .done
	lda #$04
	bne .sendanim
.fire
	lda #$77
	sta aObjVXlo,x
	lda #$01
	sta aObjVX,x
	lda #$6E
	ldx #$01
	jsr CreateEnemyHere
	bcs .loopanim
	txa
	pha
	tya
	adc #$10
	tax
	stx <zObjIndex
	lda #$08
	sta <$09
	lda #$00
	sta <$08
	jsr SetVelocityAtRockman
	pla
	tax
	stx <zObjIndex
.loopanim
	lda aObjFrame,x
	cmp #$04
	bne .done
	lda #$00
.sendanim
	sta aObjFrame,x
.done
	jsr CheckOffscreenEnemy
	bcc .rts
	sec
	lda aObjLife + 1
	sbc #$06
	sta aObjLife + 1
	bcs .rts
	lda #$00
	sta aObjLife + 1
.rts
	rts

;BB98
;エイリアン戦の背景の白玉
EN70:
	lda #$00
	sta aObjWait,x
	ldy aObjFrame,x
	clc
	lda aObjX,x
	adc .dx,y
	sta aObjX,x
	rts
.dx
	.db $03, $02

;BBAD
;ビッグフィッシュ
EN71:
	jsr FaceTowards
	lda aObjVar,x
	bne .1
	lda <$00
	cmp #$38
	bcs .done
	lda <zRand
	sta <$01
	lda #$03
	sta <$02
	jsr Divide8
	ldy <$04
	ldx <zObjIndex
	lda .table_wait,y
	sta aEnemyVar,x
	inc aObjVar,x
.done
	mJSR_NORTS CheckOffscreenEnemy
.1
	cmp #$02
	bcs .skip
	lda <$00
	cmp #$38
	bcc .wait
	dec aObjVar,x
	beq .done
.wait
	dec aEnemyVar,x
	bne .done
	lda #$02
	sta aObjVY,x
	lda #$00
	sta aObjVYlo,x
	lda #%10000011
	sta aObjFlags,x
	inc aObjVar,x
.skip
	lda aObjVY,x
	bpl .jump
	lda aObjY,x
	cmp #$E0
	bcc .move
	lda #$00
	sta aObjVar,x
	lda #%10100000
	sta aObjFlags,x
	bne .move
.jump
	lda aObjY,x
	cmp #$80
	bcs .move
	lda #$FF
	sta aObjVYlo,x
	sta aObjVY,x
	lda #%10000111
	sta aObjFlags,x
.move
	mJSR_NORTS MoveEnemy
.table_wait
	.db $1F, $2E, $7D

;BC30
;溶解液その1、その2
EN72:
EN73:
	lda aObjVar,x
	cmp #$3E
	bne .wait
	lda aObjFrame,x
	cmp #$05
	bne .done
	lda aObjWait,x
	bne .done
	lda #$74
	jsr CreateEnemyHere
	bcs .overflow
	lda aObjAnim,x
	sta aObjVar10,y
	clc
	lda aObjY10,y
	adc #$04
	sta aObjY10,y
	lda #$FF
	sta aObjVY10,y
	sta aObjVYlo10,y
.overflow
	lda #$00
	sta aObjVar,x
.wait
	inc aObjVar,x
	lda aObjFrame,x
	cmp #$02
	bne .done
	lda #$00
	sta aObjFrame,x
.done
	mJSR_NORTS CheckOffscreenEnemy

;BC79
;溶解液のしずく
EN74:
	lda aObjFrame,x
	beq .do
	mJSR_NORTS CheckOffscreenEnemy
.do
	lda #$00
	sta aObjWait,x
	lda #$03
	sta <$01
	lda #$04
	sta <$02
	jsr WallCollisionY
	lda <$00
	beq .move
	ldy aObjVar,x
	mPLAYTRACK .playsound - $72,y
	inc aObjFrame,x
	rts
.move
	mJSR_NORTS MoveEnemy
.playsound
	.db $3D, $3E

;BCA9
;obj75、体力回復大、武器回復大、E缶、1UP
EN75:
EN76:
EN78:
EN7A:
EN7B:
	lda #$07
	sta <$01
	ldy #$08
	bne Obj_Item_Behaviour
;BCB1
;体力回復小、武器回復小
EN77:
EN79:
	lda #$03
	sta <$01
	ldy #$04
;BCB7
;アイテム処理合流
Obj_Item_Behaviour:
	lda aObjFlags,x
	cmp #%10000001
	beq .stop
	lda <$01
	pha
	tya
	pha
	jsr MoveEnemy
	pla
	sta <$02
	pla
	sta <$01
	lda aObjFlags,x
	bpl .rts
	lda aObjVY,x
	php
	jsr WallCollisionXY
	plp
	bpl .rts
	lda <$00
	beq .rts
	lda #$FA
	sta aEnemyVar,x
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
	lda #%10000001
	sta aObjFlags,x
.rts
	rts
.stop
	lda aObjVar,x
	beq .isitem
	dec aEnemyVar,x
	bne .end
	lsr aObjFlags,x
	rts
.end
	mJSR_NORTS CheckOffscreenEnemy
.isitem
	mJSR_NORTS CheckOffscreenItem

;BD08
;テレポーター
EN7C:
EN7D:
EN7E:
	ldy #$25
	lda <zFrameCounter
	and #$08
	bne .light
	ldy #$0F
.light
	sty aPaletteSpr + $0B
	jsr CheckOffscreenEnemy
	lda <$01
	beq .rts
	txa
	and #$0F
	sta <zBossRushStage
	inc <zBossRushStage
.rts
	rts

;BD24
;空き領域
EN7F:

