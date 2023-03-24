function find($searchDir) {
    Write-Host "Searching $searchDir ..."
    $cmd = "Get-ChildItem $searchDir -Recurse -File"
    $return = Invoke-Expression $cmd
    Write-Host "done"
    return $return
}

class Bucket {
    protected static $data;

    public static function load($bucket) {
        $letter = $bucket.Substring(0, 1)
        if ([char]::IsNumber($letter))
            $letter = "#"
        $fileName = "/mnt/e/dev/scoop-emulators/bucket/$letter/$bucket.json"
        $data = Get-Content $fileName | ConvertFrom-Json
        self::$data = $data
    }

    public static function getExtracteDir() {
        $extractDir = self::getField('extract_dir', $true)
        return $extractDir
    }

    public static function getUrls() {
        $urls = self::getField('extract_dir')
        return $urls
    }

    public static function getBins() {
        $bins = self::getField('extract_dir')
        return $bins
    }

    public static function getField($bucketFile, $field = 'bin', $lastOnly = $false) {
        $data = Get-Content $bucketFile -Raw | ConvertFrom-Json
        $return = @()
        $sections = @(@(), @('architecture'), @('architecture', '32bit'), @('architecture', '64bit'))
        foreach ($section in $sections) {
            $var = $data
            if ($section.Count -gt 0) {
                foreach ($s in $section) {
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
                foreach ($value in $values) {
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

}

function Get-BucketList {
    $buckets = @()
    foreach ($fileName in Get-ChildItem '/mnt/e/dev/scoop-emulators/bucket/*/*.json') {
        $buckets += [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    }
    return $buckets
}

Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
Expand-Archive -Path "master.zip" -DestinationPath "./" -Force
Remove-Item -Path "master.zip" -Force
Get-ChildItem -Path "scoop-emulators-master/bucket" -Filter "*.json" -Recurse


$buckets = Get-BucketList



$out = @{
    'paths' = @()
    'emus' = @()
}
$allBuckets = @{}
$bin2bucket = @{}
$regexes = @()
$totalBins = 0
foreach ($bucket in $buckets) {
    [Bucket]::load($bucket)
    $bins = [Bucket]::getBins()
    $urls = [Bucket]::getUrls()
    $extractDir = [Bucket]::getExtracteDir()
    $allBuckets[$bucket] = @{
        'bins' = $bins
        'urls' = $urls
    }
    if (-not [string]::IsNullOrWhiteSpace($extractDir)) {
        $allBuckets[$bucket]['extractDir'] = $extractDir
    }
    foreach ($bin in $bins) {
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
    Write-Host "Bucket $bucket: $($bins -join ', ') $urls $extractDir"
}
if ($args.Count -lt 1) {
    Write-Error "Invalid Syntax! $($MyInvocation.MyCommand.Name) <dir>"
    return
}
$searchDir = $args[0]
Write-Host "Found $totalBins Bins and $($bins.Count) Unique Bins to search for"
$regexesPattern = '(' + [string]::Join('|', ($regexes | foreach { [regex]::Escape($_) })) + ')'
$matches = Select-String -Path (Get-ChildItem -Path $searchDir -Recurse -Include $regexesPattern) -Pattern $regexesPattern -AllMatches | Select-Object -ExpandProperty Matches
if ($matches.Count -eq 0) {
    Write-Error "No matches were found"
    Exit 1
}

$fileEmus = @{}
foreach ($match in $matches) {
    $fileName = $match.Value
    $bin = $match.Groups[1].Value.ToLower()
    if (-not $bin2bucket.ContainsKey($bin)) {
        Write-Host "Cant find $bin in: $($bin2bucket.Keys -join ', ')"
    } else {
        $dirName = Split-Path $fileName -Parent
        $fileEmus[$dirName] = $bin2bucket[$bin]
        $out.paths[$dirName] = $fileEmus[$dirName]
        foreach ($emu in $bin2bucket[$bin]) {
            $out.emus[$emu] = $allBuckets[$emu]
        }
    }
}

$out | ConvertTo-Json -Depth 10 | Set-Content -Path 'found_emulators.json'