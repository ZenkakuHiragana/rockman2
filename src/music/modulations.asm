
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
MOD_3d1t1f = 5
    .dw $A101, $0080 ;エグゼ6ボス戦のギターの音
MOD_4d2t1f = 6
    .dw $8201, $0080 ;ポーキーのポーキーのビブラート
MOD_DEATHTRAP = 7
    .dw $4304, $0080 ;Deathtrap Mirageのブーン
MOD_2d2t2f = 8
    .dw $4202, $0080 ;ScarfaceのボーカルにかかるMOD
MOD_3d3t1f = 9
    .dw $6301, $0080 ;Scarfaceのボーカルがビブラートしてる時のMOD
MOD_STONECOLD = 10
    .dw $0000, $0F01 ;Stone Coldの音量モジュレーション
