# https://domruggeri.com/2019/07/06/creating-extensive-powershell-gui-applications-part-1/
# https://domruggeri.com/2019/07/09/creating-extensive-powershell-gui-applications-part-2/
# https://learn.microsoft.com/en-us/powershell/scripting/samples/selecting-items-from-a-list-box?view=powershell-7.3
# Convert-Form -Path "E:\dev\WindowsFormsApp1\Form1.Designer.cs" -Destination "E:\dev\emulatest\converted" -Encoding ascii -force


# Start by importing the Windows Forms assembly:
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

# Create a new form and add UI elements for the list of directories and buttons to add/remove directories:
[System.Windows.Forms.Application]::EnableVisualStyles();
$form = New-Object System.Windows.Forms.Form
$form.Text = "Emulator Updater"
$form.Size = New-Object System.Drawing.Size(900, 500)
$form.StartPosition = "CenterScreen"
$listBox = New-Object System.Windows.Forms.ListBox
$addButton = New-Object System.Windows.Forms.Button
$removeButton = New-Object System.Windows.Forms.Button
$listBox.Location = New-Object System.Drawing.Point(10, 10)
$listBox.Size = New-Object System.Drawing.Size(250, 150)
$addButton.Location = New-Object System.Drawing.Point(10, 170)
$addButton.Size = New-Object System.Drawing.Size(75, 23)
$addButton.Text = "Add"
$removeButton.Location = New-Object System.Drawing.Point(90, 170)
$removeButton.Size = New-Object System.Drawing.Size(75, 23)
$removeButton.Text = "Remove"
$form.Controls.Add($listBox)
$form.Controls.Add($addButton)
$form.Controls.Add($removeButton)

# Add a RichTextBox control to the form to serve as the log box:
$logBox = New-Object System.Windows.Forms.RichTextBox
$logBox.Location = New-Object System.Drawing.Point(10, 230)
$logBox.Size = New-Object System.Drawing.Size(250, 100)
$form.Controls.Add($logBox)

# Add event handlers to the add and remove buttons to modify the list of directories:
$addButton.Add_Click({
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.ShowDialog() | Out-Null
    if ($dialog.SelectedPath) {
        $listBox.Items.Add($dialog.SelectedPath)
    }
})
$removeButton.Add_Click({
    $listBox.Items.Remove($listBox.SelectedItem)
})


# Add a DataGridView control to the form and configure its columns:
$table = New-Object System.Windows.Forms.DataGridView
$table.Location = New-Object System.Drawing.Point(270, 10)
$table.Size = New-Object System.Drawing.Size(520, 320)
$table.RowHeadersVisible = $false
$table.AllowUserToAddRows = $false
$column1 = New-Object System.Windows.Forms.DataGridViewCheckBoxColumn
$column1.Name = "Select"
$column1.HeaderText = ""
$column1.Width = 30
[void]$table.Columns.Add($column1)
$column2 = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$column2.Name = "Path"
$column2.HeaderText = "Path"
$column2.Width = 200
[void]$table.Columns.Add($column2)
$column3 = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$column3.Name = "Emulator"
$column3.HeaderText = "Emulator"
$column3.Width = 120
[void]$table.Columns.Add($column3)
$column4 = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$column4.Name = "CurrentVersion"
$column4.HeaderText = "Current Version"
$column4.Width = 100
[void]$table.Columns.Add($column4)
$column5 = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
$column5.Name = "NewVersion"
$column5.HeaderText = "New Version"
$column5.Width = 100
[void]$table.Columns.Add($column5)
$form.Controls.Add($table)


# Add a "Scan Paths" button that scans the directories in the list for emulators and populates a table with checkable items:
$scanButton = New-Object System.Windows.Forms.Button
$scanButton.Location = New-Object System.Drawing.Point(170, 170)
$scanButton.Size = New-Object System.Drawing.Size(90, 23)
$scanButton.Text = "Scan Paths"
$form.Controls.Add($scanButton)
$scanButton.Add_Click({
    foreach ($item in $listBox.Items) {
        $logBox.AppendText("Got Item " + $item + [Environment]::NewLine)
        Write-Host $item
    }

    $table.Rows.Clear()

    # PowerShell script code to scan paths for emulators and get their current and new versions
    # You can use $table.Rows.Add to add rows to the table

    # Example code to add a row to the table:
    $table.Rows.Add($false, "C:\Emulators\SNES", "snes9x", "1.60", "1.61")
    $table.Rows.Add($false, "C:\Emulators\cemu", "cemu", "1.0", "1.1")
})


# Add an "Update Selected Emulators" button that updates the selected emulators in the table:
$updateButton = New-Object System.Windows.Forms.Button
$updateButton.Location = New-Object System.Drawing.Point(10, 200)
$updateButton.Size = New-Object System.Drawing.Size(120, 23)
$updateButton.Text = "Update Selected Emulators"
$form.Controls.Add($updateButton)
# In the "Update Selected Emulators" button event handler, you can add messages to the log box using its AppendText method:
$updateButton.Add_Click({
    $logBox.AppendText("Starting update selected emulators..." + [Environment]::NewLine)
    # PowerShell script code to update selected emulators in the table
    # You can use $logBox.AppendText to add messages to the log box
    $logBox.AppendText("Finished update selected emulators." + [Environment]::NewLine)
})

$logBox.AppendText("Emulatest Emulation Updater..." + [Environment]::NewLine)

# Finally, display the form:
$form.ShowDialog() | Out-Null
