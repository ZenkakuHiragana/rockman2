
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
	sty <zSoundBasehi
	mSTZ <zSoundIndex
	mMOV #$04, <zProcessChannel
	lda #$01
	ldy #$18
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
	lda #$01
	ldy #$1D
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
	lda <zSFXChannel_Copy
	lsr a
	bcc $8266 ;Sound_ProcessTracks_IsMusic
	jsr $856D
	lda <zMusicPause
	lsr a
	bcc .continue
	jmp $8286
.continue
	ldy #$00
	lda [zSoundBase],y
	iny
	ora [zSoundBase],y
	beq $8286
	lda #$01
	ldy #$0E
	clc
	adc [zSoundBase],y
	sta [zSoundBase],y
	jsr $86B4
	jmp $8294
;8286
.skip_track
	lda <zSFXChannel_Copy
	lsr a
	bcs $8294
	ldx <zSoundIndex
	inx
	inx
	ldy <zProcessChannel
	jsr Sound_ResetFreqRegisters
	lsr <zSFXChannel_Copy
	bcc $829E
