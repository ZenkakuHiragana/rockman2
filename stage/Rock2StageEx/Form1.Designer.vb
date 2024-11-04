<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'フォームがコンポーネントの一覧をクリーンアップするために dispose をオーバーライドします。
    <System.Diagnostics.DebuggerNonUserCode()>
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
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Me.scr = New System.Windows.Forms.PictureBox()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.Menu_File = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_Open = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_Save = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_Exit = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_ShowAll = New System.Windows.Forms.ToolStripMenuItem()
        Me.Menu_ShowPartial = New System.Windows.Forms.ToolStripMenuItem()
        Me.UndoToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.WilyToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.tmap = New System.Windows.Forms.TabPage()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Radio_IsEnemy = New System.Windows.Forms.RadioButton()
        Me.Radio_IsItem = New System.Windows.Forms.RadioButton()
        Me.TextBoxScreenNum = New System.Windows.Forms.TextBox()
        Me.TextBoxObjY = New System.Windows.Forms.TextBox()
        Me.TextBoxObjX = New System.Windows.Forms.TextBox()
        Me.TextBoxObjType = New System.Windows.Forms.TextBox()
        Me.Radio_EditEnemies = New System.Windows.Forms.RadioButton()
        Me.Radio_EditTerrain = New System.Windows.Forms.RadioButton()
        Me.ButtonMapDown = New System.Windows.Forms.Button()
        Me.ButtonMapRight = New System.Windows.Forms.Button()
        Me.ButtonMapUp = New System.Windows.Forms.Button()
        Me.ButtonMapLeft = New System.Windows.Forms.Button()
        Me.LabelViewOrigin = New System.Windows.Forms.Label()
        Me.Label_ScreenNum = New System.Windows.Forms.Label()
        Me.Label_ObjY = New System.Windows.Forms.Label()
        Me.Label_ObjX = New System.Windows.Forms.Label()
        Me.Label_ObjType = New System.Windows.Forms.Label()
        Me.Label_32Chip1 = New System.Windows.Forms.Label()
        Me.pmapSelect = New System.Windows.Forms.PictureBox()
        Me.tchip = New System.Windows.Forms.TabPage()
        Me.Button32Info = New System.Windows.Forms.Button()
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
        Me.ButtonTileInfo = New System.Windows.Forms.Button()
        Me.Label_8Graph = New System.Windows.Forms.Label()
        Me.Label_16Chip1 = New System.Windows.Forms.Label()
        Me.ppalette = New System.Windows.Forms.PictureBox()
        Me.pgraphs = New System.Windows.Forms.PictureBox()
        Me.p8focus = New System.Windows.Forms.PictureBox()
        Me.p16focus = New System.Windows.Forms.PictureBox()
        Me.ptile = New System.Windows.Forms.PictureBox()
        Me.tpal = New System.Windows.Forms.TabPage()
        Me.PaletteGridView = New System.Windows.Forms.DataGridView()
        Me.Column0 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column5 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column6 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column8 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Column9 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ColumnA = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ColumnB = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ColumnC = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ColumnD = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ColumnE = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ColumnF = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.BottomToolStripPanel = New System.Windows.Forms.ToolStripPanel()
        Me.TopToolStripPanel = New System.Windows.Forms.ToolStripPanel()
        Me.RightToolStripPanel = New System.Windows.Forms.ToolStripPanel()
        Me.LeftToolStripPanel = New System.Windows.Forms.ToolStripPanel()
        Me.ContentPanel = New System.Windows.Forms.ToolStripContentPanel()
        Me.ContextMenuStripObj = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.CreateObjectToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DeleteObjectToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ChangeScreenNumberToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.bg_chipinfo = New System.ComponentModel.BackgroundWorker()
        Me.bg_tileinfo = New System.ComponentModel.BackgroundWorker()
        CType(Me.scr, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.MenuStrip1.SuspendLayout()
        Me.TabControl1.SuspendLayout()
        Me.tmap.SuspendLayout()
        Me.Panel1.SuspendLayout()
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
        Me.tpal.SuspendLayout()
        CType(Me.PaletteGridView, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ContextMenuStripObj.SuspendLayout()
        Me.SuspendLayout()
        '
        'scr
        '
        Me.scr.BackColor = System.Drawing.SystemColors.Window
        Me.scr.Location = New System.Drawing.Point(6, 6)
        Me.scr.Name = "scr"
        Me.scr.Size = New System.Drawing.Size(512, 512)
        Me.scr.TabIndex = 0
        Me.scr.TabStop = False
        '
        'MenuStrip1
        '
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.Menu_File, Me.Menu_ShowAll, Me.Menu_ShowPartial, Me.UndoToolStripMenuItem, Me.WilyToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(556, 24)
        Me.MenuStrip1.TabIndex = 1
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'Menu_File
        '
        Me.Menu_File.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.Menu_Open, Me.Menu_Save, Me.Menu_Exit})
        Me.Menu_File.Name = "Menu_File"
        Me.Menu_File.Size = New System.Drawing.Size(67, 20)
        Me.Menu_File.Text = "ファイル(&F)"
        '
        'Menu_Open
        '
        Me.Menu_Open.Name = "Menu_Open"
        Me.Menu_Open.Size = New System.Drawing.Size(180, 22)
        Me.Menu_Open.Text = "開く(&O)"
        '
        'Menu_Save
        '
        Me.Menu_Save.Name = "Menu_Save"
        Me.Menu_Save.Size = New System.Drawing.Size(180, 22)
        Me.Menu_Save.Text = "保存(&S)"
        '
        'Menu_Exit
        '
        Me.Menu_Exit.Name = "Menu_Exit"
        Me.Menu_Exit.Size = New System.Drawing.Size(180, 22)
        Me.Menu_Exit.Text = "終了(&X)"
        '
        'Menu_ShowAll
        '
        Me.Menu_ShowAll.Name = "Menu_ShowAll"
        Me.Menu_ShowAll.Size = New System.Drawing.Size(67, 20)
        Me.Menu_ShowAll.Text = "全部表示"
        '
        'Menu_ShowPartial
        '
        Me.Menu_ShowPartial.Name = "Menu_ShowPartial"
        Me.Menu_ShowPartial.Size = New System.Drawing.Size(67, 20)
        Me.Menu_ShowPartial.Text = "部分表示"
        '
        'UndoToolStripMenuItem
        '
        Me.UndoToolStripMenuItem.Enabled = False
        Me.UndoToolStripMenuItem.Name = "UndoToolStripMenuItem"
        Me.UndoToolStripMenuItem.Size = New System.Drawing.Size(62, 20)
        Me.UndoToolStripMenuItem.Text = "元に戻す"
        '
        'WilyToolStripMenuItem
        '
        Me.WilyToolStripMenuItem.BackColor = System.Drawing.SystemColors.Control
        Me.WilyToolStripMenuItem.Name = "WilyToolStripMenuItem"
        Me.WilyToolStripMenuItem.Size = New System.Drawing.Size(77, 20)
        Me.WilyToolStripMenuItem.Text = "ワイリー！！"
        '
        'TabControl1
        '
        Me.TabControl1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.TabControl1.Controls.Add(Me.tmap)
        Me.TabControl1.Controls.Add(Me.tchip)
        Me.TabControl1.Controls.Add(Me.ttile)
        Me.TabControl1.Controls.Add(Me.tpal)
        Me.TabControl1.Location = New System.Drawing.Point(12, 29)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(532, 732)
        Me.TabControl1.TabIndex = 2
        '
        'tmap
        '
        Me.tmap.Controls.Add(Me.Panel1)
        Me.tmap.Controls.Add(Me.TextBoxScreenNum)
        Me.tmap.Controls.Add(Me.TextBoxObjY)
        Me.tmap.Controls.Add(Me.TextBoxObjX)
        Me.tmap.Controls.Add(Me.TextBoxObjType)
        Me.tmap.Controls.Add(Me.Radio_EditEnemies)
        Me.tmap.Controls.Add(Me.Radio_EditTerrain)
        Me.tmap.Controls.Add(Me.ButtonMapDown)
        Me.tmap.Controls.Add(Me.ButtonMapRight)
        Me.tmap.Controls.Add(Me.ButtonMapUp)
        Me.tmap.Controls.Add(Me.ButtonMapLeft)
        Me.tmap.Controls.Add(Me.LabelViewOrigin)
        Me.tmap.Controls.Add(Me.Label_ScreenNum)
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
        'Panel1
        '
        Me.Panel1.Controls.Add(Me.Radio_IsEnemy)
        Me.Panel1.Controls.Add(Me.Radio_IsItem)
        Me.Panel1.Location = New System.Drawing.Point(297, 553)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(81, 52)
        Me.Panel1.TabIndex = 8
        '
        'Radio_IsEnemy
        '
        Me.Radio_IsEnemy.AutoSize = True
        Me.Radio_IsEnemy.Checked = True
        Me.Radio_IsEnemy.Font = New System.Drawing.Font("MS UI Gothic", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Radio_IsEnemy.Location = New System.Drawing.Point(3, 3)
        Me.Radio_IsEnemy.Name = "Radio_IsEnemy"
        Me.Radio_IsEnemy.Size = New System.Drawing.Size(41, 20)
        Me.Radio_IsEnemy.TabIndex = 9
        Me.Radio_IsEnemy.TabStop = True
        Me.Radio_IsEnemy.Text = "敵"
        Me.Radio_IsEnemy.UseVisualStyleBackColor = True
        '
        'Radio_IsItem
        '
        Me.Radio_IsItem.AutoSize = True
        Me.Radio_IsItem.Font = New System.Drawing.Font("MS UI Gothic", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Radio_IsItem.Location = New System.Drawing.Point(3, 29)
        Me.Radio_IsItem.Name = "Radio_IsItem"
        Me.Radio_IsItem.Size = New System.Drawing.Size(74, 20)
        Me.Radio_IsItem.TabIndex = 10
        Me.Radio_IsItem.Text = "アイテム"
        Me.Radio_IsItem.UseVisualStyleBackColor = True
        '
        'TextBoxScreenNum
        '
        Me.TextBoxScreenNum.Font = New System.Drawing.Font("MS UI Gothic", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.TextBoxScreenNum.Location = New System.Drawing.Point(241, 556)
        Me.TextBoxScreenNum.MaxLength = 2
        Me.TextBoxScreenNum.Name = "TextBoxScreenNum"
        Me.TextBoxScreenNum.ShortcutsEnabled = False
        Me.TextBoxScreenNum.Size = New System.Drawing.Size(46, 22)
        Me.TextBoxScreenNum.TabIndex = 7
        Me.TextBoxScreenNum.Visible = False
        '
        'TextBoxObjY
        '
        Me.TextBoxObjY.Font = New System.Drawing.Font("MS UI Gothic", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.TextBoxObjY.Location = New System.Drawing.Point(432, 583)
        Me.TextBoxObjY.MaxLength = 2
        Me.TextBoxObjY.Name = "TextBoxObjY"
        Me.TextBoxObjY.ShortcutsEnabled = False
        Me.TextBoxObjY.Size = New System.Drawing.Size(69, 22)
        Me.TextBoxObjY.TabIndex = 7
        '
        'TextBoxObjX
        '
        Me.TextBoxObjX.Font = New System.Drawing.Font("MS UI Gothic", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.TextBoxObjX.Location = New System.Drawing.Point(432, 556)
        Me.TextBoxObjX.MaxLength = 2
        Me.TextBoxObjX.Name = "TextBoxObjX"
        Me.TextBoxObjX.ShortcutsEnabled = False
        Me.TextBoxObjX.Size = New System.Drawing.Size(69, 22)
        Me.TextBoxObjX.TabIndex = 6
        '
        'TextBoxObjType
        '
        Me.TextBoxObjType.Font = New System.Drawing.Font("MS UI Gothic", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.TextBoxObjType.Location = New System.Drawing.Point(432, 527)
        Me.TextBoxObjType.MaxLength = 2
        Me.TextBoxObjType.Name = "TextBoxObjType"
        Me.TextBoxObjType.ShortcutsEnabled = False
        Me.TextBoxObjType.Size = New System.Drawing.Size(69, 22)
        Me.TextBoxObjType.TabIndex = 5
        '
        'Radio_EditEnemies
        '
        Me.Radio_EditEnemies.AutoSize = True
        Me.Radio_EditEnemies.Font = New System.Drawing.Font("MS UI Gothic", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Radio_EditEnemies.Location = New System.Drawing.Point(76, 684)
        Me.Radio_EditEnemies.Name = "Radio_EditEnemies"
        Me.Radio_EditEnemies.Size = New System.Drawing.Size(126, 20)
        Me.Radio_EditEnemies.TabIndex = 4
        Me.Radio_EditEnemies.Text = "オブジェクト配置"
        Me.Radio_EditEnemies.UseVisualStyleBackColor = True
        '
        'Radio_EditTerrain
        '
        Me.Radio_EditTerrain.AutoSize = True
        Me.Radio_EditTerrain.Checked = True
        Me.Radio_EditTerrain.Font = New System.Drawing.Font("MS UI Gothic", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Radio_EditTerrain.Location = New System.Drawing.Point(76, 658)
        Me.Radio_EditTerrain.Name = "Radio_EditTerrain"
        Me.Radio_EditTerrain.Size = New System.Drawing.Size(57, 20)
        Me.Radio_EditTerrain.TabIndex = 3
        Me.Radio_EditTerrain.TabStop = True
        Me.Radio_EditTerrain.Text = "地形"
        Me.Radio_EditTerrain.UseVisualStyleBackColor = True
        '
        'ButtonMapDown
        '
        Me.ButtonMapDown.Location = New System.Drawing.Point(432, 660)
        Me.ButtonMapDown.Name = "ButtonMapDown"
        Me.ButtonMapDown.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapDown.TabIndex = 13
        Me.ButtonMapDown.Text = "↓"
        Me.ButtonMapDown.UseVisualStyleBackColor = True
        '
        'ButtonMapRight
        '
        Me.ButtonMapRight.Location = New System.Drawing.Point(478, 660)
        Me.ButtonMapRight.Name = "ButtonMapRight"
        Me.ButtonMapRight.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapRight.TabIndex = 14
        Me.ButtonMapRight.Text = "→"
        Me.ButtonMapRight.UseVisualStyleBackColor = True
        '
        'ButtonMapUp
        '
        Me.ButtonMapUp.Location = New System.Drawing.Point(432, 614)
        Me.ButtonMapUp.Name = "ButtonMapUp"
        Me.ButtonMapUp.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapUp.TabIndex = 11
        Me.ButtonMapUp.Text = "↑"
        Me.ButtonMapUp.UseVisualStyleBackColor = True
        '
        'ButtonMapLeft
        '
        Me.ButtonMapLeft.Location = New System.Drawing.Point(386, 660)
        Me.ButtonMapLeft.Name = "ButtonMapLeft"
        Me.ButtonMapLeft.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapLeft.TabIndex = 12
        Me.ButtonMapLeft.Text = "←"
        Me.ButtonMapLeft.UseVisualStyleBackColor = True
        '
        'LabelViewOrigin
        '
        Me.LabelViewOrigin.AutoSize = True
        Me.LabelViewOrigin.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.LabelViewOrigin.Location = New System.Drawing.Point(140, 527)
        Me.LabelViewOrigin.Name = "LabelViewOrigin"
        Me.LabelViewOrigin.Size = New System.Drawing.Size(95, 19)
        Me.LabelViewOrigin.TabIndex = 7
        Me.LabelViewOrigin.Text = "画面位置: "
        '
        'Label_ScreenNum
        '
        Me.Label_ScreenNum.AutoSize = True
        Me.Label_ScreenNum.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ScreenNum.Location = New System.Drawing.Point(140, 556)
        Me.Label_ScreenNum.Name = "Label_ScreenNum"
        Me.Label_ScreenNum.Size = New System.Drawing.Size(95, 19)
        Me.Label_ScreenNum.TabIndex = 7
        Me.Label_ScreenNum.Text = "画面番号: "
        Me.Label_ScreenNum.Visible = False
        '
        'Label_ObjY
        '
        Me.Label_ObjY.AutoSize = True
        Me.Label_ObjY.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ObjY.Location = New System.Drawing.Point(402, 583)
        Me.Label_ObjY.Name = "Label_ObjY"
        Me.Label_ObjY.Size = New System.Drawing.Size(24, 19)
        Me.Label_ObjY.TabIndex = 7
        Me.Label_ObjY.Text = "Y:"
        '
        'Label_ObjX
        '
        Me.Label_ObjX.AutoSize = True
        Me.Label_ObjX.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ObjX.Location = New System.Drawing.Point(402, 556)
        Me.Label_ObjX.Name = "Label_ObjX"
        Me.Label_ObjX.Size = New System.Drawing.Size(24, 19)
        Me.Label_ObjX.TabIndex = 6
        Me.Label_ObjX.Text = "X:"
        '
        'Label_ObjType
        '
        Me.Label_ObjType.AutoSize = True
        Me.Label_ObjType.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_ObjType.Location = New System.Drawing.Point(293, 527)
        Me.Label_ObjType.Name = "Label_ObjType"
        Me.Label_ObjType.Size = New System.Drawing.Size(133, 19)
        Me.Label_ObjType.TabIndex = 5
        Me.Label_ObjType.Text = "オブジェクト番号:"
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
        Me.pmapSelect.Location = New System.Drawing.Point(6, 524)
        Me.pmapSelect.Name = "pmapSelect"
        Me.pmapSelect.Size = New System.Drawing.Size(128, 128)
        Me.pmapSelect.TabIndex = 3
        Me.pmapSelect.TabStop = False
        '
        'tchip
        '
        Me.tchip.Controls.Add(Me.Button32Info)
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
        'Button32Info
        '
        Me.Button32Info.AutoSize = True
        Me.Button32Info.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Button32Info.Location = New System.Drawing.Point(406, 623)
        Me.Button32Info.Name = "Button32Info"
        Me.Button32Info.Size = New System.Drawing.Size(112, 29)
        Me.Button32Info.TabIndex = 16
        Me.Button32Info.Text = "タイル情報..."
        Me.Button32Info.UseVisualStyleBackColor = True
        '
        'ComboBox_attr
        '
        Me.ComboBox_attr.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ComboBox_attr.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.ComboBox_attr.FormattingEnabled = True
        Me.ComboBox_attr.Items.AddRange(New Object() {"0: 背景", "1: 水中", "2: ハシゴ", "3: ", "4: ", "5: ", "6: ", "7: ", "8: 壁", "9: トゲ", "A: コンベア(左)", "B: コンベア(右)", "C: 氷", "D: 一方通行(上)", "E: 一方通行(下)", "F: シャッター"})
        Me.ComboBox_attr.Location = New System.Drawing.Point(274, 625)
        Me.ComboBox_attr.Name = "ComboBox_attr"
        Me.ComboBox_attr.Size = New System.Drawing.Size(121, 27)
        Me.ComboBox_attr.TabIndex = 15
        '
        'ppalette32
        '
        Me.ppalette32.BackColor = System.Drawing.SystemColors.Window
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
        Me.Label_16Chip2.TabIndex = 15
        Me.Label_16Chip2.Text = "No: 00"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label1.Location = New System.Drawing.Point(274, 603)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(85, 19)
        Me.Label1.TabIndex = 15
        Me.Label1.Text = "地形判定"
        '
        'Label_32Chip2
        '
        Me.Label_32Chip2.AutoSize = True
        Me.Label_32Chip2.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_32Chip2.Location = New System.Drawing.Point(274, 524)
        Me.Label_32Chip2.Name = "Label_32Chip2"
        Me.Label_32Chip2.Size = New System.Drawing.Size(61, 19)
        Me.Label_32Chip2.TabIndex = 15
        Me.Label_32Chip2.Text = "No: 00"
        '
        'p3216focus
        '
        Me.p3216focus.BackColor = System.Drawing.SystemColors.Window
        Me.p3216focus.Location = New System.Drawing.Point(454, 524)
        Me.p3216focus.Name = "p3216focus"
        Me.p3216focus.Size = New System.Drawing.Size(64, 64)
        Me.p3216focus.TabIndex = 3
        Me.p3216focus.TabStop = False
        '
        'p32focus_attr
        '
        Me.p32focus_attr.BackColor = System.Drawing.SystemColors.Window
        Me.p32focus_attr.Location = New System.Drawing.Point(140, 524)
        Me.p32focus_attr.Name = "p32focus_attr"
        Me.p32focus_attr.Size = New System.Drawing.Size(128, 128)
        Me.p32focus_attr.TabIndex = 3
        Me.p32focus_attr.TabStop = False
        '
        'p32focus
        '
        Me.p32focus.BackColor = System.Drawing.SystemColors.Window
        Me.p32focus.Location = New System.Drawing.Point(6, 524)
        Me.p32focus.Name = "p32focus"
        Me.p32focus.Size = New System.Drawing.Size(128, 128)
        Me.p32focus.TabIndex = 3
        Me.p32focus.TabStop = False
        '
        'p32
        '
        Me.p32.BackColor = System.Drawing.SystemColors.Window
        Me.p32.Location = New System.Drawing.Point(6, 6)
        Me.p32.Name = "p32"
        Me.p32.Size = New System.Drawing.Size(512, 512)
        Me.p32.TabIndex = 1
        Me.p32.TabStop = False
        '
        'ttile
        '
        Me.ttile.Controls.Add(Me.ButtonTileInfo)
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
        'ButtonTileInfo
        '
        Me.ButtonTileInfo.AutoSize = True
        Me.ButtonTileInfo.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.ButtonTileInfo.Location = New System.Drawing.Point(406, 530)
        Me.ButtonTileInfo.Name = "ButtonTileInfo"
        Me.ButtonTileInfo.Size = New System.Drawing.Size(112, 29)
        Me.ButtonTileInfo.TabIndex = 17
        Me.ButtonTileInfo.Text = "タイル情報..."
        Me.ButtonTileInfo.UseVisualStyleBackColor = True
        '
        'Label_8Graph
        '
        Me.Label_8Graph.AutoSize = True
        Me.Label_8Graph.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_8Graph.Location = New System.Drawing.Point(195, 335)
        Me.Label_8Graph.Name = "Label_8Graph"
        Me.Label_8Graph.Size = New System.Drawing.Size(61, 19)
        Me.Label_8Graph.TabIndex = 16
        Me.Label_8Graph.Text = "No: 00"
        '
        'Label_16Chip1
        '
        Me.Label_16Chip1.AutoSize = True
        Me.Label_16Chip1.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_16Chip1.Location = New System.Drawing.Point(6, 399)
        Me.Label_16Chip1.Name = "Label_16Chip1"
        Me.Label_16Chip1.Size = New System.Drawing.Size(61, 19)
        Me.Label_16Chip1.TabIndex = 16
        Me.Label_16Chip1.Text = "No: 00"
        '
        'ppalette
        '
        Me.ppalette.BackColor = System.Drawing.SystemColors.Window
        Me.ppalette.Location = New System.Drawing.Point(6, 668)
        Me.ppalette.Name = "ppalette"
        Me.ppalette.Size = New System.Drawing.Size(512, 32)
        Me.ppalette.TabIndex = 2
        Me.ppalette.TabStop = False
        '
        'pgraphs
        '
        Me.pgraphs.BackColor = System.Drawing.SystemColors.Window
        Me.pgraphs.Location = New System.Drawing.Point(262, 268)
        Me.pgraphs.Name = "pgraphs"
        Me.pgraphs.Size = New System.Drawing.Size(256, 256)
        Me.pgraphs.TabIndex = 2
        Me.pgraphs.TabStop = False
        '
        'p8focus
        '
        Me.p8focus.BackColor = System.Drawing.SystemColors.Window
        Me.p8focus.Location = New System.Drawing.Point(192, 268)
        Me.p8focus.Name = "p8focus"
        Me.p8focus.Size = New System.Drawing.Size(64, 64)
        Me.p8focus.TabIndex = 2
        Me.p8focus.TabStop = False
        '
        'p16focus
        '
        Me.p16focus.BackColor = System.Drawing.SystemColors.Window
        Me.p16focus.Location = New System.Drawing.Point(6, 268)
        Me.p16focus.Name = "p16focus"
        Me.p16focus.Size = New System.Drawing.Size(128, 128)
        Me.p16focus.TabIndex = 2
        Me.p16focus.TabStop = False
        '
        'ptile
        '
        Me.ptile.BackColor = System.Drawing.SystemColors.Window
        Me.ptile.Location = New System.Drawing.Point(6, 6)
        Me.ptile.Name = "ptile"
        Me.ptile.Size = New System.Drawing.Size(512, 256)
        Me.ptile.TabIndex = 2
        Me.ptile.TabStop = False
        '
        'tpal
        '
        Me.tpal.Controls.Add(Me.PaletteGridView)
        Me.tpal.Location = New System.Drawing.Point(4, 22)
        Me.tpal.Name = "tpal"
        Me.tpal.Size = New System.Drawing.Size(524, 706)
        Me.tpal.TabIndex = 3
        Me.tpal.Text = "パレット"
        Me.tpal.UseVisualStyleBackColor = True
        '
        'PaletteGridView
        '
        Me.PaletteGridView.AllowUserToAddRows = False
        Me.PaletteGridView.AllowUserToDeleteRows = False
        Me.PaletteGridView.AllowUserToResizeColumns = False
        Me.PaletteGridView.AllowUserToResizeRows = False
        Me.PaletteGridView.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.PaletteGridView.ClipboardCopyMode = System.Windows.Forms.DataGridViewClipboardCopyMode.EnableWithoutHeaderText
        Me.PaletteGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.PaletteGridView.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Column0, Me.Column1, Me.Column2, Me.Column3, Me.Column4, Me.Column5, Me.Column6, Me.Column7, Me.Column8, Me.Column9, Me.ColumnA, Me.ColumnB, Me.ColumnC, Me.ColumnD, Me.ColumnE, Me.ColumnF})
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Window
        DataGridViewCellStyle1.Font = New System.Drawing.Font("MS UI Gothic", 12.5!)
        DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.ControlText
        DataGridViewCellStyle1.NullValue = Nothing
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.PaletteGridView.DefaultCellStyle = DataGridViewCellStyle1
        Me.PaletteGridView.ImeMode = System.Windows.Forms.ImeMode.Off
        Me.PaletteGridView.Location = New System.Drawing.Point(3, 3)
        Me.PaletteGridView.Name = "PaletteGridView"
        Me.PaletteGridView.RowHeadersVisible = False
        Me.PaletteGridView.RowTemplate.Height = 28
        Me.PaletteGridView.Size = New System.Drawing.Size(518, 409)
        Me.PaletteGridView.TabIndex = 4
        '
        'Column0
        '
        Me.Column0.HeaderText = "0"
        Me.Column0.Name = "Column0"
        '
        'Column1
        '
        Me.Column1.HeaderText = "1"
        Me.Column1.Name = "Column1"
        '
        'Column2
        '
        Me.Column2.HeaderText = "2"
        Me.Column2.Name = "Column2"
        '
        'Column3
        '
        Me.Column3.HeaderText = "3"
        Me.Column3.Name = "Column3"
        '
        'Column4
        '
        Me.Column4.HeaderText = "4"
        Me.Column4.Name = "Column4"
        '
        'Column5
        '
        Me.Column5.HeaderText = "5"
        Me.Column5.Name = "Column5"
        '
        'Column6
        '
        Me.Column6.HeaderText = "6"
        Me.Column6.Name = "Column6"
        '
        'Column7
        '
        Me.Column7.HeaderText = "7"
        Me.Column7.Name = "Column7"
        '
        'Column8
        '
        Me.Column8.HeaderText = "8"
        Me.Column8.Name = "Column8"
        '
        'Column9
        '
        Me.Column9.HeaderText = "9"
        Me.Column9.Name = "Column9"
        '
        'ColumnA
        '
        Me.ColumnA.HeaderText = "A"
        Me.ColumnA.Name = "ColumnA"
        '
        'ColumnB
        '
        Me.ColumnB.HeaderText = "B"
        Me.ColumnB.Name = "ColumnB"
        '
        'ColumnC
        '
        Me.ColumnC.HeaderText = "C"
        Me.ColumnC.Name = "ColumnC"
        '
        'ColumnD
        '
        Me.ColumnD.HeaderText = "D"
        Me.ColumnD.Name = "ColumnD"
        '
        'ColumnE
        '
        Me.ColumnE.HeaderText = "E"
        Me.ColumnE.Name = "ColumnE"
        '
        'ColumnF
        '
        Me.ColumnF.HeaderText = "F"
        Me.ColumnF.Name = "ColumnF"
        '
        'BottomToolStripPanel
        '
        Me.BottomToolStripPanel.Location = New System.Drawing.Point(0, 0)
        Me.BottomToolStripPanel.Name = "BottomToolStripPanel"
        Me.BottomToolStripPanel.Orientation = System.Windows.Forms.Orientation.Horizontal
        Me.BottomToolStripPanel.RowMargin = New System.Windows.Forms.Padding(3, 0, 0, 0)
        Me.BottomToolStripPanel.Size = New System.Drawing.Size(0, 0)
        '
        'TopToolStripPanel
        '
        Me.TopToolStripPanel.Location = New System.Drawing.Point(0, 0)
        Me.TopToolStripPanel.Name = "TopToolStripPanel"
        Me.TopToolStripPanel.Orientation = System.Windows.Forms.Orientation.Horizontal
        Me.TopToolStripPanel.RowMargin = New System.Windows.Forms.Padding(3, 0, 0, 0)
        Me.TopToolStripPanel.Size = New System.Drawing.Size(0, 0)
        '
        'RightToolStripPanel
        '
        Me.RightToolStripPanel.Location = New System.Drawing.Point(0, 0)
        Me.RightToolStripPanel.Name = "RightToolStripPanel"
        Me.RightToolStripPanel.Orientation = System.Windows.Forms.Orientation.Horizontal
        Me.RightToolStripPanel.RowMargin = New System.Windows.Forms.Padding(3, 0, 0, 0)
        Me.RightToolStripPanel.Size = New System.Drawing.Size(0, 0)
        '
        'LeftToolStripPanel
        '
        Me.LeftToolStripPanel.Location = New System.Drawing.Point(0, 0)
        Me.LeftToolStripPanel.Name = "LeftToolStripPanel"
        Me.LeftToolStripPanel.Orientation = System.Windows.Forms.Orientation.Horizontal
        Me.LeftToolStripPanel.RowMargin = New System.Windows.Forms.Padding(3, 0, 0, 0)
        Me.LeftToolStripPanel.Size = New System.Drawing.Size(0, 0)
        '
        'ContentPanel
        '
        Me.ContentPanel.Size = New System.Drawing.Size(531, 773)
        '
        'ContextMenuStripObj
        '
        Me.ContextMenuStripObj.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.CreateObjectToolStripMenuItem, Me.DeleteObjectToolStripMenuItem, Me.ChangeScreenNumberToolStripMenuItem})
        Me.ContextMenuStripObj.Name = "ContextMenuStrip1"
        Me.ContextMenuStripObj.Size = New System.Drawing.Size(201, 70)
        '
        'CreateObjectToolStripMenuItem
        '
        Me.CreateObjectToolStripMenuItem.Name = "CreateObjectToolStripMenuItem"
        Me.CreateObjectToolStripMenuItem.Size = New System.Drawing.Size(200, 22)
        Me.CreateObjectToolStripMenuItem.Text = "オブジェクトの新規作成"
        '
        'DeleteObjectToolStripMenuItem
        '
        Me.DeleteObjectToolStripMenuItem.Name = "DeleteObjectToolStripMenuItem"
        Me.DeleteObjectToolStripMenuItem.Size = New System.Drawing.Size(200, 22)
        Me.DeleteObjectToolStripMenuItem.Text = "選択したオブジェクトの削除"
        '
        'ChangeScreenNumberToolStripMenuItem
        '
        Me.ChangeScreenNumberToolStripMenuItem.Name = "ChangeScreenNumberToolStripMenuItem"
        Me.ChangeScreenNumberToolStripMenuItem.Size = New System.Drawing.Size(200, 22)
        Me.ChangeScreenNumberToolStripMenuItem.Text = "画面番号の変更"
        '
        'bg_chipinfo
        '
        '
        'bg_tileinfo
        '
        '
        'Form1
        '
        Me.AllowDrop = True
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
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
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
        Me.tpal.ResumeLayout(False)
        CType(Me.PaletteGridView, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ContextMenuStripObj.ResumeLayout(False)
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
    Friend WithEvents BottomToolStripPanel As System.Windows.Forms.ToolStripPanel
    Friend WithEvents TopToolStripPanel As System.Windows.Forms.ToolStripPanel
    Friend WithEvents RightToolStripPanel As System.Windows.Forms.ToolStripPanel
    Friend WithEvents LeftToolStripPanel As System.Windows.Forms.ToolStripPanel
    Friend WithEvents ContentPanel As System.Windows.Forms.ToolStripContentPanel
    Friend WithEvents Radio_IsItem As System.Windows.Forms.RadioButton
    Friend WithEvents Radio_IsEnemy As System.Windows.Forms.RadioButton
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents ContextMenuStripObj As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents CreateObjectToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents DeleteObjectToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TextBoxScreenNum As System.Windows.Forms.TextBox
    Friend WithEvents Label_ScreenNum As System.Windows.Forms.Label
    Friend WithEvents ChangeScreenNumberToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Button32Info As System.Windows.Forms.Button
    Friend WithEvents bg_chipinfo As System.ComponentModel.BackgroundWorker
    Friend WithEvents bg_tileinfo As System.ComponentModel.BackgroundWorker
    Friend WithEvents ButtonTileInfo As System.Windows.Forms.Button
    Friend WithEvents Menu_Save As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents LabelViewOrigin As System.Windows.Forms.Label
    Friend WithEvents UndoToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents WilyToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents tpal As TabPage
    Friend WithEvents PaletteGridView As DataGridView
    Friend WithEvents Column0 As DataGridViewTextBoxColumn
    Friend WithEvents Column1 As DataGridViewTextBoxColumn
    Friend WithEvents Column2 As DataGridViewTextBoxColumn
    Friend WithEvents Column3 As DataGridViewTextBoxColumn
    Friend WithEvents Column4 As DataGridViewTextBoxColumn
    Friend WithEvents Column5 As DataGridViewTextBoxColumn
    Friend WithEvents Column6 As DataGridViewTextBoxColumn
    Friend WithEvents Column7 As DataGridViewTextBoxColumn
    Friend WithEvents Column8 As DataGridViewTextBoxColumn
    Friend WithEvents Column9 As DataGridViewTextBoxColumn
    Friend WithEvents ColumnA As DataGridViewTextBoxColumn
    Friend WithEvents ColumnB As DataGridViewTextBoxColumn
    Friend WithEvents ColumnC As DataGridViewTextBoxColumn
    Friend WithEvents ColumnD As DataGridViewTextBoxColumn
    Friend WithEvents ColumnE As DataGridViewTextBoxColumn
    Friend WithEvents ColumnF As DataGridViewTextBoxColumn
End Class
