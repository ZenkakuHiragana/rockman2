
SOUND_HDR_ALWAYS = 1
SOUND_POMPOKO_VELOCITY = $0040
SOUND_POMPOKO_LENGTH = 5
SOUND_POMPOKO_INIT_HIGH = $806A
SOUND_POMPOKO_INIT_LOW = $80A0
SOUND_DECREMENT_COUNTER = $80

	mBEGIN #$0C, #$8000

	jmp Sound_ProcessTracks

;8003
;20 51 C0で予約された曲を鳴らし始める処理
SOUND_STARTPLAY: ;A = 曲番号
	.ifdef SOUND_HDR_ALWAYS
	ldx #%00000111
	stx $4001
	stx $4005
	.endif
	cmp #$FC
	bcc .other
	bne .notFC
;8129
;#FCを実行 曲を早くする
	inc <zSoundSpeed
	rts
.notFC
	cmp #$FD
	bne .notFD
;812D
;#FDを実行 曲をフェードアウト/インする
	sty <zSoundFade
	lda #$01
	sta <zSoundFadeProg
	and <zSoundCounter
	sta <zSoundCounter
	rts
.notFD
	ldx #$01
	stx <zNMILock
	dex
	stx <zSoundBase
	cmp #$FE
	bne .startFF
;813A
;#FEを実行 効果音を止める
.LoopCounter = zSoundVar1
.FreqRegPtr = zSoundVar2 ;周波数レジスタへのポインタ
	mAND <zSoundAttr, #$0F
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
	clc
	mADD <.FreqRegPtr, #$04 ;{zSoundVar2|2, 6, A, E}
	dec <.LoopCounter
	bne .loop_sfx
	mSTZ <zSFXChannel, <zSFXChannel_Copy, <zNMILock
	rts
;818C
;#FFを実行 曲を止める
.startFF
.LoopCounter = zSoundVar1
	mAND <zSoundAttr, #$F0
	mMOV #$04, <.LoopCounter
	mSTZ <zSoundFade, <zSoundSpeed
.loop
	ldx <zSoundBase
	sta aSQ1Ptr,x
	sta aSQ1Ptrhi,x ;曲ポインタ = 0
	jsr Sound_GotoNextTrack_Music
	lda #$00
	dec <.LoopCounter
	bne .loop
	sta <zNMILock
	rts
.other ;A < #$FC
	asl a
	tax
	mMOV Table_TrackStartPointers,x, <zTrackPtr
	mMOV Table_TrackStartPointers + 1,x, <zTrackPtrhi
	ldy #$00
	lda [zTrackPtr],y
	tax
	and #$0F
	beq Bank0C_StartSFX

;8044, 曲セットアップ開始
.TestStrength = zSoundVar1 ;曲の上書き優先順位保存用変数
	mAND <zSoundAttr, #$0F, <.TestStrength
	cpx <.TestStrength ;X = 曲定義先頭の1バイト
	bcc .rts
;現在の優先度00-0F ≦ 鳴らそうとする曲の優先度X の時鳴らす
	stx <.TestStrength
	lda <zSoundAttr
	and #$F0
	ora <.TestStrength
	sta <zSoundAttr ;優先度を更新
	rol <zNMILock ;zNMILock = 1
	mSTZ <zSoundBase, <zSoundFade, <zSoundSpeed
;8067, 曲セットアップのチャンネルごとのループ開始
.LoopCounter = zSoundVar1
	mMOV #$04, <.LoopCounter
	clc
.loop_init
	mADD <zTrackPtr, #$01 ;ヘッダの曲開始ポインタの参照先を1つ進める
	mBCC inc <zTrackPtrhi
	ldx <zSoundBase ;x = {zSoundBase|0, 1F, 2E, 3D}
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
	mBCS jsr Sound_ClearLFOs ;現在のトラックが効果音再生中でないなら呼ぶ
	jsr Sound_GotoNextTrack ;ループを進める
	sec ;ループ2回目以降はポインタを2つ進める
	dec <.LoopCounter
	bne .loop_init

.end_init ;この時、zTrackPtrはノイズ開始アドレスを指している
	ldy #$02 ;+2バイト → テンポ値
	mMOV [zTrackPtr],y, aTempo
	iny
	mMOV [zTrackPtr],y, aTempohi
	jsr Sound_RestoreSFXReservation
	lsr <zNMILock
.rts
	rts

;80BB
;効果音セットアップ開始
Bank0C_StartSFX:
.TestStrength = zSoundVar1
	mAND <zSoundAttr, #$F0, <.TestStrength
	cpx <.TestStrength
	bcc .end
;現在の優先度00-F0 ≦ 鳴らそうとする効果音の優先度X の時鳴らす
	stx <.TestStrength
	lda <zSoundAttr
	and #$0F
	ora <.TestStrength
	sta <zSoundAttr ;優先度を更新
	clc
	mADD <zTrackPtr, #$02, <zSFXPtr
	lda #$00
	tax
	adc <zTrackPtrhi
	sta <zSFXPtrhi ;効果音ポインタ = トラック開始ポインタ + 2

	;X = 0
	stx <zSoundBase
	stx <zSFXWait
	stx <zSFXLoop ;一時変数の初期化

	ldy #$01
	sty <zNMILock
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
	clc
	mADD <.FreqRegPtr, #$04 ;{FreqRegPtr|2, 6, A, E}
	dec <.LoopCounter
	bne .loop_initsfx

	jsr Sound_RestoreSFXReservation
	mMOV <zSFXChannel, <zSFXChannel_Copy
	pla
	mSTZ <zNMILock
.end
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
	clc
	lda <zSoundBase
	adc #$06
	tax
	lda aSQ1Ptr,x ;A = aSQ1Mod
	and #$1F ;現在のモジュレーション定義番号にアクセス
	asl a
	asl a
	tay ;Y = 4 * MOD番号
	txa ;A = zSoundBase + 6
	adc #$0E ;A = zSoundBase + 6 + E
	tax ;X = zSoundBase + #$14
	sec
	lda #$04 ;ループ変数
