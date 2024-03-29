$global:pathMatches = @{}
$global:bucketNames = @()
$global:LoadedBucketData = @{}
$global:LoadedBucketName = ''
$global:LoadedBuckets = @{}
$global:regexMatches = @{}
$global:allBuckets = @{}
$global:bin2buckets = @{}
$global:regexes = @()
$global:totalBins = 0
$global:scriptDir = $PSScriptRoot

function Update-Emulator {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$BucketName,

        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    $BucketData = Restore-Bucket -BucketName $BucketName
    $urls = Get-Bucket-Url
    $extractDir = Get-Bucket-ExtractDir
    $emulatestPath = Join-Path $env:USERPROFILE ".emulatest"
    $newDir = Join-Path $emulatestPath "new"
    $baseDir = Join-Path -Path $newDir -ChildPath "$BucketName"
    Write-Host "$baseDir Upgrading $BucketName located at $Path to version $($BucketData.version) with zip $urls"
    New-Item -ItemType Directory -Path $baseDir -Force | Out-Null
    $bucketZip = $urls | Split-Path -Leaf
    $bucketZip = "$emulatestPath\$bucketZip"
    Invoke-WebRequest -Uri $urls -UseBasicParsing -MaximumRedirection 10 -OutFile $bucketZip
    try {
        Write-Host "Extracting '$bucketZip'"
        $baseDrive = Split-Path -Qualifier $env:USERPROFILE
        #$baseDrive
        #Set-Location $baseDrive
        #Set-Location $emulatestPath
        $emulatestPath = Join-Path $env:USERPROFILE ".emulatest"
        $newBucketPath = Join-Path $emulatestPath "new\$BucketName"
        if (-not (Test-Path $newBucketPath)) {
            New-Item -ItemType Directory -Path $newBucketPath -Force | Out-Null
        }
        $zipFilePath = Join-Path $emulatestPath "$BucketName.zip"
        $exePath = Join-Path $PSScriptRoot "7zr.exe"
        #Invoke-WebRequest -Uri $urls -UseBasicParsing -MaximumRedirection 10 -OutFile $zipFilePath
        Set-Location $emulatestPath
        #& $exePath x $($urls | Split-Path -Leaf) "-onew\$BucketName" -aoa -bb0
        $cmd = "7z.exe x $($urls | Split-Path -Leaf) `"-onew\$BucketName`" -aoa -bb0"
        #$cmd = "$global:scriptDir\7zr.exe x -bb0 -aoa -o`"$baseDir`" `"$bucketZip`"";
        Write-Host "Running Command: $cmd"
        $result = cmd /c $cmd
        #$result = cmd /c "$global:scriptDir\7zr.exe" x -bb0 -aoa -o"$baseDir" "$bucketZip"
        #& "$global:scriptDir\7zr.exe" x -bb0 -aoa -o"$baseDir" "$bucketZip"
        #Write-Host "Got Exit Code $LASTEXITCODE"
        Write-Host "Got Exit Code $LASTEXITCODE Result $result"
        if ($LASTEXITCODE -eq 0) {
            Remove-Item -Path $bucketZip -Force
            if ($bucketZip -match "\.tar\.") {
                Get-ChildItem "$baseDir\*.tar" | ForEach-Object {
                    $bucketZip = $_
                    Write-Host "Extracting '$bucketZip'"
                    $cmd = "tar.exe -xvf `"$bucketZip`" -C `"$baseDir`" 2>&1"
                    Write-Host "Running Command: $cmd"
                    $result = cmd /c $cmd
                    Write-Host "Got Exit Code $LASTEXITCODE Result $result`n"
                    if ($LASTEXITCODE -eq 0) {
                        #Remove-Item -Path $bucketZip -Force
                    } else {
                        Write-Host "got tar extraction error: $result`n"
                    }
                }
            }
        } else {
            Write-Host "got extraction error: $result`n"
        }
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Host "Something threw an exception"
        Write-Host $_
    }
    if ($LASTEXITCODE -eq 0) {
        if ($extractDir -ne '') {
            $oldDir = Join-Path -Path $newDir -ChildPath "old"
            $moveDir = Join-Path -Path $oldDir -ChildPath "$extractDir"
            Write-Host "Only keeping the '$extractDir' directory'n"
            if (Test-Path -Path $oldDir) {
                Remove-Item -Recurse -Force "$oldDir"
            }
            Write-Host "Moving from '$baseDir' to '$oldDir' directory'n"
            Move-Item -Force "$baseDir" "$oldDir"
            Write-Host "Moving from '$moveDir' to 'baseDir' directory'n"
            Move-Item -Force "$moveDir" "$baseDir"
            if (Test-Path -Path $oldDir) {
                Remove-Item -Recurse -Force "$oldDir"
            }
        }
        $backupDir = Join-Path -Path "$($env:USERPROFILE)\.emulatest" -ChildPath "backup\$BucketName"
        Write-Host "Backing up $Path to $backupDir`n"
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        Copy-Item -Path "$Path\*" -Destination "$backupDir" -Recurse

        Write-Host "Overwriting $Path with files from $baseDir"
        Copy-Item -Path "$baseDir\*" -Destination "$Path" -Recurse -Force

        Write-Host "Cleaning up temp files in $baseDir"
        Remove-Item -Recurse -Force "$baseDir"
        if (-Not (Test-Path -Path "$newDir\*")) {
            Remove-Item "$newDir"
        }
    }
    Set-Location $global:scriptDir
}

