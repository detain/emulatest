################################################################################
#
#  Name    : E:\dev\emulatest\converted\Form1.ps1
#  Version : 0.1
#  Author  :
#  Date    : 4/4/2023
#
 #  Generated with ConvertForm module version 2.0.0
#  PowerShell version 5.1.22621.963
#
#  Invocation Line   : Convert-Form -Path "E:\dev\WindowsFormsApp1\Form1.Designer.cs" -Destination "E:\dev\emulatest\converted" -Encoding ascii -force

#  Source            : E:\dev\WindowsFormsApp1\Form1.Designer.cs
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

$Form1 = New-Object System.Windows.Forms.Form

$PathsGroup = New-Object System.Windows.Forms.GroupBox
$ScanPathButton = New-Object System.Windows.Forms.Button
$RemovePathButton = New-Object System.Windows.Forms.Button
$AddPathButton = New-Object System.Windows.Forms.Button
$PathsList = New-Object System.Windows.Forms.ListBox
$LogGroup = New-Object System.Windows.Forms.GroupBox
$LogText = New-Object System.Windows.Forms.RichTextBox
$BucketsGroup = New-Object System.Windows.Forms.GroupBox
$BucketLogoLabel = New-Object System.Windows.Forms.Label
$BucketLogoImage = New-Object System.Windows.Forms.PictureBox
$BucketDescriptionText = New-Object System.Windows.Forms.Label
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
$UpdateButton = New-Object System.Windows.Forms.Button
#
# PathsGroup
#
$PathsGroup.Controls.Add($UpdateButton)
$PathsGroup.Controls.Add($ScanPathButton)
$PathsGroup.Controls.Add($RemovePathButton)
$PathsGroup.Controls.Add($AddPathButton)
$PathsGroup.Controls.Add($PathsList)
$PathsGroup.Location = New-Object System.Drawing.Point(12, 254)
$PathsGroup.Name = "PathsGroup"
$PathsGroup.Size = New-Object System.Drawing.Size(292, 145)
$PathsGroup.TabIndex = 1
$PathsGroup.TabStop = $false
$PathsGroup.Text = "Scan Paths"
#
# ScanPathButton
#
$ScanPathButton.Location = New-Object System.Drawing.Point(202, 77)
$ScanPathButton.Name = "ScanPathButton"
$ScanPathButton.Size = New-Object System.Drawing.Size(84, 23)
$ScanPathButton.TabIndex = 3
$ScanPathButton.Text = "Scan Paths"
$ScanPathButton.UseVisualStyleBackColor = $true
#
# RemovePathButton
#
$RemovePathButton.Location = New-Object System.Drawing.Point(202, 48)
$RemovePathButton.Name = "RemovePathButton"
$RemovePathButton.Size = New-Object System.Drawing.Size(84, 23)
$RemovePathButton.TabIndex = 2
$RemovePathButton.Text = "Remove Path"
$RemovePathButton.UseVisualStyleBackColor = $true
#
# AddPathButton
#
$AddPathButton.Location = New-Object System.Drawing.Point(202, 19)
$AddPathButton.Name = "AddPathButton"
$AddPathButton.Size = New-Object System.Drawing.Size(84, 23)
$AddPathButton.TabIndex = 1
$AddPathButton.Text = "Add Path"
$AddPathButton.UseVisualStyleBackColor = $true
#
# PathsList
#
$PathsList.FormattingEnabled = $true
$PathsList.Location = New-Object System.Drawing.Point(6, 19)
$PathsList.Name = "PathsList"
$PathsList.Size = New-Object System.Drawing.Size(190, 108)
$PathsList.TabIndex = 0
#
# LogGroup
#
$LogGroup.Controls.Add($LogText)
$LogGroup.Location = New-Object System.Drawing.Point(12, 12)
$LogGroup.Name = "LogGroup"
$LogGroup.Size = New-Object System.Drawing.Size(286, 143)
$LogGroup.TabIndex = 2
$LogGroup.TabStop = $false
$LogGroup.Text = "Log"
#
# LogText
#
$LogText.Location = New-Object System.Drawing.Point(6, 19)
$LogText.Name = "LogText"
$LogText.Size = New-Object System.Drawing.Size(274, 118)
$LogText.TabIndex = 0
$LogText.Text = ""
#
# BucketsGroup
#
$BucketsGroup.Controls.Add($BucketLogoLabel)
$BucketsGroup.Controls.Add($BucketLogoImage)
$BucketsGroup.Controls.Add($BucketDescriptionText)
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
$BucketsGroup.Location = New-Object System.Drawing.Point(311, 12)
$BucketsGroup.Name = "BucketsGroup"
$BucketsGroup.Size = New-Object System.Drawing.Size(566, 210)
$BucketsGroup.TabIndex = 3
$BucketsGroup.TabStop = $false
$BucketsGroup.Text = "Emulators Database"

