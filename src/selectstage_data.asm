
;8499
Table_PaletteData1A:
	.db $0F, $20, $11, $2C, $0F, $20, $29, $19
	.db $0F, $19, $37, $17, $0F, $28, $15, $05
	.db $0F, $30, $36, $26, $0F, $0F, $28, $05
	.db $0F, $30, $38, $26, $0F, $0F, $36, $26
	
	.db $20, $30, $10, $20, $0F, $30, $20, $10
	.db $0F, $10, $20, $10, $0F, $30, $20, $10
	.db $20, $30, $20, $10, $0F, $30, $20, $10
	.db $0F, $30, $20, $10, $0F, $30, $20, $10
	
;84D9
Table_SelectBoss_SprPalette:
	.db $0F, $0F, $0F, $0F, $0F, $0F, $30, $38
;84E1
Table_SelectBoss_SprPalette_Boss:
	.db $0F, $0F, $28, $15, $0F, $0F, $28, $15
	.db $0F, $0F, $28, $11, $0F, $0F, $28, $11
	.db $0F, $0F, $30, $29, $0F, $0F, $36, $17
	.db $0F, $0F, $30, $19, $0F, $0F, $30, $19
	.db $0F, $0F, $30, $28, $0F, $0F, $28, $15
	.db $0F, $30, $30, $28, $0F, $0F, $30, $12
	.db $0F, $0F, $30, $15, $0F, $0F, $28, $15
	.db $0F, $0F, $30, $30, $0F, $0F, $30, $16
;8521
Table_SelectBoss_Palette_IntroStar:
	.db $00, $00, $07, $10, $17, $20, $17, $20
	.db $17, $20, $17, $20, $17, $20, $17, $20
;8531
Table_SelectBoss_BlackPtrhi:
	.db $21, $20, $21, $20, $20, $22, $22, $22
;8539
Table_SelectBoss_BlackPtrlo:
	.db $86, $8E, $96, $86, $96, $8E, $86, $96
;8541
Table_SelectBoss_Sprite_Data:
	.db $29, $0A, $01, $31, $28, $0B, $00, $3D
	.db $28, $0C, $00, $45
	
	.db $26, $27, $02, $78, $2E, $25, $01, $76
	.db $2E, $26, $01, $7E, $36, $23, $01, $70
	.db $36, $24, $01, $83
	
	.db $17, $2E, $01, $C8, $26, $28, $00, $C0
	.db $2E, $29, $00, $B0, $2E, $2A, $00, $B8
	.db $2E, $2B, $00, $C0, $36, $2C, $00, $B8
	.db $36, $2D, $00, $C0
	
	.db $6C, $06, $00, $3B, $6C, $07, $00, $43
	.db $74, $08, $00, $3B, $74, $09, $00, $43
	
	.db $5F, $0D, $00, $B0, $5F, $0E, $00, $B8
	.db $5F, $0F, $00, $C0, $67, $10, $00, $B0
	.db $67, $11, $00, $B8, $67, $12, $00, $C0
	.db $6F, $13, $00, $B7, $6F, $14, $00, $BF
	.db $77, $15, $00, $B7, $77, $16, $00, $BF
	
	.db $9F, $1F, $00, $38, $A7, $20, $00, $38
	.db $AF, $21, $00, $3B, $AF, $22, $00, $43
	
	.db $A7, $17, $01, $71, $A7, $18, $00, $79
	.db $A7, $19, $02, $81, $AF, $1A, $01, $71
	.db $AF, $1B, $00, $79, $AF, $1C, $00, $81
	.db $B7, $1D, $00, $79, $B7, $1E, $00, $81
	
	.db $9D, $04, $00, $C0, $A5, $05, $00, $C0
	.db $AD, $00, $00, $B6, $AD, $01, $00, $BE
	.db $B5, $02, $00, $B6, $B5, $03, $00, $BE
;85FD
Table_SelectBoss_Sprite_StartPtr:
	.db $3C, $0C, $4C, $00, $20, $84, $74, $A4
;8605
Table_SelectBoss_Sprite_Size:
	.db $10, $14, $28, $0C, $1C, $20, $10, $18
;860D
Table_SelectBoss_CursorSprites:
	.db $F8, $2F, $00, $F9, $F8, $2F, $00, $1F
	.db $1E, $2F, $00, $F9, $1E, $2F, $00, $1F
