
	mBEGIN $0B, $8000
	
;A14F
;ボスの移動処理

;A249
;ボスの地形判定処理

	.bank $17
	.org $A249
BossPickupMap:
.result = $00
.dx = $01
.dy = $02
.x = $08
.r = $09
.y = $0A
	mSTZ <$0B
	lda aObjVY + 1
	php
	bpl .up
	clc
	lda aObjY + 1
	adc <.dy
	jmp .write_y
.up
	sec
	lda aObjY + 1
	sbc <.dy
.write_y
	sta <.y
	clc
	lda aObjX + 1
	adc <.dx
	sta <.x
	lda aObjRoom + 1
	adc #$00
	sta <.r
	jsr PickupMap_BossBank
	ldy <.result
	lda $A349,y
	sta <.dy
	sec
	lda aObjX + 1
	sbc <.dx
	sta <.x
	lda aObjRoom + 1
	sbc #$00
	sta <.r
	jsr PickupMap_BossBank
	lda <.result
	lda $A349,y
	ora <.dy
	sta <.result
	beq .nohit
	plp
	bmi .down
	lda <.y
	and #$0F
	eor #$FF
	sec
	adc aObjY + 1
	jmp .write_y2
.down
	lda aObjY + 1
	pha
	lda <.y
	and #$0F
	sta <.dy
	pla
	sec
	sbc <.dy
.write_y2
	sta aObjY + 1
	lda #$00
	sta aObjYlo + 1
	lda aObjFlags + 1
	and #%00000100
	beq .nogravity
	lda #$C0
	sta aObjVYlo + 1
	lda #$FF
	sta aObjVY + 1
.nogravity
	rts
.nohit
	plp
	rts
