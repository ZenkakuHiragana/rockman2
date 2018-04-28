
	mBEGIN #$0C, #$8000
	
	jmp Sound_ProcessTracks
	
;8003
;20 51 C0で予約された曲を鳴らし始める処理
SOUND_STARTPLAY: ;A = 曲番号
	cmp #$FC
	bne .notFC
	jmp Bank0C_StartFC ;A = #$FC
.notFC
	cmp #$FD
	bne .notFD
	jmp Bank0C_StartFD ;A = #$FD
.notFD
	cmp #$FE
	bne .notFE
	mMOV #$01, <zNMILock
	mSTZ <zSoundBase
	jmp Bank0C_StartFE ;A = #$FE
.notFE
	cmp #$FF
	bne .other
	mMOV #$01, <zNMILock
	mSTZ <zSoundBase
	jmp Bank0C_StartFF ;A = #$FF
.other
	asl a
	tax
	mMOV $8A50,x, <zTrackPtr
	mMOV $8A51,x, <zTrackPtrhi
	ldy #$00
	lda [zTrackPtr],y
	tax
	and #$0F
	beq Bank0CStartSFX
	
;8044, 曲セットアップ開始
.TestStrength = zSoundVar1
	lda <zSoundAttr
	and #$0F
	sta <.TestStrength
	cpx <.TestStrength
	bcs .play_music ;現在の優先度 - 鳴らそうとする曲の優先度X ≧ 0の時続行
	rts
;曲の上書き優先順位00～0Fが大きい時鳴らす
.play_music
	stx <.TestStrength
	lda <zSoundAttr
	and #$F0
	ora <.TestStrength
	sta <zSoundAttr ;優先度を更新
	mMOV #$01, <zNMILock
	.ifndef ___OPTIMIZE
	mSTZ <zSoundBase
	mSTZ <zSoundSpeed, <zSoundFade
	.else
	mSTZ <zSoundBase, <zSoundSpeed, <zSoundFade
	.endif
;8067, 曲セットアップのチャンネルごとのループ開始
.LoopCounter = zSoundVar1
	mMOV #$04, <.LoopCounter
	lda #$01
.loop_init
	clc
	adc <zTrackPtr
	sta <zTrackPtr
	lda #$00
	adc <zTrackPtrhi
	sta <zTrackPtrhi ;0F構造体中の曲開始ポインタの参照先を1つ進める
	ldx <zSoundBase ;x = {zSoundBase|0, 0, 0, 0}
	ldy #$00
.loop_init_trackptr ;トラックごとの曲ポインタを初期化
	mMOV [zTrackPtr],y, aSQ1Ptr,x
	inx ;{x|zSoundBase, zSoundBase + 1}
	iny ;{y|0, 1}
	cpy #$02
	bne .loop_init_trackptr
	
	ldy #$0E
	lda #$00
