
;20 4E DA
;FireWeapon
	lda <zOffscreen
	bne .invalid
	ldx <zEquipment
	beq .isbuster
	lda <zEnergyArray - 1,x
	beq .invalid
.isbuster
	lda Table_FireWeaponBeginLow,x
	sta <zPtrlo
	lda Table_FireWeaponBeginHigh,x
	sta <zPtrhi
	jmp [zPtr]
.invalid
	sec
	rts

;DA69
FireRockBuster:
	lda <zKeyPress
	and #$02
	beq FireRockBuster_Invalid
	ldx #$04
.loopseek
	lda aObjFlags,x
	bpl .ok
	dex
	cpx #$01
	bne .loopseek
	beq FireRockBuster_Invalid
.ok
	mPLAYTRACK #$24
	ldy #$00
	jsr CreateWeaponObject
FireRockBuster_SetShootPose:
	lda #$0F
	sta <zShootPoseTimer
	lda #$01
FireRockBuster_SetThrowPose:
	sta <zShootPose
	ldx <zStatus
	clc
	adc Table_RockmanAnimation,x
	sta aObjAnim
	clc
	rts
FireRockBuster_Invalid:
	sec
	rts

;DA9C
FireAtomicFire:
	lda <zKeyPress
	and #$02
	beq .invalid
	ldx #$02
	ldy #$01
	jsr CreateWeaponObject
	lda #$82
	sta aObjFlags,x
.invalid
	sec
	rts

;DAB0
FireAirShooter:
	lda <zKeyPress
	and #$02
	beq .invalid
	ldx #$04
.loopseek
	lda aObjFlags,x
	bmi .invalid
	dex
	cpx #$01
	bne .loopseek
	ldx #$04
.loop
	stx <$01
	ldy #$02
	jsr CreateWeaponObject
	ldx <$01
	dex
	cpx #$01
	bne .loop
	mPLAYTRACK #$3F
	sec
	lda <zEnergyAir
	sbc #$02
	sta <zEnergyAir
	jmp FireRockBuster_SetShootPose
.invalid
	sec
	rts

;DAE3
FireLeafShield:
	lda <zKeyPress
	and #$02
	beq .invalid
	lda aObjFlags + 2
	bmi .invalid
	sec
	lda <zEnergyWood
	sbc #$03
	bcc .invalid
	ldx #$05
.loop
	stx <$02
	ldy #$03
	jsr CreateWeaponObject
	ldx <$02
	dex
	cpx #$01
	bne .loop
.invalid
	sec
	rts

;DB07
FireBubbleLead
	lda <zKeyPress
	and #$02
	beq .invalid
	ldx #$03
.loopseek
	lda aObjFlags,x
	bpl .ok
	dex
	cpx #$01
	bne .loopseek
	beq .invalid
.ok
	ldy #$04
	jsr CreateWeaponObject
	mPLAYTRACK #$24
	inc <zWeaponEnergy
	lda <zWeaponEnergy
	cmp #$02
	bne .noconsume
	lda #$00
	sta <zWeaponEnergy
	dec <zEnergyBubble
.noconsume
	jmp FireRockBuster_SetShootPose
.invalid
	sec
	rts

;DB38
FireQuickBoomerang:
	lda <zKeyPress
	and #$02
	bne .fire
	lda <zAutoFireTimer
	cmp #$0B
	beq .fire
	inc <zAutoFireTimer
	clc
	rts
.fire
	ldx #$05
.loopseek
	lda aObjFlags,x
	bpl .ok
	dex
	cpx #$01
	bne .loopseek
	beq .invalid
.ok
	ldy #$05
	jsr CreateWeaponObject
	mPLAYTRACK #$24
	inc <zWeaponEnergy
	lda <zWeaponEnergy
	cmp #$08
	bne .noconsume
	lda #$00
	sta <zWeaponEnergy
	dec <zEnergyQuick
.noconsume
	lda #$00
	sta <zAutoFireTimer
	jmp FireRockBuster_SetShootPose
.invalid
	sec
	rts

;DB77
FireCrashBomb
	lda <zKeyPress
	and #$02
	beq .invalid
	lda aObjFlags + 2
	bmi .invalid
	sec
	lda <zEnergyCrash
	sbc #$04
	bcc .invalid
	sta <zEnergyCrash
	ldx #$02
	ldy #$06
	jsr CreateWeaponObject
	mPLAYTRACK #$24
	jmp FireRockBuster_SetShootPose
