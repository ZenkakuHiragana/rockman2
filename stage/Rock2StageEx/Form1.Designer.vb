<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'フォームがコンポーネントの一覧をクリーンアップするために dispose をオーバーライドします。
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Windows フォーム デザイナーで必要です。
    Private components As System.ComponentModel.IContainer

    'メモ: 以下のプロシージャは Windows フォーム デザイナーで必要です。
    'Windows フォーム デザイナーを使用して変更できます。  
    'コード エディターを使って変更しないでください。
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.scr = New System.Windows.Forms.PictureBox()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.Menu_File = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_Open = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_Exit = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_ShowAll = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_ShowPartial = New System.Windows.Forms.ToolStripMenuItem()
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.tmap = New System.Windows.Forms.TabPage()
        Me.ButtonMapDown = New System.Windows.Forms.Button()
        Me.ButtonMapRight = New System.Windows.Forms.Button()
        Me.ButtonMapUp = New System.Windows.Forms.Button()
        Me.ButtonMapLeft = New System.Windows.Forms.Button()
        Me.Label_32Chip1 = New System.Windows.Forms.Label()
        Me.pmapSelect = New System.Windows.Forms.PictureBox()
        Me.tchip = New System.Windows.Forms.TabPage()
        Me.ComboBox_attr = New System.Windows.Forms.ComboBox()
        Me.ppalette32 = New System.Windows.Forms.PictureBox()
        Me.Label_16Chip2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label_32Chip2 = New System.Windows.Forms.Label()
        Me.p3216focus = New System.Windows.Forms.PictureBox()
        Me.p32focus_attr = New System.Windows.Forms.PictureBox()
        Me.p32focus = New System.Windows.Forms.PictureBox()
        Me.p32 = New System.Windows.Forms.PictureBox()
        Me.ttile = New System.Windows.Forms.TabPage()
        Me.Label_8Graph = New System.Windows.Forms.Label()
        Me.Label_16Chip1 = New System.Windows.Forms.Label()
        Me.ppalette = New System.Windows.Forms.PictureBox()
        Me.pgraphs = New System.Windows.Forms.PictureBox()
        Me.p8focus = New System.Windows.Forms.PictureBox()
        Me.p16focus = New System.Windows.Forms.PictureBox()
        Me.ptile = New System.Windows.Forms.PictureBox()
        Me.Radio_EditTerrain = New System.Windows.Forms.RadioButton()
        Me.Radio_EditEnemies = New System.Windows.Forms.RadioButton()
        Me.Label_ObjType = New System.Windows.Forms.Label()
        Me.Label_ObjX = New System.Windows.Forms.Label()
        Me.Label_ObjY = New System.Windows.Forms.Label()
        Me.TextBoxObjType = New System.Windows.Forms.TextBox()
        Me.TextBoxObjX = New System.Windows.Forms.TextBox()
        Me.TextBoxObjY = New System.Windows.Forms.TextBox()
        CType(Me.scr, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.MenuStrip1.SuspendLayout()
        Me.TabControl1.SuspendLayout()
        Me.tmap.SuspendLayout()
        CType(Me.pmapSelect, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.tchip.SuspendLayout()
        CType(Me.ppalette32, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p3216focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p32focus_attr, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p32focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p32, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ttile.SuspendLayout()
        CType(Me.ppalette, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.pgraphs, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p8focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p16focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ptile, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'scr
        '
        Me.scr.BackColor = System.Drawing.SystemColors.Window
        Me.scr.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.scr.Location = New System.Drawing.Point(6, 6)
        Me.scr.Name = "scr"
        Me.scr.Size = New System.Drawing.Size(512, 512)
        Me.scr.TabIndex = 0
        Me.scr.TabStop = False
        '
        'MenuStrip1
        '
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.Menu_File, Me.Menu_ShowAll, Me.Menu_ShowPartial})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(556, 26)
        Me.MenuStrip1.TabIndex = 1
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'Menu_File
        '
        Me.Menu_File.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.Menu_Open, Me.Menu_Exit})
        Me.Menu_File.Name = "Menu_File"
        Me.Menu_File.Size = New System.Drawing.Size(85, 22)
        Me.Menu_File.Text = "ファイル(&F)"
        '
        'Menu_Open
        '
        Me.Menu_Open.Name = "Menu_Open"
        Me.Menu_Open.Size = New System.Drawing.Size(152, 22)
        Me.Menu_Open.Text = "開く(&O)"
        '
        'Menu_Exit
        '
        Me.Menu_Exit.Name = "Menu_Exit"
        Me.Menu_Exit.Size = New System.Drawing.Size(152, 22)
        Me.Menu_Exit.Text = "終了(&X)"
        '
        'Menu_ShowAll
        '
        Me.Menu_ShowAll.Name = "Menu_ShowAll"
        Me.Menu_ShowAll.Size = New System.Drawing.Size(68, 22)
        Me.Menu_ShowAll.Text = "全部表示"
        '
        'Menu_ShowPartial
        '
        Me.Menu_ShowPartial.Name = "Menu_ShowPartial"
        Me.Menu_ShowPartial.Size = New System.Drawing.Size(68, 22)
        Me.Menu_ShowPartial.Text = "部分表示"
        '
        'TabControl1
        '
        Me.TabControl1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.TabControl1.Controls.Add(Me.tmap)
        Me.TabControl1.Controls.Add(Me.tchip)
        Me.TabControl1.Controls.Add(Me.ttile)
        Me.TabControl1.Location = New System.Drawing.Point(12, 29)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(532, 732)
        Me.TabControl1.TabIndex = 1
        '
        'tmap
        '
        Me.tmap.Controls.Add(Me.TextBoxObjY)
        Me.tmap.Controls.Add(Me.TextBoxObjX)
        Me.tmap.Controls.Add(Me.TextBoxObjType)
        Me.tmap.Controls.Add(Me.Radio_EditEnemies)
        Me.tmap.Controls.Add(Me.Radio_EditTerrain)
        Me.tmap.Controls.Add(Me.ButtonMapDown)
        Me.tmap.Controls.Add(Me.ButtonMapRight)
        Me.tmap.Controls.Add(Me.ButtonMapUp)
        Me.tmap.Controls.Add(Me.ButtonMapLeft)
        Me.tmap.Controls.Add(Me.Label_ObjY)
        Me.tmap.Controls.Add(Me.Label_ObjX)
        Me.tmap.Controls.Add(Me.Label_ObjType)
        Me.tmap.Controls.Add(Me.Label_32Chip1)
        Me.tmap.Controls.Add(Me.pmapSelect)
        Me.tmap.Controls.Add(Me.scr)
        Me.tmap.Location = New System.Drawing.Point(4, 22)
        Me.tmap.Name = "tmap"
        Me.tmap.Padding = New System.Windows.Forms.Padding(3)
        Me.tmap.Size = New System.Drawing.Size(524, 706)
        Me.tmap.TabIndex = 0
        Me.tmap.Text = "マップ"
        Me.tmap.UseVisualStyleBackColor = True
        '
        'ButtonMapDown
        '
        Me.ButtonMapDown.Location = New System.Drawing.Point(432, 660)
        Me.ButtonMapDown.Name = "ButtonMapDown"
        Me.ButtonMapDown.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapDown.TabIndex = 6
        Me.ButtonMapDown.Text = "↓"
        Me.ButtonMapDown.UseVisualStyleBackColor = True
        '
        'ButtonMapRight
        '
        Me.ButtonMapRight.Location = New System.Drawing.Point(478, 660)
        Me.ButtonMapRight.Name = "ButtonMapRight"
        Me.ButtonMapRight.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapRight.TabIndex = 6
        Me.ButtonMapRight.Text = "→"
        Me.ButtonMapRight.UseVisualStyleBackColor = True
        '
        'ButtonMapUp
        '
        Me.ButtonMapUp.Location = New System.Drawing.Point(432, 614)
        Me.ButtonMapUp.Name = "ButtonMapUp"
        Me.ButtonMapUp.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapUp.TabIndex = 6
        Me.ButtonMapUp.Text = "↑"
        Me.ButtonMapUp.UseVisualStyleBackColor = True
        '
        'ButtonMapLeft
        '
        Me.ButtonMapLeft.Location = New System.Drawing.Point(386, 660)
        Me.ButtonMapLeft.Name = "ButtonMapLeft"
        Me.ButtonMapLeft.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapLeft.TabIndex = 6
        Me.ButtonMapLeft.Text = "←"
        Me.ButtonMapLeft.UseVisualStyleBackColor = True
        '
        'Label_32Chip1
        '
        Me.Label_32Chip1.AutoSize = True
        Me.Label_32Chip1.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_32Chip1.Location = New System.Drawing.Point(6, 655)
        Me.Label_32Chip1.Name = "Label_32Chip1"
        Me.Label_32Chip1.Size = New System.Drawing.Size(61, 19)
        Me.Label_32Chip1.TabIndex = 5
        Me.Label_32Chip1.Text = "No: 00"
        '
        'pmapSelect
        '
        Me.pmapSelect.BackColor = System.Drawing.SystemColors.Window
        Me.pmapSelect.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.pmapSelect.Location = New System.Drawing.Point(6, 524)
        Me.pmapSelect.Name = "pmapSelect"
        Me.pmapSelect.Size = New System.Drawing.Size(128, 128)
        Me.pmapSelect.TabIndex = 3
        Me.pmapSelect.TabStop = False
        '
        'tchip
        '
        Me.tchip.Controls.Add(Me.ComboBox_attr)
        Me.tchip.Controls.Add(Me.ppalette32)
        Me.tchip.Controls.Add(Me.Label_16Chip2)
        Me.tchip.Controls.Add(Me.Label1)
        Me.tchip.Controls.Add(Me.Label_32Chip2)
        Me.tchip.Controls.Add(Me.p3216focus)
        Me.tchip.Controls.Add(Me.p32focus_attr)
        Me.tchip.Controls.Add(Me.p32focus)
        Me.tchip.Controls.Add(Me.p32)
        Me.tchip.Location = New System.Drawing.Point(4, 22)
        Me.tchip.Name = "tchip"
        Me.tchip.Padding = New System.Windows.Forms.Padding(3)
        Me.tchip.Size = New System.Drawing.Size(524, 706)
        Me.tchip.TabIndex = 1
        Me.tchip.Text = "32x32"
        Me.tchip.UseVisualStyleBackColor = True
        '
        'ComboBox_attr
        '
        Me.ComboBox_attr.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ComboBox_attr.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.ComboBox_attr.FormattingEnabled = True
        Me.ComboBox_attr.Items.AddRange(New Object() {"0: 背景", "1: 水中", "2: ハシゴ", "3: ", "4: ", "5: ", "6: ", "7: ", "8: 壁", "9: トゲ", "A: コンベア(左)", "B: コンベア(右)", "C: 氷", "D: 一方通行(上)", "E: 一方通行(下)", "F: シャッター"})
        Me.ComboBox_attr.Location = New System.Drawing.Point(278, 625)
        Me.ComboBox_attr.Name = "ComboBox_attr"
        Me.ComboBox_attr.Size = New System.Drawing.Size(121, 27)
        Me.ComboBox_attr.TabIndex = 6
        '
        'ppalette32
        '
        Me.ppalette32.BackColor = System.Drawing.SystemColors.Window
        Me.ppalette32.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ppalette32.Location = New System.Drawing.Point(6, 668)
        Me.ppalette32.Name = "ppalette32"
        Me.ppalette32.Size = New System.Drawing.Size(512, 32)
        Me.ppalette32.TabIndex = 5
        Me.ppalette32.TabStop = False
        '
        'Label_16Chip2
        '
        Me.Label_16Chip2.AutoSize = True
        Me.Label_16Chip2.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_16Chip2.Location = New System.Drawing.Point(457, 591)
        Me.Label_16Chip2.Name = "Label_16Chip2"
        Me.Label_16Chip2.Size = New System.Drawing.Size(61, 19)
        Me.Label_16Chip2.TabIndex = 4
        Me.Label_16Chip2.Text = "No: 00"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label1.Location = New System.Drawing.Point(274, 603)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(85, 19)
        Me.Label1.TabIndex = 4
        Me.Label1.Text = "地形判定"
        '
        'Label_32Chip2
        '
        Me.Label_32Chip2.AutoSize = True
        Me.Label_32Chip2.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_32Chip2.Location = New System.Drawing.Point(274, 524)
        Me.Label_32Chip2.Name = "Label_32Chip2"
        Me.Label_32Chip2.Size = New System.Drawing.Size(61, 19)
        Me.Label_32Chip2.TabIndex = 4
        Me.Label_32Chip2.Text = "No: 00"
        '
        'p3216focus
        '
        Me.p3216focus.BackColor = System.Drawing.SystemColors.Window
        Me.p3216focus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p3216focus.Location = New System.Drawing.Point(454, 524)
        Me.p3216focus.Name = "p3216focus"
        Me.p3216focus.Size = New System.Drawing.Size(64, 64)
        Me.p3216focus.TabIndex = 3
        Me.p3216focus.TabStop = False
        '
        'p32focus_attr
        '
        Me.p32focus_attr.BackColor = System.Drawing.SystemColors.Window
        Me.p32focus_attr.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p32focus_attr.Location = New System.Drawing.Point(140, 524)
        Me.p32focus_attr.Name = "p32focus_attr"
        Me.p32focus_attr.Size = New System.Drawing.Size(128, 128)
        Me.p32focus_attr.TabIndex = 3
        Me.p32focus_attr.TabStop = False
        '
        'p32focus
        '
        Me.p32focus.BackColor = System.Drawing.SystemColors.Window
        Me.p32focus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p32focus.Location = New System.Drawing.Point(6, 524)
        Me.p32focus.Name = "p32focus"
        Me.p32focus.Size = New System.Drawing.Size(128, 128)
        Me.p32focus.TabIndex = 3
        Me.p32focus.TabStop = False
        '
        'p32
        '
        Me.p32.BackColor = System.Drawing.SystemColors.Window
        Me.p32.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p32.Location = New System.Drawing.Point(6, 6)
        Me.p32.Name = "p32"
        Me.p32.Size = New System.Drawing.Size(512, 512)
        Me.p32.TabIndex = 1
        Me.p32.TabStop = False
        '
        'ttile
        '
        Me.ttile.Controls.Add(Me.Label_8Graph)
        Me.ttile.Controls.Add(Me.Label_16Chip1)
        Me.ttile.Controls.Add(Me.ppalette)
        Me.ttile.Controls.Add(Me.pgraphs)
        Me.ttile.Controls.Add(Me.p8focus)
        Me.ttile.Controls.Add(Me.p16focus)
        Me.ttile.Controls.Add(Me.ptile)
        Me.ttile.Location = New System.Drawing.Point(4, 22)
        Me.ttile.Name = "ttile"
        Me.ttile.Padding = New System.Windows.Forms.Padding(3)
        Me.ttile.Size = New System.Drawing.Size(524, 706)
        Me.ttile.TabIndex = 2
        Me.ttile.Text = "16x16"
        Me.ttile.UseVisualStyleBackColor = True
        '
        'Label_8Graph
        '
        Me.Label_8Graph.AutoSize = True
        Me.Label_8Graph.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_8Graph.Location = New System.Drawing.Point(195, 335)
        Me.Label_8Graph.Name = "Label_8Graph"
        Me.Label_8Graph.Size = New System.Drawing.Size(61, 19)
        Me.Label_8Graph.TabIndex = 5
        Me.Label_8Graph.Text = "No: 00"
        '
        'Label_16Chip1
        '
        Me.Label_16Chip1.AutoSize = True
        Me.Label_16Chip1.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_16Chip1.Location = New System.Drawing.Point(6, 399)
        Me.Label_16Chip1.Name = "Label_16Chip1"
        Me.Label_16Chip1.Size = New System.Drawing.Size(61, 19)
        Me.Label_16Chip1.TabIndex = 5
        Me.Label_16Chip1.Text = "No: 00"
        '
        'ppalette
        '
        Me.ppalette.BackColor = System.Drawing.SystemColors.Window
        Me.ppalette.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ppalette.Location = New System.Drawing.Point(6, 668)
        Me.ppalette.Name = "ppalette"
        Me.ppalette.Size = New System.Drawing.Size(512, 32)
        Me.ppalette.TabIndex = 2
        Me.ppalette.TabStop = False
        '
        'pgraphs
        '
        Me.pgraphs.BackColor = System.Drawing.SystemColors.Window
        Me.pgraphs.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.pgraphs.Location = New System.Drawing.Point(262, 268)
        Me.pgraphs.Name = "pgraphs"
        Me.pgraphs.Size = New System.Drawing.Size(256, 256)
        Me.pgraphs.TabIndex = 2
        Me.pgraphs.TabStop = False
        '
        'p8focus
        '
        Me.p8focus.BackColor = System.Drawing.SystemColors.Window
        Me.p8focus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p8focus.Location = New System.Drawing.Point(192, 268)
        Me.p8focus.Name = "p8focus"
        Me.p8focus.Size = New System.Drawing.Size(64, 64)
        Me.p8focus.TabIndex = 2
        Me.p8focus.TabStop = False
        '
        'p16focus
        '
        Me.p16focus.BackColor = System.Drawing.SystemColors.Window
        Me.p16focus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p16focus.Location = New System.Drawing.Point(6, 268)
        Me.p16focus.Name = "p16focus"
        Me.p16focus.Size = New System.Drawing.Size(128, 128)
        Me.p16focus.TabIndex = 2
        Me.p16focus.TabStop = False
        '
        'ptile
        '
        Me.ptile.BackColor = System.Drawing.SystemColors.Window
        Me.ptile.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ptile.Location = New System.Drawing.Point(6, 6)
        Me.ptile.Name = "ptile"
        Me.ptile.Size = New System.Drawing.Size(512, 256)
        Me.ptile.TabIndex = 2
        Me.ptile.TabStop = False
        '
        'Radio_EditTerrain
        '
        Me.Radio_EditTerrain.AutoSize = True
        Me.Radio_EditTerrain.Checked = True
        Me.Radio_EditTerrain.Font = New System.Drawing.Font("MS UI Gothic", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Radio_EditTerrain.Location = New System.Drawing.Point(76, 653)
        Me.Radio_EditTerrain.Name = "Radio_EditTerrain"
        Me.Radio_EditTerrain.Size = New System.Drawing.Size(58, 20)
        Me.Radio_EditTerrain.TabIndex = 7
        Me.Radio_EditTerrain.TabStop = True
        Me.Radio_EditTerrain.Text = "地形"
        Me.Radio_EditTerrain.UseVisualStyleBackColor = True
        '
        'Radio_EditEnemies
        '
        Me.Radio_EditEnemies.AutoSize = True
        Me.Radio_EditEnemies.Font = New System.Drawing.Font("MS UI Gothic", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Radio_EditEnemies.Location = New System.Drawing.Point(76, 679)
        Me.Radio_EditEnemies.Name = "Radio_EditEnemies"
        Me.Radio_EditEnemies.Size = New System.Drawing.Size(74, 20)
        Me.Radio_EditEnemies.TabIndex = 7
        Me.Radio_EditEnemies.Text = "敵配置"
        Me.Radio_EditEnemies.UseVisualStyleBackColor = True
        '
        'Label_ObjType
        '
        Me.Label_ObjType.AutoSize = True
        Me.Label_ObjType.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ObjType.Location = New System.Drawing.Point(140, 524)
        Me.Label_ObjType.Name = "Label_ObjType"
        Me.Label_ObjType.Size = New System.Drawing.Size(133, 19)
        Me.Label_ObjType.TabIndex = 5
        Me.Label_ObjType.Text = "オブジェクト番号:"
        '
        'Label_ObjX
        '
        Me.Label_ObjX.AutoSize = True
        Me.Label_ObjX.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ObjX.Location = New System.Drawing.Point(211, 543)
        Me.Label_ObjX.Name = "Label_ObjX"
        Me.Label_ObjX.Size = New System.Drawing.Size(62, 19)
        Me.Label_ObjX.TabIndex = 5
        Me.Label_ObjX.Text = "X座標:"
        '
        'Label_ObjY
        '
        Me.Label_ObjY.AutoSize = True
        Me.Label_ObjY.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ObjY.Location = New System.Drawing.Point(211, 562)
        Me.Label_ObjY.Name = "Label_ObjY"
        Me.Label_ObjY.Size = New System.Drawing.Size(62, 19)
        Me.Label_ObjY.TabIndex = 5
        Me.Label_ObjY.Text = "Y座標:"
        '
        'TextBoxObjType
        '
        Me.TextBoxObjType.Location = New System.Drawing.Point(279, 524)
        Me.TextBoxObjType.Name = "TextBoxObjType"
        Me.TextBoxObjType.Size = New System.Drawing.Size(69, 19)
        Me.TextBoxObjType.TabIndex = 8
        '
        'TextBoxObjX
        '
        Me.TextBoxObjX.Location = New System.Drawing.Point(279, 543)
        Me.TextBoxObjX.Name = "TextBoxObjX"
        Me.TextBoxObjX.Size = New System.Drawing.Size(69, 19)
        Me.TextBoxObjX.TabIndex = 8
        '
        'TextBoxObjY
        '
        Me.TextBoxObjY.Location = New System.Drawing.Point(279, 562)
        Me.TextBoxObjY.Name = "TextBoxObjY"
        Me.TextBoxObjY.Size = New System.Drawing.Size(69, 19)
        Me.TextBoxObjY.TabIndex = 8
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(556, 773)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Controls.Add(Me.TabControl1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "Form1"
        Me.Text = "Form1"
        CType(Me.scr, System.ComponentModel.ISupportInitialize).EndInit()
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.TabControl1.ResumeLayout(False)
        Me.tmap.ResumeLayout(False)
        Me.tmap.PerformLayout()
        CType(Me.pmapSelect, System.ComponentModel.ISupportInitialize).EndInit()
        Me.tchip.ResumeLayout(False)
        Me.tchip.PerformLayout()
        CType(Me.ppalette32, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p3216focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p32focus_attr, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p32focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p32, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ttile.ResumeLayout(False)
        Me.ttile.PerformLayout()
        CType(Me.ppalette, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.pgraphs, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p8focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p16focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ptile, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents scr As System.Windows.Forms.PictureBox
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents Menu_File As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Menu_Open As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Menu_Exit As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TabControl1 As System.Windows.Forms.TabControl
    Friend WithEvents tchip As System.Windows.Forms.TabPage
    Friend WithEvents tmap As System.Windows.Forms.TabPage
    Friend WithEvents p32 As System.Windows.Forms.PictureBox
    Friend WithEvents ttile As System.Windows.Forms.TabPage
    Friend WithEvents ptile As System.Windows.Forms.PictureBox
    Friend WithEvents p32focus As System.Windows.Forms.PictureBox
    Friend WithEvents pmapSelect As System.Windows.Forms.PictureBox
    Friend WithEvents p16focus As System.Windows.Forms.PictureBox
    Friend WithEvents p3216focus As System.Windows.Forms.PictureBox
    Friend WithEvents Label_32Chip2 As System.Windows.Forms.Label
    Friend WithEvents Label_32Chip1 As System.Windows.Forms.Label
    Friend WithEvents Label_16Chip2 As System.Windows.Forms.Label
    Friend WithEvents Label_16Chip1 As System.Windows.Forms.Label
    Friend WithEvents ButtonMapDown As System.Windows.Forms.Button
    Friend WithEvents ButtonMapRight As System.Windows.Forms.Button
    Friend WithEvents ButtonMapUp As System.Windows.Forms.Button
    Friend WithEvents ButtonMapLeft As System.Windows.Forms.Button
    Friend WithEvents pgraphs As System.Windows.Forms.PictureBox
    Friend WithEvents p8focus As System.Windows.Forms.PictureBox
    Friend WithEvents Label_8Graph As System.Windows.Forms.Label
    Friend WithEvents ppalette As System.Windows.Forms.PictureBox
    Friend WithEvents ppalette32 As System.Windows.Forms.PictureBox
    Friend WithEvents p32focus_attr As System.Windows.Forms.PictureBox
    Friend WithEvents ComboBox_attr As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Menu_ShowAll As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Menu_ShowPartial As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Radio_EditEnemies As System.Windows.Forms.RadioButton
    Friend WithEvents Radio_EditTerrain As System.Windows.Forms.RadioButton
    Friend WithEvents TextBoxObjY As System.Windows.Forms.TextBox
    Friend WithEvents TextBoxObjX As System.Windows.Forms.TextBox
    Friend WithEvents TextBoxObjType As System.Windows.Forms.TextBox
    Friend WithEvents Label_ObjY As System.Windows.Forms.Label
    Friend WithEvents Label_ObjX As System.Windows.Forms.Label
    Friend WithEvents Label_ObjType As System.Windows.Forms.Label

End Class
