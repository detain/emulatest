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
    $newDir = Join-Path -Path $PWD -ChildPath "new"
    $baseDir = Join-Path -Path $newDir -ChildPath "$BucketName"
    Write-Output "$baseDir Upgrading $BucketName located at $Path to version $($BucketData.version) with zip $urls"
    New-Item -ItemType Directory -Path $baseDir -Force | Out-Null
    $bucketZip = $urls | Split-Path -Leaf
    Invoke-WebRequest -Uri $urls -OutFile $bucketZip
    try {
        Write-Output "Extracting '$bucketZip'"
        $result = cmd /c ".\7zr.exe x -bb0 -aoa -o`"$baseDir`" `"$bucketZip`" 2>&1"
        if ($LASTEXITCODE -eq 0) {
            Remove-Item -Path $bucketZip -Force
            if ($bucketZip -match "\.tar\.") {
                Get-ChildItem "$baseDir\*.tar" | ForEach-Object {
                    $bucketZip = $_
                    Write-Output "Extracting '$bucketZip'"
                    $result = cmd /c "tar.exe -xvf `"$bucketZip`" -C `"$baseDir`" 2>&1"
                    if ($LASTEXITCODE -eq 0) {
                        Remove-Item -Path $bucketZip -Force
                    } else {
                        Write-Output "got extraction error: $result"
                    }
                }
            }
        } else {
            Write-Output "got extraction error: $result"
        }
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Output "Something threw an exception"
        Write-Output $_
    }
    if ($LASTEXITCODE -eq 0) {
        if ($extractDir -ne '') {
            $oldDir = Join-Path -Path $newDir -ChildPath "old"
            $moveDir = Join-Path -Path $oldDir -ChildPath "$extractDir"
            Write-Output "Only keeping the '$extractDir' directory"
            if (Test-Path -Path $oldDir) {
                Remove-Item -Recurse -Force "$oldDir"
            }
            Write-Output "Moving from '$baseDir' to '$oldDir' directory"
            Move-Item -Force "$baseDir" "$oldDir"
            Write-Output "Moving from '$moveDir' to 'baseDir' directory"
            Move-Item -Force "$moveDir" "$baseDir"
            if (Test-Path -Path $oldDir) {
                Remove-Item -Recurse -Force "$oldDir"
            }
        }
        $backupDir = Join-Path -Path $PWD -ChildPath "backup/$BucketName"
        Write-Output "Backing up $Path to $backupDir"
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        Copy-Item -Path "$Path\*" -Destination "$backupDir" -Recurse
        Write-Output "Overwriting $Path with files from $baseDir"
        Copy-Item -Path "$baseDir\*" -Destination "$Path" -Recurse -Force
        Write-Output "Cleaning up temp files in $baseDir"
        Remove-Item -Recurse -Force "$baseDir"
        if (-Not (Test-Path -Path "$newDir\*")) {
            Remove-Item "$newDir"
        }
    }
}

function Expand-Repo {
    Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
    Expand-Archive -Path "master.zip" -DestinationPath ".\" -Force
    Remove-Item -Path "master.zip" -Force
}

function Remove-Repo {
    Remove-Item -Path scoop-emulators-master -Recurse -Force
}

function Get-BucketCollection {
    $global:bucketNames = @()
    Get-ChildItem 'scoop-emulators-master\bucket\*\*.json' | ForEach-Object {
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
            $fileName = "scoop-emulators-master\bucket\$letter\$BucketName.json"
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
    return Get-Bucket-Field -Field 'extract_dir' -LastOnly
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
        #Write-Output("Bucket {0}: {1} {2} {3}" -f $BucketName, ($bins -join ", "), ($urls), (($extractDir -join ", ")))
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
        #Write-Output "Got: $fullPath"
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