.loop_stz
	sta aSQ1Ptr,x ;トラックごとの曲用一時変数を初期化
	inx ;{x|zSoundBase + 2 ≦ x < zSoundBase + #$10}
	dey
	bne .loop_stz
	
	lda <zSFXChannel
	lsr a
	bcs .skip_for_sfx ;現在のトラックが効果音再生中なら飛ぶ
	jsr Sound_ClearLFOs
.skip_for_sfx
	jsr Sound_GotoNextTrack ;ループを進める
	dec <.LoopCounter
	beq .end_init
	lda #$02
	jmp .loop_init
	
.end_init ;この時、zTrackPtrはノイズ開始アドレスを指している
	ldy #$02 ;+2バイト → MOD定義
	mMOV [zTrackPtr],y, aModDefine
	iny
	mMOV [zTrackPtr],y, aModDefinehi
	jsr Sound_RestoreSFXReservation
	mSTZ <zNMILock
	rts

;80BB
;効果音セットアップ開始
Bank0CStartSFX:
.TestStrength = zSoundVar1
	lda <zSoundAttr
	and #$F0
	sta <.TestStrength
	cpx <.TestStrength
	bcs .play_sfx ;現在の優先度 - 鳴らそうとする曲の優先度X ≧ 0の時続行
	rts
;効果音上書き優先順位00～F0が大きい時に続く
.play_sfx
	stx <.TestStrength
	lda <zSoundAttr
	and #$0F
	ora <.TestStrength
	sta <zSoundAttr ;優先度を更新
	mMOV #$01, <zNMILock
	mSTZ <zSoundBase
	ldx #$00
	lda #$02
	clc
	adc <zTrackPtr
	sta <zSFXPtr
	txa
	adc <zTrackPtrhi
	sta <zSFXPtrhi ;効果音ポインタ = トラック開始ポインタ + 2
	
	stx <zSFXWait
	stx <zSFXLoop ;一時変数の初期化
	
	ldy #$01
	lda [zTrackPtr],y ;A = 使用チャンネル
	and #$0F
	tax
	ora <zSFXChannel
	pha
	stx <zSFXChannel ;使用チャンネルを上書き

.LoopCounter = zSoundVar1
.FreqRegPtr = zSoundVar2 ;周波数レジスタへのポインタ
	mMOV #$04, <.LoopCounter
	mMOV #$02, <.FreqRegPtr
.loop_initsfx
	pla
	lsr a ;対象は今から使うチャンネルと現在効果音再生中のチャンネル
	pha
	bcc .skip
	jsr Sound_ClearLFOs
	lda <zSFXChannel
	lsr a
	bcs .skip
	jsr Sound_RestoreModulation ;効果音再生中 かつ もう使わない時
.skip
	jsr Sound_GotoNextTrack
	lda #$04
	clc
	adc <.FreqRegPtr
	sta <.FreqRegPtr ;{FreqRegPtr|2, 6, A, E}
	dec <.LoopCounter
	bne .loop_initsfx
	
	jsr Sound_RestoreSFXReservation
	lda <zSFXChannel
	sta <zSFXChannel_Copy
	pla
	mSTZ <zNMILock
	rts

;8129
;#FCを実行 曲を早くする
Bank0C_StartFC:
	iny
	sty <zSoundSpeed
	rts

;812D
;#FDを実行 曲をフェードアウト/インする
Bank0C_StartFD:
	sty <zSoundFade
	lda #$01
	sta <zSoundFadeProg
	lda <zSoundCounter
	and #$01
	sta <zSoundCounter
	rts

;813A
;#FEを実行 効果音を止める
Bank0C_StartFE:
	lda <zSoundAttr
	and #$0F
	sta <zSoundAttr
.LoopCounter = zSoundVar1
.FreqRegPtr = zSoundVar2 ;周波数レジスタへのポインタ
	mMOV #$04, <.LoopCounter
	mMOV #$02, <.FreqRegPtr
.loop_sfx
	lda <zSFXChannel
	lsr a
	bcc .skip
	jsr Sound_ClearLFOs
	jsr Sound_RestoreModulation
.skip
	jsr Sound_GotoNextTrack
	lda #$04
	clc
	adc <.FreqRegPtr
	sta <.FreqRegPtr ;{zSoundVar2|2, 6, A, E}
	dec <.LoopCounter
	bne .loop_sfx
	.ifndef ___OPTIMIZE
	mSTZ <zSFXChannel, <zSFXChannel_Copy
	mSTZ <zNMILock
	.else
	mSTZ <zSFXChannel, <zSFXChannel_Copy, <zNMILock
	.endif
	rts

;816C
;処理中のチャンネルが音を鳴らしている時
;もしくは曲で使用される時、モジュレーション定義をリセット
;音を鳴らしていない時、周波数レジスタをリセット
Sound_RestoreModulation:
.Channel = zSoundVar1
.RegPtr = zSoundVar2
	lda <zSoundBase
	clc
	adc #$0A
	tax
	lda aSQ1Ptr,x   ;A = aSQ1Reg
	ora aSQ1Ptrhi,x ;A = A or aSQ1Reghi
	bne Sound_CopyModulation ;音を鳴らしている時に飛ぶ
	ldy <.Channel ;{y|4, 3, 2, 1}
	ldx <.RegPtr  ;{x|2, 6, A, E}
	jsr Sound_ResetFreqRegisters
	ldx <zSoundBase
	lda aSQ1Ptr,x
	ora aSQ1Ptrhi,x ;曲で使われないトラックならrts
	bne Sound_CopyModulation
	rts

;818C
;#FFを実行 曲を止める
Bank0C_StartFF:
	lda <zSoundAttr
	and #$F0
	sta <zSoundAttr
	mSTZ <zSoundSpeed, <zSoundFade
.LoopCounter = zSoundVar1
	mMOV #$04, <.LoopCounter
.loop
	lda #$00
	ldx <zSoundBase
	sta aSQ1Ptr,x
	sta aSQ1Ptrhi,x ;曲ポインタ = 0
	jsr Sound_GotoNextTrack_Music
	dec <.LoopCounter
	bne .loop
	mSTZ <zNMILock
	rts

;81B2
;音の変調関係を0にする
Sound_ClearLFOs:
	ldy #$0F
	lda #$10
	clc
	adc <zSoundBase
	tax ;X = zSoundBase + 10
	lda #$00
.loop
	sta aSQ1Ptr,x ;SFXPitch～VolModVolume($510～$51E) = 0
	inx
	dey
	bne .loop
	rts

;81C4
;モジュレーション定義をコピーする
Sound_CopyModulation:
	lda <zSoundVar1
	pha
	lda <zSoundVar2
	pha
.ModPtr = zSoundVar1
.ModPtrhi = zSoundVar2
	mMOV aModDefine, <.ModPtr
	mMOV aModDefinehi, <.ModPtrhi
	lda <zSoundBase
	clc
	adc #$06
	tax
	lda aSQ1Ptr,x ;A = aSQ1Mod
	and #$1F ;現在のモジュレーション定義番号にアクセス
	beq .skip
	tay ;MOD ≠ 0の時、Y = モジュレーション番号
	lda #$00
.loop_mod
	clc
	adc #$04
	dey
	bne .loop_mod
.skip
	tay ;Y = 4 * MOD番号
	txa ;A = zSoundBase + 6
	clc
	adc #$0E ;A = zSoundBase + 6 + E = zSoundBase + 14
	tax ;X = zSoundBase + 14
	lda #$04 ;ループ変数
.loop_copy ;モジュレーション定義の内容を格納
	pha
	mMOV [.ModPtr],y, aSQ1Ptr,x ;aModDefine1, 2, 3, 4
	iny ;{y|4 * MOD ≦ y < 4 * MOD + 4}
	inx ;{x|14, 15, 16, 17}
	pla
	sec
	sbc #$01
	bne .loop_copy ;4バイトコピー
;一時変数の復元
	pla
	sta <zSoundVar2
	pla
	sta <zSoundVar1
	rts

;8207
;現在の処理を次のチャンネルを対象にするように進める
;効果音処理チャンネルのシフトとチャンネルベースポインタの加算
Sound_GotoNextTrack:
	lsr <zSFXChannel
	bcc Sound_GotoNextTrack_Music
	lda <zSFXChannel
	ora #$80 ;Sound_RestoreSFXReservationで戻すためのora
	sta <zSFXChannel
;8211
Sound_GotoNextTrack_Music:
	lda #$1F
	clc
	adc <zSoundBase
	sta <zSoundBase
	rts

;8219
;効果音を鳴らすチャンネルの予約を上位ニブルを使って戻す
Sound_RestoreSFXReservation:
	lsr <zSFXChannel
	lsr <zSFXChannel
	lsr <zSFXChannel
	lsr <zSFXChannel
	rts

;8222
;周波数レジスタをリセットする
Sound_ResetFreqRegisters:
	cpy #$01 ;{x|2, 6, A, E}, {y|4, 3, 2, 1}
	beq .noise ;処理中のチャンネル = NOIなら飛ぶ
	mSTZ $4000,x, $4001,x ;周波数レジスタリセット $400X, $400X+1 = 0, 0
	rts
.noise ;ノイズなら、音声再生制御レジスタをいじる
	mMOV #%00000111, $4015 ;ノイズとDPCMは再生しない
	rts

;8235
;$8000から飛んでくる 曲の処理
Sound_ProcessTracks:
	inc <zSoundCounter
	lda <zNMILock
	beq .do
	rts
.do
	ldx #$00
	ldy #$05
	stx <zSoundBase
	sty <zSoundBasehi ;[zSoundBase] = $0500
	mSTZ <zSoundIndex
	mMOV #$04, <zProcessChannel ;処理中のチャンネル = SQ1
.loop
	lda #$01
	ldy #$18
	clc
	adc [zSoundBase],y ;$518, ピッチMOD用カウンタ
	sta [zSoundBase],y ;$518 += 1
	lda #$01
	ldy #$1D
	clc
	adc [zSoundBase],y ;$51D, 音量MOD用カウンタ
	sta [zSoundBase],y ;$51D += 1
	
	lda <zSFXChannel_Copy
	lsr a
	bcc .nosfx
	jsr $856D ;処理中のトラックは効果音を鳴らしている
.nosfx
	lda <zMusicPause
	lsr a
	bcc .continue
	jmp .skip_track ;曲が一時停止している
.continue
	ldy #$00
	lda [zSoundBase],y ;$500
	iny
	ora [zSoundBase],y ;$501
	beq .skip_track
;処理中のトラックは曲で使われている
	lda #$01
	ldy #$0E
	clc
	adc [zSoundBase],y ;$50E, 音量env用カウンタ
	sta [zSoundBase],y ;$50E += 1
	jsr $86B4
	jmp .done
.skip_track
	lda <zSFXChannel_Copy
	lsr a
	bcs .done
;効果音も曲も鳴ってない
	ldx <zSoundIndex
	inx
	inx
	ldy <zProcessChannel
	jsr Sound_ResetFreqRegisters
.done
	lsr <zSFXChannel_Copy
	bcc .advanceSFX
	mORA <zSFXChannel_Copy, #$80
.advanceSFX
	dec <zProcessChannel
	beq .endloop
	lda #$04
	clc
	adc <zSoundIndex
	sta <zSoundIndex ;zSoundIndex += 4
	lda #$1F
	clc
	adc <zSoundBase
	sta <zSoundBase
	lda #$00
	adc <zSoundBasehi
	sta <zSoundBasehi ;zSoundBase += 001F
	jmp .loop

.endloop
	lda <zSoundFade
	and #$7F
	beq .nofade
	cmp <zSoundCounter
	bne .nofade
;フェードイン/アウトの処理
	mAND <zSoundCounter, #$01
	inc <zSoundFadeProg
	lda #$10
	cmp <zSoundFadeProg
	bne .nofade
	lda <zSoundFade
	bmi .isfadeout
	mSTZ <zSoundFade
.isfadeout
	mMOV #$0F, <zSoundFadeProg
.nofade
;効果音音長カウンタ--;
	lda <zSFXWait
	beq .decsfx
	dec <zSFXWait
.decsfx
	lsr <zSFXChannel_Copy
	lsr <zSFXChannel_Copy
	lsr <zSFXChannel_Copy
	lsr <zSFXChannel_Copy
	rts

;82EC
Sound_ManipulateModulations: ;$86FBで呼ばれる
	ldy #$0C
	lda [zSoundBase],y ;$50C, 02と03命令から音量レジスタへ入れる値
	ldy #$02
	cpy <zProcessChannel
	beq .istri_mask ;三角波以外を処理中なら、
	and #$0F ;音量成分のみを抽出(bit6, bit7は音色)
.istri_mask
	sta <zSoundPtr
	lda <zSoundFade
	and #$7F
	beq .nofade
;フェードイン/アウトの適用
	lda <zSoundFadeProg
	ldy #$02
	cpy <zProcessChannel
	bne .isnottri
;三角波を処理中
	ldx #$0C
.loop_mul
	clc
	adc <zSoundFadeProg
	dex
	bne .loop_mul
.isnottri
	tay
	lda <zSoundFade
	bmi .isfadein
;フェードアウト
	ldx #$FF
.loop_fadeout
	inx
	cpx <zSoundPtr
	beq .nofade
	dey
	bne .loop_fadeout
	stx <zSoundPtr
	jmp .nofade
;8324, フェードイン
.isfadein
	dec <zSoundPtr
	beq .nofade
	dey
	bne .isfadein
.nofade
	lda #$02
	cmp <zProcessChannel
	beq .noenv
	ldy #$0D
	lda [zSoundBase],y ;$50D, 07命令の第一引数
	tax
	and #$7F
	beq .noenv
	iny
	cmp [zSoundBase],y ;$50E, 音量env用カウンタ
	beq .wait
	iny
	lda [zSoundBase],y ;$50F, 音量envでの現在の音量
	and #$0F
	jmp .isvalidvolume
.wait
	mSTZ [zSoundBase],y ;$50E
	iny
	lda [zSoundBase],y ;$50F
	lsr a
	lsr a
	lsr a
	lsr a
	sta <zSoundPtrhi
	txa ;A = $507
	bpl .iscresc
;音量envが音量を下げている
	lda #$00
	sec
	sbc <zSoundPtrhi
	sta <zSoundPtrhi
.iscresc
	lda [zSoundBase],y ;$50F
	and #$0F
	clc
	adc <zSoundPtrhi
	bpl .isvalidvolume
	lda #$00
	jmp .overwrite
.isvalidvolume
	cmp <zSoundPtr
	bcc .overwrite
	lda <zSoundPtr
.overwrite
	sta <zSoundPtr
	lda [zSoundBase],y
	and #$F0
	ora <zSoundPtr
	sta [zSoundBase],y
.noenv
	lda <zSFXChannel_Copy
	lsr a
	bcs .isplayingSFX
	mMOV #$0C, <zSoundPtrhi
	jmp Sound_838F
.isplayingSFX
	mMOV #$09, <zSoundPtrhi
	jmp Sound_83FE
Sound_838F:
	ldy #$16
	lda [zSoundBase],y ;$516, MOD定義YY
	and #$7F ;A = MODの音量変化周期
	beq .endvolmod
	ldy #$1D
	cmp [zSoundBase],y ;$51D, 音量MOD用カウンタ
	beq .changemod
	jmp .nochangemod
.changemod
	mSTZ [zSoundBase],y ;$51D
	ldy #$17
	lda [zSoundBase],y ;$517, MOD定義ZZ
	ldy #$1E
	clc
	adc [zSoundBase],y ;$51E, 音量MODの現在の音量
	beq .zero
	bpl .isplaying
.zero
	mMOV #$01, [zSoundBase],y ;$51E
	jmp .iszerovolmod
.isplaying
	sta [zSoundBase],y
	cmp #$10
	bcc .nochangemod
	mMOV #$0F, [zSoundBase],y
.iszerovolmod
	lda #$00
	ldy #$17
	sec
	sbc [zSoundBase],y ;$517, MOD定義ZZ
	sta [zSoundBase],y
.nochangemod
	ldy #$1E
	lda [zSoundBase],y ;$51E, 音量MODの現在の音量
	cmp <zSoundPtr
	bcs .endvolmod
	sta <zSoundPtr
.endvolmod
	ldy #$02
	cpy <zProcessChannel
	beq .istri_mod
	lda <zSoundPtrhi
	and #$7F
	tay
	lda [zSoundBase],y
	and #$F0
	ora <zSoundPtr
	sta <zSoundPtr
.istri_mod
	ldx <zSoundIndex
	mMOV <zSoundPtr, $4000,x
	lda <zSoundPtrhi
	bpl .positive
	mMOV #$90, <zSoundPtrhi
	jmp Sound_83FE
.positive
	mMOV #$09, <zSoundPtrhi
Sound_83FE:
	lda <zSoundPtrhi
	and #$7F
	tay
	ldx #$00
	lda [zSoundBase],y
	beq .jump8418
	bpl .jump840C
	dex
.jump840C
	iny
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
	txa
	iny
	adc [zSoundBase],y
	sta [zSoundBase],y
.jump8418
	lda <zSoundPtrhi
	bmi .playingsfx
	lda <zSFXChannel_Copy
	lsr a
	bcc .playingsfx
	rts
.playingsfx
	ldy #$14
	lda [zSoundBase],y ;$514, MOD定義のWW
	and #$7F
	bne .pitchmod
	jmp .jump84A9
.pitchmod
	ldy #$18
	cmp [zSoundBase],y ;$518, ピッチMOD用カウンタ
	beq .dopitchmod
	jmp .jump84A9
;8436
.dopitchmod
	mSTZ [zSoundBase],y ;$518
	tax
	ldy #$15
	lda [zSoundBase],y ;$515, MOD定義のXX
	rol a
	rol a
	rol a
	rol a
	and #$07
	sta <zSoundPtr
	ldy #$19
	lda [zSoundBase],y ;$519, ピッチMOD用上下動情報
	asl a
	bcc .negatepitch
	lda #$00
	sec
	sbc <zSoundPtr
	sta <zSoundPtr
	dex
.negatepitch
	lda <zSoundPtr
	clc
	ldy #$1A
	adc [zSoundBase],y
	sta [zSoundBase],y ;$51A, ピッチMOD変動下位
	iny
	txa
	adc [zSoundBase],y
	sta [zSoundBase],y ;$51B, ピッチMOD変動上位
	ldy #$15
	mAND [zSoundBase],y, #$1F, <zSoundPtr ;zSoundPtr = ピッチの最大変位回数
	ldy #$19
	lda [zSoundBase],y ;$519, ピッチMOD用上下動情報
	clc
	adc #$01
	sta [zSoundBase],y
	and #$7F
	cmp <zSoundPtr
	bne .jump84A9
	mAND [zSoundBase],y, #$80 ;$519
	ldy #$14
	lda [zSoundBase],y ;$514, MOD定義のWW
	asl a
	bcs .jump84A3
	mORA [zSoundBase],y, #$80 ;$514
	ldy #$19
	lda [zSoundBase],y ;$519, ピッチMOD用上下動情報
	bpl .positivepitchmod
	and #$7F
	sta [zSoundBase],y
	jmp .jump84A9
.positivepitchmod
	ora #$80
	sta [zSoundBase],y
	jmp .jump84A9
;84A3
.jump84A3
	mAND [zSoundBase],y, #$7F
.jump84A9
	mAND <zSoundPtrhi, #$7F
	inc <zSoundPtrhi
	ldy #$1A
	lda [zSoundBase],y ;$51A, ピッチMOD変動下位
	ldy <zSoundPtrhi
	clc
	adc [zSoundBase],y
	tax
	ldy #$1B
	lda [zSoundBase],y ;$51B, ピッチMOD変動上位
	inc <zSoundPtrhi
	ldy <zSoundPtrhi
	adc [zSoundBase],y
	tay
	lda #$01
	cmp <zProcessChannel
	bne .isnotnoi
;ノイズを処理中
	mMOV #$0F, $4015
	txa
	and #$0F
	tax
	inc <zSoundPtrhi
	ldy <zSoundPtrhi
	mAND [zSoundBase],y, #$80, <zSoundPtr
	txa
	ora <zSoundPtr
	tax
	ldy #$00
.isnotnoi
	txa
	ldx <zSoundIndex
	inx
	inx
	sta $4000,x
	tya
	ldy #$1C
	cmp [zSoundBase],y ;$51C, 二度書き防止用退避変数
	bne .writemod
	rts
.writemod
	sta [zSoundBase],y
	ora #$08
	sta $4001,x
	rts

;84FD
Sound_MuteCurrentTrack: ;$85BF, $879Fで呼ばれる
	ldy #$01
	cpy <zProcessChannel
	bne .isnotnoi
	mMOV #$07, $4015 ;ノイズは再生しない
	rts
.isnotnoi
	lda #$00
	ldx <zSoundIndex
	inx
	inx
	sta $4000,x
	sta $4001,x
	rts

;8516
Sound_Unknown8516: ;
	ldy #$14
	mAND [zSoundBase],y, #$7F ;$514, MOD定義WW
	ldy #$16
	lda [zSoundBase],y ;$516, MOD定義YY
	asl a
	bcc .volmod
	ldy <zSoundPtr
	lda [zSoundBase],y
	ldx #$02
	cpx <zProcessChannel
	beq .istri
	and #$0F
.istri
	ldy #$1E
	sta [zSoundBase],y
.volmod
	ldx #$06
	lda #$00
	ldy #$18
.loop
	sta [zSoundBase],y ;addr = 0, $518 ≦ addr ≦ $51D
	iny
	dex
	bne .loop
	lda #$FF
	ldy #$1C
	sta [zSoundBase],y ;$51C, 二度書き防止用退避変数
	rts

;8548
Sound_8548:
	ldy #$1C
	lda [zSoundBase],y
	pha
	jsr Sound_Unknown8516
	pla
	ldy #$1C
	sta [zSoundBase],y
	rts

;8556
Sound_8556:
	txa
	asl a
	tay
	iny
	pla
	sta <zSoundPtr
	pla
	sta <zSoundPtrhi
	lda [zSoundPtr],y
	tax
	iny
	lda [zSoundPtr],y
	sta <zSoundPtrhi
	stx <zSoundPtr
	jmp [zSoundPtr]

;856D
Sound_856D:
	lda <zSFXWait
	bne Sound_8574
	jmp $8592

;8574
Sound_8574:
	ldy #$11
	lda [zSoundBase],y
	iny
	ora [zSoundBase],y
	bne .do
	rts
.do
	iny
	lda [zSoundBase],y
	ldy #$02
	cpy <zProcessChannel
	beq .istri
	and #$0F
.istri
	sta <zSoundPtr
	mMOV #$93, <zSoundPtrhi
	jmp Sound_838F

;8592
Sound_8592:
	