.invalid
	sec
	rts

;DB9C
FireMetalBlade:
	lda <zKeyPress
	and #$02
	beq .invalid
	ldx #$04
.loopseek
	lda aObjFlags,x
	bpl .ok
	dex
	cpx #$01
	bne .loopseek
	beq .invalid
.ok
	ldy #$07
	jsr CreateWeaponObject
	mPLAYTRACK #$23
	inc <zWeaponEnergy
	lda <zWeaponEnergy
	cmp #$04
	bne .noconsume
	lda #$00
	sta <zWeaponEnergy
	dec <zEnergyMetal
.noconsume
	lda <zKeyDown
	and #$F0
	lsr a
	lsr a
	lsr a
	lsr a
	tay
	lda Table_MetalBladeVYlo,y
	sta aObjVYlo,x
	lda Table_MetalBladeVYhi,y
	sta aObjVY,x
	lda Table_MetalBladeVXlo,y
	sta aObjVXlo,x
	lda Table_MetalBladeVXhi,y
	sta aObjVX,x
	jmp FireTimeStopper_SetThrowPose
.invalid
	sec
	rts

;DBEE
Table_MetalBladeVYlo:
	.db $00, $00, $00, $00, $00, $D4, $2C, $00
	.db $00, $D4, $2C, $00, $00, $00, $00, $00
;DBFE
Table_MetalBladeVYhi:
	.db $00, $04, $FC, $00, $00, $02, $FD, $00
	.db $00, $02, $FD, $00, $00, $00, $00, $00
;DC0E
Table_MetalBladeVXlo:
	.db $00, $00, $00, $00, $00, $D4, $D4, $00
	.db $00, $D4, $D4, $00, $00, $00, $00, $00
;DC1E
Table_MetalBladeVXhi:
	.db $04, $00, $00, $00, $04, $02, $02, $00
	.db $04, $02, $02, $00, $00, $00, $00, $00

;DC2E
FireTimeStopper:
	lda <zKeyPress
	and #$02
	beq FireTimeStopper_Invalid
	ldx #$02
	lda aObjFlags + 2
	bmi FireTimeStopper_Invalid
	ldy #$08
	jsr CreateWeaponObject
	lda #$01
	sta aTimeStopper ;--------------------------目的がよく分かんないのであとで調べて
	mPLAYTRACK #$21
FireTimeStopper_SetThrowPose:
	lda #$0F
	sta <zShootPoseTimer
	lda #$03
	jmp FireRockBuster_SetThrowPose
FireTimeStopper_Invalid
	sec
	rts

;DC55
FireItem1:
	lda <zKeyPress
	and #$02
	beq FireTimeStopper_Invalid
	ldx #$04
.loopseek
	lda aObjFlags,x
	bpl .ok
	dex
	cpx #$01
	bne .loopseek
	beq .invalid
.ok
	ldy #$09
	jsr CreateWeaponObject
	sec
	lda <zEnergy1
	sbc #$02
	sta <zEnergy1
	jmp FireTimeStopper_SetThrowPose
.invalid
	sec
	rts

;DC7A
FireItem2:
	lda <zKeyPress
	and #$02
	beq .invalid
	lda aObjFlags + 2
	bmi .invalid
	ldx #$02
	ldy #$0A
	jsr CreateWeaponObject
	lda #$3E
	sta aObjVar + 2
	lda #$13
	sta aObjLife + 2
	jmp FireTimeStopper_SetThrowPose
.invalid
	rts

;DC9A
FireItem3:
	lda <zKeyPress
	and #$02
	beq .invalid
	lda aObjFlags + 2
	bmi .invalid
	ldx #$02
	ldy #$0B
	jsr CreateWeaponObject
	lda #$1F
	sta aObjLife + 2
	jmp FireTimeStopper_SetThrowPose
.invalid
	rts

;DCB5
Table_FireWeaponBeginLow:
	.db LOW(FireRockBuster)
	.db LOW(FireAtomicFire)
	.db LOW(FireAirShooter)
	.db LOW(FireLeafShield)
	.db LOW(FireBubbleLead)
	.db LOW(FireQuickBoomerang)
	.db LOW(FireTimeStopper)
	.db LOW(FireMetalBlade)
	.db LOW(FireCrashBomb)
	.db LOW(FireItem1)
	.db LOW(FireItem2)
	.db LOW(FireItem3)
