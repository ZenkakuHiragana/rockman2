
;デバッグオプション
;最適化のためのオプション

;___2P                   ;2Pコントローラー用の入力を有効
;___WAITFRAMES           ;20 00 C1 Aフレーム待つ命令を有効
___DISABLE_INTRO_PIPI   ;ボス紹介のピピ化を無効化
___OPTIMIZE             ;不要な謎コードを無効化
___NOCLC                ;不要と思われるclcを無効化
___NOSEC                ;不要と思われるsecを無効化
___NORTS                ;jsr→rtsとつながる部分をjmpに置き換え
___JSRJMP               ;jsr→rtsの部分をjmpに置き換え(ただしrtsを残す)
___BUGFIX               ;バグを修正
;ディレイスクロール、割り算処理のミスを修正
___BUGFIXENEMYBUBBLELEAD;敵バブルリードの地形判定処理に間違いがあるみたい？

;メモリアドレス
;ゼロページアドレスは先頭にz、アブソリュートアドレスは先頭にa

zPtr = $08              ;汎用ポインタ
zPtrlo = $08            ;汎用ポインタ下位
zPtrhi = $09            ;汎用ポインタ上位

zScrollLeft = $14       ;横スクロール左端
zScrollRight = $15      ;横スクロール右端

zNTPrevlo = $16         ;マップ書き込みアドレス・戻る方下位
zNTPrevhi = $17         ;マップ書き込みアドレス・戻る方上位
zNTNextlo = $18         ;マップ書き込みアドレス・進む方下位
zNTNexthi = $19         ;マップ書き込みアドレス・進む方上位
zNTPointer = $1A        ;マップ読み込み位置

zPPUObjhi = $14         ;敵画像書き込み位置上位
zPPUObjlo = $15         ;敵画像書き込み位置下位
zPPUObjPtr = $16        ;敵画像読み込みセット番号
zPPUObjPtrEnd = $17     ;敵画像読み込み完了位置
zPPUObjProg = $18       ;敵画像読み込み位置
zPPUHScr = $19          ;横スクロール書き込みフラグ
zPPUVScr = $1A          ;縦スクロール書き込みフラグ

zPPUSqr = $1B           ;PPU矩形書き込みサイズ予約

zFrameCounter = $1C     ;フレームカウンタ

zIsLag = $1D            ;メインルーチン終了時に0 処理落ちフラグ

zHScrolllo = $1E        ;横スクロール値下位
zHScroll = $1F          ;横スクロール値

zRoom = $20             ;画面番号

zVScrolllo = $21        ;縦スクロール値下位
zVScroll = $22          ;縦スクロール値

zKeyDown = $23          ;キー押下状態
zKeyDown2P = $24        ;キー押下状態・2P
zKeyDownPrev = $25      ;1フレーム前のキー押下状態
zKeyDownPrev2P = $26    ;1フレーム前のキー押下状態・2P
zKeyPress = $27         ;キークリック
zKeyPress2P = $28       ;キークリック・2P

zBank = $29             ;$8000～$BFFFのバンク番号

zStage = $2A            ;ステージ番号 HAWBQFMC

zObjIndex = $2B         ;オブジェクトインデックス

zStatus = $2C           ;ロックマンの状態値

zRScreenX = $2D         ;ロックマンの画面内X座標(他に用途あり)
zEScreenX = $2E         ;敵の画面内X座標(他に用途あり)
zEScreenRoom = $2F      ;$440,x - $20

zGravity = $30          ;重力加速度下位
zGravityhi = $31        ;重力加速度上位

zBGAttr = $32           ;ロックマンに接するBG属性左
zBGAttr2 = $33          ;ロックマンに接するBG属性右
zBGAttr3 = $34          ;ロックマンに接するBG属性真ん中など
zBGLadder = $35         ;ロックマンのはしご周りの状態

zShootPoseTimer = $36   ;撃つ姿勢の保持時間

zScrollFlag = $37       ;スクロールフラグ +80: シャッター
zScrollNumber = $38     ;スクロール番号 → スクロール移動先画面数

