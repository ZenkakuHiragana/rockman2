
;20 57 E5
;Obj[x]�̃��b�N�}���ւ̐ڐG����/x�j��
;RockmanTakeDamage:
	lda #$00
	sta <$01
	lda <zStatus
	beq .nodmg
	lda <zNoDamage
	bne .nodmg
	lda <zOffscreen
	bne .nodmg
	sec
	lda <zRScreenX
	sbc <zEScreenX
	bcs .inv_x
	eor #$FF
	adc #$01
.inv_x
	ldy aObjCollision,x
	cmp Table_CollisionSizeX,y
	bcs .nodmg

	sec
	lda aObjY
	sbc aObjY,x
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp Table_CollisionSizeY,y
	bcs .nodmg
	ldy aObjAnim,x
	cpy #$76
	bcs .isitem
	lda <zInvincible
	bne .nodmg
	sec
	lda aObjLife
	sbc Table_DamageAmount_Enemy,y
	sta aObjLife
	beq .dead
	bcs .alive
.dead
	lda #$00
	sta <zStatus
	sta aObjLife
	jmp DieRockman
.alive
	lda aObjFlags
	and #%10111111
	sta aObjFlags
	lda aObjFlags,x
	and #%01000000
	eor #%01000000
	ora aObjFlags
	sta aObjFlags
	jsr DamageRockman
	inc <$01
.nodmg
	rts
.isitem
	lda <zItemInterrupt
	bne .skip
	lsr aObjFlags,x
	sty <zItemInterrupt
	inc <$01
	lda aObjVar,x
	bne .skip
	lda #$FF
	sta aItemOrder,x
	lda aItemLifeOffset,x
	tay
	lda #$00
	sta aItemLife,y
.skip
	rts

;20 E9 E5
;Obj[x]�ƃ��b�N�}���̕���Ƃ̃q�b�g����
EnemyTakeDamage:
	lda aObjY,x
	sta <$00
	lda aObjCollision,x
	sta <$08
;���ԕ����ւ̊Ԉ����ɂ��œK���炵��
	ldx #$09
	lda <zFrameCounter
	and #$01
	bne .loop
	dex