;DCC1
Table_FireWeaponBeginHigh:
	.db HIGH(FireRockBuster)
	.db HIGH(FireAtomicFire)
	.db HIGH(FireAirShooter)
	.db HIGH(FireLeafShield)
	.db HIGH(FireBubbleLead)
	.db HIGH(FireQuickBoomerang)
	.db HIGH(FireTimeStopper)
	.db HIGH(FireMetalBlade)
	.db HIGH(FireCrashBomb)
	.db HIGH(FireItem1)
	.db HIGH(FireItem2)
	.db HIGH(FireItem3)

;DCCD
WeaponObjectProcess:
	ldx #$0F
.loop
	stx <zObjIndex
	lda aObjFlags,x
	bpl .skip
	and #$02
	bne .ctrl
	sec
	lda aObjX,x
	sbc <zHScroll
	sta aWeaponScreenX,x
	jsr MoveObjectForWeapon
.skip
	ldx <zObjIndex
	dex
	cpx #$01
	bne .loop
	rts
.ctrl
.low = LOW(.skip - 1)
.high = HIGH(.skip - 1)
	lda #.high
	pha
	lda #.low
	pha
	sec
	lda aObjX,x
	sbc <zHScroll
	sta aWeaponScreenX,x
	sec
	lda aObjAnim,x
	sbc #$2F
	tay
	lda Table_WeaponObjectLow,y
	sta <zPtrlo
	lda Table_WeaponObjectHigh,y
	sta <zPtrhi
	jmp [zPtr]

;DD11
Table_WeaponObjectLow:
	.db LOW(DoRockBuster)
	.db LOW(DoAtomicFire)
	.db LOW(DoAirShooter)
	.db LOW(DoLeafShield)
	.db LOW(DoBubbleLead)
	.db LOW(DoQuickBoomerang)
	.db LOW(DoCrashBomb)
	.db LOW(DoTimeStopper)
	.db LOW(DoMetalBlade)
	.db LOW(DoItem1)
	.db LOW(DoItem2)
	.db LOW(DoItem3)
	.db LOW(DoLeafShield_Disabled)
	.db LOW(DoQuickBoomerang_Disabled)
	.db LOW(DoAirShooter_Disabled)
	.db LOW(DoWaterSplash)
;DD21
Table_WeaponObjectHigh:
	.db HIGH(DoRockBuster)
	.db HIGH(DoAtomicFire)
	.db HIGH(DoAirShooter)
	.db HIGH(DoLeafShield)
	.db HIGH(DoBubbleLead)
	.db HIGH(DoQuickBoomerang)
	.db HIGH(DoCrashBomb)
	.db HIGH(DoTimeStopper)
	.db HIGH(DoMetalBlade)
	.db HIGH(DoItem1)
	.db HIGH(DoItem2)
	.db HIGH(DoItem3)
	.db HIGH(DoLeafShield_Disabled)
	.db HIGH(DoQuickBoomerang_Disabled)
	.db HIGH(DoAirShooter_Disabled)
	.db HIGH(DoWaterSplash)
;DD31
DoRockBuster:
DoAtomicFire:
	lda aObjVar,x
	beq .manage
	jmp .bullet
.manage
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	lda <zWeaponEnergy
	cmp #$FF
	beq .max
	inc <zWeaponEnergy
.max
	ldy #$02
	lda <zWeaponEnergy
	cmp #$7D
	bcc .charging
	iny
	iny
	cmp #$BB
	bcc .charging
	iny
	iny
.charging
	sty <$00
	lda <zFrameCounter
	and #$04
	bne .zero
	ldy #$00
.zero
	jsr .changepalette
	lda aObjY
	sta aObjY,x
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda <$00
	lsr a
	tay
	lda .energy - 1,y
	cmp <zEnergyHeat
	bcc .canshoot
	beq .canshoot
	ldy #$00
	sty <zWeaponEnergy
	jsr .changepalette
	lsr aObjFlags,x
	rts
.canshoot
	lda <zKeyDown
	and #$02
	beq .shoot
	rts
.shoot
	ldy #$00
	sty <zWeaponEnergy
	jsr .changepalette
	lsr aObjFlags + 2
	ldx #$04
