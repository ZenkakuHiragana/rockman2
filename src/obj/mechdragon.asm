
;8CC3
;メカドラゴン
MechDragon:
	dex
	mMOV Table_CrashmanBehaviourlo,x, <zPtrlo
	mMOV Table_CrashmanBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;8E1E
;2, メカドラゴン
MechDragon2:
	

;9205
;メカドラゴン行動アドレス下位
Table_MechDragonBehaviourlo:
	.db LOW(BossBehaviour_Spawn)
	.db LOW(MechDragon2)
	.db LOW(MechDragon3)
	.db LOW(MechDragon4)
	.db LOW(MechDragon5)
	.db LOW(MechDragon6)
	.db LOW(MechDragon7)
;920C
;メカドラゴン行動アドレス上位
Table_MechDragonBehaviourhi:
	.db HIGH(BossBehaviour_Spawn)
	.db HIGH(MechDragon2)
	.db HIGH(MechDragon3)
	.db HIGH(MechDragon4)
	.db HIGH(MechDragon5)
	.db HIGH(MechDragon6)
	.db HIGH(MechDragon7)
