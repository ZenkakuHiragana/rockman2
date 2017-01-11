Imports System.IO
Imports System.ComponentModel
Imports System.Threading
Imports System.Windows.Forms
Imports System.Collections.Generic

Public Class Form1

    '''<summary>画面内に定義された敵1体の情報を表します。</summary>
    Private Structure EnemiesStructure
        Dim org As Point
        Dim type As UInteger

        Public Sub New(ByVal p As Point, ByVal t As UInteger)
            org = p
            type = t
        End Sub

        Public Shared Operator =(ByVal a As EnemiesStructure, ByVal b As EnemiesStructure) As Boolean
            Return (a.org = b.org) And (a.type = b.type)
        End Operator
        Public Shared Operator <>(ByVal a As EnemiesStructure, ByVal b As EnemiesStructure) As Boolean
            Return Not ((a.org = b.org) And (a.type = b.type))
        End Operator
    End Structure

    Const SizeTile16x16 As UInteger = &H200
    Const SizeChip32x32 As UInteger = 4 * &H100
    Const SizeAttr32x32 As UInteger = &H100
    Const SizeFlag32x32 As UInteger = &H200
    Const SizeMaps16x16 As UInteger = &H100
    Const SizeEnemies As UInteger = &HC0
    Const SizeItems As UInteger = &H20
    Const SizePaletteAnim As UInteger = &H10 * 10
    Const SizeBG As UInteger = &H1000
    Const SizeRoom As UInteger = &H1000

    Const AddrTile16x16 As UInteger = &H0       '16x16グラ定義
    Const AddrChip32x32 As UInteger = &H200     '32x32グラ定義
    Const AddrAttr32x32 As UInteger = &H600     '属性テーブル, 配色
    Const AddrFlag32x32 As UInteger = &H700     '地形判定フラグ
    Const AddrMaps16x16 As UInteger = &H900     'マップの配置
    Const AddrEnemiesX As UInteger = &HA00      '敵配置X
    Const AddrEnemiesY As UInteger = &HAC0      '敵配置Y
    Const AddrEnemies As UInteger = &HB80       '敵の種類
    Const AddrEnemiesPtr As UInteger = &HC40    '画面ごとの敵配置ポインタ
    Const AddrEnemiesAmount As UInteger = &HC80 '画面ごとの敵配置量
    Const AddrItemsX As UInteger = &HCC0        'アイテム配置X
    Const AddrItemsY As UInteger = &HCE0        'アイテム配置Y
    Const AddrItems As UInteger = &HD00         'アイテムの種類
    Const AddrItemsPtr As UInteger = &HD20      '画面ごとのアイテム配置ポインタ
    Const AddrItemsAmount As UInteger = &HD60   '画面ごとのアイテム配置量
    Const PaletteAnimFrames As UInteger = &HDA0 'パレットアニメーション枚数
    Const PaletteAnimWait As UInteger = &HDA1   'パレットアニメーション待ち
    Const PaletteAddr As UInteger = &HDA2       'パレット
    Const PaletteAnimAddr As UInteger = &HDC2   'パレットアニメーション定義(8x)
    'Const AddrContinue As UInteger = &HE80      '中間地点定義
    'F00-FFF free

    Const AddrBG As UInteger = &H2000       'BG画像位置
    Const AddrRoom As UInteger = &H3000     '画面定義

    ''' <summary>マップ表示画面で表示する左上の画面位置を表します。</summary>
    Dim ViewOrigin As New Point(0, 0)
    ''' <summary>ステージ情報の全データを格納する配列です。</summary>
    Dim testfile(&H4000) As Byte
    ''' <summary>非圧縮の背景画像を格納する配列です。</summary>
    Dim bg(SizeBG) As Byte
    ''' <summary>16x16タイル定義のバッファを格納する配列です。</summary>
    Dim tile(SizeTile16x16) As Byte
    ''' <summary>32x32タイル定義のバッファを格納する配列です。</summary>
    Dim chip(SizeChip32x32) As Byte
    ''' <summary>32x32タイルの、属性テーブルへ書き込むデータを格納する配列です。</summary>
    Dim attr(SizeAttr32x32) As Byte
    ''' <summary>32x32タイルの、地形判定情報を格納する配列です。</summary>
    Dim flag(SizeFlag32x32) As Byte
    ''' <summary>8x8の画面定義を格納する配列です。</summary>
    Dim room(SizeRoom) As Byte '画面定義のバッファ
    ''' <summary>16x16の、マップ定義を格納する配列です。</summary>
    Dim map(SizeMaps16x16) As Byte

    Dim enemiesx(SizeEnemies) As Byte '敵の位置X
    Dim enemiesy(SizeEnemies) As Byte '敵の位置Y
    Dim enemies(SizeEnemies) As Byte '敵の種類
    Dim enemies_ptr(&H40) As Byte '敵の配置定義の開始位置
    Dim enemies_amount(&H40) As Byte '敵の数

    Dim itemsx(SizeItems) As Byte 'アイテムの位置X
    Dim itemsy(SizeItems) As Byte 'アイテムの位置Y
    Dim items(SizeItems) As Byte 'アイテムの種類
    Dim items_ptr(&H40) As Byte 'アイテムの配置定義の開始位置
    Dim items_amount(&H40) As Byte 'アイテムの数

    ''' <summary>パレットアニメーションの枚数です。</summary>
    Dim numpalanim As Byte
    ''' <summary>パレットアニメーションの待ちフレーム数です。</summary>
    Dim palwait As Byte
    ''' <summary>現在のパレット情報です。</summary>
    Dim palette(16) As Byte
    ''' <summary>パレットアニメーションバッファです。</summary>
    Dim palanim(SizePaletteAnim) As Byte
    ''' <summary>ファミコンのパレットとブラシを対応付けたテーブルです。</summary>
    Dim PaletteBrushes(&H40) As Brush
    ''' <summary>選択したタイル番号を格納します。</summary>
    Dim focus32, focus16, focus8 As UInteger
    ''' <summary>16x16タイル、8x8タイルを描画する時に使用するパレット番号です。</summary>
    Dim tile_attr As UInteger
    ''' <summary>選択した地形判定情報です。</summary>
    Dim flags_selected As UInteger
    ''' <summary>選択したオブジェクトが敵であるかどうかを示します。</summary>
    Dim obj_isenemy As Boolean = True
    ''' <summary>選択したオブジェクトが存在する画面数です。</summary>
    Dim objroom_selected As UInteger
    ''' <summary>選択したオブジェクトを表すインデックスです。</summary>
    Dim objindex_selected As UInteger
    ''' <summary>画面内に定義された敵の情報を格納するコレクションです。</summary>
    Dim EnemiesArray(&H40) As List(Of EnemiesStructure)
    ''' <summary>画面内に定義されたアイテムの情報を格納するコレクションです。</summary>
    Dim ItemsArray(&H40) As List(Of EnemiesStructure)
    ''' <summary>右クリックメニューを適用する画面数です。</summary>
    Dim ContextRoom As UInteger
    ''' <summary>右クリックメニューを適用する位置です。</summary>
    Dim ContextOrigin As Point
    ''' <summary>右クリックメニューを適用する画面位置です。</summary>
    Dim ContextViewOrigin As Point
    ''' <summary>ファイルのパスです。</summary>
    Dim BinFilePath As String
    ''' <summary>ファイルの最終書き込み日時です。</summary>
    Dim TimeStamp As Date

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        For i As UInteger = 0 To &H4000 - 1
            testfile(i) = 0
        Next
        For i As UInteger = 0 To SizeBG - 1
            bg(i) = 0
            room(i) = 0
        Next
        For i As UInteger = 0 To SizeTile16x16 - 1
            tile(i) = 0
        Next
        For i As UInteger = 0 To SizeChip32x32 - 1
            chip(i) = 0
        Next
        For i As UInteger = 0 To SizeAttr32x32 - 1
            attr(i) = 0
        Next
        For i As UInteger = 0 To SizeFlag32x32 - 1
            flag(i) = 0
        Next
        For i As UInteger = 0 To SizeRoom - 1
            room(i) = 0
        Next
        For i As UInteger = 0 To SizeMaps16x16 - 1
            map(i) = 0
        Next

        numpalanim = 0
        palwait = 0
        SyncLock palette
            For i As UInteger = 0 To 16 - 1
                palette(i) = 0
            Next
        End SyncLock

        For i As UInteger = 0 To SizePaletteAnim - 1
            palanim(i) = 0
        Next
        For i As UInteger = 0 To SizeEnemies
            enemiesx(i) = 0
            enemiesy(i) = 0
            enemies(i) = 0
        Next
        For i As UInteger = 0 To SizeItems
            itemsx(i) = 0
            itemsy(i) = 0
            items(i) = 0
        Next
        For i As UInteger = 0 To &H40 - 1
            PaletteBrushes(i) = GetPalette(i)
            enemies_ptr(i) = 0
            enemies_amount(i) = 0
            EnemiesArray(i) = New List(Of EnemiesStructure)
            items_ptr(i) = 0
            items_amount(i) = 0
            ItemsArray(i) = New List(Of EnemiesStructure)
        Next

        palwait = 0
        focus32 = 0
        focus16 = 0
        focus8 = 0
        tile_attr = 0
        flags_selected = 0
        ComboBox_attr.SelectedIndex = 0
        ClearObjectSelection()

        'ダブルバッファリングのための準備
        BufContext = BufferedGraphicsManager.Current
        scrBuf = BufContext.Allocate(scr.CreateGraphics(), scr.DisplayRectangle())
        p32Buf = BufContext.Allocate(p32.CreateGraphics(), p32.DisplayRectangle())
        p16Buf = BufContext.Allocate(ptile.CreateGraphics(), ptile.DisplayRectangle())
        p8Buf = BufContext.Allocate(pgraphs.CreateGraphics(), pgraphs.DisplayRectangle())
        p32selectedBuf = BufContext.Allocate(p32focus.CreateGraphics(), p32focus.DisplayRectangle())
        p16selectedBuf = BufContext.Allocate(p16focus.CreateGraphics(), p16focus.DisplayRectangle())
        p3216selectedBuf = BufContext.Allocate(p3216focus.CreateGraphics(), p3216focus.DisplayRectangle())
        p8selectedBuf = BufContext.Allocate(p8focus.CreateGraphics(), p8focus.DisplayRectangle())
        paletteBuf = BufContext.Allocate(ppalette.CreateGraphics(), ppalette.DisplayRectangle())
    End Sub

    Private Sub Form1_DragEnter(sender As Object, e As DragEventArgs) Handles MyBase.DragEnter
        If e.Data.GetDataPresent(DataFormats.FileDrop) Then
            e.Effect = DragDropEffects.Copy
        Else
            e.Effect = DragDropEffects.None
        End If
    End Sub

    Private Sub Form1_DragDrop(sender As Object, e As DragEventArgs) Handles MyBase.DragDrop
        OpenStageData(e.Data.GetData(DataFormats.FileDrop, False)(0))
    End Sub

    Private Sub OpenStageData(ByVal path As String)
        If Not TimerStats Is Nothing Then TimerStats.Dispose()

        Try
            Dim f As New FileStream(path, FileMode.Open, FileAccess.ReadWrite)
            TimeStamp = File.GetLastWriteTime(path)
            ReDim testfile(f.Length - 1)
            f.Read(testfile, 0, f.Length)
            f.Close()
        Catch ex As FileNotFoundException
            MessageBox.Show("File not found.", "", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1)
            Exit Sub
        End Try
        BinFilePath = path

        For i As UInteger = 0 To SizeBG - 1
            bg(i) = testfile(AddrBG + i)
            room(i) = testfile(AddrRoom + i)
        Next

        For i As UInteger = 0 To SizeTile16x16 - 1
            tile(i) = testfile(AddrTile16x16 + i)
        Next

        For i As UInteger = 0 To SizeChip32x32 - 1
            chip(i) = testfile(AddrChip32x32 + i)
        Next
        For i As UInteger = 0 To SizeAttr32x32 - 1
            attr(i) = testfile(AddrAttr32x32 + i)
        Next
        For i As UInteger = 0 To SizeFlag32x32 - 1
            flag(i) = testfile(AddrFlag32x32 + i)
        Next

        For i As UInteger = 0 To SizeRoom - 1
            room(i) = testfile(AddrRoom + i)
        Next

        For i As UInteger = 0 To SizeMaps16x16 - 1
            map(i) = testfile(AddrMaps16x16 + i)
        Next

        numpalanim = testfile(PaletteAnimFrames)
        palwait = testfile(PaletteAnimWait)
        SyncLock palette
            For i As UInteger = 0 To 16 - 1
                palette(i) = testfile(PaletteAddr + i)
            Next
        End SyncLock

        For i As UInteger = 0 To SizePaletteAnim - 1
            palanim(i) = testfile(PaletteAnimAddr + i)
        Next

        For i As UInteger = 0 To SizeEnemies
            enemiesx(i) = testfile(AddrEnemiesX + i)
            enemiesy(i) = testfile(AddrEnemiesY + i)
            enemies(i) = testfile(AddrEnemies + i)
        Next
        For i As UInteger = 0 To SizeItems
            itemsx(i) = testfile(AddrItemsX + i)
            itemsy(i) = testfile(AddrItemsY + i)
            items(i) = testfile(AddrItems + i)
        Next

        For i As UInteger = 0 To &H40 - 1
            PaletteBrushes(i) = GetPalette(i)

            enemies_ptr(i) = testfile(AddrEnemiesPtr + i)
            enemies_amount(i) = testfile(AddrEnemiesAmount + i)
            items_ptr(i) = testfile(AddrItemsPtr + i)
            items_amount(i) = testfile(AddrItemsAmount + i)

            EnemiesArray(i) = New List(Of EnemiesStructure)
            If enemies_amount(i) > 0 And enemies_ptr(i) > 0 Then
                For a As UInteger = 0 To enemies_amount(i) - 1
                    EnemiesArray(i).Add(New EnemiesStructure( _
                                        New Point(enemiesx(enemies_ptr(i) - 1 + a), _
                                                  enemiesy(enemies_ptr(i) - 1 + a)), _
                                        enemies(enemies_ptr(i) - 1 + a)))
                Next
            End If

            ItemsArray(i) = New List(Of EnemiesStructure)
            If items_amount(i) > 0 And items_ptr(i) > 0 Then
                For a As UInteger = 0 To items_amount(i) - 1
                    ItemsArray(i).Add(New EnemiesStructure( _
                                        New Point(itemsx(items_ptr(i) - 1 + a), _
                                                  itemsy(items_ptr(i) - 1 + a)), _
                                        items(items_ptr(i) - 1 + a)))
                Next
            End If
        Next

        focus32 = 0
        focus16 = 0
        focus8 = 0
        tile_attr = 0
        flags_selected = 0
        ComboBox_attr.SelectedIndex = 0
        ClearObjectSelection()
        RefreshAll()

        If palwait > 0 Then
            Dim wait As Integer = palwait * 16
            If wait < 350 Then wait = 350
            'Timerのインスタンスを作成
            Dim timerDelegate As New TimerCallback(AddressOf AnimationTimer)
            Dim timer As New Threading.Timer(timerDelegate, Nothing, 100, wait)
            'インスタンスをコピー
            TimerStats = timer
        End If
    End Sub

    Private Sub 保存SToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles 保存SToolStripMenuItem.Click
        Dim f As FileStream

        For i As UInteger = 0 To SizeTile16x16 - 1
            testfile(AddrTile16x16 + i) = tile(i)
        Next
        For i As UInteger = 0 To SizeChip32x32 - 1
            testfile(AddrChip32x32 + i) = chip(i)
        Next
        For i As UInteger = 0 To SizeAttr32x32 - 1
            testfile(AddrAttr32x32 + i) = attr(i)
        Next
        For i As UInteger = 0 To SizeFlag32x32 - 1
            testfile(AddrFlag32x32 + i) = flag(i)
        Next
        For i As UInteger = 0 To SizeMaps16x16 - 1
            testfile(AddrMaps16x16 + i) = map(i)
        Next
        For i As UInteger = 0 To SizeRoom - 1
            testfile(AddrRoom + i) = room(i)
        Next

        Dim ptr As UInteger = 0
        For i As UInteger = 0 To SizeEnemies - 1
            enemies(i) = 0
            enemiesx(i) = 0
            enemiesy(i) = 0
        Next
        For i As UInteger = 0 To &H40 - 1
            enemies_amount(i) = 0
            enemies_ptr(i) = 0
            For Each a As EnemiesStructure In EnemiesArray(i)
                ptr += 1
                If a = EnemiesArray(i).First() Then enemies_ptr(i) = ptr

                enemies(ptr - 1) = a.type
                enemiesx(ptr - 1) = a.org.X
                enemiesy(ptr - 1) = a.org.Y
            Next
            enemies_amount(i) = EnemiesArray(i).Count
        Next
        For i As UInteger = 0 To SizeEnemies - 1
            testfile(AddrEnemiesX + i) = enemiesx(i)
            testfile(AddrEnemiesY + i) = enemiesy(i)
            testfile(AddrEnemies + i) = enemies(i)
        Next
        For i As UInteger = 0 To &H40 - 1
            testfile(AddrEnemiesPtr + i) = enemies_ptr(i)
            testfile(AddrEnemiesAmount + i) = enemies_amount(i)
        Next

        ptr = 0
        For i As UInteger = 0 To SizeItems - 1
            items(i) = 0
            itemsx(i) = 0
            itemsy(i) = 0
        Next
        For i As UInteger = 0 To &H40 - 1
            items_amount(i) = 0
            items_ptr(i) = 0
            For Each a As EnemiesStructure In ItemsArray(i)
                ptr += 1
                If a = ItemsArray(i).First() Then items_ptr(i) = ptr

                items(ptr - 1) = a.type
                itemsx(ptr - 1) = a.org.X
                itemsy(ptr - 1) = a.org.Y
            Next
            items_amount(i) = ItemsArray(i).Count
        Next
        For i As UInteger = 0 To SizeItems - 1
            testfile(AddrItemsX + i) = itemsx(i)
            testfile(AddrItemsY + i) = itemsy(i)
            testfile(AddrItems + i) = items(i)
        Next
        For i As UInteger = 0 To &H40 - 1
            testfile(AddrItemsPtr + i) = items_ptr(i)
            testfile(AddrItemsAmount + i) = items_amount(i)
        Next

        If BinFilePath = "" Then
            Dim index As UInteger = 1
            While File.Exists(My.Application.Info.DirectoryPath & "\" & "NewStage" & index.ToString() & ".bin")
                index += 1
            End While
            BinFilePath = My.Application.Info.DirectoryPath & "\" & "NewStage" & index.ToString() & ".bin"
        End If
        f = New FileStream(BinFilePath, FileMode.Create, FileAccess.Write)
        f.Write(testfile, 0, &H4000)
        f.Close()
        TimeStamp = File.GetLastWriteTime(BinFilePath)
    End Sub

    ''' <summary>
    ''' 選択したオブジェクトの情報をセットします。
    ''' </summary>
    ''' <param name="room">オブジェクトが存在する画面数。</param>
    ''' <param name="index">オブジェクトの情報が格納されているArrayList内のインデックス番号。</param>
    ''' <param name="type">オブジェクトの種類。</param>
    ''' <param name="p">オブジェクトの位置。</param>
    ''' <remarks></remarks>
    Private Sub SetObjectSelection(ByVal room As UInteger, ByVal index As UInteger, ByVal type As UInteger, ByVal p As Point)
        ClearObjectSelection()
        objroom_selected = room
        objindex_selected = index + 1
        TextBoxObjType.Text = Hex(type)
        TextBoxObjType.Focus()
        TextBoxObjX.Text = Hex(p.X)
        TextBoxObjY.Text = Hex(p.Y)
    End Sub

    Private Sub ClearObjectSelection()
        objindex_selected = 0
        objroom_selected = 0
        TextBoxObjType.Text = ""
        TextBoxObjX.Text = ""
        TextBoxObjY.Text = ""
    End Sub

    'マップ編集画面の描画
    '敵配置もここで描く
    Private Sub scr_Paint(sender As Object, e As PaintEventArgs) Handles scr.Paint
        'DrawScr(sender)
        SyncLock scrBuf
            scrBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    Private Sub p32_Paint(sender As Object, e As PaintEventArgs) Handles p32.Paint
        'DrawP32(sender)
        SyncLock p32Buf
            p32Buf.Render(e.Graphics)
        End SyncLock
    End Sub

    Private Sub ptile_Paint(sender As Object, e As PaintEventArgs) Handles ptile.Paint
        'DrawP16(sender)
        SyncLock p16Buf
            p16Buf.Render(e.Graphics)
        End SyncLock
    End Sub

    '選択されたやつを表示する
    Private Sub pmapSelect_Paint(sender As Object, e As PaintEventArgs) Handles pmapSelect.Paint
        'DrawP32Focus(sender)
        Dim ss As String = "No.: "
        If focus32 < 16 Then
            ss += "0"
        End If
        ss += Hex(focus32)
        If ss <> Label_32Chip1.Text Then
            Label_32Chip1.Text = ss
        End If
        SyncLock p32selectedBuf
            p32selectedBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    Private Sub p32focus_Paint(sender As Object, e As PaintEventArgs) Handles p32focus.Paint
        'DrawP32Focus(sender)

        Dim ss As String = "No.: "
        If focus32 < 16 Then
            ss += "0"
        End If
        ss += Hex(focus32)
        If ss <> Label_32Chip2.Text Then
            Label_32Chip2.Text = ss
        End If
        SyncLock p32selectedBuf
            p32selectedBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    '32x32タイル選択枠、属性表示の方
    Private Sub p32focus_attr_Paint(sender As Object, e As PaintEventArgs) Handles p32focus_attr.Paint
        'DrawP32Focus(sender)
        SyncLock p32selectedBuf
            p32selectedBuf.Render(e.Graphics)
        End SyncLock

        Dim s As String
        Dim a As UInteger
        Dim g As Graphics = e.Graphics
        For i As UInteger = 0 To 1
            For k As UInteger = 0 To 1
                a = flag(focus32 * 2 + i)
                If k = 0 Then
                    a = a >> 4
                Else
                    a = a And &HF
                End If
                s = Hex(a)
                g.DrawString(s, New Font("MS UI Gothic", sender.Size.Width / 3), Brushes.Cyan, _
                             New RectangleF(sender.Size.Width / 2 * i, sender.Size.Width / 2 * k, _
                                            sender.Size.Width / 2, sender.Size.Width / 2))
            Next
        Next
    End Sub

    '16x16タイルの選択枠
    Private Sub p16focus_Paint(sender As Object, e As PaintEventArgs) Handles p16focus.Paint
        'DrawP16Focus(sender)

        Dim ss As String = "No.: "
        If focus16 < 16 Then
            ss += "0"
        End If
        ss += Hex(focus16)
        If ss <> Label_16Chip1.Text Then
            Label_16Chip1.Text = ss
        End If
        SyncLock p16selectedBuf
            p16selectedBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    Private Sub p3216focus_Paint(sender As Object, e As PaintEventArgs) Handles p3216focus.Paint
        'DrawP16Focus(sender)

        Dim ss As String = "No.: "
        If focus16 < 16 Then
            ss += "0"
        End If
        ss += Hex(focus16)
        If ss <> Label_16Chip2.Text Then
            Label_16Chip2.Text = ss
        End If
        SyncLock p3216selectedBuf
            p3216selectedBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    '8x8タイルの選択枠
    Private Sub p8focus_Paint(sender As Object, e As PaintEventArgs) Handles p8focus.Paint
        'DrawP8Focus(sender)

        Dim ss As String = "No.: "
        If focus8 < 16 Then
            ss += "0"
        End If
        ss += Hex(focus8)
        If ss <> Label_8Graph.Text Then
            Label_8Graph.Text = ss
        End If
        SyncLock p8selectedBuf
            p8selectedBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    '8x8タイルのパレット
    Private Sub pgraphs_Paint(sender As Object, e As PaintEventArgs) Handles pgraphs.Paint
        'DrawP8(sender)
        SyncLock p8Buf
            p8Buf.Render(e.Graphics)
        End SyncLock
    End Sub

    'パレットバーの表示
    Private Sub ppalette_Paint(sender As Object, e As PaintEventArgs) Handles ppalette.Paint, ppalette32.Paint
        'DrawPaletteBar(sender)
        SyncLock paletteBuf
            paletteBuf.Render(e.Graphics)
        End SyncLock
    End Sub

    '選択するやつ
    Private Sub scr_MouseClick(sender As Object, e As MouseEventArgs) Handles scr.MouseClick
        Dim numroom, selected As UInteger
        Dim quad As Point '4分割した時、どこをクリックしたか
        Dim p As Point 'どのマスをクリックしたか
        quad.X = Math.Floor(e.X / (sender.Size.Width / 2))
        quad.Y = Math.Floor(e.Y / (sender.Size.Width / 2))
        p.X = Math.Floor(e.X / (sender.Size.Width / 16)) 'p = 0～15
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))
        If quad.X > 0 Then
            p.X -= 8
        End If
        If quad.Y > 0 Then
            p.Y -= 8
        End If

        'p = 0～7
        selected = p.X * 8 + p.Y 'selected = 0～31
        numroom = map((ViewOrigin.Y + quad.Y) * 16 + ViewOrigin.X + quad.X)

        '位置情報を取得したら、選択や書き込みなどの処理へ
        If numroom < &H40 Then
            If Radio_EditTerrain.Checked Then
                '地形編集モード| 右クリック: 選択, 左クリック: 書き込み
                If e.Button = Windows.Forms.MouseButtons.Right Then
                    focus32 = room(numroom * &H40 + selected)
                    DrawP32Focus(p32focus)
                    RefreshP32Focus()
                ElseIf e.Button = MouseButtons.Left Then
                    room(numroom * &H40 + selected) = focus32
                    DrawScr(scr)
                    scr.Refresh()
                End If
            Else
                If e.Button = MouseButtons.Left Then
                    '敵編集モード| 左クリック: オブジェクト選択

                    Dim org As Point
                    If obj_isenemy Then
                        For Each en As EnemiesStructure In EnemiesArray(numroom)
                            org = en.org
                            org += New Point(quad.X * 256, quad.Y * 256)
                            org -= New Point(16, 16)
                            If e.X > org.X And e.Y > org.Y And e.X < org.X + 32 And e.Y < org.Y + 32 Then
                                SetObjectSelection(numroom, EnemiesArray(numroom).IndexOf(en), en.type, en.org)
                                DrawScr(scr)
                                scr.Refresh()
                                Exit For
                            End If
                        Next
                    Else
                        For Each it As EnemiesStructure In ItemsArray(numroom)
                            org = it.org
                            org += New Point(quad.X * 256, quad.Y * 256)
                            org -= New Point(16, 16)
                            If e.X > org.X And e.Y > org.Y And e.X < org.X + 32 And e.Y < org.Y + 32 Then
                                SetObjectSelection(numroom, ItemsArray(numroom).IndexOf(it), it.type, it.org)
                                DrawScr(scr)
                                scr.Refresh()
                                Exit For
                            End If
                        Next
                    End If
                End If
            End If
        End If
    End Sub

    'マップに32x32タイルを書き込み
    Private Sub scr_MouseMove(sender As Object, e As MouseEventArgs) Handles scr.MouseMove
        If Radio_EditTerrain.Checked And (e.Button = MouseButtons.Left Or e.Button = MouseButtons.Right) Then
            Dim numroom, selected As UInteger
            Dim quad As Point '4分割した時、どこをクリックしたか
            Dim p As Point 'どのマスをクリックしたか
            quad.X = Math.Floor(e.X / (sender.Size.Width / 2))
            quad.Y = Math.Floor(e.Y / (sender.Size.Width / 2))
            p.X = Math.Floor(e.X / (sender.Size.Width / 16)) 'p = 0～15
            p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))
            If quad.X > 0 Then
                p.X -= 8
            End If
            If quad.Y > 0 Then
                p.Y -= 8
            End If

            'p = 0～7
            selected = p.X * 8 + p.Y 'selected = 0～31
            numroom = map((ViewOrigin.Y + quad.Y) * 16 + ViewOrigin.X + quad.X)

            If numroom < &H40 Then
                If e.Button = MouseButtons.Left Then
                    room(numroom * &H40 + selected) = focus32
                    DrawScr(scr)
                    scr.Refresh()
                End If
            End If
        End If
    End Sub


    '32x32パレットのクリック
    Private Sub p32_MouseClick(sender As Object, e As MouseEventArgs) Handles p32.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / (sender.Size.Width / 16)) 'p = 0～15
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))
        If e.Button = MouseButtons.Left Then

            focus32 = p.Y * 16 + p.X
            DrawP32Focus(p32)
            RefreshP32Focus()
        Else
            Dim bitmask() As UInteger = {3, &H30, &HC, &HC0}
            Dim shift() As UInteger = {0, 4, 2, 6}
            Dim selectedattr As UInteger
            Dim selected32 As UInteger = p.Y * 16 + p.X
            p.X = Math.Floor(e.X / (sender.Size.Width / 32)) 'p = 0～31
            p.Y = Math.Floor(e.Y / (sender.Size.Width / 32))
            p.X = p.X Mod 2
            p.Y = p.Y Mod 2

            focus16 = chip(selected32 * 4 + p.X * 2 + p.Y)
            selectedattr = (attr(selected32) And bitmask(p.X * 2 + p.Y)) >> shift(p.X * 2 + p.Y)

            ReDraw16Focus()
        End If
    End Sub

    '32x32選択枠のクリック
    Private Sub p32focus_MouseClick(sender As Object, e As MouseEventArgs) Handles p32focus.MouseClick
        Dim bitmask() As UInteger = {3, &H30, &HC, &HC0}
        Dim shift() As UInteger = {0, 4, 2, 6}
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / (sender.Size.Width / 2)) 'p = 0～1
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 2))

        If e.Button = MouseButtons.Right Then '読み
            focus16 = chip(focus32 * 4 + p.X * 2 + p.Y) And &H7F
            tile_attr = (attr(focus32) And bitmask(p.X * 2 + p.Y)) >> shift(p.X * 2 + p.Y)

            ReDraw16Focus()
        ElseIf e.Button = MouseButtons.Left Then '書き
            Dim attr_write As UInteger = tile_attr << shift(p.X * 2 + p.Y)
            Dim attr_tmp As UInteger = attr(focus32)
            attr_tmp = attr_tmp And (Not bitmask(p.X * 2 + p.Y))
            attr(focus32) = attr_tmp Or attr_write
            chip(focus32 * 4 + p.X * 2 + p.Y) = focus16

            DrawP32Focus(p32focus)
            RefreshP32Focus()
            DrawP32(p32)
            p32.Refresh()
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    '16x16タイル定義パレットのクリック
    Private Sub ptile_MouseClick(sender As Object, e As MouseEventArgs) Handles ptile.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / (sender.Size.Width / 16)) 'p = 0～15
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))

        If e.Button = MouseButtons.Left Then
            focus16 = p.Y * 16 + p.X
            RefreshAll()

            DrawP16Focus(p16focus)
            p16focus.Refresh()
            DrawP16Focus(p3216focus)
            p3216focus.Refresh()
        Else
            Dim selected16 As UInteger = p.Y * 16 + p.X
            p.X = Math.Floor(e.X / (sender.Size.Width / 32)) 'p = 0～31
            p.Y = Math.Floor(e.Y / (sender.Size.Width / 32))
            p.X = p.X Mod 2
            p.Y = p.Y Mod 2

            focus8 = tile(selected16 * 4 + p.X * 2 + p.Y)
            DrawP8Focus(p8focus)
            p8focus.Refresh()
        End If
    End Sub

    '16x16選択枠のクリック
    Private Sub p16focus_MouseClick(sender As Object, e As MouseEventArgs) Handles p16focus.MouseClick
        Dim p As Point
        p.X = Math.Floor(e.X / (sender.Size.Width / 2))
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 2))

        If e.Button = MouseButtons.Right Then '読み
            focus8 = tile(focus16 * 4 + p.X * 2 + p.Y)
            DrawP8Focus(p8focus)
            p8focus.Refresh()
        ElseIf e.Button = MouseButtons.Left Then '書き
            tile(focus16 * 4 + p.X * 2 + p.Y) = focus8
            DrawP16(ptile)
            ptile.Refresh()
            DrawP16Focus(p16focus)
            p16focus.Refresh()
            DrawP16Focus(p3216focus)
            p3216focus.Refresh()
            DrawP32(p32)
            DrawP32Focus(p32focus)
            p32.Refresh()
            RefreshP32Focus()
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    '8x8タイルパレットのクリック
    Private Sub pgraphs_MouseClick(sender As Object, e As MouseEventArgs) Handles pgraphs.MouseClick
        Dim p As Point
        p.X = Math.Floor(e.X / (sender.Size.Width / 16))
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))

        focus8 = p.X + p.Y * 16
        DrawP8Focus(p8focus)
        p8focus.Refresh()
    End Sub

    'パレットバーのクリック
    Private Sub ppalette_MouseClick(sender As Object, e As MouseEventArgs) Handles ppalette.MouseClick, ppalette32.MouseClick
        tile_attr = Math.Floor(e.X / (sender.Size.Width / 4))
        DrawP8(pgraphs)
        DrawP8Focus(p8focus)
        DrawP16(ptile)
        DrawP16Focus(p16focus)
        pgraphs.Refresh()
        ptile.Refresh()
        p8focus.Refresh()
        p16focus.Refresh()
        DrawP16Focus(p3216focus)
        p3216focus.Refresh()
    End Sub

    '地形判定の設定選択時
    Private Sub ComboBox_attr_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ComboBox_attr.SelectedIndexChanged
        flags_selected = ComboBox_attr.SelectedIndex
    End Sub

    '32x32地形判定選択枠のクリック
    Private Sub p32focus_attr_MouseClick(sender As Object, e As MouseEventArgs) Handles p32focus_attr.MouseClick
        Dim p As Point
        p.X = Math.Floor(e.X / (sender.Size.Width / 2))
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 2))

        Dim a As UInteger = flag(focus32 * 2 + p.X)
        Dim write As UInteger = flags_selected
        If e.Button = MouseButtons.Right Then '読み
            If p.Y = 0 Then
                a = a >> 4
            Else
                a = a And &HF
            End If
            flags_selected = a
            ComboBox_attr.SelectedIndex = flags_selected
        ElseIf e.Button = MouseButtons.Left Then '書き
            If p.Y = 0 Then
                a = a And &HF
                write = write << 4
            Else
                a = a And &HF0
            End If
            flag(focus32 * 2 + p.X) = a Or write
            p32focus_attr.Refresh()
        End If
    End Sub

    '敵番号の変更
    Private Sub TextBoxObjType_Validating(sender As Object, e As CancelEventArgs) Handles TextBoxObjType.Validating
        Try
            If objindex_selected = 0 Then Exit Sub

            Dim t As UInteger = Convert.ToUInt32(TextBoxObjType.Text, 16)
            If t >= &H100 Then
                e.Cancel = True
                Exit Sub
            End If

            Dim obj As EnemiesStructure
            If obj_isenemy Then
                obj = EnemiesArray(objroom_selected).Item(objindex_selected - 1)
            Else
                obj = ItemsArray(objroom_selected).Item(objindex_selected - 1)
            End If

            obj.type = t

            If obj_isenemy Then
                EnemiesArray(objroom_selected).Item(objindex_selected - 1) = obj
            Else
                ItemsArray(objroom_selected).Item(objindex_selected - 1) = obj
            End If
            DrawScr(scr)
            scr.Refresh()
        Catch ex As Exception
            e.Cancel = True
        End Try
    End Sub

    Private Sub TextBoxObjX_Validating(sender As Object, e As CancelEventArgs) Handles TextBoxObjX.Validating
        Try
            If objindex_selected = 0 Then Exit Sub

            Dim t As UInteger = Convert.ToUInt32(TextBoxObjX.Text, 16)
            If t >= &H100 Then
                e.Cancel = True
                Exit Sub
            End If

            Dim obj As EnemiesStructure
            If obj_isenemy Then
                obj = EnemiesArray(objroom_selected).Item(objindex_selected - 1)
            Else
                obj = ItemsArray(objroom_selected).Item(objindex_selected - 1)
            End If
            obj.org.X = t

            If obj_isenemy Then
                EnemiesArray(objroom_selected).Item(objindex_selected - 1) = obj
            Else
                ItemsArray(objroom_selected).Item(objindex_selected - 1) = obj
            End If
            DrawScr(scr)
            scr.Refresh()
        Catch ex As Exception
            e.Cancel = True
        End Try
    End Sub

    Private Sub TextBoxObjY_Validating(sender As Object, e As CancelEventArgs) Handles TextBoxObjY.Validating
        Try
            If objindex_selected = 0 Then Exit Sub

            Dim t As UInteger = Convert.ToUInt32(TextBoxObjY.Text, 16)
            If t >= &H100 Then
                e.Cancel = True
                Exit Sub
            End If

            Dim obj As EnemiesStructure
            If obj_isenemy Then
                obj = EnemiesArray(objroom_selected).Item(objindex_selected - 1)
            Else
                obj = ItemsArray(objroom_selected).Item(objindex_selected - 1)
            End If
            obj.org.Y = t

            If obj_isenemy Then
                EnemiesArray(objroom_selected).Item(objindex_selected - 1) = obj
            Else
                ItemsArray(objroom_selected).Item(objindex_selected - 1) = obj
            End If
            DrawScr(scr)
            scr.Refresh()
        Catch ex As Exception
            e.Cancel = True
        End Try
    End Sub

    '矢印キーでマップ移動
    Private Sub TabControl1_KeyUp(sender As Object, e As KeyEventArgs) Handles TabControl1.KeyUp
        Select Case e.KeyValue
            Case Keys.W
                ButtonMapUp_Click(Nothing, Nothing)
            Case Keys.S
                ButtonMapDown_Click(Nothing, Nothing)
            Case Keys.A
                ButtonMapLeft_Click(Nothing, Nothing)
            Case Keys.D
                ButtonMapRight_Click(Nothing, Nothing)
        End Select
        'Debug.WriteLine(ViewOrigin)
    End Sub

    Private Sub ButtonMapUp_Click(sender As Object, e As EventArgs) Handles ButtonMapUp.Click
        If ViewOrigin.Y > 0 Then
            ViewOrigin.Y -= 1
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    Private Sub ButtonMapDown_Click(sender As Object, e As EventArgs) Handles ButtonMapDown.Click
        If ViewOrigin.Y < 15 Then
            ViewOrigin.Y += 1
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    Private Sub ButtonMapLeft_Click(sender As Object, e As EventArgs) Handles ButtonMapLeft.Click
        If ViewOrigin.X > 0 Then
            ViewOrigin.X -= 1
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    Private Sub ButtonMapRight_Click(sender As Object, e As EventArgs) Handles ButtonMapRight.Click
        If ViewOrigin.X < 15 Then
            ViewOrigin.X += 1
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    Private Sub scr_MouseDown(sender As Object, e As MouseEventArgs) Handles scr.MouseDown
        If e.Button = MouseButtons.Right Then
            ContextViewOrigin = New Point(Math.Floor(e.X / 256), Math.Floor(e.Y / 256))
            ContextOrigin = New Point(e.X Mod 256, e.Y Mod 256)
            ContextRoom = map((ViewOrigin.Y + Math.Floor(e.Y / 256)) * 16 + ViewOrigin.X + Math.Floor(e.X / 256))
        End If
    End Sub
    Private Sub CreateObjectToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles オブジェクトの新規作成ToolStripMenuItem.Click
        If ContextRoom >= 0 And ContextRoom < &H40 Then
            Dim type As UInteger = 0

            If TextBoxObjType.Text <> "" Then
                Try
                    type = Convert.ToUInt32(TextBoxObjType.Text, 16)
                Catch ex As Exception
                    type = 0
                End Try
            End If

            Dim o As New EnemiesStructure(ContextOrigin, type)
            If obj_isenemy Then
                EnemiesArray(ContextRoom).Add(o)
                objindex_selected = EnemiesArray(ContextRoom).Count
            Else
                ItemsArray(ContextRoom).Add(o)
                objindex_selected = ItemsArray(ContextRoom).Count
            End If
            SetObjectSelection(ContextRoom, objindex_selected - 1, type, ContextOrigin)
            DrawScr(scr)
            scr.Refresh()
        End If
    End Sub

    Private Sub DeleteObjectToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles 選択したオブジェクトの削除ToolStripMenuItem.Click
        If objindex_selected = 0 Then Exit Sub

        If obj_isenemy Then
            EnemiesArray(objroom_selected).RemoveAt(objindex_selected - 1)
        Else
            ItemsArray(objroom_selected).RemoveAt(objindex_selected - 1)
        End If
        ClearObjectSelection()
        DrawScr(scr)
        scr.Refresh()
    End Sub

    Private Sub 画面番号の変更ToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles 画面番号の変更ToolStripMenuItem.Click
        Label_ScreenNum.Visible = True
        TextBoxScreenNum.Visible = True
        TextBoxScreenNum.Text = Hex(ContextRoom)
        TextBoxScreenNum.Focus()
        TextBoxScreenNum.SelectAll()
    End Sub

    Private Sub TextBoxScreenNum_Validating(sender As Object, e As CancelEventArgs) Handles TextBoxScreenNum.Validating
        Try
            Dim t As UInteger = Convert.ToUInt32(TextBoxScreenNum.Text, 16)
            map((ViewOrigin.Y + ContextViewOrigin.Y) * 16 + ViewOrigin.X + ContextViewOrigin.X) = t
            RefreshAll()
        Catch ex As Exception
            e.Cancel = True
        End Try

        TextBoxScreenNum.Visible = False
        Label_ScreenNum.Visible = False
        DrawScr(scr)
        scr.Refresh()
    End Sub

    '32x32タイル情報の表示
    Private Sub Button32Info_Click(sender As Object, e As EventArgs) Handles Button32Info.Click
        If Not bg_chipinfo.IsBusy Then
            Dim unusedchip As New ArrayList '未使用チップ
            Dim dupe(&H100) As ArrayList '重複チップ
            Dim f As Boolean
            Dim ss As String

            For i As UInteger = 0 To &H100 - 1
                f = True
                For k As UInteger = 0 To &H40 * &H40 - 1
                    If i = room(k) Then
                        f = False
                        Exit For
                    End If
                Next
                If f Then unusedchip.Add(i)
            Next

            Dim prev As Integer = -1
            ss = "未使用の32x32定義:" & vbCrLf
            For Each n As UInteger In unusedchip
                If prev > 0 And (prev And &HF0) <> (n And &HF0) Then
                    ss &= vbCrLf
                End If
                prev = n
                If n < &H10 Then
                    ss &= "0"
                End If
                ss &= Hex(n)
                ss &= ", "
            Next

            bg_chipinfo.RunWorkerAsync(ss)
        End If
    End Sub

    Private Sub ButtonTileInfo_Click(sender As Object, e As EventArgs) Handles ButtonTileInfo.Click
        If Not bg_tileinfo.IsBusy Then
            Dim unusedchip As New ArrayList '未使用チップ
            Dim dupe(&H100) As ArrayList '重複チップ
            Dim f As Boolean
            Dim ss As String

            For i As UInteger = 0 To &H80 - 1
                f = True
                For k As UInteger = 0 To &H4 * &H100 - 1
                    If i = (chip(k) And &H7F) Then
                        f = False
                        Exit For
                    End If
                Next
                If f Then unusedchip.Add(i)
            Next

            Dim prev As Integer = -1
            ss = "未使用の16x16定義:" & vbCrLf
            For Each n As UInteger In unusedchip
                If prev > 0 And (prev And &HF0) <> (n And &HF0) Then
                    ss &= vbCrLf
                End If
                prev = n
                If n < &H10 Then
                    ss &= "0"
                End If
                ss &= Hex(n)
                ss &= ", "
            Next

            ss &= vbCrLf & vbCrLf
            ss &= "未使用の8x8画像:" & vbCrLf

            unusedchip.Clear()
            For i As UInteger = 0 To &H100 - 1
                f = True
                For k As UInteger = 0 To &H4 * &H80 - 1
                    If i = tile(k) Then
                        f = False
                        Exit For
                    End If
                Next
                If f Then unusedchip.Add(i)
            Next

            prev = -1
            For Each n As UInteger In unusedchip
                If prev > 0 And (prev And &HF0) <> (n And &HF0) Then
                    ss &= vbCrLf
                End If
                prev = n
                If n < &H10 Then
                    ss &= "0"
                End If
                ss &= Hex(n)
                ss &= ", "
            Next
            bg_chipinfo.RunWorkerAsync(ss)
        End If
    End Sub

    Private Sub bg_chipinfo_DoWork(sender As Object, e As DoWorkEventArgs) Handles bg_chipinfo.DoWork, bg_tileinfo.DoWork
        MessageBox.Show(e.Argument.ToString())
    End Sub

    '全部表示
    Dim ClientSizePartial As New Size(562, 800)
    Dim tchip_bak As TabPage
    Dim ttile_bak As TabPage
    Dim IsShowingAll As Boolean = False
    Private Sub Menu_ShowAll_Click(sender As Object, e As EventArgs) Handles Menu_ShowAll.Click
        If Not IsShowingAll Then
            IsShowingAll = True
            Me.Size = New Size(ClientSizePartial.Width * 3, ClientSizePartial.Height)

            For Each o As Control In GetAllControls(Me)
                If o.Parent Is tchip Then
                    o.Location = New Point(o.Location.X + ClientSizePartial.Width, o.Location.Y)
                    tmap.Controls.Add(o)
                ElseIf o.Parent Is ttile Then
                    o.Location = New Point(o.Location.X + ClientSizePartial.Width * 2, o.Location.Y)
                    tmap.Controls.Add(o)
                End If
            Next
            tchip_bak = tchip
            ttile_bak = ttile
            TabControl1.TabPages.RemoveByKey("tchip")
            TabControl1.TabPages.RemoveByKey("ttile")

            ppalette32.Visible = False
            'DrawAll()
            'RefreshAll()
        End If
    End Sub

    '部分表示
    Private Sub Menu_ShowPartial_Click(sender As Object, e As EventArgs) Handles Menu_ShowPartial.Click
        If IsShowingAll Then
            IsShowingAll = False
            Me.Size = ClientSizePartial
            TabControl1.TabPages.Insert(1, ttile_bak)
            TabControl1.TabPages.Insert(1, tchip_bak)

            For Each o As Control In GetAllControls(Me)
                If o.Location.X > ClientSizePartial.Width * 2 Then
                    o.Location = New Point(o.Location.X - ClientSizePartial.Width * 2, o.Location.Y)
                    ttile.Controls.Add(o)
                ElseIf o.Location.X > ClientSizePartial.Width Then
                    o.Location = New Point(o.Location.X - ClientSizePartial.Width, o.Location.Y)
                    tchip.Controls.Add(o)
                End If
            Next

            ppalette32.Visible = True
            DrawScr(scr)
            scr.Refresh()
            DrawP32Focus(pmapSelect)
            pmapSelect.Refresh()
        End If
    End Sub

    '地形/オブジェクト切り替えのラジオボタン
    Private Sub Radio_EditTerrain_CheckedChanged(sender As Object, e As EventArgs) Handles Radio_EditTerrain.CheckedChanged, Radio_EditEnemies.CheckedChanged
        If Radio_EditTerrain.Checked Then
            scr.ContextMenuStrip = Nothing
        Else
            scr.ContextMenuStrip = ContextMenuStripObj
        End If
        ClearObjectSelection()
        DrawScr(scr)
        scr.Refresh()
    End Sub

    '敵/アイテム切り替えのラジオボタン
    Private Sub Radio_IsEnemy_CheckedChanged(sender As Object, e As EventArgs) Handles Radio_IsEnemy.CheckedChanged, Radio_IsItem.CheckedChanged
        obj_isenemy = Radio_IsEnemy.Checked
        ClearObjectSelection()
        DrawScr(scr)
        scr.Refresh()
    End Sub

    Private Sub Form1_Activated(sender As Object, e As EventArgs) Handles MyBase.Activated
        If BinFilePath <> "" Then
            Dim t As Date = File.GetLastWriteTime(BinFilePath)
            Dim c As Integer = Date.Compare(TimeStamp, t)
            If c < 0 Then
                TimeStamp = File.GetLastWriteTime(BinFilePath)
                If MessageBox.Show("ファイルが外部で変更されています。リロードしますか？", _
                                "Rockman 2 Extended Stage Structure Editor", _
                                MessageBoxButtons.YesNo, _
                                MessageBoxIcon.Exclamation, _
                                MessageBoxDefaultButton.Button1) = DialogResult.Yes Then
                    OpenStageData(BinFilePath)
                End If
            End If
            'DrawAll()
            'RefreshAll()
        End If
    End Sub
End Class