.loopseek
	lda aObjFlags,x
	bpl .ok
	dex
	cpx #$02
	bne .loopseek
.ifdead
	rts
.ok
	lda <zOffscreen
	bne .invalid
	ldy #$01
	jsr CreateWeaponObject
	lda <$00
	lsr a
	sta aObjVar,x
	sta aWeaponCollision,x
	tay
	lda .vision,y
	sta aObjFrame,x
	sec
	lda aObjX,x
	sbc <zHScroll
	sta aWeaponScreenX,x
.invalid
	sec
	lda <zEnergyHeat
	sbc .energy - 1,y
	sta <zEnergyHeat
	mPLAYTRACK #$38
	lda #$04
	sta aObjVX,x
	lda <zStatus
	beq .ifdead
	jmp FireRockBuster_SetShootPose

.bullet
	cmp #$02
	bcs .skip
	lda aObjFrame,x
	cmp #$03
	bne .donothing
	lda #$01
	bne .setanim
.skip
	bne .skip2
	lda aObjFrame,x
	cmp #$06
	bne .donothing
	lda #$04
	bne .setanim
.skip2
	lda aObjFrame,x
	cmp #$09
	bne .donothing
	lda #$07
.setanim
	sta aObjFrame,x
.donothing
	jsr MoveObjectForWeapon
	rts

;DE15
.changepalette
	lda .pal_atomic,y
	sta aPaletteSpr + 1
	lda .pal_atomic + 1,y
	sta aPaletteSpr + 3
	lda <zFrameCounter
	and #$07
	bne .dontplay
	lda <$00
	lsr a
	tay
	lda .sound_atomic,y
	jsr PlayTrack
.dontplay
	rts

;DE32
.sound_atomic
	.db $35, $35, $36, $37
.pal_atomic
	.db $0F, $15
	.db $31, $15
	.db $35, $2C
	.db $30, $30
.vision
	.db $00, $01, $04, $07
.energy
	.db $01, $06, $0A

;DE45
DoAirShooter:
	txa
	sec
	sbc #$02
	tay
	lda .vxlo,y
	sta aObjVXlo,x
	lda .vxhi,y
	sta aObjVX,x
	clc
	lda aObjVYlo,x
	adc #$10
	sta aObjVYlo,x
	lda aObjVY,x
	adc #$00
	sta aObjVY,x
	jsr MoveObjectForWeapon
	rts

.vxlo
	.db $19, $99, $33
.vxhi
	.db $01, $01, $02

;DE71
DoLeafShield:
	lda aObjVar,x
	bne .deploy
	lda #$00
	sta aObjWait,x
	lda aObjLife,x
	sta <$01
	txa
	sec
	sbc #$02
	sta <$00
	and #$01
	bne .odd_h
	sec
	lda aObjX
	sbc <$01
	sta aObjX,x
	lda aObjRoom
	sbc #$00
	jmp .write_h
.odd_h
	clc
	lda aObjX
	adc <$01
	sta aObjX,x
	lda aObjRoom
	adc #$00
.write_h
	sta aObjRoom,x
	lda <$00
	and #$02
	bne .odd_v
	sec
	lda aObjY
	sbc <$01
	jmp .write_v
.odd_v
	clc
	lda aObjY
	adc <$01
.write_v
	sta aObjY,x
	lda <$01
	cmp #$0C
	beq .end
	clc
	adc #$02
	sta aObjLife,x
	rts
.end
	lsr aObjFlags + 3
	lsr aObjFlags + 4
	lsr aObjFlags + 5
	lda #$83
	sta aObjFlags + 2
	lda #$01
	sta aObjVar +2
	lda #$01
	sta aObjFrame + 2
	rts

.deploy
	lda <zOffscreen
	beq .inscreen
	lda #$06
	bne .writeframe
.inscreen
	lda aObjFrame,x
	cmp #$05
	bcc .noloop
	lda #$01
.writeframe
	sta aObjFrame,x
.noloop
	lda aObjVar,x
	cmp #$01
	bne .flying

	lda <zFrameCounter
	and #$07
	bne .jump
	mPLAYTRACK #$31
.jump
	lda aObjX
	sta aObjX,x
	lda aObjRoom
	sta aObjRoom,x
	lda aObjY
	sta aObjY,x
	lda <zOffscreen
	beq .inscreenshield
	lda #$00
	sta aObjY,x
