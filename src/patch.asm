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

;ゴブリンの角の画像定義を変更したのを反映する
;後でスプライト定義バンク全体をアセンブリソースに落とし込みたい
	mBEGIN $0A, $A750
	.db $04, $17, $F2, $02, $F2, $42, $F3, $02, $F3, $42
