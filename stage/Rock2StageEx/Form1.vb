Imports System.IO
Imports System.Windows.Forms

Public Class Form1

    Const SizeTile16x16 As UInteger = &H200
    Const SizeChip32x32 As UInteger = 4 * &H100
    Const SizeAttr32x32 As UInteger = &H100
    Const SizeFlag32x32 As UInteger = &H200
    Const SizeMaps16x16 As UInteger = &H100
    Const SizeEnemies As UInteger = &HC0
    Const SizeItems As UInteger = &H20
    Const SizePaletteAnim As UInteger = &H10 * 8
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

    Dim ViewOrigin As New Point(0, 0)
    Dim testfile(&H4000) As Byte 'ステージ情報の全バッファ
    Dim bg(SizeBG) As Byte 'BG画像のバッファ 非圧縮
    Dim tile(SizeTile16x16) As Byte '16x16タイル定義のバッファ
    Dim chip(SizeChip32x32) As Byte '32x32タイル定義のバッファ
    Dim attr(SizeAttr32x32) As Byte '32x32属性情報のバッファ
    Dim flag(SizeFlag32x32) As Byte '32x32地形情報のバッファ
    Dim room(SizeRoom) As Byte '画面定義のバッファ
    Dim map(SizeMaps16x16) As Byte 'マップ定義のバッファ

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

    Dim numpalanim As Byte 'パレットアニメーション枚数
    Dim palwait As Byte 'パレットアニメーション待ち
    Dim palette(16) As Byte
    Dim palanim(SizePaletteAnim) As Byte
    Dim PaletteBrushes(&H40) As Brush
    Dim focus32, focus16, focus8 As UInteger '選択したチップ
    Dim tile_attr As UInteger '16x16タイルを描画する時に使う属性
    Dim flags_selected As UInteger '地形判定の書き込み用
    Dim obj_selected As UInteger '選択したオブジェクトのポインタ

    Dim zoom As UInteger = 1

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Dim f As New FileStream("C:\Users\nanashi\Dropbox\git\rockman2\stage\test.bin", FileMode.Open, FileAccess.ReadWrite)
        ReDim testfile(f.Length - 1)
        f.Read(testfile, 0, f.Length)
        f.Close()

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
        For i As UInteger = 0 To 16 - 1
            palette(i) = testfile(PaletteAddr + i)
        Next

        For i As UInteger = 0 To SizePaletteAnim - 1
            palanim(i) = testfile(PaletteAnimAddr + i)
        Next

        For i As UInteger = 0 To &H40 - 1
            PaletteBrushes(i) = GetPalette(i)

            enemies_ptr(i) = testfile(AddrEnemiesPtr + i)
            enemies_amount(i) = testfile(AddrEnemiesAmount + i)
            items_ptr(i) = testfile(AddrItemsPtr + i)
            items_amount(i) = testfile(AddrItemsAmount + i)
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

        focus32 = 0
        focus16 = 0
        focus8 = 0
        tile_attr = 0
        flags_selected = 0
        ComboBox_attr.SelectedIndex = 0
    End Sub

    Private Function GetPalette(ByVal c As Byte)
        c = c And &H3F
        Dim cr = Color.FromArgb(255, My.Resources.nes(c * 3), _
                               My.Resources.nes(c * 3 + 1), _
                               My.Resources.nes(c * 3 + 2))
        Return New SolidBrush(cr)
    End Function

    Private Sub DrawCenterLine(ByVal sender As Object, ByRef g As Graphics)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.Gray, 1)
        chain.DashStyle = Drawing2D.DashStyle.Custom
        chain.DashPattern = New Single() {16, 2, 4, 2}

        '32x32 line
        For i As UInteger = 1 To 15
            g.DrawLine(chain, New Point(0, sender.ClientSize.Height / 16 * i), New Point(sender.ClientSize.Width, sender.ClientSize.Height / 16 * i))
            g.DrawLine(chain, New Point(sender.ClientSize.Width / 16 * i, 0), New Point(sender.ClientSize.Width / 16 * i, sender.ClientSize.Height))
        Next

        chain.Brush = Brushes.White
        'horizontal center line
        g.DrawLine(chain, New Point(0, center.Y), New Point(sender.ClientSize.Width, center.Y))
        'vertical center line
        g.DrawLine(chain, New Point(center.X, 0), New Point(center.X, sender.ClientSize.Height))
    End Sub

    Private Sub Draw8Graph(ByRef g As Graphics, ByRef cur As Point, ByVal a As UInteger, ByVal at As UInteger, ByVal mag As UInteger)
        Dim c, seek As UInteger
        Dim bitmask() As Byte = {&H80, &H40, &H20, &H10, &H8, &H4, &H2, &H1}

        For x As UInteger = 0 To 7
            For y As UInteger = 0 To 7
                seek = a * 16 + y
                c = bg(seek) And bitmask(x)
                If c <> 0 Then
                    c = 1
                End If

                seek += 8
                If bg(seek) And bitmask(x) Then
                    c = c Or 2
                End If

                g.FillRectangle(PaletteBrushes(palette(4 * at + c)), New Rectangle((cur.X + x) * mag, (cur.Y + y) * mag, mag, mag))
            Next
        Next
    End Sub

    Private Sub Draw16Tile(ByRef g As Graphics, ByRef cur As Point, ByVal a As UInteger, ByVal at As UInteger, ByVal mag As UInteger)
        Dim graphnum As UInteger

        For x8 As UInteger = 0 To 1
            For y8 As UInteger = 0 To 1
                graphnum = tile(a * 4 + x8 * 2 + y8)

                Draw8Graph(g, cur, graphnum, at, mag)
                cur += New Point(0, 8)
            Next
            cur += New Point(8, -16)
        Next
    End Sub

    '32x32チップ番号aをcurに描画
    Private Sub Draw32Chip(ByRef g As Graphics, ByRef cur As Point, ByVal a As UInteger, ByVal mag As UInteger)
        Dim tilenum, at As UInteger '属性、ドットの色、8x8グラのデータ読み取り位置
        'Dim bitmask_inv() As Byte = {1, 2, 4, 8, &H10, &H20, &H40, &H80}
        Dim attrmask() As Byte = {&H3, &H30, &HC, &HC0}
        Dim attrshiftmask() As Byte = {0, 4, 2, 6}

        For x16 As UInteger = 0 To 1 '16x16 tile loop
            For y16 As UInteger = 0 To 1
                tilenum = chip(a * 4 + x16 * 2 + y16) And &H7F
                at = ((attr(a) And attrmask(x16 * 2 + y16)) >> attrshiftmask(x16 * 2 + y16)) And 3
                Draw16Tile(g, cur, tilenum, at, mag)
                cur += New Point(-16, 16)
            Next
            cur += New Point(16, -32)
        Next
    End Sub

    Public Function GetAllControls(ByVal top As Control) As Control()
        Dim buf As ArrayList = New ArrayList
        For Each c As Control In top.Controls
            buf.Add(c)
            buf.AddRange(GetAllControls(c))
        Next
        Return CType(buf.ToArray(GetType(Control)), Control())
    End Function

    Private Sub RefreshAll()
        For Each o As Control In GetAllControls(Me)
            If TypeOf o Is PictureBox Then
                o.Refresh()
            End If
        Next
    End Sub

    'マップ編集画面の描画
    '敵配置もここで描く
    Private Sub scr_Paint(sender As Object, e As PaintEventArgs) Handles scr.Paint
        Dim g As Graphics = e.Graphics

        '地形描画用
        Dim mapimage As New Bitmap(256, 256)
        Dim cur As New Point(0, 0)
        Dim roomnum, chipnum As UInteger

        '敵位置描画用
        Dim p As Point
        Dim ptr As UInteger
        Dim type As UInteger
        Dim s As String
        For Xm As UInteger = 0 To 1
            For Ym As UInteger = 0 To 1
                roomnum = map(((ViewOrigin.Y + Ym) * 16) + ViewOrigin.X + Xm)
                If roomnum < &H40 Then
                    For x32 As UInteger = 0 To 7 '32x32 chip loop
                        For y32 As UInteger = 0 To 7
                            chipnum = room(roomnum * &H40 + x32 * 8 + y32)
                            Draw32Chip(g, cur, chipnum, zoom)
                            cur += New Point(-32, 32)
                        Next
                        cur += New Point(32, -256)
                    Next

                    '敵配置編集モード有効の時、敵の位置情報を描く
                    If Radio_EditEnemies.Checked Then
                        If enemies_amount(roomnum) > 0 Then
                            ptr = enemies_ptr(roomnum) - 1
                            For i As Integer = 0 To enemies_amount(roomnum) - 1
                                type = enemies(ptr + i)
                                p.X = enemiesx(ptr + i)
                                p.Y = enemiesy(ptr + i)
                                p += New Point(Xm * 256, Ym * 256)
                                p.X *= zoom
                                p.Y *= zoom
                                If type < 16 Then
                                    s = "0"
                                Else
                                    s = ""
                                End If
                                s += Hex(type)
                                g.DrawRectangle(Pens.White, p.X - 16, p.Y - 16, 32, 32)
                                g.DrawString(s, New Font("MS UI Gothic", 12), Brushes.White, _
                                             New Rectangle(p - New Point(16, 16), New Size(32, 32)))
                            Next
                        End If

                        If items_amount(roomnum) > 0 Then
                            ptr = items_ptr(roomnum) - 1
                            For i As Integer = 0 To items_amount(roomnum) - 1
                                type = items(ptr + i)
                                p.X = itemsx(ptr + i)
                                p.Y = itemsy(ptr + i)
                                p += New Point(Xm * 256, Ym * 256)
                                p.X *= zoom
                                p.Y *= zoom
                                If type < 16 Then
                                    s = "0"
                                Else
                                    s = ""
                                End If
                                s += Hex(type)
                                g.DrawRectangle(Pens.White, p.X - 16, p.Y - 16, 32, 32)
                                g.DrawString(s, New Font("MS UI Gothic", 12), Brushes.Violet, _
                                             New Rectangle(p - New Point(16, 16), New Size(32, 32)))
                            Next
                        End If
                    End If
                Else
                    g.FillRectangle(Brushes.Black, cur.X * zoom, cur.Y * zoom, (cur.X + 256) * zoom, (cur.Y + 256) * zoom)
                    cur += New Point(256, 0)
                End If
                cur += New Point(-256, 256)
            Next
            cur += New Point(256, -512)
        Next
        DrawCenterLine(sender, g)
    End Sub

    Private Sub p32_Paint(sender As Object, e As PaintEventArgs) Handles p32.Paint
        Dim g As Graphics = e.Graphics
        Dim cur As New Point(0, 0)
        Dim chipnum As UInteger

        For y32 As UInteger = 0 To 15 '32x32 chip loop
            For x32 As UInteger = 0 To 15
                chipnum = y32 * 16 + x32
                Draw32Chip(g, cur, chipnum, zoom)
            Next
            cur += New Point(-512, 32)
        Next

        DrawCenterLine(sender, g)
    End Sub

    Private Sub ptile_Paint(sender As Object, e As PaintEventArgs) Handles ptile.Paint
        Dim g As Graphics = e.Graphics
        Dim cur As New Point(0, 0)
        Dim tilenum As UInteger

        For y16 As UInteger = 0 To 7 '16x16 tile loop
            For x16 As UInteger = 0 To 15
                tilenum = y16 * 16 + x16
                Draw16Tile(g, cur, tilenum, tile_attr, zoom * 2)
            Next
            cur += New Point(-256, 16)
        Next

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.Gray, 1)
        chain.DashStyle = Drawing2D.DashStyle.Custom
        chain.DashPattern = New Single() {16, 2, 4, 2}

        '32x32 line
        For i As UInteger = 1 To 7
            g.DrawLine(chain, New Point(0, sender.ClientSize.Height / 16 * 2 * i), New Point(sender.ClientSize.Width, sender.ClientSize.Height / 16 * 2 * i))
        Next

        For i As UInteger = 1 To 15
            g.DrawLine(chain, New Point(sender.ClientSize.Width / 16 * i, 0), New Point(sender.ClientSize.Width / 16 * i, sender.ClientSize.Height))
        Next

        chain.Brush = Brushes.White
        'horizontal center line
        g.DrawLine(chain, New Point(0, center.Y), New Point(sender.ClientSize.Width, center.Y))
        'vertical center line
        g.DrawLine(chain, New Point(center.X, 0), New Point(center.X, sender.ClientSize.Height))
    End Sub

    '選択されたやつを表示する
    Private Sub p32focus_Paint(sender As Object, e As PaintEventArgs) Handles p32focus.Paint, pmapSelect.Paint
        Dim g As Graphics = e.Graphics
        Draw32Chip(g, New Point(0, 0), focus32, zoom * 4)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.White, 1)
        'horizontal center line
        g.DrawLine(chain, New Point(0, center.Y), New Point(sender.ClientSize.Width, center.Y))
        'vertical center line
        g.DrawLine(chain, New Point(center.X, 0), New Point(center.X, sender.ClientSize.Height))

        Label_32Chip1.Text = "No: "
        If focus32 < 16 Then
            Label_32Chip1.Text += "0"
        End If
        Label_32Chip1.Text += Hex(focus32)

        Label_32Chip2.Text = "No: "
        If focus32 < 16 Then
            Label_32Chip2.Text += "0"
        End If
        Label_32Chip2.Text += Hex(focus32)
    End Sub

    '32x32タイル選択枠、属性表示の方
    Private Sub p32focus_attr_Paint(sender As Object, e As PaintEventArgs) Handles p32focus_attr.Paint
        p32focus_Paint(sender, e)

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
    Private Sub p16focus_Paint(sender As Object, e As PaintEventArgs) Handles p16focus.Paint, p3216focus.Paint
        Dim g As Graphics = e.Graphics
        Draw16Tile(g, New Point(0, 0), focus16, tile_attr, zoom * sender.Size.Width / 16)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.White, 1)
        'horizontal center line
        g.DrawLine(chain, New Point(0, center.Y), New Point(sender.ClientSize.Width, center.Y))
        'vertical center line
        g.DrawLine(chain, New Point(center.X, 0), New Point(center.X, sender.ClientSize.Height))

        Label_16Chip1.Text = "No: "
        If focus16 < 16 Then
            Label_16Chip1.Text += "0"
        End If
        Label_16Chip1.Text += Hex(focus16)

        Label_16Chip2.Text = "No: "
        If focus16 < 16 Then
            Label_16Chip2.Text += "0"
        End If
        Label_16Chip2.Text += Hex(focus16)
    End Sub

    '8x8タイルの選択枠
    Private Sub p8focus_Paint(sender As Object, e As PaintEventArgs) Handles p8focus.Paint
        Dim g As Graphics = e.Graphics
        Draw8Graph(g, New Point(0, 0), focus8, tile_attr, zoom * sender.Size.Width / 8)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.White, 1)
        'horizontal center line
        g.DrawLine(chain, New Point(0, center.Y), New Point(sender.ClientSize.Width, center.Y))
        'vertical center line
        g.DrawLine(chain, New Point(center.X, 0), New Point(center.X, sender.ClientSize.Height))

        Label_8Graph.Text = "No: "
        If focus8 < 16 Then
            Label_8Graph.Text += "0"
        End If
        Label_8Graph.Text += Hex(focus8)
    End Sub

    '8x8タイルのパレット
    Private Sub pgraphs_Paint(sender As Object, e As PaintEventArgs) Handles pgraphs.Paint
        Dim g As Graphics = e.Graphics
        Dim cur As New Point(0, 0)
        For y As UInteger = 0 To 15
            For x As UInteger = 0 To 15
                Draw8Graph(g, cur, y * 16 + x, tile_attr, zoom * 2)
                cur += New Point(8, 0)
            Next
            cur += New Point(-128, 8)
        Next
        DrawCenterLine(sender, g)
    End Sub

    'パレットバーの表示
    Private Sub ppalette_Paint(sender As Object, e As PaintEventArgs) Handles ppalette.Paint, ppalette32.Paint
        Dim g As Graphics = e.Graphics
        For i As UInteger = 0 To 15
            g.FillRectangle(GetPalette(palette(i)), New Rectangle(sender.Size.Height * i, 0, sender.Size.Height, sender.Size.Height))
            If i > 0 And i Mod 4 = 0 Then
                g.DrawLine(Pens.White, sender.Size.Height * i, 0, sender.Size.Height * i, sender.Size.Height)
            End If
        Next
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
                ElseIf e.Button = MouseButtons.Left Then
                    room(numroom * &H40 + selected) = focus32
                End If
                RefreshAll()
            Else
                '敵編集モード| 右クリック: アイテム選択, 左クリック: 敵選択

                Dim type As UInteger
                Dim ptr As UInteger
                Dim org As Point
                If e.Button = Windows.Forms.MouseButtons.Right Then
                    If items_amount(numroom) > 0 Then
                        ptr = items_ptr(numroom) - 1
                        For i As Integer = 0 To items_amount(numroom) - 1
                            type = items(ptr + i)
                            org.X = itemsx(ptr + i)
                            org.Y = itemsy(ptr + i)
                            org += New Point(quad.X * 256, quad.Y * 256)
                            org -= New Point(16, 16)
                            org.X *= zoom
                            org.Y *= zoom

                            If e.X > org.X And e.Y > org.Y And e.X < org.X + 32 And e.Y < org.Y + 32 Then
                                obj_selected = ptr + i
                                TextBoxObjType.Text = Hex(items(obj_selected))
                                TextBoxObjX.Text = Hex(itemsx(obj_selected))
                                TextBoxObjY.Text = Hex(itemsy(obj_selected))
                                Exit For
                            End If
                        Next
                    End If
                ElseIf e.Button = MouseButtons.Left Then
                    If enemies_amount(numroom) > 0 Then
                        ptr = enemies_ptr(numroom) - 1
                        For i As Integer = 0 To enemies_amount(numroom) - 1
                            type = enemies(ptr + i)
                            org.X = enemiesx(ptr + i)
                            org.Y = enemiesy(ptr + i)
                            org += New Point(quad.X * 256, quad.Y * 256)
                            org -= New Point(16, 16)
                            org.X *= zoom
                            org.Y *= zoom

                            If e.X > org.X And e.Y > org.Y And e.X < org.X + 32 And e.Y < org.Y + 32 Then
                                obj_selected = ptr + i
                                TextBoxObjType.Text = Hex(enemies(obj_selected))
                                TextBoxObjX.Text = Hex(enemiesx(obj_selected))
                                TextBoxObjY.Text = Hex(enemiesy(obj_selected))
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
        If Radio_EditTerrain.Checked Then
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
                    RefreshAll()
                End If
            End If
        End If
    End Sub


    '32x32パレットのクリック
    Private Sub p32_MouseClick(sender As Object, e As MouseEventArgs) Handles p32.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / (sender.Size.Width / 16)) 'p = 0～15
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))

        focus32 = p.Y * 16 + p.X
        RefreshAll()
    End Sub

    '32x32選択枠のクリック
    Private Sub p32focus_MouseClick(sender As Object, e As MouseEventArgs) Handles p32focus.MouseClick
        Dim bitmask() As UInteger = {3, &H30, &HC, &HC0}
        Dim shift() As UInteger = {0, 4, 2, 6}
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / (sender.Size.Width / 2)) 'p = 0～1
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 2))

        If e.Button = Windows.Forms.MouseButtons.Right Then '読み
            focus16 = chip(focus32 * 4 + p.X * 2 + p.Y) And &H7F
            tile_attr = (attr(focus32) And bitmask(p.X * 2 + p.Y)) >> shift(p.X * 2 + p.Y)
        ElseIf e.Button = Windows.Forms.MouseButtons.Left Then '書き
            Dim attr_write As UInteger = tile_attr << shift(p.X * 2 + p.Y)
            Dim attr_tmp As UInteger = attr(focus32)
            attr_tmp = attr_tmp And (Not bitmask(p.X * 2 + p.Y))
            attr(focus32) = attr_tmp Or attr_write
            chip(focus32 * 4 + p.X * 2 + p.Y) = focus16
        End If
        RefreshAll()
    End Sub

    '16x16タイル定義パレットのクリック
    Private Sub ptile_MouseClick(sender As Object, e As MouseEventArgs) Handles ptile.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / (sender.Size.Width / 16)) 'p = 0～15
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))

        focus16 = p.Y * 16 + p.X
        RefreshAll()
    End Sub

    '16x16選択枠のクリック
    Private Sub p16focus_MouseClick(sender As Object, e As MouseEventArgs) Handles p16focus.MouseClick
        Dim p As Point
        p.X = Math.Floor(e.X / (sender.Size.Width / 2))
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 2))

        If e.Button = Windows.Forms.MouseButtons.Right Then '読み
            focus8 = tile(focus16 * 4 + p.X * 2 + p.Y)
        ElseIf e.Button = Windows.Forms.MouseButtons.Left Then '書き
            tile(focus16 * 4 + p.X * 2 + p.Y) = focus8
        End If
        RefreshAll()
    End Sub

    '8x8タイルパレットのクリック
    Private Sub pgraphs_MouseClick(sender As Object, e As MouseEventArgs) Handles pgraphs.MouseClick
        Dim p As Point
        p.X = Math.Floor(e.X / (sender.Size.Width / 16))
        p.Y = Math.Floor(e.Y / (sender.Size.Width / 16))

        focus8 = p.X + p.Y * 16
        RefreshAll()
    End Sub

    'パレットバーのクリック
    Private Sub ppalette_MouseClick(sender As Object, e As MouseEventArgs) Handles ppalette.MouseClick, ppalette32.MouseClick
        tile_attr = Math.Floor(e.X / (sender.Size.Width / 4))
        RefreshAll()
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
        If e.Button = Windows.Forms.MouseButtons.Right Then '読み
            If p.Y = 0 Then
                a = a >> 4
            Else
                a = a And &HF
            End If
            flags_selected = a
            ComboBox_attr.SelectedIndex = flags_selected
        ElseIf e.Button = Windows.Forms.MouseButtons.Left Then '書き
            If p.Y = 0 Then
                a = a And &HF
                write = write << 4
            Else
                a = a And &HF0
            End If
            flag(focus32 * 2 + p.X) = a Or write
            RefreshAll()
        End If
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
            RefreshAll()
        End If
    End Sub

    Private Sub ButtonMapDown_Click(sender As Object, e As EventArgs) Handles ButtonMapDown.Click
        If ViewOrigin.Y < 15 Then
            ViewOrigin.Y += 1
            RefreshAll()
        End If
    End Sub

    Private Sub ButtonMapLeft_Click(sender As Object, e As EventArgs) Handles ButtonMapLeft.Click
        If ViewOrigin.X > 0 Then
            ViewOrigin.X -= 1
            RefreshAll()
        End If
    End Sub

    Private Sub ButtonMapRight_Click(sender As Object, e As EventArgs) Handles ButtonMapRight.Click
        If ViewOrigin.X < 15 Then
            ViewOrigin.X += 1
            RefreshAll()
        End If
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
        End If
    End Sub

    Private Sub Radio_EditTerrain_CheckedChanged(sender As Object, e As EventArgs) Handles Radio_EditTerrain.CheckedChanged
        RefreshAll()
        obj_selected = 0
    End Sub
End Class
