
;20 57 E5
;Obj[x]のロックマンへの接触処理/x破壊
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
	lda aObjY,x
	sbc <zVScroll
	sta <$00
	sec
	lda aObjY
	sbc <zVScroll
	sec
	sbc <$00
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
	ldx <zObjIndex
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
	ldy aItemOrder,x
	lda #$FF
	sta aItemOrder,x
	lda #$00
	sta aItemLife - 1,y
.skip
	rts

;20 E9 E5
;Obj[x]とロックマンの武器とのヒット処理
EnemyTakeDamage:
	lda aEnemyFlash,x
	bne .abort
	sec
	mSUB aObjY,x, <zVScroll, <$00
	mMOV aObjCollision,x, <$08
;時間方向への間引きによる最適化らしい
	ldx #$09
	lda <zFrameCounter
	lsr a
	bcs .loop
	dex
.loop
;武器一つずつに対してのループ
	lda aObjFlags,x
	bpl .skip
	lsr a
	bcc .skip
	clc
	ldy aWeaponCollision,x
	lda Table_WeaponCollisionOffset,y
	adc <$08
	tay
;|ΔX|を計算
	sec
	lda <zEScreenX
	sbc aWeaponScreenX,x
	bcs .inv_x
	eor #$FF
	adc #$01
.inv_x
;比較
	cmp Table_CollisionSizeX,y
	bcs .skip
	sec
	lda aObjY,x
	sbc <zVScroll
	sec
	sbc <$00
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
.abort
	mSTZ aEnemyFlash,x
	clc
	rts
.hit
	ldy <zEquipment
	mMOV Table_EnemyTakeDamageInfolo,y, <zPtrlo
	mMOV Table_EnemyTakeDamageInfohi,y, <zPtrhi
	ldy <zObjIndex
	lda aObjFlags,y
	and #%00001000
	jmp [zPtr]

;E64F
;ロックバスターダメージ処理
EnemyTakeDamageByRockBuster:
	bne .guard
	lda aObjAnim,y
	tay
	lda Table_DamageAmount_RockBuster,y
	sta <$00
	beq .guard
	lsr aObjFlags,x
	mPLAYTRACK #$2B
	ldx <zObjIndex
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
;アトミックファイアーダメージ処理
EnemyTakeDamageByAtomicFire:
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
;エアーシューターダメージ処理
EnemyTakeDamageByAirShooter:
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
;リーフシールドダメージ処理
EnemyTakeDamageByLeafShield:
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
;バブルリードダメージ処理
EnemyTakeDamageByBubbleLead:
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
;クイックブーメランダメージ処理
EnemyTakeDamageByQuickBoomerang:
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
;クラッシュボムダメージ処理
EnemyTakeDamageByCrashBomb:
	bne .guard
	lda aObjAnim,y
	tay
	mMOV Table_DamageAmount_CrashBomb,y, <$00
	beq .guard
	txa
	pha
	mPLAYTRACK #$2B
	pla
	tay
	ldx <zObjIndex
	inc aEnemyFlash,x
	sec
	mSUB aObjLife,x, <$00
	beq .dead
	bcs QuickBoomerang_TakeDamageAlive
.dead
	mSTZ aObjLife,x
	sec
	rts
.guard
	lda aObjAnim,x
	cmp #$2F
	beq .abort
;「爆弾本体爆発中」は弾かれてもスルー
	lda aObjVar,x
	cmp #$02
	beq .abort
;爆発へ移行する
	mAND aObjFlags,x, #~$00000001
	mMOV #$05, aObjFrame,x
	mMOV #$01, aObjLife,x
	lsr a
	sta aObjWait,x
	inc aObjVar,x
	mPLAYTRACK #$2D
.abort
	ldx <zObjIndex
	clc
	rts

;E8FD
;メタルブレードダメージ処理
EnemyTakeDamageByMetalBlade:
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
;タイムストッパーダメージ処理（来ない）
EnemyTakeDamageByTimeStopper:
;武器ヒット時のルーチンlo
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
;武器ヒット時のルーチンhi
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
;オブジェクトごとのダメージ, ロックバスター
Table_DamageAmount_RockBuster:
	.incbin "src/bin/obj/dmg_RockBuster.bin"
;E9F2
;オブジェクトごとのダメージ, アトミックファイヤー
Table_DamageAmount_AtomicFire:
	.incbin "src/bin/obj/dmg_AtomicFire.bin"
;EA6A
;オブジェクトごとのダメージ, エアーシューター
Table_DamageAmount_AirShooter:
	.incbin "src/bin/obj/dmg_AirShooter.bin"
;EAE2
;オブジェクトごとのダメージ, リーフシールド
Table_DamageAmount_LeafShield:
	.incbin "src/bin/obj/dmg_LeafShield.bin"
;EB5A
;オブジェクトごとのダメージ, バブルリード
Table_DamageAmount_BubbleLead:
	.incbin "src/bin/obj/dmg_BubbleLead.bin"
;EBD2
;オブジェクトごとのダメージ, クイックブーメラン
Table_DamageAmount_QuickBoomerang:
	.incbin "src/bin/obj/dmg_QuickBoomerang.bin"
;EC4A
;オブジェクトごとのダメージ, クラッシュボム
Table_DamageAmount_CrashBomb:
	.incbin "src/bin/obj/dmg_CrashBomb.bin"
;ECC2
;オブジェクトごとのダメージ, メタルブレード
Table_DamageAmount_MetalBlade:
	.incbin "src/bin/obj/dmg_MetalBlade.bin"
;ED3A
;オブジェクトの体当たりダメージ
Table_DamageAmount_Enemy:
	.incbin "src/bin/obj/dmg_Enemy.bin"

