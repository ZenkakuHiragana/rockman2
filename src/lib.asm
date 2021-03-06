

mBEGIN	.macro
	.bank \1*2
	.org \2
	.endm

mBEGINRAW .macro
	.bank \1
	.org \2
	.endm

mBEGINLABEL .macro
	.bank BANK(\1)
	.org \1
	.endm

mJSR_NORTS .macro
	.ifdef ___NORTS
		jmp \1
	.else
		jsr \1
		rts
	.endif
	.endm
mJSRJMP .macro
	.ifdef ___JSRJMP
		jmp \1
	.else
		jsr \1
	.endif
	.endm

mCLC .macro
	.ifndef ___NOCLC
		clc
	.endif
	.endm

mSEC .macro
	.ifndef ___NOSEC
		sec
	.endif
	.endm

mCHANGEBANK .macro
	lda \1
	.if \?2
	mJSR_NORTS ChangeBank
	.else
	jsr ChangeBank
	.endif
	.endm

mPLAYTRACK .macro
	lda \1
	.if \?2
	mJSR_NORTS PlayTrack
	.else
	jsr PlayTrack
	.endif
	.endm

mSTOREALL .macro
	.if \?4
		sta \4
	.endif
	.if \?5
		sta \5
	.endif
	.if \?6
		sta \6
	.endif
	.if \?7
		sta \7
	.endif
	.if \?8
		sta \8
	.endif
	.if \?9
		sta \9
	.endif
	.endm

mMOV .macro
	lda \1
	sta \2
	.if \?3
		sta \3
	.endif
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.endm

mMOVW .macro
	lda #LOW(\1)
	sta \2
	lda #HIGH(\1)
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \2+1
	.endif
	.endm

mMOVWB .macro
	lda #HIGH(\1)
	sta \2
	lda #LOW(\1)
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \2+1
	.endif
	.endm

mSTZ .macro
	lda #$00
	sta \1
	.if \?2
		sta \2
	.endif
	.if \?3
		sta \3
	.endif
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.endm

mADD .macro
	lda \1
	.if \?2
	adc \2
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.else
	adc #$00
	sta \1
	.endif
	.endm

mSUB .macro
	lda \1
	.if \?2
	sbc \2
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.else
	sbc #$00
	sta \1
	.endif
	.endm

mORA .macro
	lda \1
	ora \2
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.endm

mAND .macro
	lda \1
	and \2
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.endm

mEOR .macro
	lda \1
	.if \?2
	eor \2
	.if \?3
	sta \3
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.else
	eor #$FF
	sta \1
	.endif
	.endm

mNEGC .macro
	clc
	lda \1
	eor #$FF
	adc #$01
	.if \?2
	sta \2
	.if \?3
	sta \3
	.endif
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.endm
	
mNEG .macro
	lda \1
	eor #$FF
	adc #$01
	.if \?2
	sta \2
	.if \?3
	sta \3
	.endif
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.endm

mNEGhi .macro
	lda \1
	eor #$FF
	adc #$00
	.if \?2
	sta \2
	.if \?3
	sta \3
	.endif
	mSTOREALL \1, \2, \3, \4, \5, \6, \7, \8, \9
	.else
	sta \1
	.endif
	.endm

_collisionx .macro
	.db $08+\1, $0C+\1, $0C+\1, $0C+\1
	.db $04+\1, $10+\1, $28+\1, $08+\1
	.db $0C+\1, $10+\1, $00+\1, $28+\1
	.db $04+\1, $10+\1, $08+\1, $06+\1
	.db $04+\1, $18+\1, $18+\1, $20+\1
	.db $40+\1, $02,    $00+\1, $00+\1
	.db $00+\1, $00+\1, $00+\1, $00+\1
	.db $00+\1, $00+\1, $00+\1, $00+\1
	.endm
_collisiony .macro
	.db $10+\1, $0C+\1, $08+\1, $04+\1
	.db $04+\1, $08+\1, $20+\1, $08+\1
	.db $16+\1, $10+\1, $20+\1, $28+\1
	.db $0C+\1, $1C+\1, $04+\1, $08+\1
	.db $10+\1, $08+\1, $18+\1, $30+\1
	.db $10+\1, $10+\1, $00+\1, $00+\1
	.db $00+\1, $00+\1, $00+\1, $00+\1
	.db $00+\1, $00+\1, $00+\1, $00+\1
	.endm

_enemyptrlo .macro
	.db LOW(EN\1), LOW(EN\2), LOW(EN\3), LOW(EN\4)
	.db LOW(EN\5), LOW(EN\6), LOW(EN\7), LOW(EN\8)
	.endm
_enemyptrhi .macro
	.db HIGH(EN\1), HIGH(EN\2), HIGH(EN\3), HIGH(EN\4)
	.db HIGH(EN\5), HIGH(EN\6), HIGH(EN\7), HIGH(EN\8)
	.endm

_selectbossanimlo .macro
	.db LOW(Table_SelectBossAnim\1), LOW(Table_SelectBossAnim\2)
	.db LOW(Table_SelectBossAnim\3), LOW(Table_SelectBossAnim\4)
	.db LOW(Table_SelectBossAnim\5), LOW(Table_SelectBossAnim\6)
	.db LOW(Table_SelectBossAnim\7), LOW(Table_SelectBossAnim\8)
	.endm
_selectbossanimhi .macro
	.db HIGH(Table_SelectBossAnim\1), HIGH(Table_SelectBossAnim\2)
	.db HIGH(Table_SelectBossAnim\3), HIGH(Table_SelectBossAnim\4)
	.db HIGH(Table_SelectBossAnim\5), HIGH(Table_SelectBossAnim\6)
	.db HIGH(Table_SelectBossAnim\7), HIGH(Table_SelectBossAnim\8)
	.endm

;サイズ測定
;測定始点と終点をlist, mNULL, nolistで挟む
;出てきた.lstファイルにあるアドレスの差を読む
mNULL .macro
	.endm