.loop
;�������ɑ΂��Ẵ��[�v
	lda aObjFlags,x
	bpl .skip
	and #%00000001
	beq .skip
	clc
	ldy aWeaponCollision,x
	lda Table_WeaponCollisionOffset,y
	adc <$08
	tay
;|��X|���v�Z
	sec
	lda <zEScreenX
	sbc aWeaponScreenX,x
	bcs .inv_x
	eor #$FF
	adc #$01
.inv_x
;��r
	cmp Table_CollisionSizeX,y
	bcs .skip
	sec
	lda <$00
	sbc aObjY,x
	bcs .inv_y
	eor #$FF
	adc #$01
.inv_y
	cmp Table_CollisionSizeY,y
	bcc .hit
.skip
	dex
	dex
	cpx #$02
	bcs .loop
	ldx <zObjIndex
	lda #$00
	sta aEnemyFlash,x
	clc
	rts
.hit
	ldy <zEquipment
	lda Table_EnemyTakeDamageInfolo,y
	sta <zPtrlo
	lda Table_EnemyTakeDamageInfohi,y
	sta <zPtrhi
	jmp [zPtr]

;E64F
;���b�N�o�X�^�[�_���[�W����
EnemyTakeDamageByRockBuster:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_RockBuster,y
	sta <$00
	beq .guard
	lsr aObjFlags,x
	mPLAYTRACK #$2B
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne .abort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs .abort
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	lda aObjFlags,x
	eor #%01000000
	and #%11111110
	sta aObjFlags,x
	lda #$05
	sta aObjVY,x
	sta aObjVX,x
	mPLAYTRACK #$2D
	ldx <zObjIndex
.abort
	clc
	rts

;E6A4
;�A�g�~�b�N�t�@�C�A�[�_���[�W����
EnemyTakeDamageByAtomicFire:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda aObjVar,x
	cmp #$02
	bcc .min
	beq .mid
	lda Table_DamageAmount_AtomicFire,y
	jmp .givedmg
.mid
	clc
	lda Table_DamageAmount_RockBuster,y
	asl a
	adc Table_DamageAmount_RockBuster,y
	jmp .givedmg
.min
	lda Table_DamageAmount_RockBuster,y
.givedmg
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne AtomicFire_TakeDamageAbort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs AtomicFire_Disappear
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	mPLAYTRACK #$2D
	lsr aObjFlags,x
	jmp AtomicFire_TakeDamageAbort
AtomicFire_Disappear:
	lda #%00000000
	sta aObjFlags,y
AtomicFire_TakeDamageAbort:
	ldx <zObjIndex
	clc
	rts

;E70D
;�G�A�[�V���[�^�[�_���[�W����
EnemyTakeDamageByAirShooter:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_AirShooter,y
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne .abort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs AtomicFire_Disappear
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	mPLAYTRACK #$2D
	lda aObjFlags,x
	and #%11111110
	sta aObjFlags,x
	lda #$3D
	sta aObjAnim,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	ldx <zObjIndex
.abort
	clc
	rts

;E766
;���[�t�V�[���h�_���[�W����
EnemyTakeDamageByLeafShield:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_LeafShield,y
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne LeafShield_TakeDamageAbort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs LeafShield_TakeDamageAlive
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	mPLAYTRACK #$2D
	lda aObjFlags,x
	and #%11110010
	sta aObjFlags,x
	lda #$3B
	sta aObjAnim,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	sta aObjVar,x
	sta aObjLife,x
LeafShield_TakeDamageAlive_Done:
	ldx <zObjIndex
LeafShield_TakeDamageAbort:
	clc
	rts
LeafShield_TakeDamageAlive:
	lda #%00000000
	sta aObjFlags,y
	beq LeafShield_TakeDamageAlive_Done

;E7CC
;�o�u�����[�h�_���[�W����
EnemyTakeDamageByBubbleLead:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_BubbleLead,y
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne .abort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs LeafShield_TakeDamageAlive
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	lda #$00
	sta aObjVX,x
	sta aObjVXlo,x
	sta aObjVYlo,x
	lda #$04
	sta aObjVY,x
	lda #%10000000
	sta aObjFlags,x
	mPLAYTRACK #$2D
	ldx <zObjIndex
.abort
	clc
	rts

;E825
;�N�C�b�N�u�[�������_���[�W����
EnemyTakeDamageByQuickBoomerang:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_QuickBoomerang,y
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne QuickBoomerang_TakeDamageAbort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs QuickBoomerang_TakeDamageAlive
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	lda #$3C
	sta aObjAnim,x
	lda aObjFlags,x
	and #%11000000
	eor #%01000000
	ora #%00000100
	sta aObjFlags,x
	lda #$00
	sta aObjFrame,x
	sta aObjWait,x
	sta aObjVX,x
	sta aObjVYlo,x
	lda #$C0
	sta aObjVXlo,x
	lda #$04
	sta aObjVY,x
	mPLAYTRACK #$2D
QuickBoomerang_TakeDamageAlive_Done:
	ldx <zObjIndex
QuickBoomerang_TakeDamageAbort:
	clc
	rts
QuickBoomerang_TakeDamageAlive:
	lda #%00000000
	sta aObjFlags,y
	beq QuickBoomerang_TakeDamageAlive_Done

;E899
;�N���b�V���{���_���[�W����
EnemyTakeDamageByCrashBomb:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_CrashBomb,y
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne .abort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs QuickBoomerang_TakeDamageAlive
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	lda aObjAnim,x
	cmp #$2F
	beq .abort
;�u���e�{�̔������v�͒e����Ă��X���[
	lda aObjVar,x
	cmp #$02
	beq .abort
;�����ֈڍs����
	lda #$05
	sta aObjFrame,x
	lda #$00
	sta aObjWait,x
	lda #$38
	sta aObjLife,x
	inc aObjVar,x
	mPLAYTRACK #$2D
.abort
	ldx <zObjIndex
	clc
	rts

;E8FD
;���^���u���[�h�_���[�W����
EnemyTakeDamageByMetalBlade:
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_MetalBlade,y
	sta <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	lda aEnemyFlash,x
	bne .abort
	inc aEnemyFlash,x
	sec
	lda aObjLife,x
	sbc <$00
	sta aObjLife,x
	beq .dead
	bcs .alive
.dead
	lda #$00
	sta aObjLife,x
	sec
	rts
.guard
	lda #$03
	sta aObjVY,x
	lda #$B2
	sta aObjVYlo,x
	lda #$01
	sta aObjVX,x
	lda #$87
	sta aObjVXlo,x
	lda aObjFlags,x
	and #%11110000
	sta aObjFlags,x
	mPLAYTRACK #$2D
.alive_done
	ldx <zObjIndex
.abort
	clc
	rts
.alive
	lda #%00000000
	sta aObjFlags,y
	beq .alive_done
;E964
;�^�C���X�g�b�p�[�_���[�W�����i���Ȃ��j
EnemyTakeDamageByTimeStopper:
;����q�b�g���̃��[�`��lo
Table_EnemyTakeDamageInfolo:
	.db LOW(EnemyTakeDamageByRockBuster)
	.db LOW(EnemyTakeDamageByAtomicFire)
	.db LOW(EnemyTakeDamageByAirShooter)
	.db LOW(EnemyTakeDamageByLeafShield)
	.db LOW(EnemyTakeDamageByBubbleLead)
	.db LOW(EnemyTakeDamageByQuickBoomerang)
	.db LOW(EnemyTakeDamageByTimeStopper)
	.db LOW(EnemyTakeDamageByMetalBlade)
	.db LOW(EnemyTakeDamageByCrashBomb)
;E96D
;����q�b�g���̃��[�`��hi
Table_EnemyTakeDamageInfohi:
	.db HIGH(EnemyTakeDamageByRockBuster)
	.db HIGH(EnemyTakeDamageByAtomicFire)
	.db HIGH(EnemyTakeDamageByAirShooter)
	.db HIGH(EnemyTakeDamageByLeafShield)
	.db HIGH(EnemyTakeDamageByBubbleLead)
	.db HIGH(EnemyTakeDamageByQuickBoomerang)
	.db HIGH(EnemyTakeDamageByTimeStopper)
	.db HIGH(EnemyTakeDamageByMetalBlade)
	.db HIGH(EnemyTakeDamageByCrashBomb)

;E976
;�I�u�W�F�N�g���Ƃ̃_���[�W, ���b�N�o�X�^�[
Table_DamageAmount_RockBuster:
	.incbin "src/bin/obj/dmg_RockBuster.bin"
;E9F2
;�I�u�W�F�N�g���Ƃ̃_���[�W, �A�g�~�b�N�t�@�C���[
Table_DamageAmount_AtomicFire:
	.incbin "src/bin/obj/dmg_AtomicFire.bin"
;EA6A
;�I�u�W�F�N�g���Ƃ̃_���[�W, �G�A�[�V���[�^�[
Table_DamageAmount_AirShooter:
	.incbin "src/bin/obj/dmg_AirShooter.bin"
;EAE2
;�I�u�W�F�N�g���Ƃ̃_���[�W, ���[�t�V�[���h
Table_DamageAmount_LeafShield:
	.incbin "src/bin/obj/dmg_LeafShield.bin"
;EB5A
;�I�u�W�F�N�g���Ƃ̃_���[�W, �o�u�����[�h
Table_DamageAmount_BubbleLead:
	.incbin "src/bin/obj/dmg_BubbleLead.bin"
;EBD2
;�I�u�W�F�N�g���Ƃ̃_���[�W, �N�C�b�N�u�[������
Table_DamageAmount_QuickBoomerang:
	.incbin "src/bin/obj/dmg_QuickBoomerang.bin"
;EC4A
;�I�u�W�F�N�g���Ƃ̃_���[�W, �N���b�V���{��
Table_DamageAmount_CrashBomb:
	.incbin "src/bin/obj/dmg_CrashBomb.bin"
;ECC2
;�I�u�W�F�N�g���Ƃ̃_���[�W, ���^���u���[�h
Table_DamageAmount_MetalBlade:
	.incbin "src/bin/obj/dmg_MetalBlade.bin"
;ED3A
;�I�u�W�F�N�g�̑̓�����_���[�W
Table_DamageAmount_Enemy:
	.incbin "src/bin/obj/dmg_Enemy.bin"