;861D
Table_SelectBoss_CursorSpritesY:
	.db $60, $20, $20, $20, $60, $A0, $A0, $A0, $60
;8626
Table_SelectBoss_CursorSpritesX:
	.db $70, $30, $70, $B0, $B0, $B0, $70, $30, $30
;862F
;なんだろこれ
	.db $60, $20, $60, $20, $20, $A0, $A0, $A0
	.db $30, $70, $B0, $30, $B0, $70, $30, $B0
;863F
;なんだろこれ
Table_Unknown863F:
	.db $00, $00, $00, $00, $00, $00, $00, $00
	.db $00, $00, $00, $00, $00, $00, $2D, $20
	.db $20, $20, $20, $20, $20, $2C, $00, $00
	.db $00, $00, $00, $00, $00, $00, $00, $00
;865F
Table_ClearStages:
	.db $08, $03, $01, $04, $02, $07, $05, $06, $00
;8668
Table_Unknown8668:
;なんだろこれ
	.db $00, $08, $02, $10, $04, $20, $80, $40, $01
;8671
Table_SelectBoss_BossSprAddrhi:
	.db $98, $99, $9A, $9B, $9C, $9D
	.db $AB, $AC, $AD, $AA, $AB, $AC
	.db $AC, $AD, $AE, $AF, $B0, $B1
	.db $98, $99, $9A, $9B, $9C, $9D
	.db $90, $91, $92, $93, $94, $95
	.db $9E, $9F, $96, $97, $9E, $9F
	.db $B0, $B1, $B2, $B3, $AA, $AB
	.db $AE, $AF, $B0, $B1, $B2, $B3
;86A1
Table_SelectBoss_BossSprAddrBank:
	.db $06, $06, $06, $06, $06, $06
	.db $05, $05, $05, $06, $06, $06
	.db $06, $06, $06, $06, $06, $06
	.db $07, $07, $07, $07, $07, $07
	.db $07, $07, $07, $07, $07, $07
	.db $06, $06, $07, $07, $07, $07
	.db $03, $03, $03, $03, $05, $05
	.db $05, $05, $05, $05, $05, $05
;86D1
Table_ClearMask:
	.db $01, $02, $04, $08, $10, $20, $40, $80
;86D9
Table_String_BossName:
	.db $20, $08, $05, $01, $14, $0D, $01, $0E, $20, $20
	.db $20, $20, $01, $09, $12, $0D, $01, $0E, $20, $20
	.db $20, $17, $0F, $0F, $04, $0D, $01, $0E, $20, $20
	.db $02, $15, $02, $02, $0C, $05, $0D, $01, $0E, $20
	.db $20, $11, $15, $09, $03, $0B, $0D, $01, $0E, $20
	.db $20, $06, $0C, $01, $13, $08, $0D, $01, $0E, $20
	.db $20, $0D, $05, $14, $01, $0C, $0D, $01, $0E, $20
	.db $20, $03, $0C, $01, $13, $08, $0D, $01, $0E, $20
;8729
;ボス紹介の星の座標(y, x)
Table_SelectBoss_IntroStarPos:
	.dw $1810, $8010, $D010, $4014, $9018, $7828, $2030
	
	.dw $F830, $B038, $E840, $9098, $40A0, $E8A0, $90B0, $68B8
	.dw $18C0, $70C8, $C0C8, $D8D0, $60D8, $C8D8, $5018, $5008
	
	.dw $F818, $0820, $A820, $4030, $D038, $5048, $B898, $78A8
	.dw $00B0, $28B8, $C8C0, $20D0, $88E0, $D024, $8834, $303C
	.dw $209C, $D0A4, $58B4, $E8D4, $A0D4
;8187
;ボス紹介アニメーションデータの開始ポインタ
Table_SelectBoss_AnimationPtr:
	.db $00, $18, $29, $32, $37, $41, $49, $4F
;8789
Table_SelectBoss_IntroAnimFrames:
	.db $17, $10, $08, $04, $09, $07, $05, $04
;8791
Table_SelectBoss_IntroAnimWait:
	.db $02, $03, $08 ,$08, $05, $06, $08, $08
