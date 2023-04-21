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
        $LogText.AppendText("Scanning Paths for emulators..." + [Environment]::NewLine)
        Find-Bucket-Matches -Paths $PathsList.Items -FileNames $global:regexes
        $LogText.AppendText("Finished scan..." + [Environment]::NewLine)
        $EmulatorsTable.Rows.Clear()
        Find-Emu-Matches
        foreach ($path in $global:pathMatches.Keys) {
            foreach ($bin in $global:pathMatches[$path]) {
                $bucket = $global:bin2bucket[$bin]
                $newVersion = 'new'
                $oldVersion = 'old'
                $EmulatorsTable.Rows.Add($false, $path, $bucket, $oldVersion, $newVersion)
            }
        }
    })
$UpdateButton.Add_Click({
        $LogText.AppendText("Starting update selected emulators..." + [Environment]::NewLine)
        # PowerShell script code to update selected emulators in the table
        # You can use $logBox.AppendText to add messages to the log box
        $LogText.AppendText("Finished update selected emulators." + [Environment]::NewLine)
    })

$MainWindow.Add_Shown({
        $MainWindow.Activate()
        $LogText.AppendText("Emulatest Emulation Updater..." + [Environment]::NewLine)
        Write-Host "MainWindow Activated"
        $LogText.AppendText("Downloading and extracting latest emulator data..." + [Environment]::NewLine)
        Expand-Repo
        $LogText.AppendText("Loading data files..." + [Environment]::NewLine);
        Get-BucketCollection
        Read-BucketCollection
        $BucketsLoadedText.Text = $global:bucketNames.Count
        # also set this
        #$EmulatorsCountText
        $LogText.AppendText("Adding to list..." + [Environment]::NewLine)
        $BucketsList.Items.AddRange($global:bucketNames);
        $LogText.AppendText("done buckets list setup..." + [Environment]::NewLine)
    })

function BucketSelected($listObj, $listArgs) {
    # $selectedIndex = $listObj.SelectedIndex
    $bucket = $listObj.SelectedItem
    $data = Restore-Bucket($bucket)
    $BucketNameText.Text = $data.name
    $BucketLogoImage.Load($data.logo)
    $BucketDescriptionText.Text = $data.description
    $BucketHomeText.Text = $data.homepage
    $BucketLicenseText.Text = $data.license
    $BucketVersionText.Text = $data.version
    Write-Host "Selected item: $selectedItem"
}

# Add the SelectedIndexChanged event handler to the ListBox
$BucketsList.Add_SelectedIndexChanged({ BucketSelected $BucketsList $_ })