.inscreenshield
	lda <zKeyDown
	and #$F0
	beq .dontfire
	ldy <zOffscreen
	beq .inscreenfire
	lsr aObjFlags,x
	rts
.inscreenfire
	and #$C0
	beq .vertical
	lsr a
	and #%01000000
	ora #%10000011
	sta aObjFlags,x
	lda #$04
	sta aObjVX,x
	bne .endfire
.vertical
	ldy #$00
	lda <zKeyDown
	and #$10
	bne .up
	iny
.up
	lda .vy,y
	sta aObjVY,x
.endfire
	sec
	lda <zEnergyWood
	sbc #$03
	sta <zEnergyWood
	inc aObjVar,x
.dontfire
	rts

.flying
	jsr MoveObjectForWeapon
	rts

.vy
	.db $04, $FC

;DF6C
DoBubbleLead:
	lda #$07
	sta <$01
	lda #$07
	sta <$02
	jsr WallCollisionXY
	lda aObjVar,x
	bne .land
	lda <$00
	beq .move
	inc aObjVar,x
	lda aObjFlags,x
	and #%11111011
	sta aObjFlags,x
.forward_setvelocity
	lda #$C0
	sta aObjVYlo,x
	lda #$FF
	sta aObjVY,x
	lda #$02
	sta aObjVX,x
	bne .move
.land
	cmp #$01
	bne .forward
	lda <$03
	beq .nothit
	lsr aObjFlags,x
	rts
.nothit
	lda <$00
	bne .move
	lda #$00
	sta aObjVX,x
	sta aObjVYlo,x
	lda #$FE
	sta aObjVY,x
	inc aObjVar,x
	bne .move
.forward
	lda <$00
	beq .move
	dec aObjVar,x
	bne .forward_setvelocity
.move
	jsr MoveObjectForWeapon
	rts

;DFCB
DoQuickBoomerang:
	lda aObjVar,x
	cmp #$12
	bcs .curve
	sec
	lda aObjVYlo,x
	sbc #$4B
	sta aObjVYlo,x
	lda aObjVY,x
	sbc #$00
	sta aObjVY,x
	jmp DoQuickBoomerang_MOVE
.curve
	bne .skip
	lda aObjFlags,x
	eor #%01000000
	sta aObjFlags,x
.skip
	lda aObjVar,x
	cmp #$23
	bne DFCB_NotDel
	lsr aObjFlags,x
	rts
DFCB_NotDel:
	clc
	lda aObjVYlo,x
	
	adc #$4B
;	.db $69
;	mBEGINRAW #$1F, $E000 ;**********************************
;	.db $4B
	
	sta aObjVYlo,x
	lda aObjVY,x
	adc #$00
	sta aObjVY,x

DoQuickBoomerang_MOVE:
	inc aObjVar,x
	mJSR_NORTS MoveObjectForWeapon

;E013
DoCrashBomb:
	lda aObjVar,x
	bne .deployed
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	sec
	lda aObjY,x
	sbc #$08
	sta <$0A
	lda #$00
	sta <$0B
	lda aObjFlags,x
	and #%01000000
	bne .right
	sec
	lda aObjX,x
	sbc #$06
	sta <$08
	lda aObjRoom,x
	sbc #$00
	jmp .write
.right
	clc
	lda aObjX,x
	adc #$06
	sta <$08
	lda aObjRoom,x
	adc #$00
.write
	sta <$09
	jsr PickupBlock
	ldy <$00
	ldx <zObjIndex
	lda Table_TerrainList,y ;----------------------------
	bne .hit
	clc
	lda <$0A
	adc #$10
	sta <$0A
	jsr PickupBlock
	ldy <$00
	ldx <zObjIndex
	lda Table_TerrainList,y ;----------------------------
	bne .hit
	mJSR_NORTS MoveObjectForWeapon
.hit
	mPLAYTRACK #$2E
	lda aObjFlags,x
	and #%11111110
	sta aObjFlags,x
	inc aObjFrame,x
	inc aObjVar,x
	lda #$7E
	sta aObjLife,x
	bne .done
.deployed
	cmp #$01
	bne .explode
	lda aObjFrame,x
	cmp #$04
	bne .loopanim
	lda #$02
	sta aObjFrame,x
.loopanim
	dec aObjLife,x
	bne .done
	lda #$05
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	lda #$38
	sta aObjLife,x
	inc aObjVar,x