;8799
Table_SelectBoss_AnimationData:
	.db $03, $02, $02, $01, $01, $00, $27, $28
	.db $27, $28, $27, $28, $27, $28, $27, $28
	.db $27, $28, $27, $28, $27, $28, $27, $00
	
	.db $1E, $1B, $1B, $1C, $1D, $1C, $1D, $1C
	.db $1D, $1B, $1C, $1D, $1C, $1D, $1C, $1D, $1B
	
	.db $26, $23, $24, $25, $24, $25, $24, $25, $23
	
	.db $04, $04, $04, $05, $06
	
	.db $0F, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $09
	
	.db $16, $10, $11, $12, $13, $14, $15, $12
	
	.db $1A, $17, $17, $17, $18, $19
	
	.db $22, $1F, $1F, $20, $21
;87ED
Table_SelectBoss_AnimFramelo:
	_selectbossanimlo 00, 01, 02, 03, 04, 05, 06, 07
	_selectbossanimlo 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	_selectbossanimlo 10, 11, 12, 13, 14, 15, 16, 17
	_selectbossanimlo 18, 19, 1A, 1B, 1C, 1D, 1E, 1F
	_selectbossanimlo 20, 21, 22, 23, 24, 25, 26, 27
	.db LOW(Table_SelectBossAnim28)
;8816
Table_SelectBoss_AnimFramehi:
	_selectbossanimhi 00, 01, 02, 03, 04, 05, 06, 07
	_selectbossanimhi 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	_selectbossanimhi 10, 11, 12, 13, 14, 15, 16, 17
	_selectbossanimhi 18, 19, 1A, 1B, 1C, 1D, 1E, 1F
	_selectbossanimhi 20, 21, 22, 23, 24, 25, 26, 27
	.db HIGH(Table_SelectBossAnim28)
;883F
Table_SelectBossAnim00:
	.db $0E
	.db $E0, $A0, $03, $FA, $E8, $A1, $03, $F0, $E8, $A2, $03, $F8, $E8, $A3, $03, $00
	.db $E8, $A4, $03, $08, $F0, $A5, $03, $F0, $F0, $A6, $03, $F8, $F0, $A7, $03, $00
	.db $F0, $A8, $03, $08, $F0, $C0, $01, $FA, $F8, $A9, $03, $F0, $F8, $AA, $03, $F8
	.db $F8, $AB, $03, $00, $F8, $AC, $03, $08
;8878
Table_SelectBossAnim01:
	.db $0C
	.db $E0, $AD, $03, $FA, $E0, $AD, $03, $04, $E8, $AE, $03, $F4, $E8, $AF, $03, $FC
	.db $E8, $B0, $03, $04, $F0, $B1, $03, $F4, $F0, $B2, $03, $FC, $F0, $B3, $03, $04
	.db $EF, $C0, $01, $FA, $F8, $B4, $03, $F4, $F8, $B5, $03, $FC, $F8, $B6, $03, $04
;88A9
Table_SelectBossAnim02:
	.db $0A
	.db $E8, $B7, $03, $F8, $E8, $B8, $03, $00, $F0, $B9, $03, $F0, $F0, $BA, $03, $F8
	.db $F0, $BB, $03, $00, $F0, $B9, $43, $08, $F8, $BC, $03, $F0, $F8, $BD, $03, $F8
	.db $F8, $BE, $03, $00, $F8, $BF, $03, $08
;88D2
Table_SelectBossAnim03:
	.db $0B
	.db $E0, $DC, $03, $F8, $E0, $DD, $03, $00, $E8, $DE, $03, $F4, $E8, $E0, $03, $FC
	.db $E8, $E1, $03, $04, $E9, $C0, $01, $FA, $F0, $E2, $03, $F4, $F0, $E3, $03, $FC
	.db $F0, $E4, $03, $04, $F8, $E5, $03, $F7, $F8, $E6, $03, $04
;88FF
Table_SelectBossAnim04:
	.db $0A
	.db $E0, $A0, $03, $F8, $E8, $A1, $03, $F7, $E8, $A2, $03, $FF, $F0, $A3, $03, $F0
	.db $F0, $A4, $03, $F8, $F0, $A5, $03, $00, $F8, $A6, $03, $F0, $F8, $A7, $03, $F8
	.db $F8, $A8, $03, $00, $F8, $A9, $03, $08
