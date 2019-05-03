
;ベースキー指定 オクターブごとのCの発音位置
O1A = 8
O2 = $0B
O3 = $17
O4 = $23
O5 = $2F
O6 = $3B
O7 = $47
O8 = $53

TRACK .macro
	.db $0F
	.db LOW(\1), HIGH(\1)
	.db LOW(\2), HIGH(\2)
	.db LOW(\3), HIGH(\3)
	.db LOW(\4), HIGH(\4)
	.db LOW(\5), HIGH(\5)
	.endm

TEMPO .macro
	.db 0, \1
	.endm

PITCH .macro
	.db 1, \1
	.endm

TONE .macro
	.db 2, \1 << 6
	.endm

VOL .macro
	.db 3, $30 + \1
	.endm

VOLRAW .macro
	.db 3, \1
	.endm

LOOP .macro
	.db 4, \1, LOW(\2), HIGH(\2)
	.endm

KEY .macro
	.db 5, \1
	.endm

DOT .macro
	.db 6
	.endm

ENV .macro
	.if \30 = 0
	.db 7, \1 + $80, \2 << 4
	.else
	.db 7, \1, \2 << 4
	.endif
	.endm

MOD .macro
	.db 8, \1
	.endm

END .macro
	.db 9
	.endm

TIE .macro
	.if \10 = 0
	.db $19
	.else
	.db $18 + \1
	.endif
	.endm

SHORT .macro
	.db $0A
	.endm

PITCH0 .macro
	.db $0B
	.endm

VOLUP .macro
	.db $0C
	.endm

VOLDOWN .macro
	.db $0D
	.endm

n .macro
	.db (\1 << 5) + \2 + $20
	.endm
n0 .macro
	.if \10 = 0
	.db $20
	.else
	.db $20 + \1
	.endif
	.endm
n1 .macro
	.if \10 = 0
	.db $40
	.else
	.db $40 + \1
	.endif
	.endm
n2 .macro
	.if \10 = 0
	.db $60
	.else
	.db $60 + \1
	.endif
	.endm
n3 .macro
	.if \10 = 0
	.db $80
	.else
	.db $80 + \1
	.endif
	.endm
n4 .macro
	.if \10 = 0
	.db $A0
	.else
	.db $A0 + \1
	.endif
	.endm
n5 .macro
	.if \10 = 0
	.db $C0
	.else
	.db $C0 + \1
	.endif
	.endm
n6 .macro
	.if \10 = 0
	.db $E0
	.else
	.db $E0 + \1
	.endif
	.endm

