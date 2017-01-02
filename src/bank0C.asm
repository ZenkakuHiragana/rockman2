
	mBEGIN #$0C, #$8000
	
	jmp Sound_ProcessTracks:
	
;8003
;20 51 C0�ŗ\�񂳂ꂽ�Ȃ�炵�n�߂鏈��
SOUND_STARTPLAY:
	cmp #$FC
	bne .continue1
	jmp Bank0CStartFC
.continue1
	cmp #$FD
	bne .continue2
	jmp Bank0CStartFD
.continue2
	cmp #$FE
	bne .continue3
	mMOV #$01, <zNMILock
	mSTZ <zSoundBase
	jmp Bank0CStartFE
.continue3
	cmp #$FF
	bne .continue4
	mMOV #$01, <zNMILock
	mSTZ <zSoundBase
	jmp Bank0CStartFF
.continue4
	asl a
	tax
	mMOV $8A50,x, <zTrackPtr
	mMOV $8A51,x, <zTrackPtrhi
	ldy #$00
	lda [zTrackPtr],y
	tax
	and #$0F
	beq Bank0CStartSound_IsSFX
	lda <zSoundAttr
	and #$0F
	sta <zSoundVar1
	cpx <zSoundVar1
	bcs .continue5
	rts
;�Ȃ̏㏑���D�揇��00�`0F���傫�����炷
.continue5
	stx <zSoundVar1
	lda <zSoundAttr
	and #$F0
	ora <zSoundVar1
	sta <zSoundAttr
	mMOV #$01, <zNMILock
	.ifndef ___OPTIMIZE
	lda #$00
	sta <zSoundBase
	lda #$00
	sta <zSoundSpeed
	sta <zSoundFade
	.else
	mSTZ <zSoundBase, <zSoundSpeed, <zSoundFade
	.endif
	mMOV #$04, <zSoundVar1
	lda #$01
.loop_init
	clc
	adc <zTrackPtr
	sta <zTrackPtr
	lda #$00
	adc <zTrackPtrhi
	sta <zTrackPtrhi
	ldx <zSoundBase
	ldy #$00
.loop_init_trackptr
	mMOV [zTrackPtr],y, aSQ1Ptr,x
	inx
	iny
	cpy #$02
	bne .loop_init_trackptr
	ldy #$0E
	lda #$00
.loop_stz
	sta aSQ1Ptr,x
	inx
	dey
	bne .loop_stz
	lda <zSFXChannel
	lsr a
	bcs .skip_for_sfx
	jsr Sound_ClearLFOs
.skip_for_sfx
	jsr Sound_GotoNextTrack
	dec <zSoundVar1
	beq .continue6
	lda #$02
	jmp .loop_init
.continue6
	ldy #$02
	mMOV [zTrackPtr],y, aModDefine
	iny
	mMOV [zTrackPtr],y, aModDefinehi
	jsr Sound_ClearSFXReserve
	mSTZ <zNMILock
	rts
;80BB
Bank0CStartSound_IsSFX:
	lda <zSoundAttr
	and #$F0
	sta <zSoundVar1
	cpx <zSoundVar1
	bcs .dosfx
	rts
;���ʉ��㏑���D�揇��00�`F0���傫�����ɑ���
.dosfx
	stx <zSoundVar1
	lda <zSoundAttr
	and #$0F
	ora <zSoundVar1
	sta <zSoundAttr
	mMOV #$01, <zNMILock
	mSTZ <zSoundBase
	ldx #$00
	lda #$02
	clc
	adc <zTrackPtr
	sta <zSFXPtr
	txa
	adc <zTrackPtrhi
	sta <zSFXPtrhi
	stx <zSFXWait
	stx <zSFXLoop
	ldy #$01
	lda [zTrackPtr],y
	and #$0F
	tax
	ora <zSFXChannel
	pha
	stx <zSFXChannel
	mMOV #$04, <zSoundVar1
	mMOV #$02, <zSoundVar2
.loop_initsfx
	pla
	lsr a
	pha
	bcc .skip
		jsr Sound_ClearLFOs
		lda <zSFXChannel
		lsr a
		bcs .skip
			jsr Sound_816C
.skip
	jsr Sound_GotoNextTrack
	lda #$04
	clc
	adc <zSoundVar2
	sta <zSoundVar2
	dec <zSoundVar1
	bne .loop_initsfx
	jsr $8219
	lda <zSFXChannel
	sta <zSFXChannel_Copy
	pla
	mSTZ <zNMILock
	rts
;8129
;#FC�����s �Ȃ𑁂�����
Bank0CStartFC:
	iny
	sty <zSoundSpeed
	rts