;8928
Table_SelectBossAnim05:
	.db $0C
	.db $E0, $AA, $03, $F2, $E0, $AB, $03, $F8, $E8, $AC, $03, $F0, $E8, $AD, $03, $F8
	.db $E8, $AE, $03, $00, $F0, $AF, $03, $F0, $F0, $B0, $03, $F8, $F0, $B1, $03, $00
	.db $F8, $B2, $03, $F0, $F8, $B3, $03, $F8, $F8, $B4, $03, $00, $F8, $B5, $03, $08
;8959
Table_SelectBossAnim06:
	.db $0C
	.db $E0, $B6, $03, $F8, $E8, $B7, $03, $F3, $E8, $B8, $03, $FB, $E8, $B9, $03, $03
	.db $F0, $BA, $03, $F0, $F0, $BB, $03, $F8, $F0, $BC, $03, $00, $F0, $BD, $03, $08
	.db $F8, $BE, $03, $F0, $F8, $BF, $03, $F8, $F8, $C0, $03, $00, $F8, $C1, $03, $08
;898A
Table_SelectBossAnim07:
	.db $0C
	.db $E0, $A0, $03, $F4, $E0, $A1, $03, $04, $E8, $A2, $03, $F4, $E8, $A3, $03, $FC
	.db $E8, $A4, $03, $04, $EC, $BF, $01, $FC, $F0, $A5, $03, $F4, $F0, $A6, $03, $FC
	.db $F0, $A7, $03, $04, $F8, $A8, $03, $F4, $F8, $A9, $03, $FC, $F8, $AA, $03, $04
;89BB
Table_SelectBossAnim08:
	.db $0C
	.db $E0, $A0, $03, $F0, $E0, $A1, $03, $00, $E8, $B6, $03, $EC, $E8, $B7, $03, $F4
	.db $E8, $B8, $03, $FC, $EC, $BF, $01, $F8, $F0, $B9, $03, $F4, $F0, $BA, $03, $FC
	.db $F0, $BB, $03, $04, $F8, $BC, $03, $F4, $F8, $BD, $03, $FC, $F8, $BE, $03, $04
;89EC
Table_SelectBossAnim09:
	.db $0C
	.db $E0, $AB, $03, $04, $E8, $AC, $03, $F4, $E8, $AD, $03, $FC, $E8, $AE, $03, $04
	.db $EE, $BF, $01, $FB, $F0, $AF, $03, $F4, $F0, $B0, $03, $FC, $F0, $B1, $03, $04
	.db $F8, $B2, $03, $EC, $F8, $B3, $03, $F4, $F8, $B4, $03, $FC, $F8, $B5, $03, $04
;8A1D
Table_SelectBossAnim0A:
	.db $0C
	.db $E0, $AB, $03, $04, $E8, $C0, $02, $F4, $E8, $AD, $03, $FC, $E8, $AE, $03, $04
	.db $EE, $BF, $01, $FB, $F0, $AF, $03, $F4, $F0, $B0, $03, $FC, $F0, $B1, $03, $04
	.db $F8, $B2, $03, $EC, $F8, $B3, $03, $F4, $F8, $B4, $03, $FC, $F8, $B5, $03, $04
;8A4E
Table_SelectBossAnim0B:
	.db $0D
	.db $E0, $AB, $03, $04, $E8, $C1, $03, $F4, $E8, $C2, $02, $FC, $E8, $C3, $03, $FC
	.db $E8, $AE, $03, $04, $EE, $BF, $01, $FB, $F0, $AF, $03, $F4, $F0, $B0, $03, $FC
	.db $F0, $B1, $03, $04, $F8, $B2, $03, $EC, $F8, $B3, $03, $F4, $F8, $B4, $03, $FC
	.db $F8, $B5, $03, $04
;8A83
Table_SelectBossAnim0C:
	.db $0D
	.db $E0, $C5, $02, $04, $E8, $AC, $03, $F4, $E8, $C4, $02, $FC, $E8, $C3, $03, $FC
	.db $E8, $AE, $03, $04, $EE, $BF, $01, $FB, $F0, $AF, $03, $F4, $F0, $B0, $03, $FC
	.db $F0, $B1, $03, $04, $F8, $B2, $03, $EC, $F8, $B3, $03, $F4, $F8, $B4, $03, $FC
	.db $F8, $B5, $03, $04
