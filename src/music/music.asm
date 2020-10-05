
;曲の定義
	mBEGIN #$0C, Table_TrackStartPointers
	.list
	.incbin "rockman2.prg", $30A50, $86
	.nolist
	mBEGIN #$0C, Table_TrackStartPointers
	.dw PUSH_IT_TO_THE_LIMIT
	.dw GATE_OF_STEINER
	.dw EXE6BOSS ; FLASH MAN
	.dw WEBSPIDER ; WOOD MAN
	.dw DRY_GUYS ; CRASH MAN
	.dw DEATHTRAP_MIRAGE ; HEAT MAN
	.dw PHARMACEUTICAL_LAB ; AIR MAN
	.dw BATTY ; METAL MAN
	.dw FLORENT_LBELLE ; QUICK MAN
	.dw ACID ; BUBBLE MAN
	.dw ETUDEFORGHOSTS ; WILY 1
	.dw PORKYS_PORKIES ; WILY 2
	.dw HEARTACHE ; BOSS
	.dw PHARMACEUTICAL_LAB
	; .dw SBOMB1_5
	; .dw SBOMB1_6

	mBEGIN #$0C, Table_TrackStartPointers + $86
Sound_Modulations:
	.include "src/music/modulations.asm"
Sound_MusicData:
	.include "src/music/scarface/header.asm"
	.include "src/music/gateofsteiner/header.asm"
	.include "src/music/exe6boss/header.asm"
	.include "src/music/batty/header.asm"
	.include "src/music/porkysporkies/header.asm"
	.include "src/music/webspider/header.asm"
	.include "src/music/acid/header.asm"
    .include "src/music/deathtrapmirage/header.asm"
    .include "src/music/dryguys/header.asm"
	.include "src/music/etudeforghosts/header.asm"
    .include "src/music/florent/header.asm"
	; .include "src/music/frozenhotel.asm"
    .include "src/music/garden/header.asm"
	.include "src/music/heartache.asm"
	; .include "src/music/sbomb1_area1.asm"
	; .include "src/music/sbomb1_area5.asm"
	.include "src/music/sbomb1_area6.asm"

	mBEGINRAW $1F, Reset_Start
	sei
	inc $FFE1
	lda #%00000111
	sta $4001
	sta $4005
	jmp Reset_JMP

	;$500,      曲ポインタ下位
	;$501,      曲ポインタ上位
	;$502,      音長カウンタ下位
	;$503,      音長カウンタ上位
	;$504,      音下げるやつの目標値下位
	;$505,      bit7-3: 音下げるやつの変化速度, bit2-0: 音下げるやつの目標値上位
	;$506,      bit7-5: タイの個数, bit4-0: MOD番号
	;$507,      周波数テーブルベースポインタ下位
	;$508,      bit7-5: 命令0Bによる繰り返し回数, bit4-0: 命令04による繰り返し回数
	;$509,      ピッチenv変化量
	;$50A,      音高レジスタ値下位
	;$50B,      音高レジスタ値上位
	;$50C,      音量レジスタ値
	;$50D,      命令07のXX, (TRI)ぽんぽこ用音高レジスタ値上位, bit7: ぽんぽこフラグ
	;$50E,      音量env用カウンタ, (TRI)ぽんぽこ用カウンタ
	;$50F,      命令$07のY0 + 音量env用現在の音量, (TRI)ぽんぽこ用音高レジスタ値下位
	;$510,      効果音用ピッチenv変化量
	;$511,      効果音用音量レジスタ値
	;$512,      効果音用音高レジスタ値下位
	;$513,      効果音用音高レジスタ値上位
	;$514,      MOD WW, bit7: ピッチMODが変位0に向かうフラグ, bit6-0: ピッチMOD変化周期
	;$515,      MOD XX, bit7-5: ピッチMOD変化量, bit4-0: ピッチMOD変化の最大回数
	;$516,      MOD YY, bit7: 音量MOD変化方向(0: 上がる, 1:下がる), bit6-0: 音量MOD変化周期
	;$517,      MOD ZZ, bit7: ピッチMOD変化量変化量の符号, bit6-4: 未使用, bit3-0: 音量MOD変化量
	;$518,      ピッチMOD用時刻カウンタ
	;$519,      ピッチMOD上下動情報, bit7: 増減方向, bit6-0: 変位の回数カウンタ(bit6-5は未使用にできる)
	;$51A,      ピッチMOD変位量下位
	;$51B,      二度書き防止フラグ
	;$51C,      音量MOD用カウンタ
	;$51D,      音量MOD用現在の音量
	;$51E,		サブルーチンのスタック下位
	;$51F,		サブルーチンのスタック上位
