################################################################################
#
#  Name    : E:\dev\emulatest\MainWindow.ps1
#  Version : 0.1
#  Author  :
#  Date    : 4/21/2023
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
$UpdateButton = New-Object System.Windows.Forms.Button
$ScanPathButton = New-Object System.Windows.Forms.Button
$RemovePathButton = New-Object System.Windows.Forms.Button
$AddPathButton = New-Object System.Windows.Forms.Button
$PathsList = New-Object System.Windows.Forms.ListBox
$splitContainerRight = New-Object System.Windows.Forms.SplitContainer
$BucketsGroup = New-Object System.Windows.Forms.GroupBox
$BucketDescriptionText = New-Object System.Windows.Forms.TextBox
$BucketLogoLabel = New-Object System.Windows.Forms.Label
$BucketLogoImage = New-Object System.Windows.Forms.PictureBox
$BucketDescriptionLabel = New-Object System.Windows.Forms.Label
$BucketVersionText = New-Object System.Windows.Forms.Label
$BucketVersionLabel = New-Object System.Windows.Forms.Label
$BucketsLoadedText = New-Object System.Windows.Forms.Label
$BucketsLoadedLabel = New-Object System.Windows.Forms.Label
$EmulatorsCountText = New-Object System.Windows.Forms.Label
$EmulatorsCountLabel = New-Object System.Windows.Forms.Label
$BucketHomeText = New-Object System.Windows.Forms.Label
$BucketHomeLabel = New-Object System.Windows.Forms.Label
$BucketLicenseText = New-Object System.Windows.Forms.Label
$BucketLicenseLabel = New-Object System.Windows.Forms.Label
$BucketNameText = New-Object System.Windows.Forms.Label
$BucketNameLabel = New-Object System.Windows.Forms.Label
$BucketsList = New-Object System.Windows.Forms.ListBox
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
$splitContainerMain.Size = New-Object System.Drawing.Size(1042, 614)
$splitContainerMain.SplitterDistance = 347
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
$splitContainerLeft.Size = New-Object System.Drawing.Size(347, 614)
$splitContainerLeft.SplitterDistance = 286
$splitContainerLeft.TabIndex = 0
#
# LogGroup
#
$LogGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$LogGroup.Controls.Add($LogText)
$LogGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$LogGroup.Location = New-Object System.Drawing.Point(0, 0)
$LogGroup.Name = "LogGroup"
$LogGroup.Size = New-Object System.Drawing.Size(347, 286)
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
$LogText.Size = New-Object System.Drawing.Size(341, 267)
$LogText.TabIndex = 0
$LogText.Text = ""
#
# PathsGroup
#
$PathsGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$PathsGroup.Controls.Add($UpdateButton)
$PathsGroup.Controls.Add($ScanPathButton)
$PathsGroup.Controls.Add($RemovePathButton)
$PathsGroup.Controls.Add($AddPathButton)
$PathsGroup.Controls.Add($PathsList)
$PathsGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$PathsGroup.Location = New-Object System.Drawing.Point(0, 0)
$PathsGroup.Name = "PathsGroup"
$PathsGroup.Size = New-Object System.Drawing.Size(347, 324)
$PathsGroup.TabIndex = 2
$PathsGroup.TabStop = $false
$PathsGroup.Text = "Scan Paths"
#
# UpdateButton
#
$UpdateButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$UpdateButton.Location = New-Object System.Drawing.Point(262, 107)
$UpdateButton.Name = "UpdateButton"
$UpdateButton.Size = New-Object System.Drawing.Size(83, 23)
$UpdateButton.TabIndex = 4
$UpdateButton.Text = "Run Updates"
$UpdateButton.UseVisualStyleBackColor = $true
#
# ScanPathButton
#
$ScanPathButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$ScanPathButton.Location = New-Object System.Drawing.Point(261, 77)
$ScanPathButton.Name = "ScanPathButton"
$ScanPathButton.Size = New-Object System.Drawing.Size(84, 23)
$ScanPathButton.TabIndex = 3
$ScanPathButton.Text = "Scan Paths"
$ScanPathButton.UseVisualStyleBackColor = $true
#
# RemovePathButton
#
$RemovePathButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$RemovePathButton.Location = New-Object System.Drawing.Point(261, 48)
$RemovePathButton.Name = "RemovePathButton"
$RemovePathButton.Size = New-Object System.Drawing.Size(84, 23)
$RemovePathButton.TabIndex = 2
$RemovePathButton.Text = "Remove Path"
$RemovePathButton.UseVisualStyleBackColor = $true
#
# AddPathButton
#
$AddPathButton.Anchor = [System.Windows.Forms.AnchorStyles]"Top,Right"
$AddPathButton.Location = New-Object System.Drawing.Point(261, 19)
$AddPathButton.Name = "AddPathButton"
$AddPathButton.Size = New-Object System.Drawing.Size(84, 23)
$AddPathButton.TabIndex = 1
$AddPathButton.Text = "Add Path"
$AddPathButton.UseVisualStyleBackColor = $true
#
# PathsList
#
$PathsList.Dock = [System.Windows.Forms.DockStyle]::Left
$PathsList.FormattingEnabled = $true
$PathsList.Location = New-Object System.Drawing.Point(3, 16)
$PathsList.Name = "PathsList"
$PathsList.Size = New-Object System.Drawing.Size(232, 305)
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
$splitContainerRight.Size = New-Object System.Drawing.Size(691, 614)
$splitContainerRight.SplitterDistance = 220
$splitContainerRight.TabIndex = 0
#
# BucketsGroup
#
$BucketsGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$BucketsGroup.Controls.Add($BucketDescriptionText)
$BucketsGroup.Controls.Add($BucketLogoLabel)
$BucketsGroup.Controls.Add($BucketLogoImage)
$BucketsGroup.Controls.Add($BucketDescriptionLabel)
$BucketsGroup.Controls.Add($BucketVersionText)
$BucketsGroup.Controls.Add($BucketVersionLabel)
$BucketsGroup.Controls.Add($BucketsLoadedText)
$BucketsGroup.Controls.Add($BucketsLoadedLabel)
$BucketsGroup.Controls.Add($EmulatorsCountText)
$BucketsGroup.Controls.Add($EmulatorsCountLabel)
$BucketsGroup.Controls.Add($BucketHomeText)
$BucketsGroup.Controls.Add($BucketHomeLabel)
$BucketsGroup.Controls.Add($BucketLicenseText)
$BucketsGroup.Controls.Add($BucketLicenseLabel)
$BucketsGroup.Controls.Add($BucketNameText)
$BucketsGroup.Controls.Add($BucketNameLabel)
$BucketsGroup.Controls.Add($BucketsList)
$BucketsGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$BucketsGroup.Location = New-Object System.Drawing.Point(0, 0)
$BucketsGroup.Name = "BucketsGroup"
$BucketsGroup.Size = New-Object System.Drawing.Size(691, 220)
$BucketsGroup.TabIndex = 4
$BucketsGroup.TabStop = $false
$BucketsGroup.Text = "Emulators Database"
#
# BucketDescriptionText
#
$BucketDescriptionText.Location = New-Object System.Drawing.Point(155, 140)
$BucketDescriptionText.Multiline = $true
$BucketDescriptionText.Name = "BucketDescriptionText"
$BucketDescriptionText.ReadOnly = $true
$BucketDescriptionText.Size = New-Object System.Drawing.Size(200, 64)
$BucketDescriptionText.TabIndex = 17
#
# BucketLogoLabel
#
$BucketLogoLabel.AutoSize = $true
$BucketLogoLabel.Location = New-Object System.Drawing.Point(338, 75)
$BucketLogoLabel.Name = "BucketLogoLabel"
$BucketLogoLabel.Size = New-Object System.Drawing.Size(31, 13)
$BucketLogoLabel.TabIndex = 16
$BucketLogoLabel.Text = "Logo"
#
# BucketLogoImage
#
$BucketLogoImage.Location = New-Object System.Drawing.Point(375, 75)
$BucketLogoImage.Name = "BucketLogoImage"
$BucketLogoImage.Size = New-Object System.Drawing.Size(185, 122)
$BucketLogoImage.TabIndex = 15
$BucketLogoImage.TabStop = $false
#
# BucketDescriptionLabel
#
$BucketDescriptionLabel.AutoSize = $true
$BucketDescriptionLabel.Location = New-Object System.Drawing.Point(156, 124)
$BucketDescriptionLabel.Name = "BucketDescriptionLabel"
$BucketDescriptionLabel.Size = New-Object System.Drawing.Size(60, 13)
$BucketDescriptionLabel.TabIndex = 13
$BucketDescriptionLabel.Text = "Description"
#
# BucketVersionText
#
$BucketVersionText.AutoSize = $true
$BucketVersionText.Location = New-Object System.Drawing.Point(224, 104)
$BucketVersionText.Name = "BucketVersionText"
$BucketVersionText.Size = New-Object System.Drawing.Size(0, 13)
$BucketVersionText.TabIndex = 12
#
# BucketVersionLabel
#
$BucketVersionLabel.AutoSize = $true
$BucketVersionLabel.Location = New-Object System.Drawing.Point(156, 104)
$BucketVersionLabel.Name = "BucketVersionLabel"
$BucketVersionLabel.Size = New-Object System.Drawing.Size(42, 13)
$BucketVersionLabel.TabIndex = 11
$BucketVersionLabel.Text = "Version"
#
# BucketsLoadedText
#
$BucketsLoadedText.AutoSize = $true
$BucketsLoadedText.Location = New-Object System.Drawing.Point(372, 44)
$BucketsLoadedText.Name = "BucketsLoadedText"
$BucketsLoadedText.Size = New-Object System.Drawing.Size(0, 13)
$BucketsLoadedText.TabIndex = 10
#
# BucketsLoadedLabel
#
$BucketsLoadedLabel.AutoSize = $true
$BucketsLoadedLabel.Location = New-Object System.Drawing.Point(313, 44)
$BucketsLoadedLabel.Name = "BucketsLoadedLabel"
$BucketsLoadedLabel.Size = New-Object System.Drawing.Size(56, 13)
$BucketsLoadedLabel.TabIndex = 9
$BucketsLoadedLabel.Text = "# Buckets"
#
# EmulatorsCountText
#
$EmulatorsCountText.AutoSize = $true
$EmulatorsCountText.Location = New-Object System.Drawing.Point(372, 22)
$EmulatorsCountText.Name = "EmulatorsCountText"
$EmulatorsCountText.Size = New-Object System.Drawing.Size(0, 13)
$EmulatorsCountText.TabIndex = 8
#
# EmulatorsCountLabel
#
$EmulatorsCountLabel.AutoSize = $true
$EmulatorsCountLabel.Location = New-Object System.Drawing.Point(306, 22)
$EmulatorsCountLabel.Name = "EmulatorsCountLabel"
$EmulatorsCountLabel.Size = New-Object System.Drawing.Size(63, 13)
$EmulatorsCountLabel.TabIndex = 7
$EmulatorsCountLabel.Text = "# Emulators"
#
# BucketHomeText
#
$BucketHomeText.AutoSize = $true
$BucketHomeText.Location = New-Object System.Drawing.Point(224, 75)
$BucketHomeText.Name = "BucketHomeText"
$BucketHomeText.Size = New-Object System.Drawing.Size(0, 13)
$BucketHomeText.TabIndex = 6
#
# BucketHomeLabel
#
$BucketHomeLabel.AutoSize = $true
$BucketHomeLabel.Location = New-Object System.Drawing.Point(156, 75)
$BucketHomeLabel.Name = "BucketHomeLabel"
$BucketHomeLabel.Size = New-Object System.Drawing.Size(63, 13)
$BucketHomeLabel.TabIndex = 5
$BucketHomeLabel.Text = "Home Page"
#
# BucketLicenseText
#
$BucketLicenseText.AutoSize = $true
$BucketLicenseText.Location = New-Object System.Drawing.Point(224, 48)
$BucketLicenseText.Name = "BucketLicenseText"
$BucketLicenseText.Size = New-Object System.Drawing.Size(0, 13)
$BucketLicenseText.TabIndex = 4
#
# BucketLicenseLabel
#
$BucketLicenseLabel.AutoSize = $true
$BucketLicenseLabel.Location = New-Object System.Drawing.Point(156, 48)
$BucketLicenseLabel.Name = "BucketLicenseLabel"
$BucketLicenseLabel.Size = New-Object System.Drawing.Size(44, 13)
$BucketLicenseLabel.TabIndex = 3
$BucketLicenseLabel.Text = "License"
#
# BucketNameText
#
$BucketNameText.AutoSize = $true
$BucketNameText.Location = New-Object System.Drawing.Point(224, 19)
$BucketNameText.Name = "BucketNameText"
$BucketNameText.Size = New-Object System.Drawing.Size(0, 13)
$BucketNameText.TabIndex = 2
#
# BucketNameLabel
#
$BucketNameLabel.AutoSize = $true
$BucketNameLabel.Location = New-Object System.Drawing.Point(156, 19)
$BucketNameLabel.Name = "BucketNameLabel"
$BucketNameLabel.Size = New-Object System.Drawing.Size(35, 13)
$BucketNameLabel.TabIndex = 1
$BucketNameLabel.Text = "Name"
#
# BucketsList
#
$BucketsList.FormattingEnabled = $true
$BucketsList.Location = New-Object System.Drawing.Point(7, 19)
$BucketsList.Name = "BucketsList"
$BucketsList.Size = New-Object System.Drawing.Size(142, 186)
$BucketsList.TabIndex = 0
#
# EmulatorsGroup
#
$EmulatorsGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$EmulatorsGroup.Controls.Add($EmulatorsTable)
$EmulatorsGroup.Dock = [System.Windows.Forms.DockStyle]::Fill
$EmulatorsGroup.Location = New-Object System.Drawing.Point(0, 0)
$EmulatorsGroup.Name = "EmulatorsGroup"
$EmulatorsGroup.Size = New-Object System.Drawing.Size(691, 390)
$EmulatorsGroup.TabIndex = 5
$EmulatorsGroup.TabStop = $false
$EmulatorsGroup.Text = "Discovered Emulators"
#
# EmulatorsTable
#
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
$EmulatorsTable.ReadOnly = $true
$EmulatorsTable.Size = New-Object System.Drawing.Size(685, 371)
$EmulatorsTable.TabIndex = 0
#
# Select
#
$Select.HeaderText = ""
$Select.Name = "Select"
$Select.ReadOnly = $true
$Select.Resizable = [System.Windows.Forms.DataGridViewTriState]::False
$Select.Width = 30
#
# Path
#
$Path.HeaderText = "Path"
$Path.Name = "Path"
$Path.ReadOnly = $true
$Path.Width = 200
#
# Emulator
#
$Emulator.HeaderText = "Emulator"
$Emulator.Name = "Emulator"
$Emulator.ReadOnly = $true
$Emulator.Width = 120
#
# CurrentVersion
#
$CurrentVersion.HeaderText = "Current Version"
$CurrentVersion.Name = "CurrentVersion"
$CurrentVersion.ReadOnly = $true
$CurrentVersion.Width = 80
#
# NewVersion
#
$NewVersion.HeaderText = "New Version"
$NewVersion.Name = "NewVersion"
$NewVersion.ReadOnly = $true
$NewVersion.Width = 80
#
# contextMenuStrip1
#
$contextMenuStrip1.Name = "contextMenuStrip1"
$contextMenuStrip1.Size = New-Object System.Drawing.Size(61, 4)
#
# MainWindow
#
$MainWindow.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$MainWindow.ClientSize = New-Object System.Drawing.Size(1052, 624)
$MainWindow.Controls.Add($splitContainerMain)
$MainWindow.MinimumSize = New-Object System.Drawing.Size(800, 400)
$MainWindow.Name = "MainWindow"
$MainWindow.Padding = New-Object System.Windows.Forms.Padding(5)
$MainWindow.Text = "EmuLatest"

. (".\scoop_finder.ps1")
. (".\Functions.ps1")

function OnFormClosing_MainWindow{
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