;8AB8
Table_SelectBossAnim0D:
	.db $0D
	.db $E0, $C6, $02, $04, $E8, $AC, $03, $F4, $E8, $AD, $03, $FC, $E8, $AE, $03, $04
	.db $E8, $C7, $02, $04, $EE, $BF, $01, $FB, $F0, $AF, $03, $F4, $F0, $B0, $03, $FC
	.db $F0, $B1, $03, $04, $F8, $B2, $03, $EC, $F8, $B3, $03, $F4, $F8, $B4, $03, $FC
	.db $F8, $B5, $03, $04
;8AED
Table_SelectBossAnim0E:
	.db $0C
	.db $E0, $C8, $02, $04, $E8, $AC, $03, $F4, $E8, $AD, $03, $FC, $E8, $AE, $03, $04
	.db $EE, $BF, $01, $FB, $F0, $AF, $03, $F4, $F0, $B0, $03, $FC, $F0, $B1, $03, $04
	.db $F8, $B2, $03, $EC, $F8, $B3, $03, $F4, $F8, $B4, $03, $FC, $F8, $B5, $03, $04
;8B1E
Table_SelectBossAnim0F:
	.db $0C
	.db $E0, $A0, $03, $F3, $E0, $A1, $03, $03, $E8, $F5, $03, $F2, $E8, $F6, $03, $FA
	.db $E8, $F7, $03, $02, $EC, $BF, $01, $FB, $F0, $F8, $03, $F4, $F0, $F9, $03, $FC
	.db $F0, $FA, $03, $04, $F8, $FB, $03, $F4, $F8, $FC, $03, $FC, $00, $FD, $03, $FD
;8B4F
Table_SelectBossAnim10:
	.db $0D
	.db $E0, $A0, $03, $FC, $E8, $A1, $03, $F6, $E8, $A2, $03, $FE, $E8, $A3, $03, $06
	.db $EB, $F4, $01, $FB, $F0, $A4, $03, $F0, $F0, $A5, $03, $F8, $F0, $A6, $03, $00
	.db $F0, $A7, $03, $08, $F8, $A8, $03, $F0, $F8, $A9, $03, $F8, $F8, $AA, $03, $00
	.db $F8, $AB, $03, $08
;8B84
Table_SelectBossAnim11:
	.db $0E
	.db $E0, $AC, $03, $F1, $E0, $A0, $03, $FE, $E8, $AD, $03, $F0, $E8, $AE, $03, $F8
	.db $E8, $AF, $03, $00, $E8, $B0, $03, $08, $EB, $F4, $01, $FD, $F0, $B1, $03, $F8
	.db $F0, $B2, $03, $00, $F0, $B3, $03, $08, $F8, $B4, $03, $F0, $F8, $B5, $03, $F8
	.db $F8, $B6, $03, $00, $F8, $B7, $03, $08
;8BBD
Table_SelectBossAnim12:
	.db $0D
	.db $E8, $B8, $03, $F0, $E8, $B9, $03, $F8, $E8, $BA, $03, $00, $E8, $BB, $03, $08
	.db $ED, $F4, $01, $FD, $F0, $BC, $03, $F0, $F0, $BD, $03, $F8, $F0, $BE, $03, $00
	.db $F0, $BF, $03, $08, $F8, $C0, $03, $F0, $F8, $C1, $03, $F8, $F8, $C2, $03, $00
	.db $F8, $C3, $03, $08
;8BF2
Table_SelectBossAnim13:
	.db $0D
	.db $E8, $B8, $03, $F0, $E8, $C4, $03, $F8, $E8, $C5, $03, $00, $E8, $BB, $03, $08
	.db $ED, $F4, $01, $FD, $F0, $BC, $03, $F0, $F0, $BD, $03, $F8, $F0, $BE, $03, $00
	.db $F0, $BF, $03, $08, $F8, $C0, $03, $F0, $F8, $C1, $03, $F8, $F8, $C2, $03, $00
	.db $F8, $C3, $03, $08
