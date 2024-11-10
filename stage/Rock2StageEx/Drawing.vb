
Partial Public Class Form1

    Dim zoom As UInteger = 1

    Dim BufContext As BufferedGraphicsContext
    Dim scrBuf As BufferedGraphics
    Dim p32Buf As BufferedGraphics
    Dim p16Buf As BufferedGraphics
    Dim p8Buf As BufferedGraphics
    Dim p32selectedBuf As BufferedGraphics
    Dim p16selectedBuf As BufferedGraphics
    Dim p3216selectedBuf As BufferedGraphics
    Dim p8selectedBuf As BufferedGraphics
    Dim paletteBuf As BufferedGraphics
    'Dim scrBit As New Bitmap(512, 512)
    'Dim p32Bit As New Bitmap(512, 512)
    'Dim p16Bit As New Bitmap(512, 256)
    'Dim p8Bit As New Bitmap(256, 256)
    'Dim p32selectedBit As New Bitmap(32, 32)
    'Dim p16selectedBit As New Bitmap(16, 16)
    'Dim p8selectedBit As New Bitmap(8, 8)

    Dim _Pi As Byte                                 'アニメーションさせる際、今何枚目のパレットか、を記録
    Dim frameCounter As Integer = 0                 'タイマーが呼び出される度にインクリメント。
    Dim TimerStats As Threading.Timer               '別スレッドでタイマーを使うため、スレッド破棄用。

    Delegate Sub SetBackColorDelegate(ByVal c As Color)         '別スレッドでコントロールを扱うときはデリゲート宣言しないといけない
    Delegate Sub AnimationTimerDelegate(ByVal o As Object)      'タイマーが呼び出されると、このメソッドに行く
    Dim AnimTDelegate As New AnimationTimerDelegate(AddressOf AnimationTimer)       'デリゲート宣言を型とする変数が要るようである
    Dim LblBkColorDelegate As New SetBackColorDelegate(AddressOf RefreshInvoke)      '上がタイマー用、下がパレット変更用。

    'アニメーション用、タイマースレ
    Private Sub AnimationTimer(ByVal o As Object)
        Dim wily As Boolean = WilyToolStripMenuItem.Checked
        Dim n As Integer = If(wily, numpalanimwily, numpalanim)
        Dim wait As Integer = If(wily, palwaitwily, palwait)
        If n = 0 OrElse wait = 0 Then Exit Sub

        'みょ～に例外が出やすいので、出たら中断
        Try
            _Pi += CByte(1) '枚数 + 1
            If _Pi >= n Then _Pi = 0 'ループ
            '現在のパレットを変える
            For i As UInteger = 0 To 15
                If wily Then
                    palette(i) = palanim((_Pi + paletteoffset) * 16 + i)
                Else
                    palette(i) = palanim(_Pi * 16 + i)
                End If
            Next
            DrawAll()

            Me.Invoke(LblBkColorDelegate, New Object() {Nothing})
        Catch ex As Exception
            Exit Sub
        End Try
    End Sub

    '別スレだとプロパティを変更するのもなんだか面倒らしい
    Private Sub RefreshInvoke(ByVal c As Color)
        scr.Invalidate()
        pmapSelect.Invalidate()
        p32focus.Invalidate()
        p32focus_attr.Invalidate()
        p32.Invalidate()
        ptile.Invalidate()
        pgraphs.Invalidate()
        p16focus.Invalidate()
        p8focus.Invalidate()
        ppalette.Invalidate()
        ppalette32.Invalidate()
        DrawP16Focus(p3216focus)
        p3216focus.Invalidate()
    End Sub

    Private Sub Form1_FormClosing(sender As Object, e As FormClosingEventArgs) Handles MyBase.FormClosing
        If TimerStats IsNot Nothing Then TimerStats.Dispose()
    End Sub

    Private Sub DrawAll()

        DrawScr(scr)
        DrawP32(p32)
        DrawP16(ptile)
        DrawP8(pgraphs)
        DrawPaletteBar(ppalette)
        DrawP32Focus(p32focus)
        DrawP16Focus(p16focus)
        DrawP8Focus(p8focus)
    End Sub

    Private Sub ReDraw16Focus()

        DrawP16Focus(p16focus)
        p16focus.Refresh()
        DrawP16Focus(p3216focus)
        p3216focus.Refresh()
        DrawP16(ptile)
        ptile.Refresh()
        DrawP8(pgraphs)
        pgraphs.Refresh()
        DrawP8Focus(p8focus)
        p8focus.Refresh()
    End Sub

    Private Sub RefreshP32Focus()
        pmapSelect.Refresh()
        p32focus.Refresh()
        p32focus_attr.Refresh()
    End Sub

    Public Function GetAllControls(ByVal top As Control) As Control()
        Dim buf As New ArrayList
        For Each c As Control In top.Controls
            buf.Add(c)
            buf.AddRange(GetAllControls(c))
        Next
        Return CType(buf.ToArray(GetType(Control)), Control())
    End Function

    Private Sub RefreshAll()
        Me.SuspendLayout()
        For Each o As Control In GetAllControls(Me)
            If TypeOf o Is PictureBox Then
                o.Refresh()
            ElseIf TypeOf o Is DataGridView Then
                o.Refresh()
            End If
        Next
        Application.DoEvents()
        Me.ResumeLayout()
    End Sub


    Private Sub DrawCenterLine(ByVal sender As Object, ByRef g As Graphics)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.Gray, 1) With {
            .DashStyle = Drawing2D.DashStyle.Custom,
            .DashPattern = New Single() {16, 2, 4, 2}
        }

        '32x32 line
        For i As UInteger = 1 To 15
            Dim p11 As New Point(0, sender.ClientSize.Height / 16 * i)
            Dim p12 As New Point(sender.ClientSize.Width, sender.ClientSize.Height / 16 * i)
            Dim p21 As New Point(sender.ClientSize.Width / 16 * i, 0)
            Dim p22 As New Point(sender.ClientSize.Width / 16 * i, sender.ClientSize.Height)
            SyncLock Me
                g.DrawLine(chain, p11, p12)
                g.DrawLine(chain, p21, p22)
            End SyncLock
        Next

        chain.Brush = Brushes.White
        SyncLock Me
            g.DrawLine(chain, 0, center.Y, sender.ClientSize.Width, center.Y) 'horizontal center line
            g.DrawLine(chain, center.X, 0, center.X, sender.ClientSize.Height) 'vertical center line
        End SyncLock
    End Sub


    Private Function GetPalette(c As Byte) As SolidBrush
        c = c And &H3F
        Dim cr = Color.FromArgb(255, My.Resources.nes(c * 3),
                                     My.Resources.nes(c * 3 + 1),
                                     My.Resources.nes(c * 3 + 2))
        Return New SolidBrush(cr)
    End Function

    Private Sub Draw8Graph(ByRef g As Graphics, ByRef cur As Point, ByVal a As UInteger, ByVal at As UInteger, ByVal mag As UInteger)
        Dim c, seek As UInteger
        Dim bitmask() As Byte = {&H80, &H40, &H20, &H10, &H8, &H4, &H2, &H1}
        Dim chosenbg() As Byte = If(WilyToolStripMenuItem.Checked, bgalt, bg)

        For x As UInteger = 0 To 7
            For y As UInteger = 0 To 7
                seek = a * 16 + y
                c = chosenbg(seek) And bitmask(x)
                If c <> 0 Then
                    c = 1
                End If

                seek += 8
                If chosenbg(seek) And bitmask(x) Then
                    c = c Or 2
                End If

                Dim b As Brush = PaletteBrushes(palette(4 * at + c))
                Dim r As New Rectangle((cur.X + x) * mag, (cur.Y + y) * mag, mag, mag)
                SyncLock Me
                    g.FillRectangle(b, r)
                End SyncLock
            Next
        Next
    End Sub

    Private Sub Draw16Tile(ByRef g As Graphics, ByRef cur As Point, ByVal a As UInteger, ByVal at As UInteger, ByVal mag As UInteger)
        Dim graphnum As UInteger
        Dim cur0 As Point = cur

        For x8 As UInteger = 0 To 1
            For y8 As UInteger = 0 To 1
                graphnum = tile(a * 4 + x8 * 2 + y8)

                Draw8Graph(g, cur, graphnum, at, mag)
                cur += New Point(0, 8)
            Next
            cur += New Point(8, -16)
        Next
    End Sub

    Dim flagbrushes() As SolidBrush = {
        New SolidBrush(Color.FromArgb(0, Color.Transparent)),
        New SolidBrush(Color.FromArgb(192, Color.LightBlue)),
        New SolidBrush(Color.FromArgb(192, Color.Green)),
        New SolidBrush(Color.FromArgb(192, Color.White)),
        New SolidBrush(Color.FromArgb(192, Color.Magenta)),
        New SolidBrush(Color.FromArgb(192, Color.Magenta)),
        New SolidBrush(Color.FromArgb(192, Color.Magenta)),
        New SolidBrush(Color.FromArgb(192, Color.Magenta)),
        New SolidBrush(Color.FromArgb(192, Color.Yellow)),
        New SolidBrush(Color.FromArgb(192, Color.Red)),
        New SolidBrush(Color.FromArgb(192, Color.Orange)),
        New SolidBrush(Color.FromArgb(192, Color.YellowGreen)),
        New SolidBrush(Color.FromArgb(192, Color.Cyan)),
        New SolidBrush(Color.FromArgb(192, Color.Magenta)),
        New SolidBrush(Color.FromArgb(192, Color.Magenta)),
        New SolidBrush(Color.FromArgb(192, Color.Gray))
    }

    ' <param name="mag">倍率。</param>
    ''' <summary>
    ''' 32x32を描画します。
    ''' </summary>
    ''' <param name="g">描画先のグラフィックスオブジェクト。</param>
    ''' <param name="cur">描画する左上の位置。</param>
    ''' <param name="a">タイル番号。</param>
    Private Sub Draw32Chip(ByRef g As Graphics, ByRef cur As Point, ByVal a As UInteger, ByVal mag As UInteger)
        Dim tilenum, at, f As UInteger 'タイル番号、属性、地形判定番号
        'Dim bitmask_inv() As Byte = {1, 2, 4, 8, &H10, &H20, &H40, &H80}
        Dim attrmask() As Byte = {&H3, &H30, &HC, &HC0}
        Dim attrshiftmask() As Byte = {0, 4, 2, 6}

        For x16 As UInteger = 0 To 1 '16x16 tile loop
            For y16 As UInteger = 0 To 1
                tilenum = chip(a * 4 + x16 * 2 + y16) And &H7F
                at = ((attr(a) And attrmask(x16 * 2 + y16)) >> attrshiftmask(x16 * 2 + y16)) And 3
                f = If(y16 > 0, flag(a * 2 + x16) And &HF, flag(a * 2 + x16) >> 4)
                Draw16Tile(g, cur, tilenum, at, mag)
                cur += New Point(-16, 16)

                '判定表示
                If CheckBoxTerrainView.Checked Then
                    SyncLock Me
                        g.FillRectangle(flagbrushes(f),
                        cur.X * mag, (cur.Y - 16) * mag, 16 * mag, 16 * mag)
                    End SyncLock
                End If
            Next
            cur += New Point(16, -32)
        Next
    End Sub

    Private Sub DrawScr(sender As Object)
        If scrBuf Is Nothing Then Exit Sub

        Dim g As Graphics = scrBuf.Graphics

        '地形描画用
        Dim mapimage As New Bitmap(256, 256)
        Dim cur As New Point(0, 0)
        Dim roomnum, chipnum As UInteger

        '敵位置描画用
        Dim p As Point
        Dim type As UInteger
        Dim s As String
        Dim pen As Pen, brush As Brush
        For Xm As UInteger = 0 To 1
            For Ym As UInteger = 0 To 1
                roomnum = map((((ViewOrigin.Y + Ym) * 16) + ViewOrigin.X + Xm) Mod &H100)
                If roomnum < &H40 Then
                    '地形描画
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
                        If obj_isenemy Then
                            pen = Pens.White
                            brush = Brushes.White
                        Else
                            pen = Pens.Violet
                            brush = Brushes.Violet
                        End If
                        For Each en As EnemyStructure In EnemiesArray(roomnum)
                            type = en.TypeID
                            p = en.Origin
                            p += New Point(Xm * 256, Ym * 256)
                            If type < 16 Then
                                s = "0"
                            Else
                                s = ""
                            End If
                            s += Hex(type)
                            SyncLock Me
                                g.DrawRectangle(pen, p.X - 15, p.Y - 15, 30, 30)
                                If obj_isenemy And objroom_selected = roomnum And objindex_selected - 1 = EnemiesArray(roomnum).IndexOf(en) Then
                                    g.DrawRectangle(pen, p.X - 13, p.Y - 13, 26, 26)
                                End If
                                g.DrawString(s, New Font("MS UI Gothic", 12), brush,
                                                New Rectangle(p - New Point(10, 10), New Size(32, 32)))
                            End SyncLock
                        Next

                        If Not obj_isenemy Then
                            pen = Pens.White
                            brush = Brushes.White
                        Else
                            pen = Pens.Violet
                            brush = Brushes.Violet
                        End If
                        For Each it As EnemyStructure In ItemsArray(roomnum)
                            type = it.TypeID
                            p = it.Origin
                            p += New Point(Xm * 256, Ym * 256)
                            If type < 16 Then
                                s = "0"
                            Else
                                s = ""
                            End If
                            s += Hex(type)
                            SyncLock Me
                                g.DrawRectangle(pen, p.X - 15, p.Y - 15, 30, 30)
                                If (Not obj_isenemy) And objroom_selected = roomnum And objindex_selected - 1 = ItemsArray(roomnum).IndexOf(it) Then
                                    g.DrawRectangle(pen, p.X - 13, p.Y - 13, 26, 26)
                                End If
                                g.DrawString(s, New Font("MS UI Gothic", 12), brush,
                                                New Rectangle(p - New Point(10, 10), New Size(32, 32)))
                            End SyncLock
                        Next
                    End If
                Else
                    SyncLock Me
                        g.FillRectangle(Brushes.Black, cur.X, cur.Y, cur.X + 256, cur.Y + 256)
                    End SyncLock
                    cur += New Point(256, 0)
                End If
                cur += New Point(-256, 256)
            Next
            cur += New Point(256, -512)
        Next
        DrawCenterLine(sender, g)
    End Sub

    Private Sub DrawP32(sender As Object)
        Dim g As Graphics = p32Buf.Graphics
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

    Private Sub DrawP16(sender As Object)
        Dim g As Graphics = p16Buf.Graphics
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
        Dim chain As New Pen(Brushes.Gray, 1) With {
            .DashStyle = Drawing2D.DashStyle.Custom,
            .DashPattern = New Single() {16, 2, 4, 2}
        }

        '32x32 line
        For i As UInteger = 1 To 7
            Dim p1 As New Point(0, sender.ClientSize.Height / 16 * 2 * i)
            Dim p2 As New Point(sender.ClientSize.Width, sender.ClientSize.Height / 16 * 2 * i)
            SyncLock Me
                g.DrawLine(chain, p1, p2)
            End SyncLock
        Next

        For i As UInteger = 1 To 15
            Dim p1 As New Point(sender.ClientSize.Width / 16 * i, 0)
            Dim p2 As New Point(sender.ClientSize.Width / 16 * i, sender.ClientSize.Height)
            SyncLock Me
                g.DrawLine(chain, p1, p2)
            End SyncLock
        Next

        chain.Brush = Brushes.White
        SyncLock Me
            g.DrawLine(chain, 0, center.Y, sender.ClientSize.Width, center.Y) 'horizontal center line
            g.DrawLine(chain, center.X, 0, center.X, sender.ClientSize.Height) 'vertical center line
        End SyncLock
    End Sub

    Private Sub DrawP8(sender As Object)
        Dim g As Graphics = p8Buf.Graphics
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

    Private Sub DrawP32Focus(sender As Object)
        Dim g As Graphics = p32selectedBuf.Graphics
        Draw32Chip(g, New Point(0, 0), focus32, zoom * 4) '4x

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.White, 1)
        SyncLock Me
            g.DrawLine(chain, 0, center.Y, sender.ClientSize.Width, center.Y) 'horizontal center line
            g.DrawLine(chain, center.X, 0, center.X, sender.ClientSize.Height) 'vertical center line
        End SyncLock
    End Sub

    Private Sub DrawP16Focus(sender As Object)
        Dim g As Graphics = p16selectedBuf.Graphics
        If sender.Name = p3216focus.Name Then g = p3216selectedBuf.Graphics
        Draw16Tile(g, New Point(0, 0), focus16, tile_attr, zoom * sender.Size.Width / 16)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.White, 1)
        SyncLock Me
            g.DrawLine(chain, 0, center.Y, sender.ClientSize.Width, center.Y) 'horizontal center line
            g.DrawLine(chain, center.X, 0, center.X, sender.ClientSize.Height) 'vertical center line
        End SyncLock
    End Sub

    Private Sub DrawP8Focus(sender As Object)
        Dim g As Graphics = p8selectedBuf.Graphics
        Draw8Graph(g, New Point(0, 0), focus8, tile_attr, zoom * sender.Size.Width / 8)

        Dim center As New Point(sender.ClientSize.Width / 2, sender.ClientSize.Height / 2)
        Dim chain As New Pen(Brushes.White, 1)
        SyncLock Me
            g.DrawLine(chain, 0, center.Y, sender.ClientSize.Width, center.Y) 'horizontal center line
            g.DrawLine(chain, center.X, 0, center.X, sender.ClientSize.Height) 'vertical center line
        End SyncLock
    End Sub

    Private Sub DrawPaletteBar(sender As Object)
        Dim g As Graphics = paletteBuf.Graphics
        Dim s As New Size(sender.Size.Height, sender.Size.Height)
        For i As UInteger = 0 To 15
            Dim b As SolidBrush = GetPalette(palette(i))
            Dim p As New Point(sender.Size.Height * i, 0)
            Dim r As New Rectangle(p, s)
            SyncLock Me
                g.FillRectangle(b, r)
            End SyncLock
            If i > 0 And i Mod 4 = 0 Then
                Dim p2 As New Point(sender.Size.Height * i, sender.Size.Height)
                SyncLock Me
                    g.DrawLine(Pens.White, p, p2)
                End SyncLock
            End If
        Next
    End Sub
End Class
