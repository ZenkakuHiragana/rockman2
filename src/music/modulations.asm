
;Sound_Modulations:
    .dw $0000, $0080
MOD_1d1t1f = 1 ;1 diff, 1 times, every 1 frame, pitch bend
    .dw $2101, $0080 ;細かいビブラート
MOD_1d1t2f = 2
    .dw $2102, $0080 ;もっと弱いビブラート
MOD_1d1t3f = 3
    .dw $2103, $0080 ;スパボン6面の弱いビブラート
MOD_1d2t1f = 4
    .dw $2201, $0080 ;弱いビブラート
MOD_4d2t1f = 5
    .dw $8201, $0080 ;ポーキーのポーキーのビブラート
MOD_DEATHTRAP = 6
    .dw $4304, $0080 ;Deathtrap Mirageのブーン
