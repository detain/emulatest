function Save-Emulatest() {
    # Get the paths in the PathsList control
    $Paths = $PathsList.Items | ForEach-Object { $_.ToString() }
    # Get the emulators in the EmulatorsTable control
    $emulators = @()
    foreach ($row in $EmulatorsTable.Rows) {
        $Path = $row.Cells[1].Value
        $emulator = $row.Cells[2].Value
        $newVersion = $row.Cells[3].Value
        $currentVersion = $row.Cells[4].Value
        $checked = $row.Cells[0].Value -eq $true
        $emulators += [PSCustomObject]@{
            Path = $Path
            Emulator = $emulator
            NewVersion = $newVersion
            CurrentVersion = $currentVersion
            Checked = $checked
        }
    }
    # Combine the paths and emulators into an object
    $emulatest = [PSCustomObject]@{
        Paths = $Paths
        Emulators = $emulators
    }
    # Convert the object to JSON format
    $json = $emulatest | ConvertTo-Json -Depth 2
    # Write the JSON string to a file
    $jsonPath = "$($env:USERPROFILE)\.emulatest.json"
    Set-Content -Path $jsonPath -Value $json
}

function Restore-Emulatest() {
    # Read the JSON string from the file
    $jsonPath = "$($env:USERPROFILE)\.emulatest.json"
    $json = Get-Content -Path $jsonPath -Raw
    # Convert the JSON string to an object
    $emulatest = $json | ConvertFrom-Json
    # Update the PathsList control
    $PathsList.Items.Clear()
    foreach ($Path in $emulatest.Paths) {
        $PathsList.Items.Add($Path) | Out-Null
    }
    # Update the EmulatorsTable control
    $EmulatorsTable.Rows.Clear()
    foreach ($emulator in $emulatest.Emulators) {
        $checked = $emulator.Checked -eq $true
        $index = $EmulatorsTable.Rows.Add($checked, $emulator.Path, $emulator.Emulator, $emulator.NewVersion, $emulator.CurrentVersion)
        $EmulatorsTable.Rows[$index].Cells[0].Value = $checked
    }
}

$LoadButton.Add_Click({
    Restore-Emulatest
})
$SaveButton.Add_Click({
    Save-Emulatest
})
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
            Write-Output $item
        }
        $LogText.AppendText("Scanning Paths for emulators..." + [Environment]::NewLine)
        Find-Bucket-Matches -Paths $PathsList.Items -FileNames $global:regexes
        $LogText.AppendText("Finished scan..." + [Environment]::NewLine)
        $EmulatorsTable.Rows.Clear()
        Find-Emu-Matches
        foreach ($Path in $global:pathMatches.Keys) {
            foreach ($bin in $global:pathMatches[$Path]) {
                foreach ($BucketName in $global:bin2buckets[$bin]) {
                    $newVersion = 'new'
                    $oldVersion = 'old'
                    $EmulatorsTable.Rows.Add($false, $Path, $BucketName, $oldVersion, $newVersion)
                }
            }
        }
    })

$UpdateButton.Add_Click({
        $LogText.AppendText("Starting update selected emulators..." + [Environment]::NewLine)
        $checkedPathsAndEmulators = @()
        foreach ($row in $EmulatorsTable.Rows) {
            if ($row.Cells[0].Value -eq $true) {
                $Path = $row.Cells[1].Value
                $BucketName = $row.Cells[2].Value
                $checkedPathsAndEmulators += [PSCustomObject]@{
                    Path = $Path
                    Emulator = $BucketName
                }
                $LogText.AppendText("Updating $BucketName at $Path" + [Environment]::NewLine)
                Update-Emulator -BucketName $BucketName -Path $Path
            }
        }
        $LogText.AppendText("Finished update selected emulators." + [Environment]::NewLine)
    })

$MainWindow.Add_Shown({
        $MainWindow.Activate()
        $LogText.AppendText("Emulatest Emulation Updater..." + [Environment]::NewLine)

        #$Runspace = [runspacefactory]::CreateRunspace()
        #$PowerShell = [powershell]::Create()
        #$PowerShell.Runspace = $Runspace
        #$Runspace.Open()
        #$PowerShell.AddScript({
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
        #})
        #$Job = $PowerShell.BeginInvoke()

        # if doing an array of $Jobs use $Jobs.IsCompleted -contains $false
        #while ($Job.IsCompleted -eq $false) {
            #Start-Sleep -Milliseconds 100
        #}
        #$Output = $PowerShell.EndInvoke($Job)
        #$LogText.AppendText("got output" + $Output + [Environment]::NewLine)
        #$LogText.AppendText("background setup task completed" + [Environment]::NewLine)
    })

function ScaleBucketLogo($file) {
    # Load the original image
    $originalImage = [System.Drawing.Image]::FromFile($file)
    # Calculate the aspect ratios of the original image and the PictureBox
    $originalAspectRatio = $originalImage.Width / $originalImage.Height
    $pictureBoxAspectRatio = $BucketLogoImage.Width / $BucketLogoImage.Height
    # Calculate the dimensions of the thumbnail image
    if ($originalAspectRatio -gt $pictureBoxAspectRatio) {
        $thumbnailWidth = $BucketLogoImage.Width
        $thumbnailHeight = [int]($thumbnailWidth / $originalAspectRatio)
    } else {
        $thumbnailHeight = $BucketLogoImage.Height
        $thumbnailWidth = [int]($thumbnailHeight * $originalAspectRatio)
    }
    # Create the thumbnail image
    $thumbnailImage = $originalImage.GetThumbnailImage($thumbnailWidth, $thumbnailHeight, $null, [System.IntPtr]::Zero)
    # Set the thumbnail image as the PictureBox's Image property
    $BucketLogoImage.Image = $thumbnailImage
    # Dispose of the original and thumbnail images to free up memory
    $originalImage.Dispose()
    $thumbnailImage.Dispose()
}

function BucketSelected($listObj, $listArgs) {
    # $selectedIndex = $listObj.SelectedIndex
    $BucketName = $listObj.SelectedItem
    $data = Restore-Bucket -BucketName $BucketName
    $BucketNameText.Text = $data.name
    #ScaleBucketLogo($data.logo)
    $BucketLogoImage.Load($data.logo)
    $BucketDescriptionText.Text = $data.description
    $BucketHomeText.Text = $data.homepage
    $BucketLicenseText.Text = $data.license
    $BucketVersionText.Text = $data.version

    Write-Output "Selected item: $selectedItem"
}

# Add the SelectedIndexChanged event handler to the ListBox
$BucketsList.Add_SelectedIndexChanged({ BucketSelected $BucketsList $_ })