zBubbleCounter = $39    ;水中の泡が出てくるまでのカウンタ

z3A = $3A

zJumpPowerlo = $3B      ;ジャンプ力下位
zJumpPowerhi = $3C      ;ジャンプ力上位

zShootPose = $3D        ;撃つ姿勢のやつ

zSliplo = $3E      ;スリップ速度下位
zSliphi = $3F      ;スリップ速度上位

zWindFlag = $40         ;風とスリップのフラグ

zMusicPause = $41       ;曲一時停止フラグ

zMoveVec = $42

zPaletteIndex = $43     ;パレット番号
zPaletteTimer = $44     ;パレットアニメーションのタイマー

zConveyorVec = $45
zConveyorRVec = $45     ;コンベア右の流れる向き
zConveyorLVec = $46     ;コンベア左の流れる向き

zPPULinear = $47        ;PPU線形書き込みサイズ予約

zEnemyIndexPrev = $48   ;敵番号・戻る方
zEnemyIndexNext = $49   ;敵番号・進む方

zRand = $4A             ;乱数

zInvincible = $4B       ;無敵時間

zItemIndexPrev = $4C    ;アイテム番号・戻る方
zItemIndexNext = $4D    ;アイテム番号・進む方

zShutterHeight = $4D    ;シャッター高さ

zObjItemFlag = $4E      ;移動処理時に使用する、アイテムフラグ

zWindlo = $4F           ;風の強さ下位
zWindhi = $50           ;風の強さ上位

zPPULaser = $51
z52 = $52 ;ポーズメニューを開く時にPPUへアドレスがここに書き込まれている
z53 = $53 ;具体的に何に使ってるのかは未調査
zPPUShutterFlag = $54   ;シャッターの書き込み時に使う

zBlockObjNum = $55      ;ブロック属性のオブジェクトの数
zBlockObjIndex = $56    ;ブロック属性のオブジェクトへのインデックス
;～$65まで

zSoundQueue = $66       ;処理するトラックのポインタ
zPostProcessSound = $67 ;バンク切り替え中のNMIと曲の処理のためのフラグ
zPostProcSemaphore = $68;曲の処理を後回しにするようセマフォ
zBankCopy = $69         ;$29のコピーらしい？

zClearFlags = $9A      ;武器取得フラグ
zItemFlags = $9B        ;アイテム取得フラグ

zEnergyArray = $9C      ;武器エネルギー配列開始
nEnergySize = $0B       ;武器の総数

zEnergyHeat = $9C       ;アトミックファイヤーのエネルギー
zEnergyAir = $9D        ;エアーシューターのエネルギー
zEnergyWood = $9E       ;リーフシールドのエネルギー
zEnergyBubble = $9F     ;バブルリードのエネルギー
zEnergyQuick = $A0      ;クイックブーメランのエネルギー
zEnergyFlash = $A1      ;タイムストッパーのエネルギー
zEnergyMetal = $A2      ;メタルブレードのエネルギー
zEnergyCrash = $A3      ;クラッシュボムのエネルギー
zEnergy1 = $A4          ;1号のエネルギー
zEnergy2 = $A5          ;2号のエネルギー
zEnergy3 = $A6          ;3号のエネルギー
zETanks = $A7           ;E缶の数
zLives = $A8            ;残機の数
zEquipment = $A9        ;装備している武器
zStopFlag = $AA         ;時間停止フラグ

zAutoFireTimer = $AB    ;クイックブーメラン用連射タイマー

zWeaponEnergy = $AC     ;武器の残り
zItemInterrupt = $AD    ;アイテムのための割り込みフラグ

zScreenMod = $AE

zWindVec = $AF          ;風の方向

zContinuePoint = $B0    ;中間地点番号を一時的に保存する
zBossBehaviour = $B1    ;ボスの行動の種類
zBossVar = $B2          ;ボス用変数
zBossType = $B3         ;ボスの種類
zBossVar2 = $B4

