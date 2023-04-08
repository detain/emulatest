
# Add event handlers to the add and remove buttons to modify the list of directories:
$AddPathButton.Add_Click({
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.ShowDialog() | Out-Null
    if ($dialog.SelectedPath) {
        $PathsList.Items.Add($dialog.SelectedPath)
    }
})
$RemovePathButton.Add_Click({
    $PathsList.Items.Remove($PathsList.SelectedItem)
})
$ScanPathButton.Add_Click({
    foreach ($item in $PathsList.Items) {
        $LogText.AppendText("Got Item " + $item + [Environment]::NewLine)
        Write-Host $item
    }
    $EmulatorsTable.Rows.Clear()
    # PowerShell script code to scan paths for emulators and get their current and new versions
    # You can use $EmulatorsTable.Rows.Add to add rows to the table
    # Example code to add a row to the table:
    $EmulatorsTable.Rows.Add($false, "C:\Emulators\SNES", "snes9x", "1.60", "1.61")
    $EmulatorsTable.Rows.Add($false, "C:\Emulators\cemu", "cemu", "1.0", "1.1")
})
$UpdateButton.Add_Click({
    $LogText.AppendText("Starting update selected emulators..." + [Environment]::NewLine)
    # PowerShell script code to update selected emulators in the table
    # You can use $logBox.AppendText to add messages to the log box
    $LogText.AppendText("Finished update selected emulators." + [Environment]::NewLine)
})
$LogText.AppendText("Emulatest Emulation Updater..." + [Environment]::NewLine)



