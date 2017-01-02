
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
	sta aPlatformY,x
	rts

;EE01
EnemyBehaviour_Stopping4:
	jsr FaceTowards
	sec
	lda aObjAnim,x
	sbc #$40
	tay
	lda $AF79,y ;--------------------------------------------
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
	jsr $AF4C ;----------------------------------------------
	ldx <zObjIndex
.jump3
	inc aObjVar,x
.done
	mJSR_NORTS CheckOffscreenEnemy

;EE5A
EnemyBehaviour_Stopping5:
	lda aObjVXlo,x
	bne .jump
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
	bcs .jump
	lda #$26
	jsr CreateEnemyHere
.jump
	jsr CheckOffscreenEnemy
	bcc .done
	lda #$23
	jsr FindObject
	bcc .done
	lda #$28
	jsr CreateEnemyHere
.done
	rts

;EE93
EnemyBehaviour_Stopping6:
	rts

