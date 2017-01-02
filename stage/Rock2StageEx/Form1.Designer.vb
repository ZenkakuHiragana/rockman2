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
        Me.ファイルFToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.開くOToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.終了XToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.tmap = New System.Windows.Forms.TabPage()
        Me.pmapSelect = New System.Windows.Forms.PictureBox()
        Me.tchip = New System.Windows.Forms.TabPage()
        Me.p3216focus = New System.Windows.Forms.PictureBox()
        Me.p32focus = New System.Windows.Forms.PictureBox()
        Me.p32 = New System.Windows.Forms.PictureBox()
        Me.ttile = New System.Windows.Forms.TabPage()
        Me.p16focus = New System.Windows.Forms.PictureBox()
        Me.ptile = New System.Windows.Forms.PictureBox()
        Me.Label_32Chip2 = New System.Windows.Forms.Label()
        Me.Label_32Chip1 = New System.Windows.Forms.Label()
        Me.Label_16Chip2 = New System.Windows.Forms.Label()
        Me.Label_16Chip1 = New System.Windows.Forms.Label()
        Me.ButtonMapLeft = New System.Windows.Forms.Button()
        Me.ButtonMapRight = New System.Windows.Forms.Button()
        Me.ButtonMapDown = New System.Windows.Forms.Button()
        Me.ButtonMapUp = New System.Windows.Forms.Button()
        Me.pgraphs = New System.Windows.Forms.PictureBox()
        CType(Me.scr, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.MenuStrip1.SuspendLayout()
        Me.TabControl1.SuspendLayout()
        Me.tmap.SuspendLayout()
        CType(Me.pmapSelect, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.tchip.SuspendLayout()
        CType(Me.p3216focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p32focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.p32, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ttile.SuspendLayout()
        CType(Me.p16focus, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ptile, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.pgraphs, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'scr
        '
        Me.scr.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
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
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ファイルFToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(556, 26)
        Me.MenuStrip1.TabIndex = 1
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'ファイルFToolStripMenuItem
        '
        Me.ファイルFToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.開くOToolStripMenuItem, Me.終了XToolStripMenuItem})
        Me.ファイルFToolStripMenuItem.Name = "ファイルFToolStripMenuItem"
        Me.ファイルFToolStripMenuItem.Size = New System.Drawing.Size(85, 22)
        Me.ファイルFToolStripMenuItem.Text = "ファイル(&F)"
        '
        '開くOToolStripMenuItem
        '
        Me.開くOToolStripMenuItem.Name = "開くOToolStripMenuItem"
        Me.開くOToolStripMenuItem.Size = New System.Drawing.Size(119, 22)
        Me.開くOToolStripMenuItem.Text = "開く(&O)"
        '
        '終了XToolStripMenuItem
        '
        Me.終了XToolStripMenuItem.Name = "終了XToolStripMenuItem"
        Me.終了XToolStripMenuItem.Size = New System.Drawing.Size(119, 22)
        Me.終了XToolStripMenuItem.Text = "終了(&X)"
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
        Me.tmap.Controls.Add(Me.ButtonMapDown)
        Me.tmap.Controls.Add(Me.ButtonMapRight)
        Me.tmap.Controls.Add(Me.ButtonMapUp)
        Me.tmap.Controls.Add(Me.ButtonMapLeft)
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
        'pmapSelect
        '
        Me.pmapSelect.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
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
        Me.tchip.Controls.Add(Me.Label_16Chip2)
        Me.tchip.Controls.Add(Me.Label_32Chip2)
        Me.tchip.Controls.Add(Me.p3216focus)
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
        'p3216focus
        '
        Me.p3216focus.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.p3216focus.BackColor = System.Drawing.SystemColors.Window
        Me.p3216focus.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.p3216focus.Location = New System.Drawing.Point(454, 524)
        Me.p3216focus.Name = "p3216focus"
        Me.p3216focus.Size = New System.Drawing.Size(64, 64)
        Me.p3216focus.TabIndex = 3
        Me.p3216focus.TabStop = False
        '
        'p32focus
        '
        Me.p32focus.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
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
        Me.p32.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
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
        Me.ttile.Controls.Add(Me.Label_16Chip1)
        Me.ttile.Controls.Add(Me.pgraphs)
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
        'p16focus
        '
        Me.p16focus.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
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
        Me.ptile.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ptile.BackColor = System.Drawing.SystemColors.Window
        Me.ptile.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.ptile.Location = New System.Drawing.Point(6, 6)
        Me.ptile.Name = "ptile"
        Me.ptile.Size = New System.Drawing.Size(512, 256)
        Me.ptile.TabIndex = 2
        Me.ptile.TabStop = False
        '
        'Label_32Chip2
        '
        Me.Label_32Chip2.AutoSize = True
        Me.Label_32Chip2.Font = New System.Drawing.Font("MS UI Gothic", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(128, Byte))
        Me.Label_32Chip2.Location = New System.Drawing.Point(7, 659)
        Me.Label_32Chip2.Name = "Label_32Chip2"
        Me.Label_32Chip2.Size = New System.Drawing.Size(61, 19)
        Me.Label_32Chip2.TabIndex = 4
        Me.Label_32Chip2.Text = "No: 00"
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
        'ButtonMapLeft
        '
        Me.ButtonMapLeft.Location = New System.Drawing.Point(386, 615)
        Me.ButtonMapLeft.Name = "ButtonMapLeft"
        Me.ButtonMapLeft.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapLeft.TabIndex = 6
        Me.ButtonMapLeft.Text = "←"
        Me.ButtonMapLeft.UseVisualStyleBackColor = True
        '
        'ButtonMapRight
        '
        Me.ButtonMapRight.Location = New System.Drawing.Point(478, 615)
        Me.ButtonMapRight.Name = "ButtonMapRight"
        Me.ButtonMapRight.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapRight.TabIndex = 6
        Me.ButtonMapRight.Text = "→"
        Me.ButtonMapRight.UseVisualStyleBackColor = True
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
        'ButtonMapUp
        '
        Me.ButtonMapUp.Location = New System.Drawing.Point(432, 569)
        Me.ButtonMapUp.Name = "ButtonMapUp"
        Me.ButtonMapUp.Size = New System.Drawing.Size(40, 40)
        Me.ButtonMapUp.TabIndex = 6
        Me.ButtonMapUp.Text = "↑"
        Me.ButtonMapUp.UseVisualStyleBackColor = True
        '
        'pgraphs
        '
        Me.pgraphs.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.pgraphs.BackColor = System.Drawing.SystemColors.Window
        Me.pgraphs.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.pgraphs.Location = New System.Drawing.Point(262, 268)
        Me.pgraphs.Name = "pgraphs"
        Me.pgraphs.Size = New System.Drawing.Size(256, 256)
        Me.pgraphs.TabIndex = 2
        Me.pgraphs.TabStop = False
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
        CType(Me.p3216focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p32focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.p32, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ttile.ResumeLayout(False)
        Me.ttile.PerformLayout()
        CType(Me.p16focus, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ptile, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.pgraphs, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents scr As System.Windows.Forms.PictureBox
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents ファイルFToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents 開くOToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents 終了XToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
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

End Class