zVScrollApparentlo = $B5;見かけの横スクロール下位
zVScrollApparenthi = $B6;見かけの横スクロール上位
zHScrollApparentlo = $B7;見かけの縦スクロール下位
zHScrollApparenthi = $B8;見かけの縦スクロール上位
zRoomApparent = $B9     ;見かけの画面の位置

zBossRushStage = $BA    ;ボスラッシュで選択したボス番号
zBossRushProg = $BC     ;ボスラッシュの進行状況
zNoDamage = $BD         ;当たり判定無効フラグ

zRestartTitle = $BE     ;タイトルスクリーンの時間切れで1

zTitleScreenWaitlo = $C0;タイトル画面の待ち時間
zTitleScreenWaithi = $C1;タイトル画面の待ち時間

zSoundAttr = $E0        ;効果音上書き優先順位など
zSFXChannel = $E1       ;効果音として鳴らすチャンネル (.... NT21)

zTrackPtr = $E2         ;トラック設定の時に使うポインタ
zTrackPtrhi = $E3

zNMILock = $E4          ;NMIのためのロック機構。らしい。
zSoundVar1 = $E5        ;曲のための一時変数
zSoundVar2 = $E6

zSoundSpeed = $E7       ;曲を早送りするやつ
zSoundFade = $E8        ;曲のフェードアウト設定
zSoundFadeProg = $E9    ;曲のフェードアウト段階

zSoundCounter = $EA     ;音関係用フレームカウンタ
zSoundIndex = $EB       ;チャンネルベースポインタ[$(4000+$EB)]
zSoundBase = $EC        ;チャンネルベースポインタ[($EC).y]
zSoundBasehi = $ED      ;
zProcessChannel = $EE   ;現在処理中のチャンネル。4, 3, 2, 1 = SQ1, S2, TRI, NOI
zSFXChannel_Copy = $EF  ;$EF = $E1

zSFXPtr = $F0           ;効果音ポインタ
zSFXPtrhi = $F1         ;効果音ポインタ上位
zSFXWait = $F2          ;次の音長処理単位までの時間
zSFXLoop = $F3          ;効果音の現在の繰り返し回数
zSoundPtr = $F4         ;汎用ポインタ
zSoundPtrhi = $F5       ;汎用ポインタ上位

zF6 = $F6

z2000 = $F7             ;$2000へコピー
z2001 = $F8             ;$2001へコピー

zOffscreen = $F9        ;画面外フラグみたいな

zFA = $FA

zWaterLevel = $FB       ;水中フラグ
zWaterWait = $FC        ;水中のラグのためのウェイト

zWait1 = $FC            ;ウェイトとか取るやつ
zWait2 = $FD            ;
zWait3 = $FE            ;
zWait4 = $FF            ;



aEnemyOrder = $F0       ;敵の順序番号
aEnemyOrder10 = $100
aEnemyFlash = $100      ;敵の被弾時のフラッシュ情報
aEnemyFlash10 = $110
aEnemyVar = $110       ;敵の汎用変数
aEnemyVar10 = $120
;aItemLifeOffset = $110  ;アイテムのライフのためのポインタ
;aItemLifeOffset10 = $120

aItemOrder = $120       ;アイテム順序番号
aItemOrder10 = $130
aItemLife = $140        ;アイテムのライフ

aPlatformWidth = $150   ;オブジェクトの足場判定の広さ
aPlatformWidth10 = $160
aPlatformY = $160       ;オブジェクトの足場判定の縦位置
aPlatformY10 = $170

aSprite = $200          ;スプライトメモリ開始
aSpriteY = $200         ;スプライトY位置
aSpriteNumber = $201    ;スプライト種類
aSpriteAttr = $202      ;スプライト属性
aSpriteX = $203         ;スプライトX位置

aPPUSqrhi = $300        ;PPU矩形書き込み位置上位
aPPUSqrlo = $304        ;PPU矩形書き込み位置下位
aPPUSqrAttrhi = $308    ;PPU矩形書き込み・属性テーブルへの書き込み上位
aPPUSqrAttrlo = $30C    ;PPU矩形書き込み・属性テーブルへの書き込み下位
aPPUSqrData = $310      ;PPU矩形書き込みデータ
aPPUSqrAttrData = $350  ;PPU矩形書き込み・属性テーブルのデータ

