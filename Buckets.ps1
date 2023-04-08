class Buckets {
    $bucketFiles
    $buckets
    $allBuckets
    $bin2bucket
    $regexes
    $matches
    $totalBins
    $totalBuckets

    function Find-Buckets {
        $this.$buckets = @()
        foreach ($fileName in Get-ChildItem '/mnt/e/dev/scoop-emulators/bucket/*/*.json') {
            $this.$bucketFiles += [System.IO.Path]::GetFileNameWithoutExtension($fileName)
        }
        return $this.$bucketFiles
    }

    function Install-Latest-Buckets {
        Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
        Expand-Archive -Path "master.zip" -DestinationPath "./" -Force
        Remove-Item -Path "master.zip" -Force
    }

    function Load-Buckets {
        $BucketClass = new Bucket
        $this.$regexes = @()
        foreach ($bucket in $this.$bucketFiles) {
            $BucketClass.load($bucket)
            Write-Host "Loading Bucket $bucket"
            $bins = $BucketClass.getBins()
            $urls = $BucketClass.getUrls()
            $extractDir = $BucketClass.getExtracteDir()
            $this.$allBuckets[$bucket] = @{
                'bins' = $bins
                'urls' = $urls
            }
            if (-Not [string]::IsNullOrWhiteSpace($extractDir)) {
                $this.$allBuckets[$bucket]['extractDir'] = $extractDir
            }
            foreach ($bin in $bins) {
                $this.$totalBins++
                $bin = $bin.ToLower().Replace('\', '/')
                $regex = [regex]::Escape($bin)
                if (-Not $this.$regexes.Contains($regex)) {
                    $this.$regexes += $regex
                }
                if (-Not $this.$bin2bucket.ContainsKey($bin)) {
                    $this.$bin2bucket[$bin] = @()
                }
                $this.$bin2bucket[$bin] += $bucket
            }
            Write-Host "Bucket $bucket: $($bins -join ', ') $urls $extractDir"
        }
    }

    function Find-Matches-Buckets {

        #$searchDir = $args[0]
        $searchDir = "F:\Consoles\RetroBat"

        Write-Host "Found $this.$totalBins Bins and $($bins.Count) Unique Bins to search for"
        $regexesPattern = '(' + [string]::Join('|', ($this.$regexes | foreach { [regex]::Escape($_) })) + ')'
        $this.$matches  = Select-String -Path (Get-ChildItem -Path $searchDir -Recurse -Include $regexesPattern) -Pattern $regexesPattern -AllMatches | Select-Object -ExpandProperty Matches
        return $this.$matches
    }

    function getMatches {
        $out = @{
            'paths' = @()
            'emus' = @()
        }
        $fileEmus = @{}
        foreach ($match in $this.$matches) {
            $fileName = $match.Value
            $bin = $match.Groups[1].Value.ToLower()
            if (-Not $this.$bin2bucket.ContainsKey($bin)) {
                Write-Host "Cant find $bin in: $($this.$bin2bucket.Keys -join ', ')"
            } else {
                $dirName = Split-Path $fileName -Parent
                $fileEmus[$dirName] = $this.$bin2bucket[$bin]
                $out.paths[$dirName] = $fileEmus[$dirName]
                foreach ($emu in $this.$bin2bucket[$bin]) {
                    $out.emus[$emu] = $this.$allBuckets[$emu]
                }
            }
        }
        return $out;
    }

    function get {
        return $this.$buckets
    }
}