.loop_copy ;モジュレーション定義の内容を格納
	pha
	mMOV Sound_Modulations,y, aSQ1Ptr,x ;aModDefine1, 2, 3, 4
	iny ;{y|4 * MOD ≦ y < 4 * MOD + 4}
	inx ;{x|14, 15, 16, 17}
	pla
	sbc #$01
	bne .loop_copy ;4バイトコピー
	rts

;8207
;現在の処理を次のチャンネルを対象にするように進める
;効果音処理チャンネルのシフトとチャンネルベースポインタの加算
Sound_GotoNextTrack:
	lsr <zSFXChannel
	bcc Sound_GotoNextTrack_Music
	mORA <zSFXChannel, #%10000000 ;Sound_RestoreSFXReservationで戻すためのora
;8211
Sound_GotoNextTrack_Music:
	clc
	mADD <zSoundBase, #$1F
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
Sound_ResetFreqRegisters_end:
	rts

;8235
;$8000から飛んでくる 曲の処理
Sound_ProcessTracks:
	inc <zSoundCounter
	lda <zNMILock
	bne Sound_ResetFreqRegisters_end
	tax
	stx <zSoundIndex
	stx <zSoundBase
	ldy #$05
	sty <zSoundBasehi ;[zSoundBase] = $0500
	dey
	sty <zProcessChannel ;処理中のチャンネル = #$04 = SQ1
.loop
	clc
	ldy #$18
	mADD [zSoundBase],y, #$01 ;$518, ピッチMOD用カウンタ += 1
	clc
	ldy #$1D
	mADD [zSoundBase],y, #$01 ;$51D, 音量MOD用カウンタ += 1

	lda <zSFXChannel_Copy
	lsr a
	mBCC jsr Sound_ProcessSFX ;処理中のトラックは効果音を鳴らしている
	lda <zMusicPause
	lsr a
	mBCC jmp .skip_track ;曲が一時停止している
	ldy #$00
	lda [zSoundBase],y ;$500
	iny
	ora [zSoundBase],y ;$501
	beq .skip_track
;処理中のトラックは曲で使われている
	;clc
	ldy #$0E
	mADD [zSoundBase],y, #$01 ;$50E, 音量env用カウンタ += 1
	jsr Sound_ProcessMusic
	jmp .done
.skip_track
;処理中のトラックは曲で使われてない
	lda <zSFXChannel_Copy
	lsr a
	bcs .done
;効果音も曲も鳴ってない時、周波数レジスタリセット
	ldx <zSoundIndex
	inx
	inx
	ldy <zProcessChannel
	jsr Sound_ResetFreqRegisters
.done
	lsr <zSFXChannel_Copy
	bcc .advanceSFX
	mORA <zSFXChannel_Copy, #$80 ;効果音の予約状況を保持
.advanceSFX
;処理するトラックを1つ進める
	dec <zProcessChannel
	beq .endloop
	clc
	mADD <zSoundIndex, #$04 ;zSoundIndex += 4
	clc
	mADD <zSoundBase, #$1F ;zSoundBase += 001F
	bcc .loop
	inc <zSoundBasehi
	bne .loop

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
;効果音音長カウンタを減らす
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
Sound_ManipulateModulations:
.Volume = zSoundPtr
.VolumeDiff = zSoundPtrhi
	ldy #$0C
	lda [zSoundBase],y ;$50C, 02と03命令から音量レジスタへ入れる値
	ldy #$02
	cpy <zProcessChannel
	mBEQ and #$0F ;三角波以外のとき、音量成分を抽出(bit6-7は音色)
	sta <.Volume
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
	bne .loop_mul ;三角波の時、A = zSoundFadeProg × 13
.isnottri
	tay
	lda <zSoundFade
	bmi .isfadein
;フェードアウト
	ldx #$FF
.loop_fadeout
	inx
	cpx <.Volume
	beq .nofade ;フェードアウト音量より小さい時は飛ばす
	dey
	bne .loop_fadeout
	stx <.Volume ;フェードアウトの段階に合わせて音量を設定
	jmp .nofade
;8324, フェードイン
.isfadein
	dec <.Volume
	beq .nofade
	dey
	bne .isfadein
.nofade
	lda #$02
	cmp <zProcessChannel
	beq .noenv
