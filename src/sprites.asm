
;20 74 CC
;SpriteSetup
.offset = $06
	mCHANGEBANK #$0A
	jsr ClearSprites
	lda #$00
	sta <.offset ;��DMA���̏������݈ʒu
	sta <$0D
	sta <$0C
	lda <zStopFlag
	beq .standard
	jmp .stopping

;�X�v���C�g�Z�b�g�A�b�v(�W����)
.standard
	lda <zFrameCounter
	and #$01
	bne .oddframe
;�X�v���C�g�Z�b�g�A�b�v�W��/�����t���[���iObj[00->1F]->�Q�[�W�j
	lda #$FF
	sta <$0C
	lda #$00
	sta <zObjIndex
.loopobj
	jsr AnimateObjects
	bcs .overflow
	inc <zObjIndex
	lda <zObjIndex
	cmp #$10
	bne .loopobj
.loopenemy
	jsr AnimateEnemies
	bcs .overflow
	inc <zObjIndex
	lda <zObjIndex
	cmp #$20
	bne .loopenemy
	lda <.offset
	sta <$0C
	jsr DrawBar
.overflow
	jmp .done
;�X�v���C�g�Z�b�g�A�b�v�W��/��t���[���i�Q�[�W->Obj[1F->00]�j
.oddframe
	jsr DrawBar
	lda <.offset
	sta <$0D
	lda #$1F
	sta <zObjIndex
.loopenemyodd
	jsr AnimateEnemies
	bcs .done
	dec <zObjIndex
	lda <zObjIndex
	cmp #$0F
	bne .loopenemyodd
.loopobjodd
	jsr AnimateObjects
	bcs .done
	dec <zObjIndex
	bpl .loopobjodd
	lda <.offset
	sta <$0C

.done
;�G�A�[�}���X�e�[�W�ł̓X�v���C�g���w�ʂɉ�遨rts
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
	;rts

;4C 02 CD
;�X�v���C�g�Z�b�g�A�b�v(���ꎞ �^�C���X�g�b�p�[�Ȃ�)
;$AA, 04�̃r�b�g��1�Ȃ�A���b�N�}���̃A�j���[�V�����������s��Ȃ�
;$AA, 02�̃r�b�g��1�Ȃ�AObj[00-0F]�̃A�j���[�V�����������s��Ȃ�
;�ǂ̏ꍇ�ł��AObj[10-1F]�̃A�j���[�V�����������s��Ȃ�
.stopping
	lda <zFrameCounter
	and #$01
	bne .odd_stop
;�X�v���C�g�Z�b�g�A�b�v����/�����t���[���iObj[00->1F]->�Q�[�W�j
	lda #$FF
	sta <$0C
	lda #$00
	sta <zObjIndex
	lda <zStopFlag
	and #$04
	beq .dorockman
	jsr DontAnimateObjects
	jmp .skiprockman
.dorockman
	jsr AnimateObjects
.skiprockman
	inc <zObjIndex
.loop_stop
	lda <zStopFlag
	and #$02
	bne .dontobj
	jsr AnimateObjects
	jmp .skipobj
.dontobj
	jsr DontAnimateObjects
.skipobj
	bcs .overflow_stop
	inc <zObjIndex
	lda <zObjIndex
	cmp #$10
	bne .loop_stop
.loop_stop_enemies
	jsr DontAnimateEnemies
	bcs .overflow_stop
	inc <zObjIndex
	lda <zObjIndex
	cmp #$20
	bne .loop_stop_enemies
	lda <.offset
	sta <$0C
	jsr DrawBar
.overflow_stop
	jmp .done
;�X�v���C�g�Z�b�g�A�b�v����/��t���[���i�Q�[�W->Obj[1F->00]�j
.odd_stop
	jsr DrawBar
	lda <.offset
	sta <$0D
	lda #$1F
	sta <zObjIndex
.loop_odd_enemies_stop
	jsr DontAnimateEnemies
	bcs .overflow_stop_odd
	dec <zObjIndex
	lda <zObjIndex
	cmp #$0F
	bne .loop_odd_enemies_stop
.loop_odd_obj_stop
	lda <zStopFlag
	and #$02
	bne .dontobj_odd
	jsr AnimateObjects
	jmp .doneobj_odd
.dontobj_odd
	jsr DontAnimateObjects
.doneobj_odd
	bcs .overflow_stop_odd
	dec <zObjIndex
	bne .loop_odd_obj_stop
	lda <zStopFlag
	and #$04
	beq .dorockman_odd
	jsr DontAnimateObjects
	jmp .donerockman
.dorockman_odd
	jsr AnimateObjects
.donerockman
	lda <.offset
	sta <$0C
.overflow_stop_odd
	jmp .done

;20 94 CD
;�A�j���[�V���������������ɃX�v���C�g�`��(X = 00�`0F)
DontAnimateObjects:
	ldx <zObjIndex
	lda aObjFlags,x
	bmi .do
	clc
	rts
.do
	ldy aObjAnim,x
	lda Table_AnimationPointer_Low,y
	sta <zPtrlo
	lda Table_AnimationPointer_High,y
	sta <zPtrhi
	lda aObjFrame,x
	clc
	adc #$02
	tay
	lda [zPtr],y
	beq .deleteobject
	jmp DrawObjectSprites
.deleteobject
	lsr aObjFlags,x
;	clc ;------added clc
	rts

;20 BC CD
;�A�j���[�V���������������ɃX�v���C�g�`��(X = 10�`1F)
DontAnimateEnemies:
	ldx <zObjIndex
	lda aObjFlags,x
	bmi .do
	clc
	rts
.do
	ldy aObjAnim,x
	lda Table_AnimationPointerEnemy_Low,y
	sta <zPtrlo
	lda Table_AnimationPointerEnemy_High,y
	sta <zPtrhi
	lda aObjFrame,x
	clc
	adc #$02
	tay
	lda [zPtr],y
	beq .deleteobject
	jmp DrawEnemySprites
.deleteobject
	lsr aObjFlags,x
;	clc ;------added clc
	rts

;20 E4 CD
;�A�j���[�V�������������ăX�v���C�g�`��(X = 00�`0F)
AnimateObjects:
	ldx <zObjIndex
	lda aObjFlags,x
	bmi .do
	clc
	rts
.do
	ldy aObjAnim,x
	lda Table_AnimationPointer_Low,y
	sta <zPtrlo
	lda Table_AnimationPointer_High,y
	sta <zPtrhi
	lda aObjFrame,x
	pha
	inc aObjWait,x
	ldy #$01
	lda [zPtr],y
	cmp aObjWait,x
	bcs .skip
	lda #$00
	sta aObjWait,x
	inc aObjFrame,x
	dey
	lda [zPtr],y
	cmp aObjFrame,x
	bcs .skip
	lda #$00
	sta aObjFrame,x
.skip
	pla
	clc
	adc #$02
	tay
	lda [zPtr],y
	bne DrawObjectSprites
	lsr aObjFlags,x
;	clc ;------added clc
	rts

;4C 2C CE
DrawObjectSprites:
.attr = $03
	tay
	cpx #$01
	bcs	.isntrockman
	lda <zInvincible
	beq .rockman
	dec <zInvincible
	lda <zFrameCounter
	and #$02
	beq .rockman
.dontdraw
	jmp DrawObjectSprites_DontDraw
.rockman
	lda <zOffscreen
	bne .dontdraw
	beq .draw
.isntrockman
	bne .draw
	lda aBossInvincible
	beq .draw
	lda <zFrameCounter
	and #$02
	bne .bossnoeffect
	ldy #$18
.bossnoeffect
	dec aBossInvincible
.draw
	lda $8000,y ;-------------SpriteDataLow
	sta <zPtrlo
	lda $8200,y ;-------------SpriteDataHigh
	sta <zPtrhi
	lda #$00
	sta <.attr

;4C 66 CE
DrawSprites:
.x = $00      ;�щ�ʑ��Β��SX
.y = $01      ;�щ�ʑ��Β��SY
.dir = $02    ;�щE�����t���O
.attr = $03   ;��Attr��or�l
.n = $04      ;�уX�v���C�g��
.offset = $06 ;��$200+offset
.itr = $07    ;�уX�v���C�g�f�[�^�̃C�e���[�^
.shape = $0A  ;�у��ʒu�f�[�^�A�h���X
.slo = $0A    ;�у��ʒu�f�[�^�A�h���Xlo
.shi = $0B    ;�у��ʒu�f�[�^�A�h���Xhi
	ldy #$00
	lda [zPtr],y
	sta <.n
	iny
	lda [zPtr],y
	tay
	lda $8400,y ;-------------SpriteShapeLow
	sta <.slo
	lda $8500,y ;-------------SpriteShapeHigh
	sta <.shi
	sec
	lda aObjX,x
	sbc <zHScroll
	sta <.x
	lda aObjRoom,x
	sbc <zRoom
	lda aObjY,x
	sta <.y
	lda aObjFlags,x
	and #%01000000
	sta <.dir

	lda #$02
	sta <.itr
.loop
	ldx <.offset
	ldy <.itr
	lda [zPtr],y
	sta aSpriteNumber,x
	clc
	lda [.shape],y
	adc <.y
	sta aSpriteY,x
	iny
	lda <.attr
	beq .nomodify
	lda [zPtr],y
	and #$F0
	ora <.attr
	bne .jump_attr
.nomodify
	lda [zPtr],y
.jump_attr
	eor <.dir
	sta aSpriteAttr,x
	lda <.dir
	beq .obj_is_left
	lda [.shape],y
	tay
	lda $8600,y ;-------------SpriteInvertX
	jmp .merge
.obj_is_left
	lda [.shape],y
.merge
	clc
	bmi .sprite_is_left
	adc <.x
	bcc .write
	bcs .over
.sprite_is_left
	adc <.x
	bcs .write
.over
	lda #$F8
	sta aSpriteY,x
	bne .skip
.write
	sta aSpriteX,x
	clc
	txa
	adc #$04
	sta <.offset
	beq DrawSprites_sprite_overflow
.skip
	inc <.itr
	inc <.itr
	dec <.n
	bne .loop
DrawObjectSprites_DontDraw:
	clc
	rts
DrawSprites_sprite_overflow:
	sec
	rts


;20 F6 CE
;�A�j���[�V�������������ăX�v���C�g�`��(X = 10�`1F)
AnimateEnemies:
	ldx <zObjIndex
	lda aObjFlags,x
	bmi .do
	clc
	rts
.do
	ldy aObjAnim,x
	lda Table_AnimationPointerEnemy_Low,y
	sta <zPtrlo
	lda Table_AnimationPointerEnemy_High,y
	sta <zPtrhi
	lda aObjFrame,x
	pha
	inc aObjWait,x
	ldy #$01
	lda [zPtr],y
	cmp aObjWait,x
	bcs .skip
	lda #$00
	sta aObjWait,x
	inc aObjFrame,x
	dey
	lda [zPtr],y
	cmp aObjFrame,x
	bcs .skip
	lda #$00
	sta aObjFrame,x
.skip
	pla
	clc
	adc #$02
	tay
	lda [zPtr],y
	bne DrawEnemySprites
	lsr aObjFlags,x
;	clc ;------added clc
	rts

;4C 3E CF
DrawEnemySprites;
.attr = $03
	tay
	lda aObjFlags,x
	and #%00100000
	bne .invisible
	lda $8100,y ;------------------SpriteDataEnemyLow
	sta <zPtrlo
	lda $8300,y ;------------------SpriteDataEnemyHigh
	sta <zPtrhi
	lda aEnemyFlash,x
	sta <.attr
	jmp DrawSprites
.invisible
	clc
	rts

;20 5A CF
;�Q�[�W�̃X�v���C�g���Z�b�g�A�b�v
DrawBar:
.amount = $00
.x = $01
.pal = $02
.offset = $06
	lda aObjLife
	sta <.amount
	ldx <.offset
	lda #$01
	sta <.pal
	lda #$18
	sta <.x
	jsr .draw
	bcs .done
	ldy <zEquipment
	beq .isbuster
	lda zEnergyArray - 1,y
	sta <.amount
	lda #$00
	sta <.pal
	lda #$10
	sta <.x
	jsr .draw
	bcs .done
.isbuster
	lda <zBossBehaviour
	beq .done
	lda aObjLife + 1
	sta <.amount
	lda #$03
	ldy <zBossKind
	cpy #$08
	beq .exception
	cpy #$0D
	bne .skip
.exception
	lda #$01
.skip
	sta <.pal
	lda #$28
	sta <.x
	mJSRJMP .draw
.done
	rts

.draw
	ldy #$06
.loop
	lda Table_BarPositionY,y
	sta aSpriteY,x
	sec
	lda <.amount
	sbc #$04
	bcs .over4
	ldx <.amount
	lda #$00
	sta <.amount
	lda Table_BarGraphics,x
	ldx <.offset
	jmp .write
.over4
	sta <.amount
	lda #$87
.write
	sta aSpriteNumber,x
	lda <.pal
	sta aSpriteAttr,x
	lda <.x
	sta aSpriteX,x
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
	rts

;CFE2
Table_BarPositionY:
	.db $18, $20, $28, $30, $38, $40, $48
;CFE9
Table_BarGraphics:
	.db $8B, $8A, $89, $88


