$global:bucketNames = @()
$global:LoadedBucketData = @{}
$global:LoadedBucketName = ''
$global:LoadedBuckets = @{}
$global:regexMatches = @{}
$global:allBuckets = @{}
$global:bin2bucket = @{}
$global:regexes = @()
$global:totalBins = 0

function Expand-Repo {
    Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
    Expand-Archive -Path "master.zip" -DestinationPath "./" -Force
    Remove-Item -Path "master.zip" -Force
}

function Get-BucketCollection {
    $global:bucketNames = @()
    Get-ChildItem 'scoop-emulators-master/bucket/*/*.json' | ForEach-Object {
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
        $letter = $Bucket.Substring(0, 1)
        if (Compare-Numeric $letter) {
            $letter = "#"
        }
        $fileName = "scoop-emulators-master/bucket/$letter/$Bucket.json"
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

function Get-Bucket-ExtracteDir() {
    $extractDir = Get-Bucket-Field('extract_dir', $true)
    return $extractDir
}

function Get-Bucket-Url() {
    $urls = Get-Bucket-Field('url')
    return $urls
}

function Get-Bucket-Bin() {
    $bins = Get-Bucket-Field('bin')
    return $bins
}

function Read-BucketCollection {
    $global:bucketNames | ForEach-Object {
        $bucket = $_
        Restore-Bucket($bucket)
        $bins = Get-Bucket-Bin
        $urls = Get-Bucket-Url
        $extractDir = Get-Bucket-ExtracteDir
        $global:allBuckets[$bucket] = @{
            'bins' = $bins
            'urls' = $urls
        }
        if (-not [string]::IsNullOrWhiteSpace($extractDir)) {
            $global:allBuckets[$bucket]['extractDir'] = $extractDir
        }
        $bins | ForEach-Object {
            $bin = $_
            $global:totalBins++
            $bin = $bin.ToLower().Replace('\', '/')
            $regex = [regex]::Escape($bin)
            if (-not $global:regexes.Contains($regex)) {
                $global:regexes += $regex
            }
            if (-not $global:bin2bucket.ContainsKey($bin)) {
                $global:bin2bucket[$bin] = @()
            }
            $global:bin2bucket[$bin] += $bucket
        }
        Write-Output("Bucket {0}: {1} {2} {3}" -f $bucket, ($bins -join ", "), ($urls), ($extractDir))
    }
}

function Find-Bucket-Matches {
    #$searchDir = $args[0]
    $searchDir = "F:\Consoles\RetroBat"
    Write-Output "Found $global:totalBins Bins and $($bins.Count) Unique Bins to search for"
    $regexPattern = '(' + [string]::Join('|', ($global:regexes | ForEach-Object { [regex]::Escape($_) })) + ')'
    $global:regexMatches = Select-String -Path (Get-ChildItem -Path $searchDir -Recurse -Include $regexPattern) -Pattern $regexPattern -AllMatches | Select-Object -ExpandProperty Matches
    return $global:regexMatches
}


function Find-Emu-Matches {
    $out = @{
        'paths' = @()
        'emus'  = @()
    }
    $fileEmus = @{}
    $global:regexMatches | ForEach-Object {
        $regexMatch = $_
        $fileName = $regexMatch.Value
        $bin = $regexMatch.Groups[1].Value.ToLower()
        if (-not $global:bin2bucket.ContainsKey($bin)) {
            Write-Output "Cant find $bin in: $($global:bin2bucket.Keys -join ', ')"
        }
        else {
            $dirName = Split-Path $fileName -Parent
            $fileEmus[$dirName] = $global:bin2bucket[$bin]
            $out.paths[$dirName] = $fileEmus[$dirName]
            $global:bin2bucket[$bin] | ForEach-Object {
                $emu = $_
                $out.emus[$emu] = $global:allBuckets[$emu]
            }
        }
    }
    return $out
}

#Expand-Repo
#Get-BucketCollection
#Read-BucketCollection
#Find-Bucket-Matches
#$out = Find-Emu-Matches
#$out | ConvertTo-Json -Depth 10 | Set-Content -Path 'found_emulators.json'
#Remove-Item -Path scoop-emulators-master -Recurse -Force