function OnEnter_BucketsGroup {
	[void][System.Windows.Forms.MessageBox]::Show("The event handler BucketsGroup.Add_Enter is not implemented.")
}

$BucketsGroup.Add_Enter( { OnEnter_BucketsGroup } )

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
# BucketDescriptionText
#
$BucketDescriptionText.AutoSize = $true
$BucketDescriptionText.Location = New-Object System.Drawing.Point(404, 19)
$BucketDescriptionText.Name = "BucketDescriptionText"
$BucketDescriptionText.Size = New-Object System.Drawing.Size(10, 13)
$BucketDescriptionText.TabIndex = 14
$BucketDescriptionText.Text = "-"
#
# BucketDescriptionLabel
#
$BucketDescriptionLabel.AutoSize = $true
$BucketDescriptionLabel.Location = New-Object System.Drawing.Point(336, 19)
$BucketDescriptionLabel.Name = "BucketDescriptionLabel"
$BucketDescriptionLabel.Size = New-Object System.Drawing.Size(60, 13)
$BucketDescriptionLabel.TabIndex = 13
$BucketDescriptionLabel.Text = "Description"

function OnClick_BucketDescriptionLabel {
	[void][System.Windows.Forms.MessageBox]::Show("The event handler BucketDescriptionLabel.Add_Click is not implemented.")
}

$BucketDescriptionLabel.Add_Click( { OnClick_BucketDescriptionLabel } )

#
# BucketVersionText
#
$BucketVersionText.AutoSize = $true
$BucketVersionText.Location = New-Object System.Drawing.Point(224, 104)
$BucketVersionText.Name = "BucketVersionText"
$BucketVersionText.Size = New-Object System.Drawing.Size(10, 13)
$BucketVersionText.TabIndex = 12
$BucketVersionText.Text = "-"
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
$BucketsLoadedText.Location = New-Object System.Drawing.Point(290, 184)
$BucketsLoadedText.Name = "BucketsLoadedText"
$BucketsLoadedText.Size = New-Object System.Drawing.Size(10, 13)
$BucketsLoadedText.TabIndex = 10
$BucketsLoadedText.Text = "-"
#
# BucketsLoadedLabel
#
$BucketsLoadedLabel.AutoSize = $true
$BucketsLoadedLabel.Location = New-Object System.Drawing.Point(155, 184)
$BucketsLoadedLabel.Name = "BucketsLoadedLabel"
$BucketsLoadedLabel.Size = New-Object System.Drawing.Size(129, 13)
$BucketsLoadedLabel.TabIndex = 9
$BucketsLoadedLabel.Text = "Emulator Buckets Loaded"
#
# EmulatorsCountText
#
$EmulatorsCountText.AutoSize = $true
$EmulatorsCountText.Location = New-Object System.Drawing.Point(226, 162)
$EmulatorsCountText.Name = "EmulatorsCountText"
$EmulatorsCountText.Size = New-Object System.Drawing.Size(10, 13)
$EmulatorsCountText.TabIndex = 8
$EmulatorsCountText.Text = "-"
#
# EmulatorsCountLabel
#
$EmulatorsCountLabel.AutoSize = $true
$EmulatorsCountLabel.Location = New-Object System.Drawing.Point(156, 162)
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
$BucketHomeText.Size = New-Object System.Drawing.Size(10, 13)
$BucketHomeText.TabIndex = 6
$BucketHomeText.Text = "-"
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
$BucketLicenseText.Size = New-Object System.Drawing.Size(10, 13)
$BucketLicenseText.TabIndex = 4
$BucketLicenseText.Text = "-"
#
# BucketLicenseLabel
#
$BucketLicenseLabel.AutoSize = $true
$BucketLicenseLabel.Location = New-Object System.Drawing.Point(156, 48)
$BucketLicenseLabel.Name = "BucketLicenseLabel"
$BucketLicenseLabel.Size = New-Object System.Drawing.Size(44, 13)
$BucketLicenseLabel.TabIndex = 3
$BucketLicenseLabel.Text = "License"

function OnClick_BucketLicenseLabel {
	[void][System.Windows.Forms.MessageBox]::Show("The event handler BucketLicenseLabel.Add_Click is not implemented.")
}

$BucketLicenseLabel.Add_Click( { OnClick_BucketLicenseLabel } )

#
# BucketNameText
#
$BucketNameText.AutoSize = $true
$BucketNameText.Location = New-Object System.Drawing.Point(224, 19)
$BucketNameText.Name = "BucketNameText"
$BucketNameText.Size = New-Object System.Drawing.Size(10, 13)
$BucketNameText.TabIndex = 2
$BucketNameText.Text = "-"

