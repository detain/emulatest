<?php
if ($_SERVER['argc'] < 2) {
    die("Invalid Syntax!\n{$_SERVER['argv'][0]} <dir>\n");
}
$searchDir = $_SERVER['argv'][1];
$bins = [];
$regex = [];
$totalBins = 0;
foreach (glob('/mnt/e/dev/scoop-emulators/bucket/*/*.json') as $scoopFile) {
    $scoopEmu = basename($scoopFile, '.json');
    $bucket = json_decode(file_get_contents($scoopFile), true);
    $extractDir = '';
    $bin = [];
    if (isset($bucket['url']))
        $url = $bucket['url'];
    if (isset($bucket['extract_dir']))
        $extractDir = $bucket['extract_dir'];
    if (isset($bucket['bin']))
        $bin['any'] = $bucket['bin'];
    if (isset($bucket['architecture'])) {
        if (isset($bucket['architecture']['url']))
            $url = $bucket['architecture']['url'];
        if (isset($bucket['architecture']['extract_dir']))
            $extractDir = $bucket['architecture']['extract_dir'];
        if (isset($bucket['architecture']['bin']))
            $bin['any'] = $bucket['architecture']['bin'];
        if (isset($bucket['architecture']['64bit'])) {
            if (isset($bucket['architecture']['64bit']['url']))
                $url = $bucket['architecture']['64bit']['url'];
            if (isset($bucket['architecture']['64bit']['extract_dir']))
                $extractDir = $bucket['architecture']['64bit']['extract_dir'];
            if (isset($bucket['architecture']['64bit']['bin']))
                $bin['64bit'] = $bucket['architecture']['64bit']['bin'];
        }
        if (isset($bucket['architecture']['32bit'])) {
            if (isset($bucket['architecture']['32bit']['url']))
                $url = $bucket['architecture']['32bit']['url'];
            if (isset($bucket['architecture']['32bit']['extract_dir']))
                $extractDir = $bucket['architecture']['64bit']['extract_dir'];
            if (isset($bucket['architecture']['32bit']['bin']))
                $bin['32bit'] = $bucket['architecture']['32bit']['bin'];
        }
    }
    foreach ($bin as $bits => $realBin) {
        if (!is_array($realBin)) {
            if ($realBin == '')
                continue;
            $realBin = [$realBin];
        }
        foreach ($realBin as $subBin) {
            $subBin = strtolower(str_replace('\\', '/', is_array($subBin) ? $subBin[0] : $subBin));
            $subBin = basename($subBin);
            if (!array_key_exists($subBin, $bins)) {
                $bins[$subBin] = [];
                $regex[] = preg_quote($subBin, '/');
            }
            if (!array_key_exists($bits, $bins[$subBin]))
                $bins[$subBin][$bits] = [];
            $bins[$subBin][$bits][] = $scoopEmu;
            $totalBins++;
        }
    }
}
ksort($bins);
//file_put_contents('bins.json', json_encode($bins, JSON_PRETTY_PRINT));
echo "Found ".$totalBins." Bins and ".count($bins)." Unique Bins to search for, searching {$searchDir}\n";
if (!preg_match_all('/^.*\/('.implode('|', array_values(array_unique($regex))).')$/imu', `find {$searchDir} -type f`, $matches))
    die("No matches were found\n");
$binMatches = $matches[0];
echo "Found ".count($binMatches)." Bin Matches\n";
//file_put_contents('binMatches.txt', implode("\n", $binMatches));
$dirs = [];
foreach  ($binMatches as $binMatch) {
    $dir = dirname($binMatch);
    if (!isset($dirs[$dir]))
        $dirs[$dir] = [];
    foreach ($bins[basename(strtolower($binMatch))] as $subBits => $subBins) {
        foreach ($subBins as $scoopEmu) {
            if (!in_array($scoopEmu, $dirs[$dir]))
                $dirs[$dir][] = $scoopEmu;
/*                $cmd = 'file '.escapeshellarg($binMatch);
                $mime = trim(`{$cmd}`);
                $bits = preg_match('/PE32.*x86-64/', $mime) ? '64bit' : (preg_match('/PE32.*80386/', $mime) ? '32bit' : 'any');
*/
                //echo "File {$binMatch} Match {$scoopEmu} Sub Bits {$subBits}\n";
        }
    }
}
file_put_contents('results.json', json_encode($dirs, JSON_PRETTY_PRINT));
foreach ($dirs as $dir => $scoopEmus) {
    echo $dir.' - '.implode(', ', $scoopEmus).PHP_EOL;
}