;三角波以外を処理中、音量エンベロープの適用
	ldy #$0D
	lda [zSoundBase],y ;$50D, 07命令のXX
	tax
	and #$7F ;A = 音量エンベロープ 変化のフレーム数
	beq .noenv
	iny
	cmp [zSoundBase],y ;$50E, 音量エンベロープ用カウンタ
	beq .wait
	iny
	lda [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
	and #$0F
	jmp .isvalidvolume
.wait
	mSTZ [zSoundBase],y ;$50E, 音量エンベロープ用カウンタ
	iny
	lda [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
	lsr a
	lsr a
	lsr a
	lsr a
	sta <.VolumeDiff ;A = 音量エンベロープの変化量(Y0)
	txa ;A = $50D, 07命令の第一引数
	bpl .iscrescendo
;音量エンベロープが音量を下げている
	lda #$00
	sec
	sbc <.VolumeDiff
	sta <.VolumeDiff ;.VolumeDiff = -.VolumeDiff
.iscrescendo
	lda [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
	and #$0F
	clc
	adc <.VolumeDiff
	bpl .isvalidvolume
	lda #$00
	jmp .overwrite
.isvalidvolume
	cmp <.Volume ;フェードイン・フェードアウトによる音量上限と比較
	bcc .overwrite
	lda <.Volume ;小さい方を採用する
.overwrite
	sta <.Volume
	lda [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
	and #$F0
	ora <.Volume
	sta [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
.noenv
;音量決定処理の終わり
	lda <zSFXChannel_Copy
	lsr a
	bcs .isplayingSFX
	mMOV #$0C, <zSoundPtrhi
	jmp Sound_ManipulateVolumeMod
.isplayingSFX
	mMOV #$09, <zSoundPtrhi
	jmp Sound_ManipulatePitchEnvelope
;838F
;音量MODの処理
Sound_ManipulateVolumeMod:
.Volume = zSoundPtr
.RegPtr = zSoundPtrhi ;$.RegPtr = #$0C, #$93
	ldy #$16
	lda [zSoundBase],y ;$516, MOD定義YY
	and #$7F ;A = MODの音量変化周期
	beq .endvolmod
	ldy #$1D
	cmp [zSoundBase],y ;$51D, 音量MOD用カウンタ
	bne .nochangemod

	mSTZ [zSoundBase],y ;$51D, 音量MOD用カウンタ
	ldy #$17
	lda [zSoundBase],y ;$517, MOD定義ZZ, 音量MOD変化量
	ldy #$1E
	clc
	adc [zSoundBase],y ;$51E, 音量MODの現在の音量
	beq .zero
	bpl .isplaying
.zero
	mMOV #$01, [zSoundBase],y ;$51E, 音量MODの現在の音量
	jmp .switch
.isplaying
	sta [zSoundBase],y ;$51E += $517, 音量MODによる音量変化
	cmp #$10
	bcc .nochangemod
	mMOV #$0F, [zSoundBase],y ;$51E, 音量MODの現在の音量
.switch
;音量MODの変化後が0もしくは#$10になったら変化方向を逆転
	ldy #$17
	sec
	mSUB #$00, [zSoundBase],y, [zSoundBase],y ;$517, MOD定義ZZ = -$517
.nochangemod
	ldy #$1E
	lda [zSoundBase],y ;$51E, 音量MODの現在の音量
	cmp <.Volume
	bcs .endvolmod
	sta <.Volume ;音量MODにより音量が小さくなった時のみ書き込み
.endvolmod
	ldy #$02
	cpy <zProcessChannel
	beq .istri
	lda <.RegPtr
	and #$7F
	tay ;Y = #$0C, #$13
	lda [zSoundBase],y ;$50C, $513, 音量系レジスタへの値(曲, SFX)
	and #$F0
	ora <.Volume
	sta <.Volume
.istri
	ldx <zSoundIndex
	mMOV <.Volume, $4000,x
	lda <.RegPtr
	bpl .ismusic
	mMOV #$90, <.RegPtr
	jmp Sound_ManipulatePitchEnvelope
.ismusic
	mMOV #$09, <.RegPtr
;83FE
Sound_ManipulatePitchEnvelope:
.RegPtr = zSoundPtrhi ;$.RegPtr = #$09, #$90
	lda <.RegPtr
	and #$7F
	tay ;Y = #$09, #$10
	ldx #$00
	lda [zSoundBase],y ;$509, $510, ピッチエンベロープ変化値(曲, SFX), 命令$01のXX
	beq .endpitchenv
	mBPL dex
;X = #$00 (下降), #$FF(上昇), ピッチエンベロープ変化値上位
	iny
	clc
	adc [zSoundBase],y ;$50A, $511, 音高レジスタ値下位(曲, SFX)
	sta [zSoundBase],y ;レジスタ値 += ピッチエンベロープ変化値
	txa
	iny
	adc [zSoundBase],y ;$50B, $512, 音高レジスタ値上位(曲, SFX)
	sta [zSoundBase],y ;レジスタ値 += ピッチエンベロープ変化値
.endpitchenv

	lda <.RegPtr
	bmi .issfx
;曲を再生中、音下げるやつのチェック
.Ref = zSoundVar1
.Refhi = zSoundVar2
.BendSpeed = zSoundPtr
	ldy #$04
	lda [zSoundBase],y ;$504, 音下げるやつの目標値下位
	beq .nobend
;音下げるやつ
	sta <.Ref
	iny
	lda [zSoundBase],y ;$505, 音下げるやつの目標値上位
	tax
	and #$07
	sta <.Refhi
	txa
	lsr a
	lsr a
	ldy <.Refhi
	mBEQ lsr a
	sta <.BendSpeed

	clc
	ldy #$0A
	mSUB [zSoundBase],y, <.BendSpeed ;$50A, 音高レジスタ値下位
	tax
	iny
	mSUB [zSoundBase],y, #$00 ;$50B, 音高レジスタ値上位

	cmp <.Refhi
	mBEQ bcs .nobend
	txa
	cmp <.Ref
	mBEQ bcs .nobend
	mMOV <.Refhi, [zSoundBase],y ;$50B, 音高レジスタ値上位
	dey
	mMOV <.Ref, [zSoundBase],y ;$50A, 音高レジスタ値下位
	ldy #$04
	mSTZ [zSoundBase],y ;$504,  音下げるやつの目標値下位
.nobend

	lda <zSFXChannel_Copy
	lsr a
	mBCC rts ;曲の処理中で効果音が再生中のとき、終了
.issfx
;ピッチMODの適用
	ldy #$14
	lda [zSoundBase],y ;$514, MOD定義のWW
	and #$7F
	mBNE jmp .nopitchmod
	ldy #$18
	cmp [zSoundBase],y ;$518, ピッチMOD用カウンタ
	bne .nopitchmod
;8436
	mSTZ [zSoundBase],y ;$518, ピッチMOD用カウンタ
	tax ;X = 0
	ldy #$15
	lda [zSoundBase],y ;$515, MOD定義のXX
	rol a
	rol a
	rol a
	rol a
	and #$07 ;A = ピッチMOD変化量
.PitchDiff = zSoundPtr
	sta <.PitchDiff
	ldy #$19
	lda [zSoundBase],y ;$519, ピッチMOD用上下動情報
	asl a
	bcc .negatepitch
	mSUB #$00, <.PitchDiff, <.PitchDiff ;$.PitchDiff = -$.PitchDiff
	dex ;X = #$FF
.negatepitch
	clc
	ldy #$1A
	mADD [zSoundBase],y, <.PitchDiff ;$51A, ピッチMOD変動下位
	iny
	txa ;A = X = #$00, #$FF, ピッチMOD変化量上位
	adc [zSoundBase],y
	sta [zSoundBase],y ;$51B, ピッチMOD変動上位
	ldy #$15
.MaxPitchCount = zSoundPtr ;ピッチの最大変位回数
	mAND [zSoundBase],y, #$1F, <.MaxPitchCount
	ldy #$19
	clc
	mADD [zSoundBase],y, #$01 ;$519, ピッチMOD用上下動情報 += 1
	and #$7F
	cmp <zSoundPtr
	bne .nopitchmod
;ピッチMODの変化方向を反転させる
	mAND [zSoundBase],y, #%10000000 ;$519, ピッチMOD用上下動情報
	ldy #$14
	lda [zSoundBase],y ;$514, MOD定義のWW
	asl a
	bcs .inversepitchmod
	mORA [zSoundBase],y, #%10000000 ;$514, MOD定義のWW
	ldy #$19
	lda [zSoundBase],y ;$519, ピッチMOD用上下動情報
	bpl .positivepitchmod
	and #%01111111
	sta [zSoundBase],y ;$519 = 0XXX XXXX
	bpl .nopitchmod
.positivepitchmod
	ora #%10000000
	sta [zSoundBase],y ;$519 = 1XXX XXXX
	bmi .nopitchmod
;84A3
.inversepitchmod
	mAND [zSoundBase],y, #%01111111 ;$514, MOD定義のWW
.nopitchmod
	mAND <.RegPtr, #$7F ;$.RegPtr = #$09, #$10
	inc <.RegPtr ;$.RegPtr = #$0A, #$11
	ldy #$1A
	lda [zSoundBase],y ;$51A, ピッチMOD変動下位
	ldy <.RegPtr
	clc
	adc [zSoundBase],y ;$50A, $511, 音高レジスタ値下位(曲, SFX)
	tax ;X = $50A, $511 + $51A
	ldy #$1B
	lda [zSoundBase],y ;$51B, ピッチMOD変動上位
	inc <.RegPtr ;$.RegPtr = #$0B, #$12
	ldy <.RegPtr
	adc [zSoundBase],y ;$50B, $512, 音高レジスタ値上位(曲, SFX)
	tay ;Y = $50B, $512 + $51B

;X, Y = ピッチMOD適用後の音高レジスタ値下位, 上位
	lda <zProcessChannel
	cmp #$01
	bne .isnotnoi
;ノイズを処理中
.NoiseFreq = zSoundPtr ;ノイズの音色 = Z000 0000
	mMOV #$0F, $4015
	txa ;A = ピッチMOD適用後の音高レジスタ値下位
	and #$0F
	tax ;A = 0000 XXXX
	inc <.RegPtr ;$.RegPtr = #$0C, #$13
	ldy <.RegPtr
	mAND [zSoundBase],y, #$80, <.NoiseFreq
	txa
	ora <.NoiseFreq
	tax ;X = Z000 XXXX, Z = 音色, XXXX = 音量
	ldy #$00
	beq .isnottri
.isnotnoi

	cmp #$02
	bne .isnottri
;三角波を処理中、三角波ぽんぽこ処理
;$50D, 07命令のXX → ぽんぽこ用レジスタ値上位, bit7: ぽんぽこフラグ
;$50E, 音量env用カウンタ → ぽんぽこ用カウンタ
;$50F, 音量envでの現在の音量 → ぽんぽこ用レジスタ値下位
	sty <zSoundPtr
	ldy #$0D
	lda [zSoundBase],y ;$50D, ぽんぽこ用レジスタ値上位, bit7: ぽんぽこフラグ
	bpl .skip_tri
	iny
	lda [zSoundBase],y ;$50E, ぽんぽこ用カウンタ
	cmp #SOUND_POMPOKO_LENGTH
	bcc .continue_pompoko
	dey
	sta [zSoundBase],y ;$50D, ぽんぽこフラグクリア
.continue_pompoko
	ldy #$0F
	clc
	mADD [zSoundBase],y, #LOW(SOUND_POMPOKO_VELOCITY) ;$50F, ぽんぽこ用レジスタ値下位
	tax
	ldy #$0D
	mADD [zSoundBase],y, #HIGH(SOUND_POMPOKO_VELOCITY), [zSoundBase],y, <zSoundPtr
.skip_tri
	ldy <zSoundPtr
.isnottri
	txa ;A = ピッチMOD適用後の音高レジスタ値下位
	ldx <zSoundIndex
	inx
	inx
	sta $4000,x
	tya ;A = ピッチMOD適用後の音高レジスタ値上位
	ldy #$1C
	cmp [zSoundBase],y ;$51C, 二度書き防止用退避変数
	beq .rts
	sta [zSoundBase],y ;$51C, 二度書き防止用退避変数
	ora #$08
	sta $4001,x
.rts
	rts

;84FD
Sound_MuteCurrentTrack:
	ldy #$01
	cpy <zProcessChannel
	bne .isnotnoi
	mMOV #$07, $4015 ;ノイズは再生しない
	rts
.isnotnoi
	ldx <zSoundIndex
	inx
	inx
	mSTZ $4000,x, $4001,x
	rts

;8516
;モジュレーション関係の変数の初期化
Sound_InitializeModulation:
	ldy #$14
	mAND [zSoundBase],y, #$7F ;$514, MOD定義WW
	ldy #$16
	lda [zSoundBase],y ;$516, MOD定義YY
	asl a ;キャリーフラグ = 音量MOD変化方向 (0: 上がる, 1: 下がる)
	bcc .vol_up
	ldy <zSoundPtr ;Y = #$13, #$0C
	lda [zSoundBase],y ;$50C, 音量系レジスタへの値 or $513, 効果音用音量系レジスタへの値
	ldx #$02
	cpx <zProcessChannel
	beq .istri
	and #$0F
.istri ;A = 音量 or 三角波再生時間
	ldy #$1E
	sta [zSoundBase],y ;$51E, 音量モジュレーションでの現在の音量
.vol_up
	ldx #$06
	lda #$00
	ldy #$18
.loop
	sta [zSoundBase],y ;$518 ～ $51D = 0
	iny
	dex
	bne .loop
	ldy #$1C
	mMOV #$FF, [zSoundBase],y ;$51C, 二度書き防止用退避変数
	rts

;8548
;二度書き防止用退避変数を保存してモジュレーション関係の変数を初期化
Sound_InitializeModulation_Continue:
	ldy #$1C
	lda [zSoundBase],y ;$51C, 二度書き防止用退避変数
	pha
	jsr Sound_InitializeModulation
	pla
	ldy #$1C
	sta [zSoundBase],y ;$51C, 二度書き防止用退避変数
	rts

;8556
Sound_ExecuteCommand:
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
Sound_ProcessSFX:
.Volume = zSoundPtr
	lda <zSFXWait
	beq Sound_AdvanceSFX
	ldy #$11
	lda [zSoundBase],y ;$511, 効果音用音高レジスタ値下位
	iny
	ora [zSoundBase],y ;$512, 効果音用音高レジスタ値上位
	bne .isplaying
	rts
.isplaying ;効果音が再生中
	iny
	lda [zSoundBase],y ;$513, 効果音用音量レジスタへの値
	dey
	cpy <zProcessChannel
	beq .istri
	and #$0F ;三角波以外の時、音量成分のみ抽出
.istri
	sta <.Volume
	mMOV #$93, <zSoundPtrhi
	jmp Sound_ManipulateVolumeMod

;8592
;効果音の処理単位を1つ進める
Sound_AdvanceSFX:
	jsr Sound_AdvanceByteSFX
	asl a
	bcs .continue
	jmp Sound_ProcessSFXCommand
.continue
	txa
	and #$0F
	cmp #$0F
	bne .write_reg
;A = #%1*** 1111 = #$8F
	jsr Sound_AdvanceByteSFX
	jmp Sound_InitializeModulation_Continue
.write_reg
;#$80 ≦ A ≦ #$87
	and #$07
	sta <zSoundPtr
	jsr Sound_AdvanceByteSFX
	ldy #$11
	sta [zSoundBase],y ;$511, 効果音用音高レジスタ値下位
	iny
	mMOV <zSoundPtr, [zSoundBase],y ;$512, 効果音用音高レジスタ値上位
	mMOV #$13, <zSoundPtr
	jsr Sound_InitializeModulation
	jmp Sound_MuteCurrentTrack

;85C2
Sound_ProcessSFXCommand:
	jsr Sound_ExecuteCommand
	.dw Sound_ProcessSFXCommand00
	.dw Sound_ProcessSFXCommand01
	.dw Sound_ProcessSFXCommand02
	.dw Sound_ProcessSFXCommand03
	.dw Sound_ProcessSFXCommand04
	.dw Sound_ProcessSFXCommand05
	.dw Sound_ProcessSFXCommand06

;85D3
Sound_ProcessSFXCommand00:
	jsr Sound_AdvanceByteSFX
	sta <zSFXWait
	bne Sound_AdvanceSFX

;85DB
Sound_ProcessSFXCommand01:
	jsr Sound_AdvanceByteSFX
	ldy #$10
	sta [zSoundBase],y ;$510, 効果音用ピッチエンベロープ変化値
	jmp Sound_AdvanceSFX

;85E5
Sound_ProcessSFXCommand02:
	jsr Sound_AdvanceByteSFX
	sta <zSoundPtr
	ldy #$13
	lda [zSoundBase],y ;$513, 効果音用音量レジスタへの値
	and #$3F
	bpl Sound_ProcessSFXCommand03.write

;85F5
Sound_ProcessSFXCommand03:
	jsr Sound_AdvanceByteSFX
	ldy #$13
	ldx #$02
	cpx <zProcessChannel
	beq .write_tri
;三角波以外の時
	sta <zSoundPtr
	lda [zSoundBase],y
	and #$C0
.write .public
	ora <zSoundPtr
.write_tri
	sta [zSoundBase],y
	jmp Sound_AdvanceSFX

;860F
Sound_ProcessSFXCommand04:
	jsr Sound_AdvanceByteSFX
	beq .jump
	cpx <zSFXLoop
	beq .dontjump
	inc <zSFXLoop
.jump
	jsr Sound_AdvanceByteSFX
	sta <zSoundPtr
	jsr Sound_AdvanceByteSFX
	sta <zSFXPtrhi
	mMOV <zSoundPtr, <zSFXPtr
.jmp
	jmp Sound_AdvanceSFX
;862C
.dontjump
	mSTZ <zSFXLoop
	clc
	mADD <zSFXPtr, #$02
	bcc .jmp
	inc <zSFXPtrhi
	bne .jmp

;8640
Sound_ProcessSFXCommand05:
	mMOV #$14, <zSoundPtr
.loop
	jsr Sound_AdvanceByteSFX
	ldy <zSoundPtr ;{y|14, 15, 16, 17}
	sta [zSoundBase],y ;MOD定義(WW, XX, YY, ZZ)
	iny
	sty <zSoundPtr
	cpy #$18
	bne .loop
	jmp Sound_AdvanceSFX

;8656
Sound_ProcessSFXCommand06:
	sec
	mSUB <zSFXPtr, #$01
	mBCS dec <zSFXPtrhi
	mAND <zSoundAttr, #$0F
	mSTZ <zSFXChannel
	mAND <zSFXChannel_Copy, #$FE
	ldy #$0A
	lda [zSoundBase],y ;$50A, 音高レジスタ値下位
	iny
	ora [zSoundBase],y ;$50B, 音高レジスタ値上位
	bne .isplaying
	ldx <zSoundIndex
	inx
	inx
	ldy <zProcessChannel
	jsr Sound_ResetFreqRegisters
	ldy #$00
	lda [zSoundBase],y ;$500, 曲ポインタ下位
	iny
	ora [zSoundBase],y ;$501, 曲ポインタ上位
	bne .isplaying
	rts
.isplaying
	ldy #$06
	lda [zSoundBase],y ;$506, タイの数とMOD番号
	and #$1F ;A = MOD番号
	tax
	jsr Sound_MusicCommand08_SetModulation
	mMOV #$0C, <zSoundPtr
	jmp Sound_InitializeModulation

;86A0
;効果音ポインタを1バイト進める
Sound_AdvanceByteSFX:
	ldy #$00
	lda [zSFXPtr],y
	inc <zSFXPtr
	mBNE inc <zSFXPtrhi
	tax
	rts

;86B4
;曲の処理
Sound_ProcessMusic:
	ldy #$03
	lda [zSoundBase],y ;$503, 音長上位
	beq Sound_AdvanceMusic_Loop
;音長カウンタの整数部分 > 0
.Tempo = zSoundPtr
.Tempohi = zSoundPtrhi
	clc
	mADD aTempo, <zSoundSpeed, <.Tempo
	mADD aTempohi, #$00, <.Tempohi
	dey
	clc
	mADD [zSoundBase],y, <.Tempo ;$502, 音長下位
	iny
	ror a
	eor #$80
	asl a
	mSUB [zSoundBase],y, <.Tempohi ;$503, 音長上位
	beq Sound_AdvanceMusic_Loop
	bcc Sound_AdvanceMusic_Loop
;音長カウンタの整数部分 > 0のとき、鳴り続ける
	ldy #$0A
	lda [zSoundBase],y ;音高レジスタ値下位
	iny
	ora [zSoundBase],y ;音高レジスタ値上位
	beq Sound_AdvanceMusic_Note.rts
	jmp Sound_ManipulateModulations

;86FE
;曲ポインタを進める, タイの指定の後でここに戻る
Sound_AdvanceMusic_Loop:
	jsr Sound_FetchByteMusic
	cmp #$18
	mBCS jmp Sound_ProcessMusicCommand
	and #$F8
	cmp #$18
	bne .isnottie
;タイ指定
	txa ;X = A = #$18 + T
	and #$07 ;0 ≦ A ≦ 7, タイの個数
	pha
	jsr Sound_AdvanceMusic_Loop
	pla ;0 ≦ A ≦ 7
	jmp Sound_WriteTieRepetition
.isnottie
;音符/休符
	txa
	rol a
	rol a
	rol a
	rol a
	and #$07
	tay ;Y = A = 0000 0YYY = 音長
	lda Table_SoundLengthNormal - 1,y
	ldy #$03
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
;8734
Sound_AdvanceMusic_Note:
	ldy #$06
	lda [zSoundBase],y ;$506, タイの数とMOD番号
	and #$E0 ;A = タイの数
	beq .notie
;新しい音符はタイで繋がれている
.NewTie = zSoundPtr
	sec
	sbc #$20
	sta <.NewTie ;タイの数を1減らす
	lda [zSoundBase],y
	and #$1F
	ora <.NewTie
	sta [zSoundBase],y ;新しいタイの数を書き込み
	lda <zSFXChannel_Copy
	lsr a
	bcc .isnotsfx
.rts .public
	rts
.isnotsfx
	jmp Sound_InitializeModulation_Continue
.notie
	txa
	and #$1F
	beq .mute
;音符
	ldy #$01
	cpy <zProcessChannel
	bne .play
.mute ;休符かノイズの時
	ldx #$00
	beq .set
.play
	asl a
	;clc
	adc #LOW(Table_SoundFrequency - SOUND_FREQTABLE_OFFSET)
	sta <zSoundPtr
	lda #$00
	adc #HIGH(Table_SoundFrequency - SOUND_FREQTABLE_OFFSET)
	sta <zSoundPtrhi
	;clc
	ldy #$07
	mADD <zSoundPtr, [zSoundBase],y ;$507, 周波数テーブルへのベースポインタ下位
	mBCC inc <zSoundPtrhi
	ldy #$01
	lda [zSoundPtr],y ;A = 周波数レジスタ値上位
	tax ;X = 周波数レジスタ値上位
	dey
	lda [zSoundPtr],y ;A = 周波数レジスタ値下位
.set
	ldy #$0A
	sta [zSoundBase],y ;$50A, 音高レジスタ値下位
	iny
	txa ;A = 周波数レジスタ値上位
	sta [zSoundBase],y ;$50B, 音高レジスタ値上位
	ldy #$0D
	mMOV [zSoundBase],y, <zSoundPtr ;$50D, 音量エンベロープの速さ(07 XX Y0のXX)
	asl a
	mBEQ jsr Sound_MusicCommand07.SetEnvelope
	lda <zSFXChannel_Copy
	lsr a
	mBCC rts
	mMOV #$0C, <zSoundPtr
	jsr Sound_InitializeModulation
	jmp Sound_MuteCurrentTrack

;87A2
Sound_WriteTieRepetition: ;0 ≦ A ≦ 7, タイの個数
	ror a
	ror a
	ror a
	ror a
	and #$E0           ;A = XXX0 0000, XXX = タイの個数
	sta <zSoundPtr
	ldy #$06
	lda [zSoundBase],y ;$506, タイの数とMOD番号
	and #$1F           ;A = 000Y YYYY
	ora <zSoundPtr     ;A = XXXY YYYY
	sta [zSoundBase],y
	rts

;87C0
;曲の音符以外の命令処理
Sound_ProcessMusicCommand:
	jsr Sound_ExecuteCommand
	.dw Sound_MusicCommand00
	.dw Sound_MusicCommand01
	.dw Sound_MusicCommand02
	.dw Sound_MusicCommand03
	.dw Sound_MusicCommand04
	.dw Sound_MusicCommand05
	.dw Sound_MusicCommand06
	.dw Sound_MusicCommand07
	.dw Sound_MusicCommand08
	.dw Sound_MusicCommand09
	.dw Sound_ProcessTriplet
	.dw Sound_MusicCommand0B
	.dw Sound_MusicCommand0C
	.dw Sound_MusicCommand0D
	.dw Sound_MusicCommand0E
	.dw Sound_MusicCommand0F
	.dw Sound_MusicCommand10

;* 命令00, テンポ変更
;00 目標音符, 開始音符
Sound_MusicCommand00:
	jsr Sound_FetchByteMusic
	sta aTempo
	jsr Sound_FetchByteMusic
	sta aTempohi
	jmp Sound_AdvanceMusic_Loop

;87E1
;命令01, ピッチエンベロープ
Sound_MusicCommand01:
	jsr Sound_FetchByteMusic
	ldy #$09 ;$509, ピッチenv
.write .public
	sta [zSoundBase],y
	jmp Sound_AdvanceMusic_Loop

;87EB
;命令02, 音色指定
Sound_MusicCommand02:
	jsr Sound_FetchByteMusic
	sta <zSoundPtr
	ldy #$0C ;$50C, 音量レジスタへの値
	lda [zSoundBase],y
	and #$3F
	bpl Sound_MusicCommand03.write

;87FB
;命令03, 音量指定
Sound_MusicCommand03:
	jsr Sound_FetchByteMusic
	ldy #$0C ;$50C, 音量レジスタへの値
	ldx #$02
	cpx <zProcessChannel
	beq .write_tri
	sta <zSoundPtr
	lda [zSoundBase],y
	and #$C0
.write .public
	ora <zSoundPtr
.write_tri
	sta [zSoundBase],y
	jmp Sound_AdvanceMusic_Loop

;8815
;命令04, ループ
Sound_MusicCommand04:
	jsr Sound_FetchByteMusic
	beq .jump
	ldy #$08
	mMOV [zSoundBase],y, <zSoundPtr ;$508, ループ回数
	cpx <zSoundPtr
	beq .nojump
	clc
	adc #$01
	sta [zSoundBase],y
.jump
	jsr Sound_FetchByteMusic
	pha
	jsr Sound_FetchByteMusic
	pla
	ldy #$00
	sta [zSoundBase],y ;$500, 曲ポインタ下位
	iny ;$501, 曲ポインタ上位
	txa
	bne Sound_MusicCommand01.write
.nojump
	mSTZ [zSoundBase],y ;$508, ループ回数
	clc
	ldy #$00
	mADD [zSoundBase],y, #$02
	iny
	lda [zSoundBase],y
.write .public
	adc #$00 ;曲ポインタ += 2
	bcc Sound_MusicCommand01.write

;885D
;命令05, キー値指定
Sound_MusicCommand05:
	jsr Sound_FetchByteMusic
	asl a
	ldy #$07 ;$507, 周波数テーブルへのベースポインタ下位
	bcc Sound_MusicCommand01.write

;887A
;命令06, 付点
Sound_MusicCommand06:
	jsr Sound_FetchByteMusic
	rol a
	rol a
	rol a
	rol a
	and #$07
	tay
	lda Table_SoundLengthDot - 2,y
	ldy #$03
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
	jmp Sound_AdvanceMusic_Note

;888D
;命令07, 音量エンベロープ
Sound_MusicCommand07:
	jsr Sound_FetchByteMusic
	ldy #$0D
	sta [zSoundBase],y ;$50D, 音量エンベロープの速さ(07 XX Y0のXX)
	pha
	jsr Sound_FetchByteMusic
	ldy #$0F
	sta [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
	pla
	sta <zSoundPtr
	asl a
	mBEQ jsr Sound_MusicCommand07.SetEnvelope
	jmp Sound_AdvanceMusic_Loop
;88A9
.SetEnvelope .public
	ldy #$0E
	mSTZ [zSoundBase],y ;$50E, 音量エンベロープ用カウンタ
	ldy <zSoundPtr
	bpl .writevol
	lda #$0F
.writevol
	sta <zSoundPtr
	ldy #$0F
	lda [zSoundBase],y ;$50F, 音量エンベロープでの現在の音量
	and #$F0
	ora <zSoundPtr
	sta [zSoundBase],y
	rts

;88C7
;命令08, MOD番号指定
Sound_MusicCommand08:
	jsr Sound_FetchByteMusic
	sta <zSoundPtr
	ldy #$06
	lda [zSoundBase],y ;$506, タイの数とMOD番号
	and #$E0
	ora <zSoundPtr
	sta [zSoundBase],y
	lda <zSFXChannel_Copy
	lsr a
	mBCS jsr Sound_MusicCommand08_SetModulation
	jmp Sound_AdvanceMusic_Loop
;88E1
Sound_MusicCommand08_SetModulation:
	txa
	asl a
	asl a
	tax
	ldy #$14
.jumpwrite
	mMOV Sound_Modulations,x, [zSoundBase],y
	inx
	iny
	cpy #$18
	bne .jumpwrite
.rts .public
	rts

;8917
;命令09, 終曲
Sound_MusicCommand09:
	ldy #$00
	tya
	sta [zSoundBase],y ;$500, 曲ポインタ下位
	iny
	sta [zSoundBase],y ;$501, 曲ポインタ上位
	mAND <zSoundAttr, #$F0
	lda <zSFXChannel_Copy
	lsr a
	bcs Sound_MusicCommand08_SetModulation.rts
	ldx <zSoundIndex
	inx
	inx
	ldy <zProcessChannel
	jmp Sound_ResetFreqRegisters

;* 命令0A, 連符指定子の処理
Sound_ProcessTriplet:
	jsr Sound_FetchByteMusic
	rol a
	rol a
	rol a
	rol a
	and #$07
	tay
	lda Table_SoundLengthTriplet - 1,y
	ldy #$03
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
	jmp Sound_AdvanceMusic_Note

;* 命令0B, ピッチエンベロープを0に戻す
Sound_MusicCommand0B:
	ldy #$09 ;$509, ピッチenv
	lda #$00
.write .public
	sta [zSoundBase],y
	jmp Sound_AdvanceMusic_Loop

;* 命令0C, 音量を1上げる
;(TRI)ハイタム
Sound_MusicCommand0C:
	ldx #LOW(SOUND_POMPOKO_INIT_HIGH)
	lda #HIGH(SOUND_POMPOKO_INIT_HIGH)
	ldy <zProcessChannel
	cpy #$02
	beq .tri
	ldy #$0C
	clc
	lda [zSoundBase],y ;$50C, 音量レジスタへの値
	adc #$01
	bcc Sound_MusicCommand0B.write
.tri .public
	ldy #$0D
	sta [zSoundBase],y
	iny
	mSTZ [zSoundBase],y
	iny
	txa
	bne Sound_MusicCommand0B.write

;* 命令0D, 音量を1下げる
;(TRI)ロータム
Sound_MusicCommand0D:
	ldx #LOW(SOUND_POMPOKO_INIT_LOW)
	lda #HIGH(SOUND_POMPOKO_INIT_LOW)
	ldy <zProcessChannel
	cpy #$02
	beq Sound_MusicCommand0C.tri
	ldy #$0C
	sec
	lda [zSoundBase],y ;$50C, 音量レジスタへの値
	sbc #$01
	bcs Sound_MusicCommand0B.write

;* 命令0E, 音下げるやつの変化速度を指定する
Sound_MusicCommand0E:
	jsr Sound_FetchByteMusic
	asl a
	asl a
	asl a
	ldy #$05
	bne Sound_MusicCommand0B.write

;* 命令0F, 次の音へスラーをつなげる
Sound_MusicCommand0F:
	ldy #$0A
	lda [zSoundBase],y ;$50A, 音高レジスタ値下位
	pha
	iny
	lda [zSoundBase],y ;$50B, 音高レジスタ値上位
	pha
	jsr Sound_AdvanceMusic_Loop
	jsr Sound_CopyFreqValue
	ldy #$0B
	pla
	sta [zSoundBase],y ;$50B, 音高レジスタ値上位
	dey
	pla
	sta [zSoundBase],y ;$50A, 音高レジスタ値下位
	rts
;* 命令10, 音符の初めの方の音程を少し下げるやつ
;00 目標音符, 開始音符
Sound_MusicCommand10:
	jsr Sound_FetchByteMusic
	jsr Sound_AdvanceMusic_Note
	jsr Sound_CopyFreqValue
	jmp Sound_AdvanceMusic_Loop

;周波数レジスタ値を音下げるやつの方にコピーする
Sound_CopyFreqValue:
	ldy #$0A
	lda [zSoundBase],y ;$50A, 音高レジスタ値下位
	tax
	iny
	mMOV [zSoundBase],y, <zSoundPtr ;$50B, 音高レジスタ値上位
	ldy #$05
	lda [zSoundBase],y ;$505, 音下げるやつの目標値上位
	and #$F8
	ora <zSoundPtr
	sta [zSoundBase],y
	txa
	dey
	sta [zSoundBase],y ;$504, 音下げるやつの目標値下位
	rts

;8935
;曲ポインタを進めて1バイトを得る
Sound_FetchByteMusic:
	ldy #$00
	mMOV [zSoundBase],y, <zSoundPtr ;$500, 曲ポインタ下位
	iny
	mMOV [zSoundBase],y, <zSoundPtrhi ;$501, 曲ポインタ上位
	dey
	lda [zSoundPtr],y
	tax ;X = 次のバイト
	clc
	mADD <zSoundPtr, #$01, [zSoundBase],y
	iny
	mADD <zSoundPtrhi, #$00, [zSoundBase],y
	txa
	rts ;X = A = 取得した値

;8975
;音長テーブル, 通常
Table_SoundLengthNormal:
	;.db $FF
	.db $03, $06, $0C, $18, $30, $60, $C0

;音長テーブル, 連符
Table_SoundLengthTriplet:
	;.db $FF
	.db $02, $04, $08, $10, $20, $40, $80

;897D
;音長テーブル, 付点
Table_SoundLengthDot:
	;.db $FF
	.db $09, $12, $24, $48, $90
	;.db $FF


;8985
;周波数テーブル
SOUND_FREQTABLE_OFFSET = 2 * 9
	.list
Table_SoundFrequency:
	.nolist
	; .dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	; .dw $0000
	.dw $07F2, $07D6, $0714, $06AE, $064E, $05F3, $0594
	.dw $054D, $0501, $04BB, $0475, $0436, $03F9, $03BF, $038A
	.dw $0357, $0327, $02FA, $02CF, $02A7, $0281, $025D, $023B
	.dw $021A, $01FC, $01E0, $01C5, $01AB, $0193, $017D, $0167
	.dw $0153, $0140, $012E, $011D, $010D, $00FE, $00F0, $00E2
	.dw $00D5, $00C9, $00BE, $00B3, $00A9, $00A0, $0097, $008E
	.dw $0086, $007F, $0078, $0071, $006A, $0064, $005F, $0059
	.dw $0054, $0050, $004B, $0047, $0043, $003F, $003C, $0038
	.dw $0035, $0032, $002F, $002C, $002A, $0028, $0025, $0023
	.dw $0021, $001F, $001E, $001C, $001A, $0019, $0017, $0016
	.dw $0015, $0014, $0012, $0011, $0010, $000F, $000F, $000E

;8A50
;曲定義テーブル
	.org $8A50 ; WORKAROUND!!
	.list
Table_TrackStartPointers:
	.nolist