.done
	mJSR_NORTS CheckOffscreen_Easy
.explode
	lda #$00
	sta aObjWait,x
	lda aObjLife,x
	and #$07
	bne .skip
	mPLAYTRACK #$2B
	lda aObjLife,x
	lsr a
	and #$0C
	sta <$02
	lda #$06
	sta <$01
.loop
	lda <$01
	cmp #$02
	beq .skip
	sta <$00
	ldy #$0C
	jsr CreateWeaponObjectFromObject
	ldy <$00
	ldx <$02
	clc
	lda aObjY,y
	adc CrashBomb_Spawndy,x
	sta aObjY,y
	clc
	lda aObjX,y
	adc CrashBomb_Spawndx,x
	sta aObjX,y
	lda aObjRoom,y
	adc CrashBomb_Spawndr,x
	sta aObjRoom,y
	ldx <zObjIndex
	inc <$02
	dec <$01
	bne .loop
.skip
	ldx <zObjIndex
	dec aObjLife,x
	bpl .exists
	lsr aObjFlags,x
	rts
.exists
	mJSR_NORTS CheckOffscreen_Easy

;E11C
CrashBomb_Spawndy:
	.db $F8, $F0, $08, $00, $F8, $F8, $08, $00
	.db $F0, $00, $10, $10, $F0, $F8, $08, $08
;E12C
CrashBomb_Spawndx:
	.db $F8, $08, $00, $10, $F8, $10, $F0, $08
	.db $00, $00, $F8, $10, $F0, $10, $F0, $08
;E13C
CrashBomb_Spawndr:
	.db $FF, $00, $00, $00, $FF, $00, $FF, $00
	.db $00, $00, $FF, $00, $FF, $00, $FF, $00
;E14C
Table_TerrainList:
	.db $00, $01, $00, $00, $00, $01, $01, $01, $01

;E155
DoMetalBlade:
DoTimeStopper:
	dec aObjVXlo,x
	bne .do
	lda #$0F
	sta aObjVXlo,x
	dec <zEnergyFlash
	bne .do
	lsr aObjFlags,x
	lda #$00
	sta <zStopFlag
	lda #$01
	sta <zWindhi
	rts
.do
	lda #$01
	sta <zStopFlag
	lda #$00
	sta <zWindhi
	sta <zWindlo
	lda #$80
	sta aObjY,x
	clc
	adc <zHScroll
	sta aObjX,x
	lda aObjRoom
	adc #$00
	sta aObjRoom,x
	rts

DoItem1:
	lda aObjVar,x
	bne .do
	inc aObjLife,x
	lda aObjLife,x
	cmp #$BB
	beq .blink
	lda aObjFrame,x
	cmp #$02
	bne .loopanim
	lda #$00
	sta aObjFrame,x
.loopanim
	jmp .skip
.blink
	lda #$3E
	sta aObjLife,x
	inc aObjVar,x
	bne .skip
.do
	cmp #$01
	bne .done
	lda aObjFrame,x
	cmp #$07
	bne .loopanimblink
	lda #$03
	sta aObjFrame,x
.loopanimblink
	dec aObjLife,x
	beq .end
.skip
	sec
	lda aObjY,x
	sbc #$04
	sta aWeaponPlatformY - 2,x
	lda #$14
	sta aWeaponPlatformW - 2,x
	lda #$0B
	sta <$01
	lda #$1D
	sta <$02
	lda #$04
	sta <$03
	jsr CheckWallXY
	lda <$00
	beq .done
	lda #$00
	sta aObjVYlo,x
.end
	lda #$02
	sta aObjVar,x
	lda #$08
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	sta aWeaponPlatformW - 2,x
.done
	jsr MoveObjectForWeapon
	bcc .inscreen
	lda #$00
	sta aWeaponPlatformW - 2,x
.inscreen
	rts

;E20D
DoItem2:
	lda aObjVar,x
	beq .zero
	dec aObjVar,x
	bne .accel
.zero
	dec aObjLife,x
	bne .skip
	lda #$13
	sta aObjLife,x
	dec <zEnergy2
	bne .skip
.hit
	lda #$05
	sta aObjFrame,x
	lda #$00
	sta aWeaponPlatformW
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjWait,x
	lda #%10000000
	sta aObjFlags,x
	beq .skip
	jmp .loopanim
