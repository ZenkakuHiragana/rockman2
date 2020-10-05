
;ベースキー指定 オクターブごとのCの発音位置
O1A = 8
O2 = $0B
O3 = $17
O4 = $23
O5 = $2F
O6 = $3B
O7 = $47
O8 = $53

BPM .func (\1) * 256 / 75
TRACK .macro
	.db $0F
	.db LOW(\1), HIGH(\1)
	.db LOW(\2), HIGH(\2)
	.db LOW(\3), HIGH(\3)
	.db LOW(\4), HIGH(\4)
	.db LOW(\5), HIGH(\5)
	.endm

TEMPO .macro
	.db 0
	.dw \1 ;usage: TEMPO BPM(NewTempo)
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

LOOP2 .macro
	.db #$0B, \1 << 5, LOW(\2), HIGH(\2)
	.endm

KEY .macro
	.db 5, \1
	.endm

DOT .macro
	.db 6
	.if \?1
	\1
	.endif
	.endm

ENV .macro
	.if \?3
	.db 7, \1, \2 << 4
	.else
	.db 7, \1 + $80, \2 << 4
	.endif
	.endm

MOD .macro
	.db 8, \1
	.endm

END .macro
	.db 9
	.endm

TIE .macro
	.if \?1
	.db $18 + \1
	.else
	.db $19
	.endif
	.endm

SHORT .macro
	.db $0A
	.if \?1
	\1
	.endif
	.endm

PITCH0 .macro ; alias of PITCH 0, deprecated
	PITCH 0
	.endm

VOLUP .macro
	.db $0C
	.endm
TOMHIGH .macro
	VOLUP
	.endm

VOLDOWN .macro
	.db $0D
	.endm
TOMLOW .macro
	VOLDOWN
	.endm

BEND .macro
	.db $10
	\1 ; Note destination
	\2 ; Note start
	.endm

BENDSPEED .macro
	.db $0E, \1
	.endm

SLUR .macro
	.db $0F
	.if \?1
	\1
	.endif
	.endm

CALL .macro
	.db #$11, LOW(\1), HIGH(\1)
	.endm

RETURN .macro
	.db #$11
	.endm

n .macro
	.db (\1 << 5) + \2 + $20
	.endm
n0 .macro
	.if \?1
	.db $20 + \1
	.else
	.db $20
	.endif
	.endm
n1 .macro
	.if \?1
	.db $40 + \1
	.else
	.db $40
	.endif
	.endm
n2 .macro
	.if \?1
	.db $60 + \1
	.else
	.db $60
	.endif
	.endm
n3 .macro
	.if \?1
	.db $80 + \1
	.else
	.db $80
	.endif
	.endm
n4 .macro
	.if \?1
	.db $A0 + \1
	.else
	.db $A0
	.endif
	.endm
n5 .macro
	.if \?1
	.db $C0 + \1
	.else
	.db $C0
	.endif
	.endm
n6 .macro
	.if \?1
	.db $E0 + \1
	.else
	.db $E0
	.endif
	.endm