;8C27
Table_SelectBossAnim14:
	.db $0D
	.db $E8, $B8, $03, $F0, $E8, $B9, $03, $F8, $E8, $BA, $03, $00, $E8, $BB, $03, $08
	.db $ED, $F4, $01, $FD, $F0, $BC, $03, $F0, $F0, $BD, $02, $F8, $F0, $BE, $02, $00
	.db $F0, $BF, $03, $08, $F8, $C0, $03, $F0, $F8, $C6, $03, $F8, $F8, $C7, $03, $00
	.db $F8, $C3, $03, $08
;8C5C
Table_SelectBossAnim15:
	.db $0D
	.db $E8, $B8, $02, $F0, $E8, $B9, $02, $F8, $E8, $BA, $02, $00, $E8, $BB, $02, $08
	.db $ED, $F4, $01, $FD, $F0, $BC, $02, $F0, $F0, $BD, $03, $F8, $F0, $BE, $03, $00
	.db $F0, $BF, $02, $08, $F8, $C0, $02, $F0, $F8, $C8, $02, $F8, $F8, $C9, $03, $00
	.db $F8, $C3, $02, $08
;8C91
Table_SelectBossAnim16:
	.db $0E
	.db $E0, $AC, $03, $F1, $E0, $A0, $03, $FE, $E8, $AD, $03, $F0, $E8, $AE, $03, $F8
	.db $E8, $AF, $03, $00, $E8, $B0, $03, $08, $EB, $F4, $01, $FD, $F0, $D6, $03, $F8
	.db $F0, $D7, $03, $00, $F0, $D8, $03, $08, $F8, $D9, $03, $F8, $F8, $DA, $03, $00
	.db $00, $DB, $03, $F8, $00, $DC, $03, $00
;8CCA
Table_SelectBossAnim17:
	.db $09
	.db $E8, $A1, $03, $F8, $E8, $A2, $03, $00, $E9, $A0, $01, $F9, $F0, $A3, $03, $F4
	.db $F0, $A4, $03, $FC, $F0, $A5, $03, $04, $F8, $A6, $03, $F4, $F8, $A7, $03, $FC
	.db $F8, $A8, $03, $04
;8CEF
Table_SelectBossAnim18:
	.db $0B
	.db $E8, $A9, $03, $F4, $E8, $AA, $03, $FC, $E8, $AB, $03, $04, $EA, $A0, $01, $F6
	.db $F0, $AC, $03, $F1, $F0, $AD, $03, $F9, $F0, $AE, $03, $01, $F8, $AF, $03, $EC
	.db $F8, $B0, $03, $F4, $F8, $B1, $03, $FC, $F8, $B2, $03, $04
;8D1C
Table_SelectBossAnim19:
	.db $09
	.db $E8, $B3, $03, $F4, $E8, $B4, $03, $FC, $E8, $B5, $03, $04, $E9, $A0, $01, $FC
	.db $F0, $B6, $03, $F9, $F0, $B7, $03, $01, $F8, $B8, $03, $F4, $F8, $B9, $03, $FC
	.db $F8, $BA, $03, $04
;8D41
Table_SelectBossAnim1A:
	.db $0A
	.db $E8, $A1, $03, $F8, $E8, $BB, $03, $00, $E9, $A0, $01, $F9, $F0, $BC, $03, $F4
	.db $F0, $BD, $03, $FC, $F0, $BE, $03, $04, $F8, $BF, $03, $F4, $F8, $C0, $03, $FC
	.db $F8, $C1, $03, $04, $00, $C2, $03, $FA
;8D6A
Table_SelectBossAnim1B:
	.db $11
	.db $E0, $A0, $03, $F0, $E0, $A1, $03, $F8, $E0, $A2, $03, $00, $E0, $A3, $03, $08
	.db $E8, $A4, $03, $F0, $E8, $A5, $03, $F8, $E8, $A6, $03, $00, $E8, $A7, $03, $08
	.db $F0, $A8, $03, $F0, $F0, $A9, $03, $F8, $F0, $AA, $03, $00, $F0, $AB, $03, $08
	.db $F8, $AC, $03, $F0, $F8, $AD, $03, $F8, $F8, $AE, $03, $00, $F8, $AF, $03, $08
	.db $E2, $DE, $01, $FB