;aPaletteAnim = $354     ;パレットアニメーション枚数
;aPaletteAnimWait = $355 ;パレットアニメーション速さ
;aPalette = $356         ;現在のパレット
;aPaletteSpr = $366      ;現在のスプライトのパレット
;aPaletteAnimBuf = $376  ;パレットアニメーションのバッファ
aPaletteAnim = $720     ;パレットアニメーション枚数
aPaletteAnimWait = $721 ;パレットアニメーション速さ
aPalette = $722         ;現在のパレット
aPaletteSpr = $732      ;現在のスプライトのパレット
;aPaletteAnimBuf = $742  ;パレットアニメーションのバッファ
aPaletteOverride = $742 ;パレット上書き情報

aPPULinearhi = $3B6     ;PPU線形書き込み上位
aPPULinearlo = $3B7     ;PPU線形書き込み下位
aPPULinearData = $3B8   ;PPU線形書き込みデータ

aPPULaserhi = $3B6      ;PPUレーザーやシャッター用の書き込み上位
aPPULaserlo = $3BC      ;PPUレーザーやシャッター用の書き込み下位
aPPULaserData = $3C2    ;PPU書き込みデータ

aPPUShutterAttrhi = $3C2;PPUシャッター書き込み時の属性テーブル位置上位
aPPUShutterAttrlo = $3C8;PPUシャッター書き込み時の属性テーブル位置下位

;--------------------------------------------------------------
aPPUHScrhi = $300       ;横スクロールNT書き込み上位
aPPUHScrlo = $301       ;横スクロールNT書き込み下位
aPPUHScrData = $302     ;横スクロールNT書き込みデータ
aPPUHScrAttrhi = $320   ;横スクロール属性書き込み上位
aPPUHScrAttrlo = $321   ;横スクロール属性書き込み下位
aPPUHScrAttr = $322     ;横スクロール属性書き込みデータ
                        ;8つ分の属性書き込み領域
aPPUVScrhi = $331       ;縦スクロールNT書き込み上位
aPPUVScrlo = $332       ;縦スクロールNT書き込み下位
aPPUVScrData = $333     ;縦スクロールNT書き込みデータ
aPPUVScrAttr = $373     ;縦スクロール属性書き込み下位
aPPUVScrAttrMask = $374 ;縦スクロール属性マスク
aPPUVScrAttrData = $375 ;縦スクロール属性書き込みデータ
;--------------------------------------------------------------

aObjAnim = $400         ;オブジェクトのアニメーション番号
aObjAnim10 = $410       ;+10する場合のラベル
aObjFlags = $420        ;オブジェクトの状態値
aObjFlags10 = $430

aObjRoom = $440         ;オブジェクトの部屋番号
aObjRoom10 = $450
aObjX = $460            ;オブジェクトのX位置上位
aObjX10 = $470
aObjXlo = $480          ;オブジェクトのX位置下位
aObjXlo10 = $490

aObjY = $4A0            ;オブジェクトのY位置上位
aObjY10 = $4B0
aObjYlo = $4C0          ;オブジェクトのY位置下位
aObjYlo10 = $4D0

aObjVar = $4E0          ;オブジェクトの汎用変数
aObjVar10 = $4F0



