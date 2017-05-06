
;20 74 CC
;SpriteSetup
.offset = $06
	mCHANGEBANK #$0A
	jsr ClearSprites ;終了時、X = 0
	stx <.offset ;τDMA元の書き込み位置
	stx <$0D
	stx <$0C
	
;スプライトアニメーションを進める
;zStopFlag = .... WRBE
;W: 武器停止 R: ロックマン停止 B: ボス停止 E: ザコ停止
	ldx #$1F
.loop_anim
	lda aObjFlags,x
	bpl .skip_anim
	ldy aObjAnim,x
	cpx #$10
	bcc .isnotenemy
;Y ≧ 10
	tya
	ora #$80
	tay
	lda <zStopFlag
	and #$01
	bpl .merge_anim
.isnotenemy
;Y < 10
	lda <zStopFlag
	cpx #$01
	beq .isboss
;Y ≠ 1
	bcs .isnotrockman
;Y = 0
	and #$04
	bpl .merge_anim
.isboss ;Y = 1
	and #$02
	bpl .merge_anim
.isnotrockman ;Y > 1
	and #$08
.merge_anim ;ここに合流
	bne .skip_anim
;アニメーション進行
	mMOV Table_AnimationPointer_Low,y, <zPtrlo
	mMOV Table_AnimationPointer_High,y, <zPtrhi
	ldy #$01
	lda [zPtr],y
	inc aObjWait,x
	cmp aObjWait,x
	bcs .skip_anim
	dey
	tya
	sta aObjWait,x
	lda [zPtr],y
	inc aObjFrame,x
	cmp aObjFrame,x
	bcs .skip_anim
	tya
	sta aObjFrame,x
.skip_anim
	dex
	bpl .loop_anim ;X = FF

;スプライトセットアップ(標準時)
.standard
	lda <zFrameCounter
	lsr a
	bcs .oddframe
;スプライトセットアップ標準/偶数フレーム（Obj[00->1F]->ゲージ）
	stx <$0C
	inx
	stx <zObjIndex
.loopobj
	jsr AnimateObjects ;Obj[00->0F] スプライト描画
	bcs .overflow
	inc <zObjIndex
	ldx <zObjIndex
	cpx #$10
	bne .loopobj
.loopenemy
	jsr AnimateEnemies ;Obj[10->1F] スプライト描画
	bcs .overflow
	inc <zObjIndex
	ldx <zObjIndex
	cpx #$20
	bne .loopenemy
	mMOV <.offset, <$0C
	jsr DrawBar ;体力バー描画
.overflow
	jmp .done
;スプライトセットアップ標準/奇数フレーム（ゲージ->Obj[1F->00]）
.oddframe
	jsr DrawBar
	mMOV <.offset, <$0D
	ldx #$1F
	stx <zObjIndex
.loopenemyodd
	jsr AnimateEnemies
	bcs .done
	dec <zObjIndex
	ldx <zObjIndex
	cpx #$0F
	bne .loopenemyodd
.loopobjodd
	jsr AnimateObjects
	bcs .done
	dec <zObjIndex
	ldx <zObjIndex
	bpl .loopobjodd
	mMOV <.offset, <$0C

.done
;エアーマンステージではスプライトが背面に回る→rts
;Sprites[$0D->$0C]を背面に回す
	lda <zStage
	cmp #$01
	bne .notairman
	ldx <$0D
.loop
	cpx <$0C
	beq .notairman
	lda aSpriteAttr,x
	ora #%00100000
	sta aSpriteAttr,x
	inx
	inx
	inx
	inx
	bne .loop
.notairman
	mCHANGEBANK #$0E, 1

;20 F6 CE
;アニメーション処理をしてスプライト描画(X = 10～1F)
AnimateEnemies:
	lda aObjFlags,x
	bpl AnimateObjects.notexist
	and #%00100000
	bne AnimateObjects.notexist
	ldy aObjAnim,x
	mMOV Table_AnimationPointerEnemy_Low,y, <zPtrlo
	mMOV Table_AnimationPointerEnemy_High,y, <zPtrhi
	ldy aObjFrame,x
	iny
	iny
	lda [zPtr],y
	beq AnimateObjects.deleteobject
;4C 3E CF
;DrawEnemySprites;
	tay
	mMOV Table_SpriteEnemyPtrLow,y, <zPtrlo
	mMOV Table_SpriteEnemyPtrHigh,y, <zPtrhi
	lda aEnemyFlash,x
	bpl DrawSprites

;20 E4 CD
;アニメーション処理をしてスプライト描画(X = 00～0F)
AnimateObjects:
	lda aObjFlags,x
	bpl .notexist
	ldy aObjAnim,x
	mMOV Table_AnimationPointer_Low,y, <zPtrlo
	mMOV Table_AnimationPointer_High,y, <zPtrhi
	ldy aObjFrame,x
	iny
	iny
	lda [zPtr],y
	bne DrawObjectSprites
.deleteobject .public
	lsr aObjFlags,x
.notexist .public
	clc
	rts

;4C 2C CE
DrawObjectSprites:
	tay
	cpx #$01
	bcs	.isnotrockman
