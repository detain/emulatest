<?php
/*
wget https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip
unzip -o master.zip
rm -f master.zip
find scoop-emulators-master/bucket -name "*.json"

Invoke-WebRequest -Uri "https://github.com/detain/scoop-emulators/archive/refs/heads/master.zip" -OutFile "master.zip"
Expand-Archive -Path "master.zip" -DestinationPath "./" -Force
Remove-Item -Path "master.zip" -Force
Get-ChildItem -Path "scoop-emulators-master/bucket" -Filter "*.json" -Recurse
*/

function find($searchDir) {
    echo "Searching {$searchDir}...";
    //return file_get_contents($searchDir);
    $cmd = 'find '.escapeshellarg($searchDir).' -type f';
    //$tempFile = tempnam(sys_get_temp_dir(), 'find');
    //$cmd = 'find '.escapeshellarg($searchDir).' -type f > '.$tempFile;
    $return = `{$cmd}`;
    /*echo "reading back file...";
    $return = file_get_contents($tempFile);
    echo "removing file...";
    unlink($tempFile);*/
    echo "done\n";
    return $return;
}

class Bucket
{
    protected static $data;

    public static function load($bucket) {
        $letter = substr($bucket, 0, 1);
        if (is_numeric($letter))
            $letter = '#';
        $fileName = '/mnt/e/dev/scoop-emulators/bucket/'.$letter.'/'.$bucket.'.json';
        $data = json_decode(file_get_contents($fileName), true);
        self::$data = $data;
    }

    public static function getExtracteDir() {
        $extractDir = self::getField('extract_dir', true);
        return $extractDir;
    }

    public static function getUrls() {
        $urls = self::getField('url', true);
        return $urls;
    }

    public static function getBins() {
        $bins = self::getField('bin');
        return $bins;
    }

    public static function getField($field = 'bin', $lastOnly = false) {
        $return = [];
        foreach ([[], ['architecture'], ['architecture','32bit'], ['architecture','64bit']] as $sections) {
            $var = self::$data;
            if (count($sections) > 0)
                foreach ($sections as $section) {
                    if (isset($var[$section]))
                        $var = $var[$section];
                    else
                        break;
                }
            if (isset($var[$field])) {
                if (!is_array($var[$field]))
                    $var[$field] = [$var[$field]];
                foreach ($var[$field] as $value) {
                    if (is_array($value))
                        $value = $value[0];
                    if (!in_array($value, $return))
                        $return[] = $value;
                }
            }
        }
        if ($lastOnly === true)
            return array_pop($return);
        return $return;
    }

    public static function getBucketList() {
        $buckets = [];
        foreach (glob('/mnt/e/dev/scoop-emulators/bucket/*/*.json') as $fileName) {
            $buckets[] = basename($fileName, '.json');
        }
        return $buckets;
    }
}

$buckets = Bucket::getBucketList();
$out = [
    'paths' => [],
    'emus' => [],
];
$allBuckets = [];
$bin2bucket = [];
$regexes = [];
$totalBins = 0;
foreach ($buckets as $bucket) {
    Bucket::load($bucket);
    $bins = Bucket::getBins();
    $urls = Bucket::getUrls();
    $extractDir = Bucket::getExtracteDir();
    $allBuckets[$bucket] = ['bins' => $bins, 'urls' => $urls];
    if (!is_null($extractDir))
        $allBuckets[$bucket]['extractDir'] = $extractDir;
    foreach ($bins as $bin) {
        $totalBins++;
        $bin = strtolower(str_replace('\\', '/', $bin));
        $regex = preg_quote($bin, '/');
        if (!in_array($regex, $regexes))
            $regexes[] = $regex;
        if (!isset($bin2bucket[$bin]))
            $bin2bucket[$bin] = [];
        $bin2bucket[$bin][] = $bucket;
    }
    //echo "Bucket {$bucket}: ".implode(', ', $bins).' '.Bucket::getUrls().' '.Bucket::getExtracteDir()."\n";
}
if ($_SERVER['argc'] < 2) {
    die("Invalid Syntax!\n{$_SERVER['argv'][0]} <dir>\n");
}
$searchDir = $_SERVER['argv'][1];
echo "Found ".$totalBins." Bins and ".count($bins)." Unique Bins to search for\n";
if (!preg_match_all('/^.*\/('.implode('|', array_values($regexes)).')$/imu', find($searchDir), $matches))
  die("No matches were found\n");
$fileEmus = [];
foreach ($matches[0] as $idx => $fileName) {
    if (!isset($bin2bucket[strtolower($matches[1][$idx])])) {
        echo "Cant find {$matches[1][$idx]} in: ".implode(',', array_keys($bin2bucket))."\n";
    } else {
        $dirName = substr($fileName, 0, 0 - (strlen($matches[1][$idx]) + 1));
        $fileEmus[$dirName] = $bin2bucket[strtolower($matches[1][$idx])];
        $out['paths'][$dirName] = $fileEmus[$dirName];
        foreach ($bin2bucket[strtolower($matches[1][$idx])] as $emu) {
            $out['emus'][$emu] = $allBuckets[$emu];
        }
    }
}
file_put_contents('found_emulators.json', json_encode($out, JSON_PRETTY_PRINT));
/*foreach ($fileEmus as $fileName => $emus) {
    echo $fileName.': '.implode(', ', $emus)."\n";
}*/

function getField($field = 'bin', $lastOnly = false) {
    $return = [];
    foreach ([[], ['architecture'], ['architecture','32bit'], ['architecture','64bit']] as $sections) {
        $var = $GLOBALS['LoadedBucketData'];
        if (count($sections) > 0)
            foreach ($sections as $section) {
                if (isset($var[$section]))
                    $var = $var[$section];
                else
                    break;
            }
        if (isset($var[$field])) {
            if (!is_array($var[$field]))
                $var[$field] = [$var[$field]];
            foreach ($var[$field] as $value) {
                if (is_array($value))
                    $value = $value[0];
                if (!in_array($value, $return))
                    $return[] = $value;
            }
        }
    }
    if ($lastOnly === true)
        return array_pop($return);
    return $return;
}