aSQ1Ptr = $500          ;矩形波1曲ポインタ下位
aSQ1Ptrhi = $501        ;矩形波1曲ポインタ上位
aSQ1Len = $502          ;矩形波1音長下位
aSQ1Lenhi = $503        ;矩形波1音長上位
aSQ1Tempo = $504        ;矩形波1テンポ
aSQ1Triplet = $505      ;bit7 矩形波1連符フラグ
aSQ1LoopCount = $505    ;bit6-0 矩形波1繰り返し回数
aSQ1Tie = $506          ;bit7-5 矩形波1タイの個数
aSQ1Mod = $506          ;bit4-0 矩形波1モジュレーション定義
aSQ1FreqBase = $507     ;矩形波1周波数テーブルへのベースポインタ下位
aSQ1FreqBasehi = $508   ;矩形波1周波数テーブルへのベースポインタ上位
aSQ1Pitch = $509        ;矩形波1ピッチエンベロープ変化値
aSQ1Reg = $50A          ;矩形波1音高レジスタ値下位
aSQ1Reghi = $50B        ;矩形波1音高レジスタ値上位
aSQ1RegVol = $50C       ;矩形波1音量系レジスタへの値
aSQ1VolWait = $50D      ;矩形波1音量エンベロープの速さ(07 XX Y0のXX)
aSQ1VolCounter = $50E   ;矩形波1音量エンベロープ用カウンタ
aSQ1Vol = $50F          ;矩形波1音量エンベロープでの現在の音量
aSQ1SFXPitch = $510     ;(効果音用)矩形波1ピッチエンベロープ変化値
aSQ1SFXReg = $511       ;(効果音用)矩形波1音高レジスタ値下位
aSQ1SFXReghi = $512     ;(効果音用)矩形波1音高レジスタ値上位
aSQ1SFXRegVol = $513    ;(効果音用)矩形波1音量系レジスタへの値
aSQ1ModDefine1 = $514   ;矩形波1モジュレーション定義WW(WW XX YY ZZのWW)
aSQ1ModDefine2 = $515   ;矩形波1モジュレーション定義XX
aSQ1ModDefine3 = $516   ;矩形波1モジュレーション定義YY
aSQ1ModDefine4 = $517   ;矩形波1モジュレーション定義ZZ
aSQ1PitchCounter = $518 ;矩形波1ピッチモジュレーション用カウンタ
aSQ1PitchInfo = $519    ;矩形波1ピッチモジュレーション用上下動情報
aSQ1PitchDelta = $51A   ;矩形波1ピッチの変位下位
aSQ1PithcDeltahi = $51B ;矩形波1ピッチの変位上位
aSQ1Prevent = $51C      ;矩形波1二度書き防止用退避変数らしい
aSQ1VolModCounter = $51D;矩形波1音量モジュレーション用カウンタ
aSQ1VolModVolume = $51E ;矩形波1音量モジュレーションでの現在の音量

aSQ2Ptr = $51F          ;矩形波2曲ポインタ下位
aSQ2Ptrhi = $520        ;矩形波2曲ポインタ上位
aSQ2Len = $521          ;矩形波2音長下位
aSQ2Lenhi = $522        ;矩形波2音長上位
aSQ2Tempo = $523        ;矩形波2テンポ
aSQ2Triplet = $524      ;bit7 矩形波2連符フラグ
aSQ2LoopCount = $524    ;bit6-0 矩形波2繰り返し回数
aSQ2Tie = $525          ;bit7-5 矩形波2タイの個数
aSQ2Mod = $525          ;bit4-0 矩形波2モジュレーション定義
aSQ2FreqBase = $526     ;矩形波2周波数テーブルへのベースポインタ下位
aSQ2FreqBasehi = $527   ;矩形波2周波数テーブルへのベースポインタ上位
aSQ2Pitch = $528        ;矩形波2ピッチエンベロープ変化値
aSQ2Reg = $529          ;矩形波2音高レジスタ値下位
aSQ2Reghi = $52A        ;矩形波2音高レジスタ値上位
aSQ2RegVol = $52B       ;矩形波2音量系レジスタへの値
aSQ2VolWait = $52C      ;矩形波2音量エンベロープの速さ(07 XX Y0のXX)
aSQ2VolCounter = $52D   ;矩形波2音量エンベロープ用カウンタ
aSQ2Vol = $52E          ;矩形波2音量エンベロープでの現在の音量
aSQ2SFXPitch = $52F     ;(効果音用)矩形波2ピッチエンベロープ変化値
aSQ2SFXReg = $530       ;(効果音用)矩形波2音高レジスタ値下位
aSQ2SFXReghi = $531     ;(効果音用)矩形波2音高レジスタ値上位
aSQ2SFXRegVol = $532    ;(効果音用)矩形波2音量系レジスタへの値
aSQ2ModDefine1 = $533   ;矩形波2モジュレーション定義WW(WW XX YY ZZのWW)
aSQ2ModDefine2 = $534   ;矩形波2モジュレーション定義XX
aSQ2ModDefine3 = $535   ;矩形波2モジュレーション定義YY
aSQ2ModDefine4 = $536   ;矩形波2モジュレーション定義ZZ
aSQ2PitchCounter = $537 ;矩形波2ピッチモジュレーション用カウンタ
aSQ2PitchInfo = $538    ;矩形波2ピッチモジュレーション用上下動情報
aSQ2PitchDelta = $539   ;矩形波2ピッチの変位下位
aSQ2PithcDeltahi = $53A ;矩形波2ピッチの変位上位
aSQ2Prevent = $53B      ;矩形波2二度書き防止用退避変数らしい
aSQ2VolModCounter = $53C;矩形波2音量モジュレーション用カウンタ
aSQ2VolModVolume = $53D ;矩形波2音量モジュレーションでの現在の音量

