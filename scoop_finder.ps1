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

function Get-Emulator() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$BucketName,

        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    $BucketData = Restore-Bucket($BucketName)
    $urls = Get-Bucket-Url
    $extractDir = Get-Bucket-ExtractDir
    $urls
    $extractDir
    $BucketData
    $baseDir = "$($PWD)\new\$($BucketName)"
    Write-Output "$baseDir Upgrading $BucketName located at $Path to version $($BucketData.version) with zip $urls"
    New-Item -ItemType Directory -Path $baseDir -Force | Out-Null
    $bucketZip = $urls | Split-Path -Leaf
    Invoke-WebRequest -Uri $urls -OutFile $bucketZip
    Expand-Archive -Path $bucketZip -DestinationPath $baseDir -Force
    $resultCode = cmd /c "7z x -bb0 -aoa -o`"$baseDir`" `"$bucketZip`"
    if ($resultCode -ne 0) {
        $results += "7z $emuId"
        Remove-Item -Path $bucketZip -Force
    }
    Write-Output "Got Exit Code $resultCode"

}

<#     foreach ($emuId in $data.emus.Keys) {
        $emuData = $data.emus[$emuId]
        $baseDir = "$PSScriptRoot\new\$emuId"
        $moveDir = "$baseDir\extracted"
        $finalDir = "$baseDir\final"

        if (!(Test-Path $finalDir)) {
            Write-Output "Emulator $emuId"
            New-Item -ItemType Directory -Path $moveDir -Force | Out-Null
            Write-Output "  Downloading $($emuData.urls)"
            Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
            Expand-Archive -Path "master.zip" -DestinationPath ".\" -Force
            Remove-Item -Path "master.zip" -Force

            $resultCode = cmd /c "wget --max-redirect 100 -c $($emuData.urls) -O `"$($baseDir)\$($emuData.urls | Split-Path -Leaf)`""
            if ($resultCode -ne 0) {
                $results += "dl $emuId"
            }
            Write-Output "Got Exit Code $resultCode"
            Write-Output "  Extracting $($emuData.urls)"
            if ($emuData.urls -match '\.tar\.(xz|bz2|gz)$') {
                $resultCode = cmd /c "tar -C `"$moveDir`" -xvf `"$($baseDir)\$($emuData.urls | Split-Path -Leaf)`""
            }
            else {
                $resultCode = cmd /c "7z x -bb0 -aoa -o`"$moveDir`" `"$($baseDir)\$($emuData.urls | Split-Path -Leaf)`""
            }
            if ($resultCode -ne 0) {
                $results += "7z $emuId"
            }
            Write-Output "Got Exit Code $resultCode"
            if ($emuData.extractDir -and (Test-Path "$moveDir\$($emuData.extractDir)")) {
                $moveDir += "\$($emuData.extractDir)"
            }
            Move-Item $moveDir $finalDir
            $results
        }
    }
}
 #>

function Install-Emulator() {
    foreach ($emuPath in $data.paths.Keys) {
        $emus = $data.paths[$emuPath]
        if ($emus.Count -ne 1) {
            Write-Output "Wrong count of emus ($($emus -join ','))"
            continue
        }
        $emuId = $emus[0]
        $emuData = $data.emus[$emuId]
        $baseDir = "$PSScriptRoot\new\$emuId"
        $backupZip = "$baseDir\backup_$emuId_$($emuPath -replace '\', '_')_$(Get-Date -Format yyyyMMdd).zip"
        $finalDir = "$baseDir\final"
        if ($doBackup && !Test-Path $backupZip) {
            Write-Output "  Backing up to $backupZip";
            $escapedBackupZip = [System.Management.Automation.WildcardPattern]::Escape($backupZip)
            $escapedEmuPath = [System.Management.Automation.WildcardPattern]::Escape($emuPath)
            & 'zip.exe' '-r' $escapedBackupZip $escapedEmuPath | Write-Output
        }
        if (Test-Path $finalDir) {
            Write-Output "Emulator $emuId $finalDir => $emuPath"
            $cmd = "cp -afv `"$finalDir\*`" `"$emuPath\`""
            Write-Output $cmd
            cmd /c $cmd
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

function Restore-Bucket ($Bucket) {
    if ($global:LoadedBucketName -ne $Bucket) {
        if ($global:LoadedBuckets.ContainsKey($Bucket)) {
            $global:LoadedBucketName = $Bucket
            $global:LoadedBucketData = $global:LoadedBuckets[$Bucket]
        } else {
            $letter = $Bucket.Substring(0, 1)
            if (Compare-Numeric $letter) {
                $letter = "#"
            }
            $fileName = "scoop-emulators-master\bucket\$letter\$Bucket.json"
            $data = Get-Content $fileName | ConvertFrom-Json -AsHashtable
            if ($data.ContainsKey("##")) {
                foreach ($row in $data["##"]) {
                    if ($row -match '^(.*?):(.*)$') {
                        $field = $matches[1].Trim()
                        $value = $matches[2].Trim()
                        $data[$field] = $value
                    }
                }
                $data.Remove("##") # Remove the ## element from the hashtable
            }
            $global:LoadedBucketData = $data
            $global:LoadedBucketName = $Bucket
            $global:LoadedBuckets[$global:LoadedBucketName] = $global:LoadedBucketData
        }
    }
    return $global:LoadedBucketData
}

function Get-Bucket-Field($field = 'bin', $lastOnly = $false) {
    if ($global:LoadedBucketData.architecture) {
        if ($global:LoadedBucketData.architecture['64bit'] -and $global:LoadedBucketData.architecture['64bit'][$field]) {
            return $global:LoadedBucketData.architecture['64bit'][$field]
        }
        if ($global:LoadedBucketData.architecture['32bit'] -and $global:LoadedBucketData.architecture['32bit'][$field]) {
            return $global:LoadedBucketData.architecture['32bit'][$field]
        }
        if ($global:LoadedBucketData.architecture[$field]) {
            return $global:LoadedBucketData.architecture[$field]
        }
    }
    if ($global:LoadedBucketData[$field]) {
        return $global:LoadedBucketData[$field]
    }
    return ''
}

function Get-Bucket-ExtractDir() {
    return Get-Bucket-Field('extract_dir')
}

function Get-Bucket-Url() {
    return Get-Bucket-Field('url')
}

function Get-Bucket-Bin() {
    return Get-Bucket-Field('bin')
}

function Read-BucketCollection {
    $global:bucketNames | ForEach-Object {
        $bucket = $_
        Restore-Bucket($bucket)
        $bins = Get-Bucket-Bin
        $urls = Get-Bucket-Url
        $extractDir = Get-Bucket-ExtractDir
        $global:allBuckets[$bucket] = @{
            'bins' = $bins
            'urls' = $urls
        }
        if (-not [string]::IsNullOrWhiteSpace($extractDir)) {
            $global:allBuckets[$bucket]['extractDir'] = $extractDir
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
                if (-not $global:bin2buckets[$bin].Contains($bucket)) {
                    $global:bin2buckets[$bin] += $bucket
                }
            }
        }
        #Write-Output("Bucket {0}: {1} {2} {3}" -f $bucket, ($bins -join ", "), ($urls), (($extractDir -join ", ")))
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

#Expand-Repo
#Get-BucketCollection
#Read-BucketCollection
#Find-Bucket-Matches
#$out = Find-Emu-Matches
#$out | ConvertTo-Json -Depth 10 | Set-Content -Path 'found_emulators.json'
#Remove-Item -Path scoop-emulators-master -Recurse -Force
