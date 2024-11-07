;原作と一致しないデータなどを修正するためのファイル。

;停止中のオブジェクトの処理アドレスで変な部分がある
;9489
;	mBEGINRAW $1C, $9489
;	.db $E6

;当たり判定テーブルの修正
;D4E1
;	mBEGINRAW $1E, Table_CollisionSizeX + $0A
;	.db $09
;	.org Table_CollisionSizeX + CollisionDataLength * 2 + $10
;	.db $0A

;アニメーションのポインタの修正
;F900
;	.org Table_AnimationPointerEnemy_Low + $4D
;	.db LOW(en35)
;	.org Table_AnimationPointerEnemy_Low + $52
;	.db LOW(en50)
;	.org Table_AnimationPointerEnemy_Low + $57
;	.db LOW(en2F)
;	.org Table_AnimationPointerEnemy_Low + $67
;	.db LOW(en1C)
;	.org Table_AnimationPointerEnemy_High + $67
;	.db HIGH(en1C)
;	.org Table_AnimationPointerEnemy_Low + $6F
;	.db LOW(en35)
;	.org Table_AnimationPointerEnemy_High + $6F
;	.db HIGH(en35)

	;TODO 後でスプライト定義バンク全体をアセンブリソースに落とし込みたい
	;ゴブリンの角の画像定義を変更したのを反映する
	mBEGIN $0A, $A750
	.db $04, $17, $F2, $02, $F2, $42, $F3, $02, $F3, $42
	;ショットマンの画像定義の変更（A列 → F列, B列 → D列, $AF → $DC）
	mBEGIN $0A, $A162
	.db $0D, $33
	.db $F0, $03, $F1, $03, $F2, $03, $F3, $03, $F4, $03, $F5, $03, $F6, $03, $F7, $03
	.db $F8, $03, $F9, $03, $F9, $43, $F8, $43, $FD, $02
	.db $0D, $33
	.db $F0, $03, $F1, $03, $FA, $03, $FB, $03, $F4, $03, $F5, $03, $F6, $03, $FC, $03
	.db $F8, $03, $F9, $03, $F9, $43, $F8, $43, $FD, $02
	.db $0D, $33
	.db $FE, $03, $DC, $03, $D0, $03, $F3, $03, $D1, $03, $D2, $03, $D3, $03, $F7, $03
	.db $F8, $03, $D4, $03, $D5, $03, $F8, $43, $D7, $02
	.db $0D, $33
	.db $FE, $03, $DC, $03, $D6, $03, $FB, $03, $D1, $03, $D2, $03, $D3, $03, $FC, $03
	.db $F8, $03, $D4, $03, $D5, $03, $F8, $43, $D7, $02
	.db $0E, $33
	.db $D9, $03, $DA, $03, $F2, $03, $F3, $03, $8F, $03, $F5, $03, $F6, $03, $F7, $03
	.db $F8, $03, $F9, $03, $F9, $43, $F8, $43, $DB, $02, $D8, $03
	.db $0E, $33
	.db $D9, $03, $DA, $03, $F2, $03, $FB, $03, $8F, $03, $F5, $03, $F6, $03, $FC, $03
	.db $F8, $03, $F9, $03, $F9, $43, $F8, $43, $DB, $02, $D8, $03