function OnClick_BucketNameText {
	[void][System.Windows.Forms.MessageBox]::Show("The event handler BucketNameText.Add_Click is not implemented.")
}

$BucketNameText.Add_Click( { OnClick_BucketNameText } )

#
# BucketNameLabel
#
$BucketNameLabel.AutoSize = $true
$BucketNameLabel.Location = New-Object System.Drawing.Point(156, 19)
$BucketNameLabel.Name = "BucketNameLabel"
$BucketNameLabel.Size = New-Object System.Drawing.Size(35, 13)
$BucketNameLabel.TabIndex = 1
$BucketNameLabel.Text = "Name"

function OnClick_BucketNameLabel {
	[void][System.Windows.Forms.MessageBox]::Show("The event handler BucketNameLabel.Add_Click is not implemented.")
}

$BucketNameLabel.Add_Click( { OnClick_BucketNameLabel } )

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
$EmulatorsGroup.Controls.Add($EmulatorsTable)
$EmulatorsGroup.Location = New-Object System.Drawing.Point(311, 228)
$EmulatorsGroup.Name = "EmulatorsGroup"
$EmulatorsGroup.Size = New-Object System.Drawing.Size(566, 168)
$EmulatorsGroup.TabIndex = 4
$EmulatorsGroup.TabStop = $false
$EmulatorsGroup.Text = "Discovered Emulators"
#
# EmulatorsTable
#
$EmulatorsTable.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$EmulatorsTable.AllowUserToAddRows = $false
#$EmulatorsTable.Columns.AddRange(@($Select, $Path, $Emulator, $CurrentVersion, $NewVersion))
$EmulatorsTable.Columns.Add($Select)
$EmulatorsTable.Columns.Add($Path)
$EmulatorsTable.Columns.Add($Emulator)
$EmulatorsTable.Columns.Add($CurrentVersion)
$EmulatorsTable.Columns.Add($NewVersion)
$EmulatorsTable.Location = New-Object System.Drawing.Point(6, 19)
$EmulatorsTable.Name = "EmulatorsTable"
$EmulatorsTable.Size = New-Object System.Drawing.Size(554, 150)
$EmulatorsTable.TabIndex = 0
#
# Select
#
$Select.HeaderText = ""
$Select.Name = "Select"
$Select.Resizable = [System.Windows.Forms.DataGridViewTriState]::False
$Select.Width = 30
#
# Path
#
$Path.HeaderText = "Path"
$Path.Name = "Path"
$Path.Width = 200
#
# Emulator
#
$Emulator.HeaderText = "Emulator"
$Emulator.Name = "Emulator"
$Emulator.Width = 120
#
# CurrentVersion
#
$CurrentVersion.HeaderText = "Current Version"
$CurrentVersion.Name = "CurrentVersion"
$CurrentVersion.Width = 80
#
# NewVersion
#
$NewVersion.HeaderText = "New Version"
$NewVersion.Name = "NewVersion"
$NewVersion.Width = 80
#
# UpdateButton
#
$UpdateButton.Location = New-Object System.Drawing.Point(203, 107)
$UpdateButton.Name = "UpdateButton"
$UpdateButton.Size = New-Object System.Drawing.Size(83, 23)
$UpdateButton.TabIndex = 4
$UpdateButton.Text = "Run Updates"
$UpdateButton.UseVisualStyleBackColor = $true
#
# Form1
#
$Form1.ClientSize = New-Object System.Drawing.Size(897, 411)
$Form1.Controls.Add($EmulatorsGroup)
$Form1.Controls.Add($BucketsGroup)
$Form1.Controls.Add($LogGroup)
$Form1.Controls.Add($PathsGroup)
$Form1.Name = "Form1"
$Form1.Text = "Emulatest"

function OnLoad_Form1 {
	[void][System.Windows.Forms.MessageBox]::Show("The event handler Form1.Add_Load is not implemented.")
}

. (".\Functions.ps1")

$Form1.Add_Load( { OnLoad_Form1 } )


function OnFormClosing_Form1{
	# $this parameter is equal to the sender (object)
	# $_ is equal to the parameter e (eventarg)

	# The CloseReason property indicates a reason for the closure :
	#   if (($_).CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing)

	#Sets the value indicating that the event should be canceled.
	($_).Cancel= $False
}

$Form1.Add_FormClosing( { OnFormClosing_Form1} )

$Form1.Add_Shown({$Form1.Activate()})
$ModalResult=$Form1.ShowDialog()
# Release the Form
$Form1.Dispose()