function Expand-Repo {
    New-Item -ItemType Directory -Path "$($env:USERPROFILE)\.emulatest" -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "$($env:USERPROFILE)\.emulatest\master.zip"
    Expand-Archive -Path "$($env:USERPROFILE)\.emulatest\master.zip" -DestinationPath "$($env:USERPROFILE)\.emulatest" -Force
    Remove-Item -Path "$($env:USERPROFILE)\.emulatest\master.zip" -Force
}

function Remove-Repo {
    Remove-Item -Path "$($env:USERPROFILE)\.emulatest\scoop-emulators-master" -Recurse -Force
}

function Get-BucketCollection {
    $global:bucketNames = @()
    Get-ChildItem "$($env:USERPROFILE)\.emulatest\scoop-emulators-master\bucket\*\*.json" | ForEach-Object {
        $fileName = $_
        $global:bucketNames += [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    }
    return $global:bucketNames
}

function Compare-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}

function Restore-Bucket {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$BucketName
    )
    if ($global:LoadedBucketName -ne $BucketName) {
        if ($global:LoadedBuckets.ContainsKey($BucketName)) {
            $global:LoadedBucketName = $BucketName
            $global:LoadedBucketData = $global:LoadedBuckets[$BucketName]
        } else {
            $letter = $BucketName.Substring(0, 1)
            if (Compare-Numeric $letter) {
                $letter = "#"
            }
            $fileName = "$($env:USERPROFILE)\.emulatest\scoop-emulators-master\bucket\$letter\$BucketName.json"
            $data = Get-Content $fileName | ConvertFrom-Json -AsHashtable
            if ($data.ContainsKey("##")) {
                foreach ($row in $data["##"]) {
                    if ($row -match '^(.*?):(.*)$') {
                        $Field = $matches[1].Trim()
                        $value = $matches[2].Trim()
                        $data[$Field] = $value
                    }
                }
                $data.Remove("##") # Remove the ## element from the hashtable
            }
            $global:LoadedBucketData = $data
            $global:LoadedBucketName = $BucketName
            $global:LoadedBuckets[$global:LoadedBucketName] = $global:LoadedBucketData
        }
    }
    return $global:LoadedBucketData
}

function Get-Bucket-Field {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Field = 'bin',

        [Parameter(Mandatory=$false)]
        [boolean]$LastOnly = $false
    )

    if ($global:LoadedBucketData.architecture) {
        if ($global:LoadedBucketData.architecture['64bit'] -and $global:LoadedBucketData.architecture['64bit'][$Field]) {
            return $global:LoadedBucketData.architecture['64bit'][$Field]
        }
        if ($global:LoadedBucketData.architecture['32bit'] -and $global:LoadedBucketData.architecture['32bit'][$Field]) {
            return $global:LoadedBucketData.architecture['32bit'][$Field]
        }
        if ($global:LoadedBucketData.architecture[$Field]) {
            return $global:LoadedBucketData.architecture[$Field]
        }
    }
    if ($global:LoadedBucketData[$Field]) {
        return $global:LoadedBucketData[$Field]
    }
    return ''
}

function Get-Bucket-ExtractDir {
    return Get-Bucket-Field -Field 'extract_dir'
}

function Get-Bucket-Url {
    return Get-Bucket-Field -Field 'url'
}

function Get-Bucket-Bin {
    return Get-Bucket-Field -Field 'bin'
}

function Read-BucketCollection {
    $global:bucketNames | ForEach-Object {
        $BucketName = $_
        Restore-Bucket  -BucketName $BucketName
        $bins = Get-Bucket-Bin
        $urls = Get-Bucket-Url
        $extractDir = Get-Bucket-ExtractDir
        $global:allBuckets[$BucketName] = @{
            'bins' = $bins
            'urls' = $urls
        }
        if (-not [string]::IsNullOrWhiteSpace($extractDir)) {
            $global:allBuckets[$BucketName]['extractDir'] = $extractDir
        }
        $bins | ForEach-Object {
            $bin = $_
            if ($bin -ne '') {
                $global:totalBins++
                #$bin = $bin.ToLower().Replace('\', '/')
                #$regex = [regex]::Escape($bin)
                $regex = $bin;
                if (-not $global:regexes.Contains($regex)) {
                    $global:regexes += $regex
                }
                if (-not $global:bin2buckets.ContainsKey($bin)) {
                    $global:bin2buckets[$bin] = @()
                }
                if (-not $global:bin2buckets[$bin].Contains($BucketName)) {
                    $global:bin2buckets[$bin] += $BucketName
                }
            }
        }
        #Write-Host("Bucket {0}: {1} {2} {3}" -f $BucketName, ($bins -join ", "), ($urls), (($extractDir -join ", ")))
    }
}

function Find-Bucket-Matches {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Paths,

        [Parameter(Mandatory=$true)]
        [string[]]$FileNames
    )
    $global:regexMatches = Get-ChildItem -Path $Paths -Recurse -Include $FileNames -File | Select-Object -ExpandProperty FullName
    #$global:regexMatches = @()
    #foreach ($path in $Paths) {
    #    if (Test-Path -Path $path -PathType Container) {
    #        $global:regexMatches += Get-ChildItem -Path $Paths -Recurse -Include $FileNames -File | Select-Object -ExpandProperty FullName
    #    }
    #}
    return $global:regexMatches
}

function Find-Emu-Matches {
    foreach ($fullPath in $global:regexMatches) {
        #Write-Host "Got: $fullPath"
        foreach ($bin in $global:bin2buckets.Keys) {
            if ($fullPath.EndsWith($bin)) {
                $dirName = Split-Path $fullPath -Parent
                if (-not $global:pathMatches.ContainsKey($dirName)) {
                    $global:pathMatches[$dirName] = @()
                }
                $global:pathMatches[$dirName] += $bin
            }
        }
    }
    return $global:pathMatches;
}
