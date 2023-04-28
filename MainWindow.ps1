################################################################################ 
#
#  Name    : E:\dev\emulatest\MainWindow.ps1  
#  Version : 0.1
#  Author  :
#  Date    : 4/28/2023
#
 #  Generated with ConvertForm module version 2.0.0
#  PowerShell version 7.3.4
#
#  Invocation Line   : Convert-Form -Path "E:\dev\emulatest-windows-form\MainWindow.Designer.cs" `

#  Source            : E:\dev\emulatest-windows-form\MainWindow.Designer.cs
################################################################################

function Get-ScriptDirectory
{ #Return the directory name of this script
  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invocation.MyCommand.Path
}

$ScriptPath = Get-ScriptDirectory

# Loading external assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$MainWindow = New-Object System.Windows.Forms.Form

$components = New-Object System.ComponentModel.Container
$splitContainerMain = New-Object System.Windows.Forms.SplitContainer
$splitContainerLeft = New-Object System.Windows.Forms.SplitContainer
$LogGroup = New-Object System.Windows.Forms.GroupBox
$LogText = New-Object System.Windows.Forms.RichTextBox
$PathsGroup = New-Object System.Windows.Forms.GroupBox
$LoadButton = New-Object System.Windows.Forms.Button
$SaveButton = New-Object System.Windows.Forms.Button
$UpdateButton = New-Object System.Windows.Forms.Button
$ScanPathButton = New-Object System.Windows.Forms.Button
$RemovePathButton = New-Object System.Windows.Forms.Button
$AddPathButton = New-Object System.Windows.Forms.Button
$PathsList = New-Object System.Windows.Forms.ListBox
$splitContainerRight = New-Object System.Windows.Forms.SplitContainer
$BucketsGroup = New-Object System.Windows.Forms.GroupBox
$BucketsTable = New-Object System.Windows.Forms.TableLayoutPanel
$BucketsList = New-Object System.Windows.Forms.ListBox
$BucketLogoImage = New-Object System.Windows.Forms.PictureBox
$BucketDescriptionText = New-Object System.Windows.Forms.TextBox
$BucketsLoadedLabel = New-Object System.Windows.Forms.Label
$BucketLogoLabel = New-Object System.Windows.Forms.Label
$BucketsLoadedText = New-Object System.Windows.Forms.Label
$EmulatorsCountLabel = New-Object System.Windows.Forms.Label
$BucketDescriptionLabel = New-Object System.Windows.Forms.Label
$EmulatorsCountText = New-Object System.Windows.Forms.Label
$BucketNameLabel = New-Object System.Windows.Forms.Label
$BucketLicenseLabel = New-Object System.Windows.Forms.Label
$BucketHomeLabel = New-Object System.Windows.Forms.Label
$BucketVersionLabel = New-Object System.Windows.Forms.Label
$BucketVersionText = New-Object System.Windows.Forms.Label
$BucketHomeText = New-Object System.Windows.Forms.Label
$BucketLicenseText = New-Object System.Windows.Forms.Label
$BucketNameText = New-Object System.Windows.Forms.Label
$EmulatorsGroup = New-Object System.Windows.Forms.GroupBox
$EmulatorsTable = New-Object System.Windows.Forms.DataGridView
$Select = New-Object System.Windows.Forms.DataGridViewCheckBoxColumn
$Path = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$Emulator = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$CurrentVersion = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$NewVersion = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$contextMenuStrip1 = New-Object System.Windows.Forms.ContextMenuStrip($components)
#
# splitContainerMain
#
$splitContainerMain.Dock = [System.Windows.Forms.DockStyle]::Fill
$splitContainerMain.Location = New-Object System.Drawing.Point(5, 5)
$splitContainerMain.Name = "splitContainerMain"
#
# splitContainerMain.Panel1
#
$splitContainerMain.Panel1.Controls.Add($splitContainerLeft)
#
# splitContainerMain.Panel2
#
$splitContainerMain.Panel2.Controls.Add($splitContainerRight)
$splitContainerMain.Size = New-Object System.Drawing.Size(1116, 516)
$splitContainerMain.SplitterDistance = 370
$splitContainerMain.TabIndex = 0
#
# splitContainerLeft
#
$splitContainerLeft.Dock = [System.Windows.Forms.DockStyle]::Fill
$splitContainerLeft.Location = New-Object System.Drawing.Point(0, 0)
$splitContainerLeft.Name = "splitContainerLeft"
$splitContainerLeft.Orientation = [System.Windows.Forms.Orientation]::Horizontal
#
# splitContainerLeft.Panel1
#
$splitContainerLeft.Panel1.Controls.Add($LogGroup)
#
# splitContainerLeft.Panel2
#
$splitContainerLeft.Panel2.Controls.Add($PathsGroup)
$splitContainerLeft.Size = New-Object System.Drawing.Size(370, 516)
$splitContainerLeft.SplitterDistance = 239
$splitContainerLeft.TabIndex = 0
#
# LogGroup
#
$LogGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$LogGroup.Controls.Add($LogText)
$LogGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$LogGroup.Location = New-Object System.Drawing.Point(0, 0)
$LogGroup.Name = "LogGroup"
$LogGroup.Size = New-Object System.Drawing.Size(370, 239)
$LogGroup.TabIndex = 3
$LogGroup.TabStop = $false
$LogGroup.Text = "Log"
#
# LogText
#
$LogText.Dock = [System.Windows.Forms.DockStyle]::Fill
$LogText.Location = New-Object System.Drawing.Point(3, 16)
$LogText.Name = "LogText"
$LogText.ReadOnly = $true
$LogText.Size = New-Object System.Drawing.Size(364, 220)
$LogText.TabIndex = 0
$LogText.Text = ""
#
# PathsGroup
#
$PathsGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$PathsGroup.Controls.Add($LoadButton)
$PathsGroup.Controls.Add($SaveButton)
$PathsGroup.Controls.Add($UpdateButton)
$PathsGroup.Controls.Add($ScanPathButton)
$PathsGroup.Controls.Add($RemovePathButton)
$PathsGroup.Controls.Add($AddPathButton)
$PathsGroup.Controls.Add($PathsList)
$PathsGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$PathsGroup.Location = New-Object System.Drawing.Point(0, 0)
$PathsGroup.Name = "PathsGroup"
$PathsGroup.Size = New-Object System.Drawing.Size(370, 273)
$PathsGroup.TabIndex = 2
$PathsGroup.TabStop = $false
$PathsGroup.Text = "Scan Paths"
#
# LoadButton
#
$LoadButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$LoadButton.Location = New-Object System.Drawing.Point(281, 163)
$LoadButton.Name = "LoadButton"
$LoadButton.Size = New-Object System.Drawing.Size(82, 23)
$LoadButton.TabIndex = 6
$LoadButton.Text = "Load Config"
$LoadButton.UseVisualStyleBackColor = $true
#
# SaveButton
#
$SaveButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$SaveButton.Location = New-Object System.Drawing.Point(281, 133)
$SaveButton.Name = "SaveButton"
$SaveButton.Size = New-Object System.Drawing.Size(83, 23)
$SaveButton.TabIndex = 5
$SaveButton.Text = "Save Config"
$SaveButton.UseVisualStyleBackColor = $true
#
# UpdateButton
#
$UpdateButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$UpdateButton.Location = New-Object System.Drawing.Point(281, 103)
$UpdateButton.Name = "UpdateButton"
$UpdateButton.Size = New-Object System.Drawing.Size(83, 23)
$UpdateButton.TabIndex = 4
$UpdateButton.Text = "Run Updates"
$UpdateButton.UseVisualStyleBackColor = $true
#
# ScanPathButton
#
$ScanPathButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$ScanPathButton.Location = New-Object System.Drawing.Point(280, 73)
$ScanPathButton.Name = "ScanPathButton"
$ScanPathButton.Size = New-Object System.Drawing.Size(84, 23)
$ScanPathButton.TabIndex = 3
$ScanPathButton.Text = "Scan Paths"
$ScanPathButton.UseVisualStyleBackColor = $true
#
# RemovePathButton
#
$RemovePathButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$RemovePathButton.Location = New-Object System.Drawing.Point(280, 44)
$RemovePathButton.Name = "RemovePathButton"
$RemovePathButton.Size = New-Object System.Drawing.Size(84, 23)
$RemovePathButton.TabIndex = 2
$RemovePathButton.Text = "Remove Path"
$RemovePathButton.UseVisualStyleBackColor = $true
#
# AddPathButton
#
$AddPathButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$AddPathButton.Location = New-Object System.Drawing.Point(280, 15)
$AddPathButton.Name = "AddPathButton"
$AddPathButton.Size = New-Object System.Drawing.Size(84, 23)
$AddPathButton.TabIndex = 1
$AddPathButton.Text = "Add Path"
$AddPathButton.UseVisualStyleBackColor = $true
#
# PathsList
#
$PathsList.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Bottom,Left,Right"
$PathsList.FormattingEnabled = $true
$PathsList.Location = New-Object System.Drawing.Point(3, 16)
$PathsList.Name = "PathsList"
$PathsList.Size = New-Object System.Drawing.Size(275, 251)
$PathsList.TabIndex = 0
#
# splitContainerRight
#
$splitContainerRight.Dock = [System.Windows.Forms.DockStyle]::Fill
$splitContainerRight.Location = New-Object System.Drawing.Point(0, 0)
$splitContainerRight.Name = "splitContainerRight"
$splitContainerRight.Orientation = [System.Windows.Forms.Orientation]::Horizontal
#
# splitContainerRight.Panel1
#
$splitContainerRight.Panel1.Controls.Add($BucketsGroup)
#
# splitContainerRight.Panel2
#
$splitContainerRight.Panel2.Controls.Add($EmulatorsGroup)
$splitContainerRight.Size = New-Object System.Drawing.Size(742, 516)
$splitContainerRight.SplitterDistance = 254
$splitContainerRight.TabIndex = 0
#
# BucketsGroup
#
$BucketsGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$BucketsGroup.Controls.Add($BucketsTable)
$BucketsGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$BucketsGroup.Location = New-Object System.Drawing.Point(0, 0)
$BucketsGroup.Name = "BucketsGroup"
$BucketsGroup.Size = New-Object System.Drawing.Size(742, 254)
$BucketsGroup.TabIndex = 4
$BucketsGroup.TabStop = $false
$BucketsGroup.Text = "Emulators Database"
#
# BucketsTable
#
$BucketsTable.ColumnCount = 5
$BucketsTable.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Absolute, 145)))
$BucketsTable.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Absolute, 80)))
$BucketsTable.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent, 40)))
$BucketsTable.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Absolute, 80)))
$BucketsTable.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent, 60)))
$BucketsTable.Controls.Add($BucketsList, 0, 0)
$BucketsTable.Controls.Add($BucketLogoImage, 4, 3)
$BucketsTable.Controls.Add($BucketDescriptionText, 4, 0)
$BucketsTable.Controls.Add($BucketsLoadedLabel, 1, 5)
$BucketsTable.Controls.Add($BucketLogoLabel, 3, 3)
$BucketsTable.Controls.Add($BucketsLoadedText, 2, 5)
$BucketsTable.Controls.Add($EmulatorsCountLabel, 1, 4)
$BucketsTable.Controls.Add($BucketDescriptionLabel, 3, 0)
$BucketsTable.Controls.Add($EmulatorsCountText, 2, 4)
$BucketsTable.Controls.Add($BucketNameLabel, 1, 0)
$BucketsTable.Controls.Add($BucketLicenseLabel, 1, 1)
$BucketsTable.Controls.Add($BucketHomeLabel, 1, 2)
$BucketsTable.Controls.Add($BucketVersionLabel, 1, 3)
$BucketsTable.Controls.Add($BucketVersionText, 2, 3)
$BucketsTable.Controls.Add($BucketHomeText, 2, 2)
$BucketsTable.Controls.Add($BucketLicenseText, 2, 1)
$BucketsTable.Controls.Add($BucketNameText, 2, 0)
$BucketsTable.Dock = [System.Windows.Forms.DockStyle]::Fill
$BucketsTable.Location = New-Object System.Drawing.Point(3, 16)
$BucketsTable.Name = "BucketsTable"
$BucketsTable.RowCount = 6
$BucketsTable.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 16.66667)))
$BucketsTable.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 16.66667)))
$BucketsTable.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 16.66667)))
$BucketsTable.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 16.66667)))
$BucketsTable.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 16.66667)))
$BucketsTable.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 16.66667)))
$BucketsTable.Size = New-Object System.Drawing.Size(736, 235)
$BucketsTable.TabIndex = 18
#
# BucketsList
#
$BucketsList.Dock = [System.Windows.Forms.DockStyle]::Fill
$BucketsList.FormattingEnabled = $true
$BucketsList.Location = New-Object System.Drawing.Point(3, 3)
$BucketsList.Name = "BucketsList"
$BucketsTable.SetRowSpan($BucketsList, 6)
$BucketsList.Size = New-Object System.Drawing.Size(139, 229)
$BucketsList.TabIndex = 0
#
# BucketLogoImage
#
$BucketLogoImage.Dock = [System.Windows.Forms.DockStyle]::Fill
$BucketLogoImage.Location = New-Object System.Drawing.Point(480, 120)
$BucketLogoImage.Name = "BucketLogoImage"
$BucketsTable.SetRowSpan($BucketLogoImage, 3)
$BucketLogoImage.Size = New-Object System.Drawing.Size(253, 112)
$BucketLogoImage.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::AutoSize
$BucketLogoImage.TabIndex = 15
$BucketLogoImage.TabStop = $false
#
# BucketDescriptionText
#
$BucketDescriptionText.Dock = [System.Windows.Forms.DockStyle]::Fill
$BucketDescriptionText.Location = New-Object System.Drawing.Point(480, 3)
$BucketDescriptionText.Multiline = $true
$BucketDescriptionText.Name = "BucketDescriptionText"
$BucketDescriptionText.ReadOnly = $true
$BucketsTable.SetRowSpan($BucketDescriptionText, 3)
$BucketDescriptionText.Size = New-Object System.Drawing.Size(253, 111)
$BucketDescriptionText.TabIndex = 17
#
# BucketsLoadedLabel
#
$BucketsLoadedLabel.AutoSize = $true
$BucketsLoadedLabel.Location = New-Object System.Drawing.Point(148, 195)
$BucketsLoadedLabel.Name = "BucketsLoadedLabel"
$BucketsLoadedLabel.Size = New-Object System.Drawing.Size(56, 13)
$BucketsLoadedLabel.TabIndex = 9
$BucketsLoadedLabel.Text = "# Buckets"
#
# BucketLogoLabel
#
$BucketLogoLabel.AutoSize = $true
$BucketLogoLabel.Location = New-Object System.Drawing.Point(400, 117)
$BucketLogoLabel.Name = "BucketLogoLabel"
$BucketLogoLabel.Size = New-Object System.Drawing.Size(31, 13)
$BucketLogoLabel.TabIndex = 16
$BucketLogoLabel.Text = "Logo"
#
# BucketsLoadedText
#
$BucketsLoadedText.AutoSize = $true
$BucketsLoadedText.Location = New-Object System.Drawing.Point(228, 195)
$BucketsLoadedText.Name = "BucketsLoadedText"
$BucketsLoadedText.Size = New-Object System.Drawing.Size(13, 13)
$BucketsLoadedText.TabIndex = 10
$BucketsLoadedText.Text = "0"
#
# EmulatorsCountLabel
#
$EmulatorsCountLabel.AutoSize = $true
$EmulatorsCountLabel.Location = New-Object System.Drawing.Point(148, 156)
$EmulatorsCountLabel.Name = "EmulatorsCountLabel"
$EmulatorsCountLabel.Size = New-Object System.Drawing.Size(63, 13)
$EmulatorsCountLabel.TabIndex = 7
$EmulatorsCountLabel.Text = "# Emulators"
#
# BucketDescriptionLabel
#
$BucketDescriptionLabel.AutoSize = $true
$BucketDescriptionLabel.Location = New-Object System.Drawing.Point(400, 0)
$BucketDescriptionLabel.Name = "BucketDescriptionLabel"
$BucketDescriptionLabel.Size = New-Object System.Drawing.Size(60, 13)
$BucketDescriptionLabel.TabIndex = 13
$BucketDescriptionLabel.Text = "Description"
#
# EmulatorsCountText
#
$EmulatorsCountText.AutoSize = $true
$EmulatorsCountText.Location = New-Object System.Drawing.Point(228, 156)
$EmulatorsCountText.Name = "EmulatorsCountText"
$EmulatorsCountText.Size = New-Object System.Drawing.Size(13, 13)
$EmulatorsCountText.TabIndex = 8
$EmulatorsCountText.Text = "0"
#
# BucketNameLabel
#
$BucketNameLabel.AutoSize = $true
$BucketNameLabel.Location = New-Object System.Drawing.Point(148, 0)
$BucketNameLabel.Name = "BucketNameLabel"
$BucketNameLabel.Size = New-Object System.Drawing.Size(35, 13)
$BucketNameLabel.TabIndex = 1
$BucketNameLabel.Text = "Name"
#
# BucketLicenseLabel
#
$BucketLicenseLabel.AutoSize = $true
$BucketLicenseLabel.Location = New-Object System.Drawing.Point(148, 39)
$BucketLicenseLabel.Name = "BucketLicenseLabel"
$BucketLicenseLabel.Size = New-Object System.Drawing.Size(44, 13)
$BucketLicenseLabel.TabIndex = 3
$BucketLicenseLabel.Text = "License"
#
# BucketHomeLabel
#
$BucketHomeLabel.AutoSize = $true
$BucketHomeLabel.Location = New-Object System.Drawing.Point(148, 78)
$BucketHomeLabel.Name = "BucketHomeLabel"
$BucketHomeLabel.Size = New-Object System.Drawing.Size(63, 13)
$BucketHomeLabel.TabIndex = 5
$BucketHomeLabel.Text = "Home Page"
#
# BucketVersionLabel
#
$BucketVersionLabel.AutoSize = $true
$BucketVersionLabel.Location = New-Object System.Drawing.Point(148, 117)
$BucketVersionLabel.Name = "BucketVersionLabel"
$BucketVersionLabel.Size = New-Object System.Drawing.Size(42, 13)
$BucketVersionLabel.TabIndex = 11
$BucketVersionLabel.Text = "Version"
#
# BucketVersionText
#
$BucketVersionText.AutoSize = $true
$BucketVersionText.Location = New-Object System.Drawing.Point(228, 117)
$BucketVersionText.Name = "BucketVersionText"
$BucketVersionText.Size = New-Object System.Drawing.Size(13, 13)
$BucketVersionText.TabIndex = 12
$BucketVersionText.Text = "v"
#
# BucketHomeText
#
$BucketHomeText.AutoSize = $true
$BucketHomeText.Location = New-Object System.Drawing.Point(228, 78)
$BucketHomeText.Name = "BucketHomeText"
$BucketHomeText.Size = New-Object System.Drawing.Size(38, 13)
$BucketHomeText.TabIndex = 6
$BucketHomeText.Text = "http://"
#
# BucketLicenseText
#
$BucketLicenseText.AutoSize = $true
$BucketLicenseText.Location = New-Object System.Drawing.Point(228, 39)
$BucketLicenseText.Name = "BucketLicenseText"
$BucketLicenseText.Size = New-Object System.Drawing.Size(53, 13)
$BucketLicenseText.TabIndex = 4
$BucketLicenseText.Text = "Unknown"
#
# BucketNameText
#
$BucketNameText.AutoSize = $true
$BucketNameText.Location = New-Object System.Drawing.Point(228, 0)
$BucketNameText.Name = "BucketNameText"
$BucketNameText.Size = New-Object System.Drawing.Size(74, 13)
$BucketNameText.TabIndex = 2
$BucketNameText.Text = "none selected"
#
# EmulatorsGroup
#
$EmulatorsGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$EmulatorsGroup.Controls.Add($EmulatorsTable)
$EmulatorsGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$EmulatorsGroup.Location = New-Object System.Drawing.Point(0, 0)
$EmulatorsGroup.Name = "EmulatorsGroup"
$EmulatorsGroup.Size = New-Object System.Drawing.Size(742, 258)
$EmulatorsGroup.TabIndex = 5
$EmulatorsGroup.TabStop = $false
$EmulatorsGroup.Text = "Discovered Emulators"
#
# EmulatorsTable
#
$EmulatorsTable.AllowUserToOrderColumns = $true
$EmulatorsTable.AutoSizeColumnsMode = [System.Windows.Forms.DataGridViewAutoSizeColumnsMode]::Fill
$EmulatorsTable.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$EmulatorsTable.Columns.AddRange(
$Select,
$Path,
$Emulator,
$CurrentVersion,
$NewVersion)
$EmulatorsTable.Dock = [System.Windows.Forms.DockStyle]::Fill
$EmulatorsTable.Location = New-Object System.Drawing.Point(3, 16)
$EmulatorsTable.Name = "EmulatorsTable"
$EmulatorsTable.Size = New-Object System.Drawing.Size(736, 239)
$EmulatorsTable.TabIndex = 0
#
# Select
#
$Select.FillWeight = 10
$Select.HeaderText = ""
$Select.Name = "Select"
#
# Path
#
$Path.FillWeight = 40
$Path.HeaderText = "Path"
$Path.Name = "Path"
$Path.ReadOnly = $true
#
# Emulator
#
$Emulator.FillWeight = 20
$Emulator.HeaderText = "Emulator"
$Emulator.Name = "Emulator"
$Emulator.ReadOnly = $true
#
# CurrentVersion
#
$CurrentVersion.FillWeight = 15
$CurrentVersion.HeaderText = "Current Version"
$CurrentVersion.Name = "CurrentVersion"
$CurrentVersion.ReadOnly = $true
#
# NewVersion
#
$NewVersion.FillWeight = 15
$NewVersion.HeaderText = "New Version"
$NewVersion.Name = "NewVersion"
$NewVersion.ReadOnly = $true
#
# contextMenuStrip1
#
$contextMenuStrip1.Name = "contextMenuStrip1"
$contextMenuStrip1.Size = New-Object System.Drawing.Size(61, 4)
#
# MainWindow
#
$MainWindow.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$MainWindow.ClientSize = New-Object System.Drawing.Size(1126, 526)
$MainWindow.Controls.Add($splitContainerMain)
$MainWindow.MinimumSize = New-Object System.Drawing.Size(800, 400)
$MainWindow.Name = "MainWindow"
$MainWindow.Padding = New-Object System.Windows.Forms.Padding(5)
$MainWindow.Text = "EmuLatest"

. (".\scoop_finder.ps1")
. (".\Functions.ps1")

function OnFormClosing_MainWindow{
	Remove-Repo 
	# $this parameter is equal to the sender (object)
	# $_ is equal to the parameter e (eventarg)

	# The CloseReason property indicates a reason for the closure :
	#   if (($_).CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing)

	#Sets the value indicating that the event should be canceled.
	($_).Cancel= $False
}

$MainWindow.Add_FormClosing( { OnFormClosing_MainWindow} )

$MainWindow.Add_Shown({$MainWindow.Activate()})
$ModalResult=$MainWindow.ShowDialog()
# Release the Form
$MainWindow.Dispose()