;8DAF
Table_SelectBossAnim1C:
	.db $12
	.db $E0, $B0, $03, $F6, $E0, $B1, $03, $FE, $E0, $B2, $03, $06, $E0, $B3, $03, $0E
	.db $E8, $B4, $03, $F0, $E8, $B5, $03, $F8, $E8, $B6, $03, $00, $E8, $B7, $03, $08
	.db $E8, $B8, $03, $10, $F0, $B9, $03, $F0, $F0, $BA, $03, $F8, $F0, $BB, $03, $00
	.db $F0, $BC, $03, $08, $F8, $BD, $03, $F0, $F8, $BE, $03, $F8, $F8, $BF, $03, $00
	.db $F8, $C0, $03, $08, $E4, $DE, $01, $FB
;8DF8
Table_SelectBossAnim1D:
	.db $12
	.db $E0, $B0, $03, $F6, $E0, $B1, $03, $FE, $E0, $B2, $03, $06, $E0, $B3, $03, $0E
	.db $E8, $B4, $03, $F0, $E8, $C1, $03, $F8, $E8, $C2, $03, $00, $E8, $B7, $03, $08
	.db $E8, $B8, $03, $10, $F0, $B9, $03, $F0, $F0, $C3, $03, $F8, $F0, $C4, $03, $00
	.db $F0, $BC, $03, $08, $F8, $BD, $03, $F0, $F8, $BE, $03, $F8, $F8, $BF, $03, $00
	.db $F8, $C0, $03, $08, $E4, $DE, $01, $FB
;8E41
Table_SelectBossAnim1E:
	.db $13
	.db $E0, $B0, $03, $F6, $E0, $B1, $03, $FE, $E0, $B2, $03, $06, $E0, $B3, $03, $0A
	.db $E8, $B4, $03, $F0, $E8, $B5, $03, $F8, $E8, $B6, $03, $00, $E8, $B7, $03, $08
	.db $E8, $B8, $03, $10, $F0, $C5, $03, $F0, $F0, $C6, $03, $F8, $F0, $C7, $03, $00
	.db $F0, $C8, $03, $08, $F8, $C9, $03, $F5, $F8, $CA, $03, $FD, $F8, $CB, $03, $05
	.db $00, $CC, $03, $F5, $00, $CD, $03, $05, $E4, $DE, $01, $FB
;8E8E
Table_SelectBossAnim1F:
	.db $0B
	.db $E8, $A0, $03, $F8, $E8, $A1, $03, $00, $F0, $A2, $03, $F0, $F0, $A3, $03, $F8
	.db $F0, $A4, $03, $00, $F0, $A5, $03, $08, $F8, $A6, $03, $F0, $F8, $A7, $03, $F8
	.db $F8, $A8, $03, $00, $F8, $A9, $03, $08, $ED, $F3, $01, $FA
;8EBB
Table_SelectBossAnim20:
	.db $0D
	.db $E0, $AA, $03, $F0, $E0, $AB, $03, $F8, $E8, $AC, $03, $F0, $E8, $AD, $03, $F8
	.db $E8, $AE, $03, $00, $F0, $AF, $03, $F0, $F0, $B0, $03, $F8, $F0, $B1, $03, $00
	.db $F8, $B2, $03, $F0, $F8, $B3, $03, $F8, $F8, $B4, $03, $00, $F8, $B5, $03, $08
	.db $ED, $F3, $01, $F9
;8EF0
Table_SelectBossAnim21:
	.db $0D
	.db $E8, $B6, $03, $F0, $E8, $B7, $03, $F8, $E8, $B8, $03, $00, $E8, $B9, $03, $08
	.db $F0, $BA, $03, $F0, $F0, $BB, $03, $F8, $F0, $BC, $03, $00, $F0, $BD, $03, $08
	.db $F8, $BE, $03, $F0, $F8, $BF, $03, $F8, $F8, $C0, $03, $00, $F8, $C1, $03, $08
	.db $ED, $F3, $01, $FC
;8F25
Table_SelectBossAnim22:
	.db $0E
	.db $E8, $B6, $03, $EE, $E8, $B7, $03, $F6, $E8, $B8, $03, $FE, $E8, $B9, $03, $06
	.db $F0, $BA, $03, $EE, $F0, $BB, $03, $F6, $F0, $BC, $03, $FE, $F0, $BD, $03, $06
	.db $F8, $C2, $03, $F8, $F8, $C3, $03, $00, $F8, $C4, $03, $08, $00, $C5, $03, $F8
	.db $00, $C6, $03, $00, $ED, $F3, $01, $FB
