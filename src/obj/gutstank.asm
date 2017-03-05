
;939B
;ガッツtンク
GutsTank:
	dex
	mMOV Table_GutsTankBehaviourlo,x, <zPtrlo
	mMOV Table_GutsTankBehaviourhi,x, <zPtrhi
	jmp [zPtr]

;93A9
;1, ガッツタンク 登場時
GutsTank1:
	

;94AD
;2, ガッツタンク 
GutsTank2:
	

;951D
;3, ガッツタンク
GutsTank3:
	

;9537
;5, ガッツタンク
GutsTank5:
	

;9547
;4, ガッツタンク
GutsTank4:
	

;954B
;6, ガッツタンク
GutsTank6:
	

;9662
;ガッツタンク行動アドレス下位
Table_GutsTankBehaviourlo:
	.db LOW(GutsTank1)
	.db LOW(GutsTank2)
	.db LOW(GutsTank3)
	.db LOW(GutsTank4)
	.db LOW(GutsTank5)
	.db LOW(GutsTank6)

;9668
;ガッツタンク行動アドレス上位
Table_GutsTankBehaviourhi:
	.db HIGH(GutsTank1)
	.db HIGH(GutsTank2)
	.db HIGH(GutsTank3)
	.db HIGH(GutsTank4)
	.db HIGH(GutsTank5)
	.db HIGH(GutsTank6)