;X = 0
	lda <zInvincible
	beq .nodmg
	dec <zInvincible ;無敵時間カウンタ減少
;	lda <zFrameCounter
	and #$02
	bne AnimateObjects.notexist
.nodmg
	lda <zOffscreen
	bne AnimateObjects.notexist ;画面外なら描画しない
	beq .draw
.isnotrockman
;X > 0
	bne .draw
;X = 1
	lda aBossInvincible
	beq .draw
	dec aBossInvincible
;	lda <zFrameCounter
	and #$02
	bne .draw
	ldy #$18 ;ボスのトゲトゲエフェクト
.draw
	mMOV Table_SpriteObjPtrLow,y, <zPtrlo
	mMOV Table_SpriteObjPtrHigh,y, <zPtrhi
	lda #$00

;4C 66 CE
DrawSprites:
.x = $00      ;τ画面相対中心X
.y = $01      ;τ画面相対中心Y
.dir = $02    ;τ右向きフラグ
.attr = $03   ;τスプライトの属性データのor値
.n = $04      ;τスプライト数
.offset = $06 ;τ$200 + offset
;.itr = $07    ;τスプライトデータのイテレータ
.shape = $0A  ;τΔ位置データアドレス
.slo = $0A    ;τΔ位置データアドレスlo
.shi = $0B    ;τΔ位置データアドレスhi
	sta <.attr
	
	ldy #$00
	lda [zPtr],y
	sta <.n
	iny
	lda [zPtr],y
	tay
	mMOV Table_SpriteShapePtrLow,y, <.slo
	mMOV Table_SpriteShapePtrHigh,y, <.shi
	sec
	lda aObjX,x
	sbc <zHScroll
	sta <.x
	sec
	lda aObjY,x
	sbc <zVScroll
	bcs .boundary_y ;画面境界を挟んだ場合、-10の補正
	sbc #$0F
.boundary_y
	sta <.y
	lda aObjFlags,x
	and #%01000000
	sta <.dir
	
	ldy #$02
;	sty <.itr ;<.itr = 2
	ldx <.offset
.loop ;スプライト配置ループ
	clc
	lda [.shape],y
	adc <.y
	sta aSpriteY,x ;Spr.Y = Y + dy
	mMOV [zPtr],y, aSpriteNumber,x
	iny
	
	lda <.attr
	beq .jump_attr
	lda [zPtr],y
	and #$F0
	ora <.attr
	bne .write_attr
.jump_attr
	lda [zPtr],y
.write_attr
	eor <.dir
	sta aSpriteAttr,x
	
	lda <.dir
	beq .obj_is_left
	sec
	lda [.shape],y
	eor #$FF
	sbc #$07
	jmp .calc_dx
.obj_is_left
	lda [.shape],y
.calc_dx
	clc
	bmi .sprite_is_left
;dx ≧ 0
	adc <.x
	bcc .write
	bcs .delete
.sprite_is_left
;dx < 0
	adc <.x
	bcs .write
.delete
	mMOV #$F8, aSpriteY,x
	bne .skip
.write
	sta aSpriteX,x
	inx
	inx
	inx
	inx
	stx <.offset
	beq .overflow
.skip
	iny
	dec <.n
	bne .loop
	clc
	rts
.overflow
	sec
	rts

;20 5A CF
;ゲージのスプライトをセットアップ
DrawBar:
.amount = $00 ;ゲージ量
.x = $01      ;X位置
.pal = $02    ;パレット
.offset = $06 ;$200 + offset
;ロックマンの体力バー
	mMOV aObjLife, <.amount
	ldx <.offset
	mMOV #$01, <.pal
	mMOV #$18, <.x
	jsr .draw
	bcs .done
;特殊武器のエネルギー
	ldy <zEquipment
	beq .isbuster
	mMOV zEnergyArray - 1,y, <.amount
	mMOV #$00, <.pal
	mMOV #$10, <.x
	jsr .draw
	bcs .done
.isbuster
;ボスの体力バー
	lda <zBossBehaviour
	beq .done
	mMOV aObjLife + 1, <.amount
	lda #$03
	ldy <zBossType
	cpy #$08
	beq .exception
	cpy #$0D
	bne .skip
.exception
	lsr a ;A = 1
.skip
	sta <.pal
	mMOV #$28, <.x

.draw
	ldy #$06
.loop ;値を4ずつ引いて、スプライトの番号を決めていく
	mMOV Table_BarPositionY,y, aSpriteY,x
	sec
	lda <.amount
	sbc #$04
	bcs .over4
	ldx <.amount
	mSTZ <.amount
	lda Table_BarGraphics,x
	ldx <.offset
	jmp .write ;27
.over4 ;メモリが4以上
	sta <.amount
	lda #$87 ;15
.write
	sta aSpriteNumber,x
	mMOV <.pal, aSpriteAttr,x
	mMOV <.x, aSpriteX,x
	inx
	inx
	inx
	inx
	stx <.offset
	beq .end
	dey
	bpl .loop
	clc
	rts
.end
	sec
.done
	rts

;CFE2
Table_BarPositionY:
	.db $18, $20, $28, $30, $38, $40, $48
;CFE9
Table_BarGraphics:
	.db $8B, $8A, $89, $88


