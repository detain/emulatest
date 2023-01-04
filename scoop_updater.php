<?php
if ($_SERVER['argc'] < 3) {
    die("Invalid Syntax!\n{$_SERVER['argv'][0]} <scoop-emulator> <dir>\n");
}
$scoopEmu = $_SERVER['argv'][1];
$installDir = $_SERVER['argv'][2];
$bucket = json_decode(file_get_contents('/mnt/e/dev/scoop-emulators/bucket/'.substr($scoopEmu, 0, 1).'/'.$scoopEmu.'.json'), true);
$extractDir = '';
$bin = '';
if (isset($bucket['extract_dir']))
    $extractDir = $bucket['extract_dir'];
if (isset($bucket['bin']))
    $extractDir = $bucket['bin'];
if (isset($bucket['architecture'])) {
    if (isset($bucket['architecture']['extract_dir']))
        $extractDir = $bucket['architecture']['extract_dir'];
    if (isset($bucket['architecture']['bin']))
        $bin = $bucket['architecture']['bin'];
	if (isset($bucket['architecture']['64bit'])) {
		$url = $bucket['architecture']['64bit']['url'];
        if (isset($bucket['architecture']['64bit']['extract_dir']))
            $extractDir = $bucket['architecture']['64bit']['extract_dir'];
        if (isset($bucket['architecture']['64bit']['bin']))
            $bin = $bucket['architecture']['64bit']['bin'];
	} else {
		$url = $bucket['architecture']['32bit']['url'];
        if (isset($bucket['architecture']['32bit']['extract_dir']))
            $extractDir = $bucket['architecture']['64bit']['extract_dir'];
        if (isset($bucket['architecture']['32bit']['bin']))
            $bin = $bucket['architecture']['32bit']['bin'];
    }
} else {
	$url = $bucket['url'];
}
$bins = [];
if (!is_array($bin) && $bin != '') {
    if (!is_array($bin))
        $bin = [$bin];
    foreach ($bin as $idx => $subBin)
        $bins[] = is_array($subBin) ? $subBin[0] : $subBin;
}
echo "echo \"$installDir => ".(is_array($url) ? implode(', ', $url) : $url)."\"\n";
if (!is_array($url))
    $url = [$url];
foreach ($url as $urlUrl) {
    $urlFile = basename($urlUrl);
    if (!file_exists($urlFile))
        passthru('wget --no-check-certificate -nv '.escapeshellarg($urlUrl)." -O ".escapeshellarg($urlFile)." || rm -f ".escapeshellarg($urlFile));
    if (!file_exists(basename($urlUrl)))
        echo "Error with $urlUrl\n";
    else {
        passthru('7z x -bb0 -aoa -o'.$installDir.' '.escapeshellarg($urlFile).($extractDir != '' ? ' '.escapeshellarg($extractDir).' && cp -af '.escapeshellarg($installDir.'/'.$extractDir).'/* '.escapeshellarg($installDir).'/ && rm -rf '.escapeshellarg($installDir.'/'.$extractDir) : ''));
        unlink($urlFile);
    }
}