aTRIPtr = $53E          ;三角波曲ポインタ下位
aTRIPtrhi = $53F        ;三角波曲ポインタ上位
aTRILen = $540          ;三角波音長下位
aTRILenhi = $541        ;三角波音長上位
aTRITempo = $542        ;三角波テンポ
aTRITriplet = $543      ;bit7 三角波連符フラグ
aTRILoopCount = $543    ;bit6-0 三角波繰り返し回数
aTRITie = $544          ;bit7-5 三角波タイの個数
aTRIMod = $544          ;bit4-0 三角波モジュレーション定義
aTRIFreqBase = $545     ;三角波周波数テーブルへのベースポインタ下位
aTRIFreqBasehi = $546   ;三角波周波数テーブルへのベースポインタ上位
aTRIPitch = $547        ;三角波ピッチエンベロープ変化値
aTRIReg = $548          ;三角波音高レジスタ値下位
aTRIReghi = $549        ;三角波音高レジスタ値上位
aTRIRegVol = $54A       ;三角波音量系レジスタへの値
aTRIVolWait = $54B      ;三角波音量エンベロープの速さ(07 XX Y0のXX)
aTRIVolCounter = $54C   ;三角波音量エンベロープ用カウンタ
aTRIVol = $54D          ;三角波音量エンベロープでの現在の音量
aTRISFXPitch = $54E     ;(効果音用)三角波ピッチエンベロープ変化値
aTRISFXReg = $54F       ;(効果音用)三角波音高レジスタ値下位
aTRISFXReghi = $550     ;(効果音用)三角波音高レジスタ値上位
aTRISFXRegVol = $551    ;(効果音用)三角波音量系レジスタへの値
aTRIModDefine1 = $552   ;三角波モジュレーション定義WW(WW XX YY ZZのWW)
aTRIModDefine2 = $553   ;三角波モジュレーション定義XX
aTRIModDefine3 = $554   ;三角波モジュレーション定義YY
aTRIModDefine4 = $555   ;三角波モジュレーション定義ZZ
aTRIPitchCounter = $556 ;三角波ピッチモジュレーション用カウンタ
aTRIPitchInfo = $557    ;三角波ピッチモジュレーション用上下動情報
aTRIPitchDelta = $558   ;三角波ピッチの変位下位
aTRIPithcDeltahi = $559 ;三角波ピッチの変位上位
aTRIPrevent = $55A      ;三角波二度書き防止用退避変数らしい
aTRIVolModCounter = $55B;三角波音量モジュレーション用カウンタ
aTRIVolModVolume = $55C ;三角波音量モジュレーションでの現在の音量

