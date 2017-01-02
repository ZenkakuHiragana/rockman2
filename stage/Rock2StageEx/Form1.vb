Imports System.IO

Public Class Form1

    Const SizeTile16x16 As UInteger = &H200
    Const SizeChip32x32 As UInteger = 4 * &H100
    Const SizeAttr32x32 As UInteger = &H100
    Const SizeFlag32x32 As UInteger = &H100
    Const SizeMaps16x16 As UInteger = &H100
    Const SizeEnemies As UInteger = &HFF
    Const SizeItems As UInteger = &H30
    Const SizePaletteAnim As UInteger = &H10 * 10
    Const SizeBG As UInteger = &H1000
    Const SizeRoom As UInteger = &H1000

    Const AddrTile16x16 As UInteger = &H0   '16x16グラ定義
    Const AddrChip32x32 As UInteger = &H200 '32x32グラ定義
    Const AddrAttr32x32 As UInteger = &H600 '属性テーブル, 配色
    Const AddrFlag32x32 As UInteger = &H700 '地形判定フラグ
    Const AddrMaps16x16 As UInteger = &H800 'マップの配置
    Const AddrEnemiesR As UInteger = &H900 '敵配置画面位置
    Const AddrEnemiesX As UInteger = &HA00 - 1  '敵配置X
    Const AddrEnemiesY As UInteger = &HB00 - 2  '敵配置Y
    Const AddrEnemies As UInteger = &HC00 - 3   '敵の種類
    Const AddrItemsR As UInteger = &HD00 - 4    'アイテム配置画面位置
    Const AddrItemsX As UInteger = &HD30 - 4    'アイテム配置X
    Const AddrItemsY As UInteger = &HD60 - 4    'アイテム配置Y
    Const AddrItems As UInteger = &HD90 - 4     'アイテムの種類
    Const PaletteAnimFrames As UInteger = &HDC0 - 2 'パレットアニメーション枚数
    Const PaletteAnimWait As UInteger = &HDC0 - 1   'パレットアニメーション待ち
    Const PaletteAddr As UInteger = &HDC0           'パレット
    Const PaletteAnimAddr As UInteger = &HDE0       'パレットアニメーション定義(10x)
    Const AddrContinue As UInteger = &HE80          '中間地点定義
    'F00-FFF free

    Const AddrBG As UInteger = &H2000       'BG画像位置
    Const AddrRoom As UInteger = &H3000     '画面定義

    Dim ViewOrigin As New Point(0, 0)
    Dim testfile(&H4000) As Byte
    Dim bg(SizeBG) As Byte
    Dim tile(SizeTile16x16) As Byte
    Dim chip(SizeChip32x32) As Byte
    Dim attr(SizeAttr32x32) As Byte
    Dim flag(SizeFlag32x32) As Byte
    Dim room(SizeRoom) As Byte
    Dim map(SizeMaps16x16) As Byte
    Dim numpalanim As Byte 'パレットアニメーション枚数
    Dim palwait As Byte 'パレットアニメーション待ち
    Dim palette(16) As Byte
    Dim palanim(SizePaletteAnim) As Byte
    Dim PaletteBrushes(&H40) As Brush
    Dim focus32, focus16 As UInteger '選択したチップ

    Dim zoom As UInteger = 1

    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim f As New FileStream("C:\Users\nanashi\Dropbox\hack\hack\stage\test.bin", FileMode.Open, FileAccess.ReadWrite)
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
        Next

        focus32 = 0
        focus16 = 0
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

    Private Sub scr_Paint(sender As Object, e As PaintEventArgs) Handles scr.Paint
        Dim g As Graphics = e.Graphics

        Dim mapimage As New Bitmap(256, 256)
        Dim cur As New Point(0, 0)
        Dim roomnum, chipnum As UInteger

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
                Else
                    g.FillRectangle(Brushes.Black, cur.X * zoom, cur.Y * zoom, (cur.X + 256) * zoom, (cur.Y + 256) * zoom)
                    cur += New Point(256, 0)
                End If
                cur += New Point(-256, 256)
            Next
            cur += New Point(256, -512)
        Next

        'g.DrawImage(mapimage, New Point(0, 0))
        DrawCenterLine(sender, g)
    End Sub

    Private Sub p32_Paint(sender As System.Object, e As System.Windows.Forms.PaintEventArgs) Handles p32.Paint
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

    Private Sub ptile_Paint(sender As System.Object, e As System.Windows.Forms.PaintEventArgs) Handles ptile.Paint
        Dim g As Graphics = e.Graphics
        Dim cur As New Point(0, 0)
        Dim tilenum As UInteger

        For y16 As UInteger = 0 To 7 '16x16 tile loop
            For x16 As UInteger = 0 To 15
                tilenum = y16 * 16 + x16
                Draw16Tile(g, cur, tilenum, 0, zoom * 2)
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
    Private Sub p32focus_Paint(sender As System.Object, e As System.Windows.Forms.PaintEventArgs) Handles pmapSelect.Paint, p32focus.Paint
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

    Private Sub p16focus_Paint(sender As System.Object, e As System.Windows.Forms.PaintEventArgs) Handles p16focus.Paint, p3216focus.Paint
        Dim g As Graphics = e.Graphics
        Draw16Tile(g, New Point(0, 0), focus16, 0, zoom * sender.Size.Width / 16)

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

    Private Sub pgraphs_Paint(sender As System.Object, e As System.Windows.Forms.PaintEventArgs) Handles pgraphs.Paint
        Dim g As Graphics = e.Graphics
        Dim cur As New Point(0, 0)
        For y As UInteger = 0 To 15
            For x As UInteger = 0 To 15
                Draw8Graph(g, cur, y * 16 + x, 0, zoom * 2)
                cur += New Point(8, 0)
            Next
            cur += New Point(-128, 8)
        Next
        DrawCenterLine(sender, g)
    End Sub

    '選択するやつ
    Private Sub scr_MouseClick(sender As System.Object, e As System.Windows.Forms.MouseEventArgs) Handles scr.MouseClick
        Dim numroom, selected As UInteger
        Dim quad As Point '4分割した時、どこをクリックしたか
        Dim p As Point 'どのマスをクリックしたか
        quad.X = Math.Floor(e.X / 256)
        quad.Y = Math.Floor(e.Y / 256)
        p.X = Math.Floor(e.X / 32) 'p = 0～15
        p.Y = Math.Floor(e.Y / 32)
        If quad.X > 0 Then
            p.X -= 8
        End If
        If quad.Y > 0 Then
            p.Y -= 8
        End If
        'p = 0～7

        selected = p.X * 8 + p.Y 'selected = 0～31
        numroom = map((ViewOrigin.Y + quad.Y) * 16 + ViewOrigin.X + quad.X)

        If e.Button = Windows.Forms.MouseButtons.Right Then
            focus32 = room(numroom * &H40 + selected)
            pmapSelect.Refresh()
        ElseIf e.Button = Windows.Forms.MouseButtons.Left Then
            room(numroom * &H40 + selected) = focus32
            scr.Refresh()
        End If
    End Sub


    Private Sub p32_MouseClick(sender As System.Object, e As System.Windows.Forms.MouseEventArgs) Handles p32.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / 32) 'p = 0～15
        p.Y = Math.Floor(e.Y / 32)

        focus32 = p.Y * 16 + p.X
        p32focus.Refresh()
    End Sub

    Private Sub p32focus_MouseClick(sender As System.Object, e As System.Windows.Forms.MouseEventArgs) Handles p32focus.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / 64) 'p = 0～15
        p.Y = Math.Floor(e.Y / 64)

        focus16 = chip(focus32 * 4 + p.X * 2 + p.Y) And &H7F
        p16focus.Refresh()
        p3216focus.Refresh()
    End Sub

    Private Sub ptile_MouseClick(sender As System.Object, e As System.Windows.Forms.MouseEventArgs) Handles ptile.MouseClick
        Dim p As Point 'どのマスをクリックしたか
        p.X = Math.Floor(e.X / 32) 'p = 0～15
        p.Y = Math.Floor(e.Y / 32)

        focus16 = p.Y * 16 + p.X
        p16focus.Refresh()
    End Sub

    '矢印キーでマップ移動
    Private Sub TabControl1_KeyUp(sender As System.Object, e As System.Windows.Forms.KeyEventArgs) Handles TabControl1.KeyUp, MyBase.KeyUp
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

    Private Sub ButtonMapUp_Click(sender As System.Object, e As System.EventArgs) Handles ButtonMapUp.Click
        If ViewOrigin.Y > 0 Then
            ViewOrigin.Y -= 1
            scr.Refresh()
        End If
    End Sub

    Private Sub ButtonMapDown_Click(sender As System.Object, e As System.EventArgs) Handles ButtonMapDown.Click
        If ViewOrigin.Y < 15 Then
            ViewOrigin.Y += 1
            scr.Refresh()
        End If
    End Sub

    Private Sub ButtonMapLeft_Click(sender As System.Object, e As System.EventArgs) Handles ButtonMapLeft.Click
        If ViewOrigin.X > 0 Then
            ViewOrigin.X -= 1
            scr.Refresh()
        End If
    End Sub

    Private Sub ButtonMapRight_Click(sender As System.Object, e As System.EventArgs) Handles ButtonMapRight.Click
        If ViewOrigin.X < 15 Then
            ViewOrigin.X += 1
            scr.Refresh()
        End If
    End Sub
End Class