;812D
;#FD�����s �Ȃ��t�F�[�h�A�E�g/�C������
Bank0CStartFD:
	sty <zSoundFade
	lda #$01
	sta <zSoundFadeProg
	lda <zSoundCounter
	and #$01
	sta <zSoundCounter
	rts
;813A
;#FE�����s ���ʉ����~�߂�
Bank0CStartFE:
	lda <zSoundAttr
	and #$0F
	sta <zSoundAttr
	mMOV #$04, <zSoundVar1
	mMOV #$02, <zSoundVar2
.loop_sfx
	lda <zSFXChannel
	lsr a
	bcc .nosfx
		jsr Sound_ClearLFOs
		jsr Sound_816C
.nosfx
	jsr Sound_GotoNextTrack
	lda #$04
	clc
	adc <zSoundVar2
	sta <zSoundVar2
	dec <zSoundVar1
	bne .loop_sfx
	lda #$00
	sta <zSFXChannel
	sta <zSFXChannel_Copy
	.ifndef ___OPTIMIZE
	lda #$00
	.endif
	sta <zNMILock
	rts
;816C
;�Ȃ񂾂��ꂻ��1
Sound_816C:
	lda <zSoundBase
	clc
	adc #$0A
	tax
	lda aSQ1Ptr,x ; = aSQ1Reg
	ora aSQ1Ptrhi,x ; = aSQ1Reghi
	bne Sound_CopyModulation
	ldy <zSoundVar1
	ldx <zSoundVar2
	jsr Sound_8222
	ldx <zSoundBase
	lda aSQ1Ptr,x
	ora aSQ1Ptrhi,x
	bne Sound_CopyModulation
	rts
;818C
;#FF�����s �Ȃ��~�߂�
Bank0CStartFF:
	lda <zSoundAttr
	and #$F0
	sta <zSoundAttr
	lda #$00
	sta <zSoundSpeed
	sta <zSoundFade
	mMOV #$04, <zSoundVar1
.loop_del
	lda #$00
	ldx <zSoundBase
	sta aSQ1Ptr,x
	sta aSQ1Ptrhi,x
	jsr $8211
	dec <zSoundVar1
	bne .loop_del
	mSTZ <zNMILock
	rts

;81B2
;���̕ϒ��֌W��0�ɂ���
Sound_ClearLFOs:
	ldy #$0F
	lda #$10
	clc
	adc <zSoundBase
	tax
	lda #$00
.loop
	sta aSQ1Ptr,x ;SFXPitch�`VolModVolume($510�`$51E) = 0
	inx
	dey
	bne .loop
	rts

;81C4
;���W�����[�V������`���R�s�[����
Sound_CopyModulation:
	lda <zSoundVar1
	pha
	lda <zSoundVar2
	pha
	mMOV aModDefine, <zSoundVar1
	mMOV aModDefinehi, <zSoundVar2
	lda <zSoundBase
	clc
	adc #$06
	tax
	lda aSQ1Ptr,x
	and #$1F ;���݂̃��W�����[�V������`�ԍ��ɃA�N�Z�X
	beq .nomod
		tay
		lda #$00
.loop_mod
		clc
		adc #$04
		dey
		bne .loop_mod
.nomod
	tay ;Y = ���W�����[�V������`�ւ̃|�C���^
	txa
	clc
	adc #$0E
	tax ;X = 6 + E = 14, ���W�����[�V������`�̓��e���i�[
	lda #$04
.loop_copy
	pha
	mMOV [zSoundVar1],y, aSQ1Ptr,x
	iny
	inx
	pla
	sec
	sbc #$01
	bne .loop_copy ;4�o�C�g�R�s�[
	pla
	sta <zSoundVar2
	pla
	sta <zSoundVar1
	rts

;8207
;���̃`�����l���̏��������邽�߂̏����H
Sound_GotoNextTrack:
	lsr <zSFXChannel
	bcc .skip_sfx
	lda <zSFXChannel
	ora #$80
	sta <zSFXChannel
.skip_sfx
	lda #$1F
	clc
	adc <zSoundBase
	sta <zSoundBase
	rts

;8219
;���ʉ���炷�`�����l���̗\���S������
Sound_ClearSFXReserve:
	lsr <zSFXChannel
	lsr <zSFXChannel
	lsr <zSFXChannel
	lsr <zSFXChannel
	rts

;8222
;�����~�߂�H
Sound_8222:
	cpy #$01
	beq .play
	mSTZ $4000,x, $4001,x
	rts
.play
	mMOV #$07, $4015
	rts

;8235
;$8000������ł��� �Ȃ̏���
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
	ldx <SoundIndex
	inx
	inx
	ldy <zProcessChannel
	jsr Sound_8222
	lsr <zSFXChannel_Copy
	bcc $829E
	