.skip
	lda aObjVX,x
	cmp #$02
	beq .accel
	clc
	lda aObjVXlo,x
	adc #$08
	sta aObjVXlo,x
	lda aObjVX,x
	adc #$00
	sta aObjVX,x
	cmp #$02
	bne .accel
	lda #$00
	sta aObjVXlo,x
.accel
	lda #$0F
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionXY
	lda <$03
	bne .hit
	sec
	lda aObjY,x
	sbc #$20
	sta <$0A
	lda #$00
	sta <$0B
	sec
	lda aObjX,x
	sbc #$10
	sta <$08
	lda aObjRoom,x
	sbc #$00
	sta <$09
	jsr PickupBlock
	ldx <zObjIndex
	ldy <$00
	lda Table_TerrainList,y
	bne .jumphit
	clc
	lda <$08
	adc #$20
	sta <$08
	lda <$09
	adc #$00
	sta <$09
	jsr PickupBlock
	ldx <zObjIndex
	ldy <$00
	lda Table_TerrainList,y
	beq .nohit
.jumphit
	jmp .hit
.nohit
	sec
	lda aObjY,x
	sbc #$04
	sta aWeaponPlatformY - 2,x
	lda #$18
	sta aWeaponPlatformW - 2,x
	lda aObjFrame,x
	cmp #$04
	bne .loopanim
	lda #$00
	sta aObjFrame,x
.loopanim
	jsr MoveObjectForWeapon
	bcc .del
	lda #$00
	sta aWeaponPlatformW - 2,x
.del
	rts

;E2DA
DoItem3:
	lda aObjVar,x
	bne .do
	lda aObjVY,x
	sta <$04
	lda #$0A
	sta <$01
	lda #$08
	sta <$02
	jsr WallCollisionXY
	lda <$03
	beq .bump
	lda #$62
	sta aObjVYlo,x
	lda #$00
	sta aObjVY,x
	sta aObjVXlo,x
	sta aObjVX,x
	lda aObjFlags,x
	and #%11111011
	sta aObjFlags,x
	inc aObjVar,x
	bne .lift
.bump
	lda <$04
	bpl .lift
	lda <$00
	beq .lift
	lda #$03
	sta aObjVY,x
	lda #$76
	sta aObjVYlo,x
.lift
	lda #$00
	sta aWeaponCollision,x
	lda aObjFrame,x
	cmp #$04
	bne .loopanim
	lda #$00
	sta aObjFrame,x
.loopanim
	dec aObjLife,x
	bne .jump
	lda #$1F
	sta aObjLife,x
	dec <zEnergy3
	beq .del
.jump
	jmp .tmp
.do
	sec
	lda aObjY,x
	sbc #$08
	sta aWeaponPlatformY - 2,x
	lda #$14
	sta aWeaponPlatformW - 2,x
	lda #$0C
	sta <$01
	lda #$21
	sta <$02
	lda #$08
	sta <$03
	jsr CheckWallXY
	lda aObjVar,x
	and #$0F
	cmp #$02
	bcs .skip
	lda aObjVar,x
	bpl .skip2
	inc aObjVar,x
	bne .skip2
.skip2
	lda <$00
	bne .del
	lda <$03
	bne .lift
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
	lda aObjFrame,x
	cmp #$09
	bne .loopanim_disappear
	lda #$05
	sta aObjFrame,x
.loopanim_disappear
	inc aWeaponCollision,x
	lda aWeaponCollision,x
	cmp #$3E
	bcc .loopanim
.del
	lda #$0A
	sta aObjFrame,x
	lda #$00
	sta aObjVY,x
	sta aObjVYlo,x
	sta aObjWait,x
	sta aWeaponPlatformW - 2,x
	lda #%10000000
	sta aObjFlags,x
	rts

.skip
	lda aObjVar,x
	bpl .skip4
	and #$0F
	sta aObjVar,x
	lda #$62
	sta aObjVYlo,x
	lda #$00
	sta aObjVY,x
	beq .skip2
.skip4
	lda aObjVY,x
	bpl .skip5
	lda <$00
	bne .del
.skip5
	lda #$9E
	sta aObjVYlo,x
	lda #$FF
	sta aObjVY,x
	jmp .skip2

;E3DF
.tmp
	jsr MoveObjectForWeapon
	bcc .exists
	lda #$00
	sta aWeaponPlatformW - 2,x
