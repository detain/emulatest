$BucketNames = @()
$LoadedBucketData = @{}
$LoadedBucketName = ''
$LoadedBuckets = @{}
$regexMatches = @{}
$allBuckets = @{}
$bin2bucket = @{}
$regexes = @()
$totalBins = 0


function Expand-Repo {
    Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
    Expand-Archive -Path "master.zip" -DestinationPath "./" -Force
    Remove-Item -Path "master.zip" -Force
}

function Get-BucketCollection {
    $bucketNames = @()
    Get-ChildItem '/mnt/e/dev/scoop-emulators/bucket/*/*.json' | ForEach-Object {
        $fileName = $_
        $bucketNames += [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    }
    return $bucketNames
}

function Compare-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}

function Restore-Bucket ($Bucket) {
    if ($LoadedBucketName -ne $Bucket) {
        $letter = $Bucket.Substring(0, 1)
        if (Compare-Numeric $letter) {
            $letter     = "#"
            $fileName   = "/mnt/e/dev/scoop-emulators/bucket/$letter/$Bucket.json"
            $data       = Get-Content $fileName | ConvertFrom-Json
            $LoadedBucketData = $data
            $LoadedBucketName = $Bucket
            $LoadedBuckets[$LoadedBucketName] = $LoadedBucketData
        }
    }
    return $LoadedBucketData
}

function Get-Bucket-Field($bucketFile, $field = 'bin', $lastOnly = $false) {
    $data = Restore-Bucket($bucketFile)
    $return = @()
    $sections = @(@(), @('architecture'), @('architecture', '32bit'), @('architecture', '64bit'))
    $sections | ForEach-Object {
        $section = $_
        $var = $data
        if ($section.Count -gt 0) {
            $section | ForEach-Object {
                $s = $_
                if ($var.$s) {
                    $var = $var.$s
                } else {
                    break
                }
            }
        }
        if ($var.$field) {
            $values = $var.$field
            if (-not $values.GetType().IsArray) {
                $values = @($values)
            }
            $values | ForEach-Object {
                $value = $_
                if ($value.GetType().IsArray) {
                    $value = $value[0]
                }
                if (-not $return.Contains($value)) {
                    $return += $value
                }
            }
        }
    }
    if ($lastOnly) {
        return $return[-1]
    }
    return $return
}

function Get-Bucket-ExtracteDir() {
    $extractDir = Get-Bucket-Field('extract_dir', $true)
    return $extractDir
}

function Get-Bucket-Url() {
    $urls = Get-Bucket-Field('extract_dir')
    return $urls
}

function Get-Bucket-Bin() {
    $bins = Get-Bucket-Field('extract_dir')
    return $bins
}

function Read-BucketCollection {
    $bucketNames | ForEach-Object {
        $bucket = $_
        Restore-Bucket($bucket)
        $bins = Get-Bucket-Bin
        $urls = Get-Bucket-Url
        $extractDir = Get-Bucket-ExtracteDir
        $allBuckets[$bucket] = @{
            'bins' = $bins
            'urls' = $urls
        }
        if (-not [string]::IsNullOrWhiteSpace($extractDir)) {
            $allBuckets[$bucket]['extractDir'] = $extractDir
        }
        $bins | ForEach-Object {
            $bin = $_
            $totalBins++
            $bin = $bin.ToLower().Replace('\', '/')
            $regex = [regex]::Escape($bin)
            if (-not $regexes.Contains($regex)) {
                $regexes += $regex
            }
            if (-not $bin2bucket.ContainsKey($bin)) {
                $bin2bucket[$bin] = @()
            }
            $bin2bucket[$bin] += $bucket
        }
        Write-Output("Bucket {0}: {1} {2} {3}" -f $bucket, ($bins -join ", "), (Get-Bucket-Url), (Get-Bucket-ExtracteDir))
    }
}

function Find-Bucket-Matches {
    #$searchDir = $args[0]
    $searchDir = "F:\Consoles\RetroBat"
    Write-Output "Found $totalBins Bins and $($bins.Count) Unique Bins to search for"
    $regexesPattern = '(' + [string]::Join('|', ($regexes | ForEach-Object { [regex]::Escape($_) })) + ')'
    $regexMatches = Select-String -Path (Get-ChildItem -Path $searchDir -Recurse -Include $regexesPattern) -Pattern $regexesPattern -AllMatches | Select-Object -ExpandProperty Matches
    return $regexMatches;
}


function Find-Emu-Matches {
    $out = @{
        'paths' = @()
        'emus' = @()
    }
    $fileEmus = @{}
    $regexMatches | ForEach-Object {
        $regexMatch = $_
        $fileName = $regexMatch.Value
        $bin = $regexMatch.Groups[1].Value.ToLower()
        if (-not $bin2bucket.ContainsKey($bin)) {
            Write-Output "Cant find $bin in: $($bin2bucket.Keys -join ', ')"
        } else {
            $dirName = Split-Path $fileName -Parent
            $fileEmus[$dirName] = $bin2bucket[$bin]
            $out.paths[$dirName] = $fileEmus[$dirName]
            $bin2bucket[$bin] | ForEach-Object {
                $emu = $_
                $out.emus[$emu] = $allBuckets[$emu]
            }
        }
    }
    return $out
}

Expand-Repo
Get-BucketCollection
Read-BucketCollection
$regexMatches = Find-Bucket-Matches
$out = Find-Emu-Matches
$out | ConvertTo-Json -Depth 10 | Set-Content -Path 'found_emulators.json'