;8F5E
Table_SelectBossAnim23:
	.db $10
	.db $E0, $A0, $03, $F8, $E0, $A1, $03, $00, $E0, $A2, $03, $08, $E8, $A3, $03, $F0
	.db $E8, $A4, $03, $F8, $E8, $A5, $03, $00, $E8, $A6, $03, $08, $F0, $A7, $03, $F0
	.db $F0, $A8, $03, $F8, $F0, $A9, $03, $00, $F0, $AA, $03, $08, $F8, $AB, $03, $F0
	.db $F8, $AC, $03, $F8, $F8, $AC, $43, $00, $F8, $AD, $03, $08, $E7, $F4, $02, $FA
;8F9F
Table_SelectBossAnim24:
	.db $0F
	.db $E0, $AE, $03, $F8, $E0, $AF, $03, $00, $E0, $B0, $03, $08, $E8, $B1, $03, $F0
	.db $E8, $B2, $03, $F8, $E8, $B3, $03, $00, $E8, $B4, $03, $08, $F0, $B5, $03, $F5
	.db $F0, $B6, $03, $FD, $F0, $B7, $03, $05, $F8, $B8, $03, $F0, $F8, $B9, $03, $F8
	.db $F8, $BA, $03, $00, $F8, $BB, $03, $08, $E8, $F4, $02, $FA
;8FDC
Table_SelectBossAnim25:
	.db $10
	.db $E0, $AE, $03, $F8, $E0, $AF, $03, $00, $E0, $B0, $03, $08, $E8, $BC, $03, $F0
	.db $E8, $BD, $03, $F8, $E8, $BE, $03, $00, $E8, $BF, $03, $08, $F0, $C0, $03, $F0
	.db $F0, $C1, $03, $F8, $F0, $C2, $03, $00, $F0, $C3, $03, $08, $F8, $B8, $03, $F0
	.db $F8, $B9, $03, $F8, $F8, $BA, $03, $00, $F8, $BB, $03, $08, $E8, $F4, $02, $FA
;901D
Table_SelectBossAnim26:
	.db $11
	.db $E0, $A0, $03, $F8, $E0, $A1, $03, $00, $E0, $CC, $03, $08, $E8, $CD, $03, $F0
	.db $E8, $CE, $03, $F8, $E8, $A5, $03, $00, $E8, $CF, $03, $08, $F0, $D0, $03, $F0
	.db $F0, $D1, $03, $F8, $F0, $D2, $03, $00, $F0, $D3, $03, $08, $F8, $D4, $03, $F0
	.db $F8, $D5, $03, $F8, $F8, $D5, $03, $00, $F8, $D6, $03, $08, $E7, $F4, $02, $FA
	.db $E0, $CB, $03, $F0
;9062
Table_SelectBossAnim27:
	.db $11
	.db $E0, $C1, $03, $F0, $E0, $C2, $03, $F8, $E0, $C3, $03, $00, $E0, $C4, $03, $08
	.db $E8, $C5, $03, $F0, $E8, $A2, $03, $F8, $E8, $C6, $03, $00, $E8, $C7, $03, $08
	.db $F0, $C8, $03, $F0, $F0, $A6, $03, $F8, $F0, $A7, $03, $00, $F0, $C9, $03, $08
	.db $F0, $C0, $01, $FA, $F8, $CA, $03, $F0, $F8, $CB, $03, $F8, $F8, $CC, $03, $00
	.db $F8, $CD, $03, $08
;90A7
Table_SelectBossAnim28:
	.db $11
	.db $E0, $CE, $03, $F0, $E0, $CF, $03, $F8, $E0, $D0, $03, $00, $E0, $D1, $03, $08
	.db $E8, $D2, $03, $F0, $E8, $A2, $03, $F8, $E8, $D3, $03, $00, $E8, $D4, $03, $08
	.db $F0, $D5, $03, $F0, $F0, $A6, $03, $F8, $F0, $A7, $03, $00, $F0, $C9, $03, $08
	.db $F0, $C0, $01, $FA, $F8, $CA, $03, $F0, $F8, $CB, $03, $F8, $F8, $CC, $03, $00
	.db $F8, $CD, $03, $08