.exists
	rts

;E3EA
;縦横地形判定らしい
;$01: 横判定範囲, $02: 下判定範囲 $03: 上判定範囲
;$00: 縦判定結果, $03: 横判定結果 ... 壁なら1, 他は0
CheckWallXY:
	lda aObjFlags,x
	and #%01000000
	bne .right
	sec
	lda aObjX,x
	sbc <$01
	sta <$08
	lda aObjRoom,x
	sbc #$00
	jmp .write
.right
	clc
	lda aObjX,x
	adc <$01
	sta <$08
	lda aObjRoom,x
	adc #$00
.write
	sta <$09
	sec
	lda aObjY,x
	sbc #$08
	sta <$0A
	lda #$00
	sbc #$00
	sta <$0B
	jsr PickupBlock
	ldx <zObjIndex
	ldy <$00
	lda .terrain,y
	pha
	lda aObjVY,x
	bpl .goup
	clc
	lda aObjY,x
	adc <$03
	sta <$0A
	lda #$00
	adc #$00
	jmp .checkterrain
.goup
	sec
	lda aObjY,x
	sbc <$02
	sta <$0A
	lda #$00
	sbc #$00
.checkterrain
	sta <$0B
	lda aObjX,x
	sta <$08
	lda aObjRoom,x
	sta <$09
	jsr PickupBlock
	ldx <zObjIndex
	ldy <$00
	lda .terrain,y
	sta <$00
	pla
	sta <$03
	rts
;E465
.terrain
	.db $00, $01, $00, $01, $00, $01, $01, $01, $01

;E46E
DoLeafShield_Disabled:
	lda #$00
	sta aObjWait,x
	lda aObjVar,x
	bne .do
	lda aObjLife,x
	bne .done
	lda aObjFlags,x
	eor #%01000000
	sta aObjFlags,x
	inc aObjFrame,x
	and #%01000000
	beq .left
	inc aObjFrame,x
.left
	lda #$00
	sta aObjVXlo,x
	sta aObjVYlo,x
	lda #$FE
	sta aObjVY,x
	lda #$01
	sta aObjVX,x
	lda #$10
	sta aObjLife,x
	inc aObjVar,x
	bne .done
.do
	clc
	lda aObjVXlo,x
	adc #$40
	sta aObjVXlo,x
	lda aObjVX,x
	adc #$00
	sta aObjVX,x
	lda aObjLife,x
	bne .done
	lda #$00
	sta aObjFrame,x
	sta aObjVXlo,x
	sta aObjVX,x
	sta aObjVYlo,x
	sta aObjVY,x
	lda #$02
	sta aObjLife,x
	dec aObjVar,x
.done
	dec aObjLife,x
	mJSR_NORTS MoveObjectForWeapon
;E4E1
DoQuickBoomerang_Disabled:
DoAirShooter_Disabled:
	mJSR_NORTS CheckOffscreen_Easy
;E4E5
DoWaterSplash:
	rts

;20 E6 E4
;Obj[x]横方向に画面外なら消す
CheckOffscreen_Easy:
	sec
	lda aObjX,x
	sbc <zHScroll
	lda aObjRoom,x
	sbc <zRoom
	bcc .del
	bne .del
	clc
	rts
.del
	lsr aObjFlags,x
	sec
	rts

;20 FC E4
CreateWeaponObjectFromObject:
.x = $08
.r = $09
.y = $0A
	lda aObjX,x
	sta <.x
	lda aObjRoom,x
	sta <.r
	lda aObjY,x
	sta <.y
	ldx <$00
	lda Table_WeaponObjectAnim,y
	sta aObjAnim,x
	lda Table_WeaponObjectFlags,y
	sta aObjFlags,x
	lda <.x
	sta aObjX,x
	lda <.r
	sta aObjRoom,x
	lda <.y
	sta aObjY,x
	lda Table_WeaponObjectVXlo,y
	sta aObjVXlo,x
	lda Table_WeaponObjectVXhi,y
	sta aObjVX,x
	lda Table_WeaponObjectVYlo,y
	sta aObjVYlo,x
	lda Table_WeaponObjectVYhi,y
	sta aObjVY,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	sta aObjVar,x
	sec
	lda aObjX,x
	sbc <zHScroll
	sta aWeaponScreenX,x
	ldx <zObjIndex
	rts
