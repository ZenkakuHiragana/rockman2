
;EDB6
;タイムストッパーで止められている間の敵の挙動
EnemyBehaviour_Stopping1:
	lda #$14
	sta aPlatformWidth,x
	jsr CheckOffscreenEnemy
	bcc .del
	lda #$00
	sta aPlatformWidth,x
.del
	sec
	lda aObjY,x
	sbc #$04
	bcs .skip_offsety
	sbc #$10 - 1
.skip_offsety
	sta aPlatformY,x
	rts

;EDCF
EnemyBehaviour_Stopping2:
	lda #$18
	sta aPlatformWidth,x
	jsr CheckOffscreenEnemy
	bcc .del
	lda #$00
	sta aPlatformWidth,x
.del
	sec
	lda aObjY,x
	sbc #$08
	bcs .skip_offsety
	sbc #$10 - 1
.skip_offsety
	sta aPlatformY,x
	rts

;EDE8
EnemyBehaviour_Stopping3:
	lda #$18
	sta aPlatformWidth,x
	jsr CheckOffscreenEnemy
	bcc .del
	lda #$00
	sta aPlatformWidth,x
.del
	sec
	lda aObjY,x
	sbc #$08
	bcs .skip_offsety
	sbc #$10 - 1
.skip_offsety
	sta aPlatformY,x
	rts

;EE01
EnemyBehaviour_Stopping4:
	jsr FaceTowards
	sec
	lda aObjAnim,x
	sbc #$40
	tay
	lda Goblin_Palette_Delta,y ;--------------------------------------------
	sta <$01
	lda aObjFlags,x
	and #%00100000
	beq .visible
	ldy <$01
	lda #$15
	cmp aPalette + 2,y
	bne .jump
	lda #$04
	sta aObjVXlo,x
	bne .jump2
.jump
	lda <$00
	cmp #$60
	bcs .done
.jump2
	lda #%10000010
	sta aObjFlags,x
.visible
	lda aObjVXlo,x
	cmp #$04
	bcs .done
	lda aObjVar,x
	and #$03
	bne .jump3
	sta aObjVar,x
	lda aObjVXlo,x
	inc aObjVXlo,x
	asl a
	asl a
	tay
	ldx <$01
	jsr Goblin_ChangePalette
	ldx <zObjIndex
.jump3
	inc aObjVar,x
.done
	mJSR_NORTS CheckOffscreenEnemy

;EE5A
EnemyBehaviour_Stopping5:
	lda aObjVXlo,x
	bne .do
	inc aObjVXlo,x
	lda #ENPaletteTable_QuickManStage.dark_to_red - ENPaletteTable_QuickManStage
	bne .jmp
.do
	jsr CheckOffscreenEnemy
	bcc .rts
	lda #$23
	jsr FindObject
	bcc .rts
	lda #ENPaletteTable_QuickManStage.red_to_dark - ENPaletteTable_QuickManStage
.jmp
	jmp ENPaletteChange_QuickManStage
.rts
;EE93
EnemyBehaviour_Stopping6:
	rts
