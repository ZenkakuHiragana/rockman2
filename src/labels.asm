
;�f�o�b�O�I�v�V����
;�œK���̂��߂̃I�v�V����

___2P                   ;2P�R���g���[���[�p�̓��͂�L��
___WAITFRAMES           ;20 00 C1 A�t���[���҂��߂�L��
;___DISABLE_INTRO_PIPI   ;�{�X�Љ�̃s�s���𖳌���
;___OPTIMIZE             ;�s�v�ȓ�R�[�h�𖳌���
;___NOCLC                ;�s�v�Ǝv����clc�𖳌���
;___NOSEC                ;�s�v�Ǝv����sec�𖳌���
;___NORTS                ;jsr��rts�ƂȂ��镔����jmp�ɒu������
;___JSRJMP               ;jsr��rts�̕�����jmp�ɒu������(������rts���c��)
;___BUGFIX               ;�o�O���C��
;;�f�B���C�X�N���[���A����Z�����̃~�X���C��
;___BUGFIXENEMYBUBBLELEAD;�G�o�u�����[�h�̒n�`���菈���ɊԈႢ������݂����H

;�������A�h���X
;�[���y�[�W�A�h���X�͐擪��z�A�A�u�\�����[�g�A�h���X�͐擪��a

zPtr = $08              ;�ėp�|�C���^
zPtrlo = $08            ;�ėp�|�C���^����
zPtrhi = $09            ;�ėp�|�C���^���

zScrollLeft = $14       ;���X�N���[�����[
zScrollRight = $15      ;���X�N���[���E�[

zNTPrevlo = $16         ;�}�b�v�������݃A�h���X�E�߂������
zNTPrevhi = $17         ;�}�b�v�������݃A�h���X�E�߂�����
zNTNextlo = $18         ;�}�b�v�������݃A�h���X�E�i�ޕ�����
zNTNexthi = $19         ;�}�b�v�������݃A�h���X�E�i�ޕ����
zNTPointer = $1A        ;�}�b�v�ǂݍ��݈ʒu

zPPUSqr = $1B           ;PPU��`�������݃T�C�Y�\��

zFrameCounter = $1C     ;�t���[���J�E���^

zIsLag = $1D            ;���C�����[�`���I������0 ���������t���O

zHScrolllo = $1E        ;���X�N���[���l����
zHScroll = $1F          ;���X�N���[���l

zRoom = $20             ;��ʔԍ�

zVScrolllo = $21        ;�c�X�N���[���l����
zVScroll = $22          ;�c�X�N���[���l

zKeyDown = $23          ;�L�[�������
zKeyDown2P = $24        ;�L�[������ԁE2P
zKeyDownPrev = $25      ;1�t���[���O�̃L�[�������
zKeyDownPrev2P = $26    ;1�t���[���O�̃L�[������ԁE2P
zKeyPress = $27         ;�L�[�N���b�N
zKeyPress2P = $28       ;�L�[�N���b�N�E2P

zBank = $29             ;$8000�`$BFFF�̃o���N�ԍ�

zStage = $2A            ;�X�e�[�W�ԍ� HAWBQFMC

zObjIndex = $2B         ;�I�u�W�F�N�g�C���f�b�N�X

zStatus = $2C           ;���b�N�}���̏�Ԓl

zRScreenX = $2D         ;���b�N�}���̉�ʓ�X���W(���ɗp�r����)
zEScreenX = $2E         ;�G�̉�ʓ�X���W(���ɗp�r����)
zEScreenRoom = $2F      ;$440,x - $20

zGravity = $30          ;�d�͉����x����
zGravityhi = $31        ;�d�͉����x���

zBGAttr = $32           ;���b�N�}���ɐڂ���BG������
zBGAttr2 = $33          ;���b�N�}���ɐڂ���BG�����E
zBGAttr3 = $34          ;���b�N�}���ɐڂ���BG�����^�񒆂Ȃ�
zBGLadder = $35         ;���b�N�}���̂͂�������̏��

zShootPoseTimer = $36   ;���p���̕ێ�����

zScrollFlag = $37       ;�X�N���[���t���O
zScrollNumber = $38     ;�X�N���[���ԍ�

zBubbleCounter = $39    ;�����̖A���o�Ă���܂ł̃J�E���^

z3A = $3A

zJumpPowerlo = $3B      ;�W�����v�͉���
zJumpPowerhi = $3C      ;�W�����v�͏��

zShootPose = $3D        ;���p���̂��

zSliplo = $3E      ;�X���b�v���x����
zSliphi = $3F      ;�X���b�v���x���

zWindFlag = $40         ;���ƃX���b�v�̃t���O

zMusicPause = $41       ;�Ȉꎞ��~�t���O

zMoveVec = $42

zPaletteIndex = $43     ;�p���b�g�ԍ�
zPaletteTimer = $44     ;�p���b�g�A�j���[�V�����̃^�C�}�[

zConveyorVec = $45
zConveyorRVec = $45     ;�R���x�A�E�̗�������
zConveyorLVec = $46     ;�R���x�A���̗�������

zPPULinear = $47        ;PPU���`�������݃T�C�Y�\��

zEnemyIndexPrev = $48   ;�G�ԍ��E�߂��
zEnemyIndexNext = $49   ;�G�ԍ��E�i�ޕ�

zRand = $4A             ;����

zInvincible = $4B       ;���G����

zItemIndexPrev = $4C    ;�A�C�e���ԍ��E�߂��
zItemIndexNext = $4D    ;�A�C�e���ԍ��E�i�ޕ�

zObjItemFlag = $4E      ;�ړ��������Ɏg�p����A�A�C�e���t���O

zWindlo = $4F           ;���̋�������
zWindhi = $50           ;���̋������

zPPULaser = $51
z52 = $52 ;�|�[�Y���j���[���J������PPU�փA�h���X�������ɏ������܂�Ă���
z53 = $53 ;��̓I�ɉ��Ɏg���Ă�̂��͖�����
zPPUShutterFlag = $54   ;�V���b�^�[�̏������ݎ��Ɏg��

zBlockObjNum = $55      ;�u���b�N�����̃I�u�W�F�N�g�̐�
zBlockObjIndex = $56    ;�u���b�N�����̃I�u�W�F�N�g�ւ̃C���f�b�N�X
;�`$65�܂�

zSoundQueue = $66       ;��������g���b�N�̃|�C���^
zPostProcessSound = $67 ;�o���N�؂�ւ�����NMI�ƋȂ̏����̂��߂̃t���O
zPostProcSemaphore = $68;�Ȃ̏�������񂵂ɂ���悤�Z�}�t�H
zBankCopy = $69         ;$29�̃R�s�[�炵���H

zClearFlags = $9A      ;����擾�t���O
zItemFlags = $9B        ;�A�C�e���擾�t���O

zEnergyArray = $9C      ;����G�l���M�[�z��J�n
nEnergySize = $0B       ;����̑���

zEnergyHeat = $9C       ;�A�g�~�b�N�t�@�C���[�̃G�l���M�[
zEnergyAir = $9D        ;�G�A�[�V���[�^�[�̃G�l���M�[
zEnergyWood = $9E       ;���[�t�V�[���h�̃G�l���M�[
zEnergyBubble = $9F     ;�o�u�����[�h�̃G�l���M�[
zEnergyQuick = $A0      ;�N�C�b�N�u�[�������̃G�l���M�[
zEnergyFlash = $A1      ;�^�C���X�g�b�p�[�̃G�l���M�[
zEnergyMetal = $A2      ;���^���u���[�h�̃G�l���M�[
zEnergyCrash = $A3      ;�N���b�V���{���̃G�l���M�[
zEnergy1 = $A4          ;1���̃G�l���M�[
zEnergy2 = $A5          ;2���̃G�l���M�[
zEnergy3 = $A6          ;3���̃G�l���M�[
zETanks = $A7           ;E�ʂ̐�
zLives = $A8            ;�c�@�̐�
zEquipment = $A9        ;�������Ă��镐��
zStopFlag = $AA         ;���Ԓ�~�t���O

zAutoFireTimer = $AB    ;�N�C�b�N�u�[�������p�A�˃^�C�}�[

zWeaponEnergy = $AC     ;����̎c��
zItemInterrupt = $AD    ;�A�C�e���̂��߂̊��荞�݃t���O

zScreenMod = $AE

zWindVec = $AF          ;���̕���

zContinuePoint = $B0    ;���Ԓn�_�ԍ����ꎞ�I�ɕۑ�����
zBossBehaviour = $B1    ;�{�X�̍s���̎��
zBossVar = $B2          ;�{�X�p�ϐ�
zBossKind = $B3         ;�{�X�̎��

zB4 = $B4

zVScrollApparentlo = $B5;�������̉��X�N���[������
zVScrollApparenthi = $B6;�������̉��X�N���[�����
zHScrollApparentlo = $B7;�������̏c�X�N���[������
zHScrollApparenthi = $B8;�������̏c�X�N���[�����
zRoomApparent = $B9     ;�������̉�ʂ̈ʒu

zBossRushStage = $BA    ;�{�X���b�V���őI�������{�X�ԍ�
zBossRushProg = $BC     ;�{�X���b�V���̐i�s��
zNoDamage = $BD         ;�����蔻�薳���t���O

zRestartTitle = $BE     ;�^�C�g���X�N���[���̎��Ԑ؂��1

zTitleScreenWaitlo = $C0;�^�C�g����ʂ̑҂�����
zTitleScreenWaithi = $C1;�^�C�g����ʂ̑҂�����

zSoundAttr = $E0        ;���ʉ��㏑���D�揇�ʂȂ�
zSFXChannel = $E1       ;���ʉ��Ƃ��Ė炷�`�����l�� (.... NT21)

zTrackPtr = $E2         ;�g���b�N�ݒ�̎��Ɏg���|�C���^
zTrackPtrhi = $E3

zNMILock = $E4          ;NMI�̂��߂̃��b�N�@�\�B�炵���B
zSoundVar1 = $E5        ;�Ȃ̂��߂̈ꎞ�ϐ�
zSoundVar2 = $E6

zSoundSpeed = $E7       ;�Ȃ𑁑��肷����
zSoundFade = $E8        ;�Ȃ̃t�F�[�h�A�E�g�ݒ�
zSoundFadeProg = $E9    ;�Ȃ̃t�F�[�h�A�E�g�i�K

zSoundCounter = $EA     ;���֌W�p�t���[���J�E���^
zSoundIndex = $EB       ;�`�����l���x�[�X�|�C���^[$(4000+$EB)]
zSoundBase = $EC        ;�`�����l���x�[�X�|�C���^[($EC).y]
zSoundBasehi = $ED      ;
zProcessChannel = $EE   ;���ݏ������̃`�����l���B4, 3, 2, 1 = SQ1, S2, TRI, NOI
zSFXChannel_Copy = $EF  ;$EF = $E1

zSFXPtr = $F0           ;���ʉ��|�C���^
zSFXPtrhi = $F1         ;���ʉ��|�C���^���
zSFXWait = $F2          ;���̉��������P�ʂ܂ł̎���
zSFXLoop = $F3          ;���ʉ��̌��݂̌J��Ԃ���
zSoundPtr = $F4         ;�ėp�|�C���^
zSoundPtrhi = $F5       ;�ėp�|�C���^���

zF6 = $F6

z2000 = $F7             ;$2000�փR�s�[
z2001 = $F8             ;$2001�փR�s�[

zOffscreen = $F9        ;��ʊO�t���O�݂�����

zFA = $FA

zWaterLevel = $FB       ;�����t���O
zWaterWait = $FC        ;�����̃��O�̂��߂̃E�F�C�g

zWait1 = $FC            ;�E�F�C�g�Ƃ������
zWait2 = $FD            ;
zWait3 = $FE            ;
zWait4 = $FF            ;



aEnemyOrder = $F0       ;�G�̏����ԍ�
aEnemyOrder10 = $100
aEnemyFlash = $100      ;�G�̔�e���̃t���b�V�����
aEnemyFlash10 = $110
aEnemyVar = $110       ;�G�̔ėp�ϐ�
aEnemyVar10 = $120
aItemLifeOffset = $110  ;�A�C�e���̃��C�t�̂��߂̃|�C���^
aItemLifeOffset10 = $120

aItemOrder = $120       ;�A�C�e�������ԍ�
aItemOrder10 = $130
aItemLife = $140        ;�A�C�e���̃��C�t

aPlatformWidth = $150   ;�I�u�W�F�N�g�̑��ꔻ��̍L��
aPlatformWidth10 = $160
aPlatformY = $160       ;�I�u�W�F�N�g�̑��ꔻ��̏c�ʒu
aPlatformY10 = $170

aSprite = $200          ;�X�v���C�g�������J�n
aSpriteY = $200         ;�X�v���C�gY�ʒu
aSpriteNumber = $201    ;�X�v���C�g���
aSpriteAttr = $202      ;�X�v���C�g����
aSpriteX = $203         ;�X�v���C�gX�ʒu

aPPUSqrhi = $300        ;PPU��`�������݈ʒu���
aPPUSqrlo = $304        ;PPU��`�������݈ʒu����
aPPUSqrAttrhi = $308    ;PPU��`�������݁E�����e�[�u���ւ̏������ݏ��
aPPUSqrAttrlo = $30C    ;PPU��`�������݁E�����e�[�u���ւ̏������݉���
aPPUSqrData = $310      ;PPU��`�������݃f�[�^
aPPUSqrAttrData = $350  ;PPU��`�������݁E�����e�[�u���̃f�[�^

aPaletteAnim = $354     ;�p���b�g�A�j���[�V��������
aPaletteAnimWait = $355 ;�p���b�g�A�j���[�V��������
aPalette = $356         ;���݂̃p���b�g
aPaletteSpr = $366      ;���݂̃X�v���C�g�̃p���b�g
aPaletteAnimBuf = $376  ;�p���b�g�A�j���[�V�����̃o�b�t�@

aPPULinearhi = $3B6     ;PPU���`�������ݏ��
aPPULinearlo = $3B7     ;PPU���`�������݉���
aPPULinearData = $3B8   ;PPU���`�������݃f�[�^

aPPULaserhi = $3B6      ;PPU���[�U�[��V���b�^�[�p�̏������ݏ��
aPPULaserlo = $3BC      ;PPU���[�U�[��V���b�^�[�p�̏������݉���
aPPULaserData = $3C2    ;PPU�������݃f�[�^

aPPUShutterAttrhi = $3C2;PPU�V���b�^�[�������ݎ��̑����e�[�u���ʒu���
aPPUShutterAttrlo = $3C8;PPU�V���b�^�[�������ݎ��̑����e�[�u���ʒu����


aObjAnim = $400         ;�I�u�W�F�N�g�̃A�j���[�V�����ԍ�
aObjAnim10 = $410       ;+10����ꍇ�̃��x��
aObjFlags = $420        ;�I�u�W�F�N�g�̏�Ԓl
aObjFlags10 = $430

aObjRoom = $440         ;�I�u�W�F�N�g�̕����ԍ�
aObjRoom10 = $450
aObjX = $460            ;�I�u�W�F�N�g��X�ʒu���
aObjX10 = $470
aObjXlo = $480          ;�I�u�W�F�N�g��X�ʒu����
aObjXlo10 = $490

aObjY = $4A0            ;�I�u�W�F�N�g��Y�ʒu���
aObjY10 = $4B0
aObjYlo = $4C0          ;�I�u�W�F�N�g��Y�ʒu����
aObjYlo10 = $4D0

aObjVar = $4E0          ;�I�u�W�F�N�g�̔ėp�ϐ�
aObjVar10 = $4F0



aSQ1Ptr = $500          ;��`�g1�ȃ|�C���^����
aSQ1Ptrhi = $501        ;��`�g1�ȃ|�C���^���
aSQ1Len = $502          ;��`�g1��������
aSQ1Lenhi = $503        ;��`�g1�������
aSQ1Tempo = $504        ;��`�g1�e���|
aSQ1Triplet = $505      ;bit7 ��`�g1�A���t���O
aSQ1LoopCount = $505    ;bit6-0 ��`�g1�J��Ԃ���
aSQ1Tie = $506          ;bit7-5 ��`�g1�^�C�̌�
aSQ1Mod = $506          ;bit4-0 ��`�g1���W�����[�V������`
aSQ1FreqBase = $507     ;��`�g1���g���e�[�u���ւ̃x�[�X�|�C���^����
aSQ1FreqBasehi = $508   ;��`�g1���g���e�[�u���ւ̃x�[�X�|�C���^���
aSQ1Pitch = $509        ;��`�g1�s�b�`�G���x���[�v�ω��l
aSQ1Reg = $50A          ;��`�g1�������W�X�^�l����
aSQ1Reghi = $50B        ;��`�g1�������W�X�^�l���
aSQ1RegVol = $50C       ;��`�g1���ʌn���W�X�^�ւ̒l
aSQ1VolWait = $50D      ;��`�g1���ʃG���x���[�v�̑���(07 XX Y0��XX)
aSQ1VolCounter = $50E   ;��`�g1���ʃG���x���[�v�p�J�E���^
aSQ1Vol = $50F          ;��`�g1���ʃG���x���[�v�ł̌��݂̉���
aSQ1SFXPitch = $510     ;(���ʉ��p)��`�g1�s�b�`�G���x���[�v�ω��l
aSQ1SFXReg = $511       ;(���ʉ��p)��`�g1�������W�X�^�l����
aSQ1SFXReghi = $512     ;(���ʉ��p)��`�g1�������W�X�^�l���
aSQ1SFXRegVol = $513    ;(���ʉ��p)��`�g1���ʌn���W�X�^�ւ̒l
aSQ1ModDefine1 = $514   ;��`�g1���W�����[�V������`WW(WW XX YY ZZ��WW)
aSQ1ModDefine2 = $515   ;��`�g1���W�����[�V������`XX
aSQ1ModDefine3 = $516   ;��`�g1���W�����[�V������`YY
aSQ1ModDefine4 = $517   ;��`�g1���W�����[�V������`ZZ
aSQ1PitchCounter = $518 ;��`�g1�s�b�`���W�����[�V�����p�J�E���^
aSQ1PitchInfo = $519    ;��`�g1�s�b�`���W�����[�V�����p�㉺�����
aSQ1PitchDelta = $51A   ;��`�g1�s�b�`�̕ψʉ���
aSQ1PithcDeltahi = $51B ;��`�g1�s�b�`�̕ψʏ��
aSQ1Prevent = $51C      ;��`�g1��x�����h�~�p�ޔ�ϐ��炵��
aSQ1VolModCounter = $51D;��`�g1���ʃ��W�����[�V�����p�J�E���^
aSQ1VolModVolume = $51E ;��`�g1���ʃ��W�����[�V�����ł̌��݂̉���

aSQ2Ptr = $51F          ;��`�g2�ȃ|�C���^����
aSQ2Ptrhi = $520        ;��`�g2�ȃ|�C���^���
aSQ2Len = $521          ;��`�g2��������
aSQ2Lenhi = $522        ;��`�g2�������
aSQ2Tempo = $523        ;��`�g2�e���|
aSQ2Triplet = $524      ;bit7 ��`�g2�A���t���O
aSQ2LoopCount = $524    ;bit6-0 ��`�g2�J��Ԃ���
aSQ2Tie = $525          ;bit7-5 ��`�g2�^�C�̌�
aSQ2Mod = $525          ;bit4-0 ��`�g2���W�����[�V������`
aSQ2FreqBase = $526     ;��`�g2���g���e�[�u���ւ̃x�[�X�|�C���^����
aSQ2FreqBasehi = $527   ;��`�g2���g���e�[�u���ւ̃x�[�X�|�C���^���
aSQ2Pitch = $528        ;��`�g2�s�b�`�G���x���[�v�ω��l
aSQ2Reg = $529          ;��`�g2�������W�X�^�l����
aSQ2Reghi = $52A        ;��`�g2�������W�X�^�l���
aSQ2RegVol = $52B       ;��`�g2���ʌn���W�X�^�ւ̒l
aSQ2VolWait = $52C      ;��`�g2���ʃG���x���[�v�̑���(07 XX Y0��XX)
aSQ2VolCounter = $52D   ;��`�g2���ʃG���x���[�v�p�J�E���^
aSQ2Vol = $52E          ;��`�g2���ʃG���x���[�v�ł̌��݂̉���
aSQ2SFXPitch = $52F     ;(���ʉ��p)��`�g2�s�b�`�G���x���[�v�ω��l
aSQ2SFXReg = $530       ;(���ʉ��p)��`�g2�������W�X�^�l����
aSQ2SFXReghi = $531     ;(���ʉ��p)��`�g2�������W�X�^�l���
aSQ2SFXRegVol = $532    ;(���ʉ��p)��`�g2���ʌn���W�X�^�ւ̒l
aSQ2ModDefine1 = $533   ;��`�g2���W�����[�V������`WW(WW XX YY ZZ��WW)
aSQ2ModDefine2 = $534   ;��`�g2���W�����[�V������`XX
aSQ2ModDefine3 = $535   ;��`�g2���W�����[�V������`YY
aSQ2ModDefine4 = $536   ;��`�g2���W�����[�V������`ZZ
aSQ2PitchCounter = $537 ;��`�g2�s�b�`���W�����[�V�����p�J�E���^
aSQ2PitchInfo = $538    ;��`�g2�s�b�`���W�����[�V�����p�㉺�����
aSQ2PitchDelta = $539   ;��`�g2�s�b�`�̕ψʉ���
aSQ2PithcDeltahi = $53A ;��`�g2�s�b�`�̕ψʏ��
aSQ2Prevent = $53B      ;��`�g2��x�����h�~�p�ޔ�ϐ��炵��
aSQ2VolModCounter = $53C;��`�g2���ʃ��W�����[�V�����p�J�E���^
aSQ2VolModVolume = $53D ;��`�g2���ʃ��W�����[�V�����ł̌��݂̉���

aTRIPtr = $53E          ;�O�p�g�ȃ|�C���^����
aTRIPtrhi = $53F        ;�O�p�g�ȃ|�C���^���
aTRILen = $540          ;�O�p�g��������
aTRILenhi = $541        ;�O�p�g�������
aTRITempo = $542        ;�O�p�g�e���|
aTRITriplet = $543      ;bit7 �O�p�g�A���t���O
aTRILoopCount = $543    ;bit6-0 �O�p�g�J��Ԃ���
aTRITie = $544          ;bit7-5 �O�p�g�^�C�̌�
aTRIMod = $544          ;bit4-0 �O�p�g���W�����[�V������`
aTRIFreqBase = $545     ;�O�p�g���g���e�[�u���ւ̃x�[�X�|�C���^����
aTRIFreqBasehi = $546   ;�O�p�g���g���e�[�u���ւ̃x�[�X�|�C���^���
aTRIPitch = $547        ;�O�p�g�s�b�`�G���x���[�v�ω��l
aTRIReg = $548          ;�O�p�g�������W�X�^�l����
aTRIReghi = $549        ;�O�p�g�������W�X�^�l���
aTRIRegVol = $54A       ;�O�p�g���ʌn���W�X�^�ւ̒l
aTRIVolWait = $54B      ;�O�p�g���ʃG���x���[�v�̑���(07 XX Y0��XX)
aTRIVolCounter = $54C   ;�O�p�g���ʃG���x���[�v�p�J�E���^
aTRIVol = $54D          ;�O�p�g���ʃG���x���[�v�ł̌��݂̉���
aTRISFXPitch = $54E     ;(���ʉ��p)�O�p�g�s�b�`�G���x���[�v�ω��l
aTRISFXReg = $54F       ;(���ʉ��p)�O�p�g�������W�X�^�l����
aTRISFXReghi = $550     ;(���ʉ��p)�O�p�g�������W�X�^�l���
aTRISFXRegVol = $551    ;(���ʉ��p)�O�p�g���ʌn���W�X�^�ւ̒l
aTRIModDefine1 = $552   ;�O�p�g���W�����[�V������`WW(WW XX YY ZZ��WW)
aTRIModDefine2 = $553   ;�O�p�g���W�����[�V������`XX
aTRIModDefine3 = $554   ;�O�p�g���W�����[�V������`YY
aTRIModDefine4 = $555   ;�O�p�g���W�����[�V������`ZZ
aTRIPitchCounter = $556 ;�O�p�g�s�b�`���W�����[�V�����p�J�E���^
aTRIPitchInfo = $557    ;�O�p�g�s�b�`���W�����[�V�����p�㉺�����
aTRIPitchDelta = $558   ;�O�p�g�s�b�`�̕ψʉ���
aTRIPithcDeltahi = $559 ;�O�p�g�s�b�`�̕ψʏ��
aTRIPrevent = $55A      ;�O�p�g��x�����h�~�p�ޔ�ϐ��炵��
aTRIVolModCounter = $55B;�O�p�g���ʃ��W�����[�V�����p�J�E���^
aTRIVolModVolume = $55C ;�O�p�g���ʃ��W�����[�V�����ł̌��݂̉���

aNOIPtr = $55D          ;�m�C�Y�ȃ|�C���^����
aNOIPtrhi = $55E        ;�m�C�Y�ȃ|�C���^���
aNOILen = $55F          ;�m�C�Y��������
aNOILenhi = $560        ;�m�C�Y�������
aNOITempo = $561        ;�m�C�Y�e���|
aNOITriplet = $562      ;bit7 �m�C�Y�A���t���O
aNOILoopCount = $562    ;bit6-0 �m�C�Y�J��Ԃ���
aNOITie = $563          ;bit7-5 �m�C�Y�^�C�̌�
aNOIMod = $563          ;bit4-0 �m�C�Y���W�����[�V������`
aNOIFreqBase = $564     ;�m�C�Y���g���e�[�u���ւ̃x�[�X�|�C���^����
aNOIFreqBasehi = $565   ;�m�C�Y���g���e�[�u���ւ̃x�[�X�|�C���^���
aNOIPitch = $566        ;�m�C�Y�s�b�`�G���x���[�v�ω��l
aNOIReg = $567          ;�m�C�Y�������W�X�^�l����
aNOIReghi = $568        ;�m�C�Y�������W�X�^�l���
aNOIRegVol = $569       ;�m�C�Y���ʌn���W�X�^�ւ̒l
aNOIVolWait = $56A      ;�m�C�Y���ʃG���x���[�v�̑���(07 XX Y0��XX)
aNOIVolCounter = $56B   ;�m�C�Y���ʃG���x���[�v�p�J�E���^
aNOIVol = $56C          ;�m�C�Y���ʃG���x���[�v�ł̌��݂̉���
aNOISFXPitch = $56D     ;(���ʉ��p)�m�C�Y�s�b�`�G���x���[�v�ω��l
aNOISFXReg = $56E       ;(���ʉ��p)�m�C�Y�������W�X�^�l����
aNOISFXReghi = $56F     ;(���ʉ��p)�m�C�Y�������W�X�^�l���
aNOISFXRegVol = $570    ;(���ʉ��p)�m�C�Y���ʌn���W�X�^�ւ̒l
aNOIModDefine1 = $571   ;�m�C�Y���W�����[�V������`WW(WW XX YY ZZ��WW)
aNOIModDefine2 = $572   ;�m�C�Y���W�����[�V������`XX
aNOIModDefine3 = $573   ;�m�C�Y���W�����[�V������`YY
aNOIModDefine4 = $574   ;�m�C�Y���W�����[�V������`ZZ
aNOIPitchCounter = $575 ;�m�C�Y�s�b�`���W�����[�V�����p�J�E���^
aNOIPitchInfo = $576    ;�m�C�Y�s�b�`���W�����[�V�����p�㉺�����
aNOIPitchDelta = $577   ;�m�C�Y�s�b�`�̕ψʉ���
aNOIPithcDeltahi = $578 ;�m�C�Y�s�b�`�̕ψʏ��
aNOIPrevent = $579      ;�m�C�Y��x�����h�~�p�ޔ�ϐ��炵��
aNOIVolModCounter = $57A;�m�C�Y���ʃ��W�����[�V�����p�J�E���^
aNOIVolModVolume = $57B ;�m�C�Y���ʃ��W�����[�V�����ł̌��݂̉���

aModDefine = $57C       ;���W�����[�V������`�ւ̃|�C���^����
aModDefinehi = $57D     ;���W�����[�V������`�ւ̃|�C���^���

a57E = $57E
a57F = $57F

aSoundQueue = $580      ;��������Ȃ̃��X�g
aWeaponCollision = $590 ;����̓����蔻��
aWeaponPlatformW = $5A0 ;����̑��ꔻ��L��
aWeaponPlatformY = $5A3 ;����̑��ꔻ��Y�ʒu

aTimeStopper = $5A6     ;�Ȃ�ł��������

aBossTiwnWait = $5A7    ;�{�X���e����Ԃ܂ł̃t���[���B�炵���B
aBossVar1 = $5A7
aBossPtrhi = $5A7       ;���C���[�X�e�[�W�̃{�X���|�C���^�Ƃ��Ďg���Ă����C������
aBossInvincible = $5A8  ;�{�X�̖��G����

aBossPtrlo = $5A9
aBossVar2 = $5A9         ;�Ȃ񂾂��������

aBossDeath = $5AA       ;�{�X�e�B�E���t���O



aObjVX = $600           ;�I�u�W�F�N�g�̑��xX���
aObjVX10 = $610
aObjVXlo = $620         ;�I�u�W�F�N�g�̑��xX����
aObjVXlo10 = $630

aObjBlockW = $600       ;�I�u�W�F�N�g�̕ǔ���͈�X
aObjBlockW10 = $610
aObjBlockH = $620       ;�I�u�W�F�N�g�̕ǔ���͈�Y
aObjBlockH10 = $630

aObjVY = $640           ;�I�u�W�F�N�g�̑��xY���
aObjVY10 = $650
aObjVYlo = $660         ;�I�u�W�F�N�g�̑��xY����
aObjVYlo10 = $670

aObjBlockX = $640       ;�I�u�W�F�N�g�̕ǔ���ʒuX
aObjBlockX10 = $650
aObjBlockY = $660       ;�I�u�W�F�N�g�̕ǔ���ʒuY
aObjBlockY10 = $670

aObjWait = $680         ;�I�u�W�F�N�g�̃A�j���[�V�����̃J�E���^
aObjWait10 = $690
aObjFrame = $6A0        ;�I�u�W�F�N�g�̃A�j���[�V�����̃R�}��
aObjFrame10 = $6B0

aObjLife = $6C0         ;�I�u�W�F�N�g�̗̑�
aObjLife10 = $6D0

aWeaponScreenX = $6E0   ;����I�u�W�F�N�g�̉�ʓ�X
aObjCollision = $6E0    ;�I�u�W�F�N�g�̓����蔻��ԍ�
aObjCollision10 = $6F0

aPaletteBackup = $700   ;�T�u���j���[���J��������BG�p���b�g�o�b�N�A�b�v





Table_AnimationPointer_Low = $F900
Table_AnimationPointerEnemy_Low = $F980
Table_AnimationPointer_High = $FA00
Table_AnimationPointerEnemy_High = $FA80
Table_AnimationData_Start = $FB00
Reset_Start = $FFE0
NMI_VECTOR = $FFFA
RESET_VECTOR = $FFFC
BREAK_VECTOR = $FFFE

