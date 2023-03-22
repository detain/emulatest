<?php
$data = json_decode(file_get_contents(__DIR__.'/found_emulators.json'), true);
$results = [];
foreach ($data['emus'] as $emuId => $emuData) {
    $baseDir = __DIR__.'/new/'.$emuId;
    $moveDir = $baseDir.'/extracted';
    $finalDir = $baseDir.'/final';
    if (!file_exists($finalDir)) {
        echo "Emulator {$emuId}\n";
        @mkdir($moveDir, 0777, true);
        echo "  Downloading {$emuData['urls']}\n";
        echo passthru('wget --max-redirect 100 -c '.escapeshellarg($emuData['urls']).' -O '.escapeshellarg($baseDir.'/'.basename($emuData['urls'])), $resultCode);
        if ($resultCode != 0)
            $results[] = 'dl '.$emuId;
        echo "Got Exit Code {$resultCode}\n";
        echo "  Extracting {$emuData['urls']}\n";
        if (preg_match('/\.tar\.(xz|bz2|gz)$/i', $emuData['urls'])) {
            echo passthru('tar -C'.escapeshellarg($moveDir).' -xvf '.escapeshellarg($baseDir.'/'.basename($emuData['urls'])), $resultCode);
        } else {
            echo passthru('7z x -bb0 -aoa -o'.escapeshellarg($moveDir).' '.escapeshellarg($baseDir.'/'.basename($emuData['urls'])), $resultCode);
        }
        if ($resultCode != 0)
            $results[] = '7z '.$emuId;
        echo "Got Exit Code {$resultCode}\n";
        if (isset($emuData['extractDir']) && file_exists($moveDir.'/'.$emuData['extractDir']))
            $moveDir .= '/'.$emuData['extractDir'];
        rename($moveDir, $finalDir);
        print_r($results);
    }
}
