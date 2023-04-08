class Bucket {
    $data
    $name

    function load {
        param {
            $bucket
        }
        if ($this.$name != $bucket) {
            $letter = $bucket.Substring(0, 1)
            if ([char]::IsNumber($letter))
            $letter     = "#"
            $fileName   = "/mnt/e/dev/scoop-emulators/bucket/$letter/$bucket.json"
            $data       = Get-Content $fileName | ConvertFrom-Json
            $this.$data = $data
            $this.$name = $bucket
        }
        return $this.$data
    }

    function restore {
        param {
            $bucket,
            $data
        }
        $this.$data = $data
        $this.$name = $bucket
    }

    function export {
        return { data: $this.$data, name: $this.$name }
    }

    function getExtracteDir {
        $extractDir = $this.getField('extract_dir', $true)
        return $extractDir
    }

    function getUrls {
        $urls = $this.getField('extract_dir')
        return $urls
    }

    function getBins {
        $bins = $this.getField('extract_dir')
        return $bins
    }

    function getField($ff {
        param {
            $bucket, $field = 'bin', $lastOnly = $false
        }
        $data     = $this.load($bucket)
        $return   = @()
        $sections = @(@(), @('architecture'), @('architecture', '32bit'), @('architecture', '64bit'))
        # loop through teh various sections that can have the field
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
                if (-Not $values.GetType().IsArray) {
                    $values = @($values)
                }
                foreach ($value in $values) {
                    if ($value.GetType().IsArray) {
                        $value = $value[0]
                    }
                    if (-Not $return.Contains($value)) {
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