aNOIPtr = $55D          ;ノイズ曲ポインタ下位
aNOIPtrhi = $55E        ;ノイズ曲ポインタ上位
aNOILen = $55F          ;ノイズ音長下位
aNOILenhi = $560        ;ノイズ音長上位
aNOITempo = $561        ;ノイズテンポ
aNOITriplet = $562      ;bit7 ノイズ連符フラグ
aNOILoopCount = $562    ;bit6-0 ノイズ繰り返し回数
aNOITie = $563          ;bit7-5 ノイズタイの個数
aNOIMod = $563          ;bit4-0 ノイズモジュレーション定義
aNOIFreqBase = $564     ;ノイズ周波数テーブルへのベースポインタ下位
aNOIFreqBasehi = $565   ;ノイズ周波数テーブルへのベースポインタ上位
aNOIPitch = $566        ;ノイズピッチエンベロープ変化値
aNOIReg = $567          ;ノイズ音高レジスタ値下位
aNOIReghi = $568        ;ノイズ音高レジスタ値上位
aNOIRegVol = $569       ;ノイズ音量系レジスタへの値
aNOIVolWait = $56A      ;ノイズ音量エンベロープの速さ(07 XX Y0のXX)
aNOIVolCounter = $56B   ;ノイズ音量エンベロープ用カウンタ
aNOIVol = $56C          ;ノイズ音量エンベロープでの現在の音量
aNOISFXPitch = $56D     ;(効果音用)ノイズピッチエンベロープ変化値
aNOISFXReg = $56E       ;(効果音用)ノイズ音高レジスタ値下位
aNOISFXReghi = $56F     ;(効果音用)ノイズ音高レジスタ値上位
aNOISFXRegVol = $570    ;(効果音用)ノイズ音量系レジスタへの値
aNOIModDefine1 = $571   ;ノイズモジュレーション定義WW(WW XX YY ZZのWW)
aNOIModDefine2 = $572   ;ノイズモジュレーション定義XX
aNOIModDefine3 = $573   ;ノイズモジュレーション定義YY
aNOIModDefine4 = $574   ;ノイズモジュレーション定義ZZ
aNOIPitchCounter = $575 ;ノイズピッチモジュレーション用カウンタ
aNOIPitchInfo = $576    ;ノイズピッチモジュレーション用上下動情報
aNOIPitchDelta = $577   ;ノイズピッチの変位下位
aNOIPithcDeltahi = $578 ;ノイズピッチの変位上位
aNOIPrevent = $579      ;ノイズ二度書き防止用退避変数らしい
aNOIVolModCounter = $57A;ノイズ音量モジュレーション用カウンタ
aNOIVolModVolume = $57B ;ノイズ音量モジュレーションでの現在の音量

aModDefine = $57C       ;モジュレーション定義へのポインタ下位
aModDefinehi = $57D     ;モジュレーション定義へのポインタ上位

a57E = $57E
a57F = $57F

aSoundQueue = $580      ;処理する曲のリスト
aWeaponCollision = $590 ;武器の当たり判定
aWeaponPlatformW = $5A0 ;武器の足場判定広さ
aWeaponPlatformY = $5A3 ;武器の足場判定Y位置

aTimeStopper = $5A6     ;なんですかこれは

aBossTiwnWait = $5A7    ;ボスが弾け飛ぶまでのフレーム。らしい。
aBossVar1 = $5A7
aBossPtrhi = $5A7       ;ワイリーステージのボスがポインタとして使っていた気がする
aBossInvincible = $5A8  ;ボスの無敵時間

aBossPtrlo = $5A9
aBossVar2 = $5A9         ;なんだっけこれは

aBossDeath = $5AA       ;ボスティウンフラグ
aBossVar3 = $5AB


aObjVX = $600           ;オブジェクトの速度X上位
aObjVX10 = $610
aObjVXlo = $620         ;オブジェクトの速度X下位
aObjVXlo10 = $630

aObjBlockW = $600       ;オブジェクトの壁判定範囲X
aObjBlockW10 = $610
aObjBlockH = $620       ;オブジェクトの壁判定範囲Y
aObjBlockH10 = $630

aObjVY = $640           ;オブジェクトの速度Y上位
aObjVY10 = $650
aObjVYlo = $660         ;オブジェクトの速度Y下位
aObjVYlo10 = $670

