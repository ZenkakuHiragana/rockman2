
;20 55 D6
;SpawnEnemyByScroll
.l = $0A
.lhi = $0B
.r = $08
.rhi = $09
	lda <zStage
	and #$07
	jsr ChangeBank
	clc
	lda <zHScroll
	sta <.l
	adc #$FF
	sta <.r
	lda <zRoom
	sta <.lhi
	adc #$00
	sta <.rhi
	lda <zMoveVec
	and #$40
	bne .right
;左スクロールのオブジェクト出現処理
.loopleft
	ldy <zEnemyIndexPrev
	beq .skipleft
	lda $B5FF,y ;------------------enemy page
	cmp <.lhi
	bcc .skipleft
	bne .spawnleft
	lda $B6FF,y ;------------------enemy x
	cmp <.l
	bcc .skipleft
.spawnleft
	dey
	jsr CreateEnemy
	dec <zEnemyIndexPrev
	bne .loopleft
.skipleft
	ldy <zEnemyIndexNext
	beq .skipleftseek
.loopleftseek
	lda $B5FF,y ;------------------enemy page
	cmp <.rhi
	bcc .skipleftseek
	bne .spawnleftseek
	lda $B6FF,y ;------------------enemy x
	cmp <.r
	bcc .skipleftseek
.spawnleftseek
	dey
	bne .loopleftseek
.skipleftseek
	sty <zEnemyIndexNext

.loopitemleft
	ldy <zItemIndexPrev
	beq .skipitemleft
	lda $B9FF,y ;------------------item page
	cmp <.lhi
	bcc .skipitemleft
	bne .spawnitemleft
	lda $BA3F,y ;------------------item x
	cmp <.l
	bcc .skipitemleft
.spawnitemleft
	lda aItemLife - 1,y
	beq .noitemhpleft
	dey
	jsr CreateItem
.noitemhpleft
	dec <zItemIndexPrev
	bne .loopitemleft
.skipitemleft
	ldy <zItemIndexNext
	beq .skipitemleftseek
.loopitemleftseek
	lda $B9FF,y ;------------------item page
	cmp <.rhi
	bcc .skipitemleftseek
	bne .spawnitemleftseek
	lda $BA3F,y ;------------------item x
	cmp <.r
	bcc .skipitemleftseek
.spawnitemleftseek
	dey
	bne .loopitemleftseek
.skipitemleftseek
	sty <zItemIndexNext
	jmp .done
;右スクロールのオブジェクト出現処理右端における敵の配置
.right
	ldy <zEnemyIndexNext
	lda <.rhi
	cmp $B600,y ;------------------enemy page
	bcc .skipright
	bne .spawnright
	lda <.r
	cmp $B700,y ;------------------enemy x
	bcc .skipright
.spawnright
	jsr CreateEnemy
	inc <zEnemyIndexNext
	bne .right
.skipright
	ldy <zEnemyIndexPrev
.looprightseek
	lda <.lhi
	cmp $B600,y ;------------------enemy page
	bcc .skiprightseek
	bne .spawnrightseek
	lda <.l
	cmp $B700,y ;------------------enemy x
	bcc .skiprightseek
.spawnrightseek
	iny
	bne .looprightseek
.skiprightseek
	sty <zEnemyIndexPrev

.loopitemright
	ldy <zItemIndexNext
	lda <.rhi
	cmp $BA00,y ;------------------item page
	bcc .skipitemright
	bne .spawnitemright
	lda <.r
	cmp $BA40,y ;------------------item x
	bcc .skipitemright
.spawnitemright
	lda aItemLife,y
	beq .noitemhpright
	jsr CreateItem
.noitemhpright
	inc <zItemIndexNext
	bne .loopitemright
.skipitemright
	ldy <zItemIndexPrev
.loopitemrightseek
	lda <.lhi
	cmp $BA00,y ;------------------item page
	bcc .skipitemrightseek
	bne .spawnitemrightseek
	lda <.l
	cmp $BA40,y ;------------------item x
	bcc .skipitemrightseek
.spawnitemrightseek
	iny
	bne .loopitemrightseek
.skipitemrightseek
	sty <zItemIndexPrev

.done
	mCHANGEBANK #$0E, 1
	;rts

;20 50 D7
CreateEnemy:
	tya
	ldx #$0F
.loopseek
	cmp aEnemyOrder10,x
	beq InvalidCreateObject
	dex
	bpl .loopseek
	jsr GetEnemyPointer
	bcs InvalidCreateObject
	tya
	sta aEnemyOrder10,x
	lda $B600,y ;------------enemy page
	sta aObjRoom10,x
	lda $B700,y ;------------enemy x
	sta aObjX10,x
	lda $B800,y ;------------enemy y
	sta aObjY10,x
	lda $B900,y ;------------enemy number
CreateObjectHere:
	sta aObjAnim10,x
	tay
	pha
	lda Table_ObjectInitialFlags,y
	sta aObjFlags10,x
	lda Table_ObjectInitalCollisionSize,y
	sta aObjCollision10,x
	lda #$14
	sta aObjLife10,x
	lda Table_ObjectInitialVX,y
	tay
	lda Table_InitialVX,y
	sta aObjVX10,x
	lda Table_InitialVX + 1,y
	sta aObjVXlo10,x
	pla
	tay
	lda Table_ObjectInitialVY,y
	tay
	lda Table_InitialVY,y
	sta aObjVY10,x
	lda Table_InitialVY + 1,y
	sta aObjVYlo10,x
	lda #$00
	sta aObjFrame10,x
	sta aObjWait10,x
	sta aObjVar10,x
	sta aEnemyVar10,x
	sta aObjXlo10,x
	sta aObjYlo10,x
	sta aEnemyFlash10,x
InvalidCreateObject:
	rts

;20 C9 D7
CreateItem:
	tya
	ldx #$0F
.loopseek
	cmp aItemOrder10,x
	beq InvalidCreateObject
	dex
	bpl .loopseek
	jsr GetEnemyPointer
	bcs InvalidCreateObject
	tya
	pha
	sta aItemOrder10,x
	lda $BA00,y ;-------------item page
	sta aObjRoom10,x
	lda $BA40,y ;-------------item x
	sta aObjX10,x
	lda $BA80,y ;-------------item y
	sta aObjY10,x
	lda $BAC0,y ;-------------item number
	jsr CreateObjectHere
	pla
	sta aItemLifeOffset10,x
	tay
	lda aItemLife,y
	sta aObjLife10,x
	rts
;D802
Table_ObjectInitialFlags:
	.incbin "src/bin/obj/InitialFlags.bin"
;D882
Table_ObjectInitialVX:
	.incbin "src/bin/obj/InitialVX.bin"
;D8FE
Table_ObjectInitialVY:
	.incbin "src/bin/obj/InitialVY.bin"
;D97E
Table_ObjectInitalCollisionSize:
	.incbin "src/bin/obj/InitialCollision.bin"

;D9FE
Table_InitialVX:
	.incbin "src/bin/InitialVXList.bin"
;DA1E
Table_InitialVY:
	.incbin "src/bin/InitialVYList.bin"

;DA3F ...?
	.db $00, $20

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