aObjBlockX = $640       ;オブジェクトの壁判定位置X
aObjBlockX10 = $650
aObjBlockY = $660       ;オブジェクトの壁判定位置Y
aObjBlockY10 = $670

aObjWait = $680         ;オブジェクトのアニメーションのカウンタ
aObjWait10 = $690
aObjFrame = $6A0        ;オブジェクトのアニメーションのコマ数
aObjFrame10 = $6B0

aObjLife = $6C0         ;オブジェクトの体力
aObjLife10 = $6D0

aWeaponScreenX = $6E0   ;武器オブジェクトの画面内X
aObjCollision = $6E0    ;オブジェクトの当たり判定番号
aObjCollision10 = $6F0

aPaletteBackup = $700   ;サブメニューを開いた時のBGパレットバックアップ


;16x16タイル定義
;13 → 1, 2, 3, 4
;24
Stage_Def16x16 = $8000
;32x32タイル定義
Stage_Def32x32 = $8200
;32x32属性定義
Stage_Def32Pal = $8600
;地形判定定義
;13 → 11112222 33334444
;24
Stage_Def32Attr = $8700
;マップ定義(00～3F)
;Scroll stop -> +40
;Block flag -> +80
Stage_DefMap16 = $8900
;敵画面位置定義
;Stage_DefEnemiesRoom = $8A00
;敵X位置定義
Stage_DefEnemiesX = $8A00
;敵Y位置定義
Stage_DefEnemiesY = $8AC0
;敵種類定義
Stage_DefEnemies = $8B80
;画面ごとの敵配置ポインタ
Stage_DefEnemiesPtr = $8C40
;画面ごとの敵配置量
Stage_DefEnemiesAmount = $8C80
;アイテム画面位置定義
;Stage_DefItemsRoom = $8D80
;アイテムX位置定義
Stage_DefItemsX = $8CC0
;アイテムY位置定義
Stage_DefItemsY = $8CE0
;アイテム種類定義
Stage_DefItems = $8D00
;画面ごとのアイテム配置ポインタ
Stage_DefItemsPtr = $8D20
;画面ごとのアイテム配置量
Stage_DefItemsAmount = $8D60
;パレットアニメーション枚数
Stage_PaletteAnimNum = $8DA0
;パレットアニメーション待ち時間
Stage_PaletteAnimWait = $8DA0 + 1
;パレット定義
Stage_Palette = $8DA0 + 2
;パレットアニメーション定義
Stage_PaletteAnim = $8DC0 + 2

Stage_PaletteAnimNumWily = $8E40 + 2
Stage_PaletteAnimWaitWily = $8E40 + 3
Stage_PaletteWily = $8E40 + 4
Stage_PaletteAnimWily = $8E60 + 4

;敵画像読み込みセット読み込み開始位置
Stage_LoadGraphicsOrg = $8F20 + 4
;敵画像読み込みセット書き込み回数
Stage_LoadGraphicsNum = $8F20 + 4 + $0C
;敵画像読み込みセット書き込み位置
Stage_LoadGraphicsPtr = $8F20 + 4 + $18
;敵画像読み込みセット
Stage_LoadGraphics = $8F48

;ステージ開始位置定義
Stage_BeginPoint = $8FE0 - 2
;ワイリーステージ開始位置定義
Stage_BeginPointWily = $8FE0 - 1

;画像セット定義
Stage_DefGraphics = $8FE0
Stage_DefGraphicsWily = $8FF0

;8x8画面定義
Stage_DefRoom = $B000
;画像格納位置
Stage_Graphics = $A000


Table_AnimationPointer_Low = $F900
Table_AnimationPointerEnemy_Low = $F980
Table_AnimationPointer_High = $FA00
Table_AnimationPointerEnemy_High = $FA80
Table_AnimationData_Start = $FB00
Reset_Start = $FFE0
NMI_VECTOR = $FFFA
RESET_VECTOR = $FFFC
BREAK_VECTOR = $FFFE

;敵出現の境界線
SpawnEnemyBoundaryX = $04
SpawnEnemyBoundaryY = $08

;水中ラグの間隔
WaterLagInterval = $03
