<?php
$data = json_decode(file_get_contents(__DIR__.'/found_emulators.json'), true);
$results = [];
$doBackup = false;
$doStep1 = false;
$doStep2 = true;
if ($doStep1 === true) {
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
}
if ($doStep2 === true) {
    foreach ($data['paths'] as $emuPath => $emus) {
        if (count($emus) != 1) {
            echo "Wrong count of emus (".implode(',',$emus).")\n";
            continue;
        }
        $emuId = $emus[0];
        $emuData = $data['emus'][$emuId];
        $baseDir = __DIR__.'/new/'.$emuId;
        $backupZip = $baseDir.'/backup_'.$emuId.'_'.str_replace(['/'], ['_'], substr($emuPath, 1)).'_'.date('Ymd').'.zip';
        $finalDir = $baseDir.'/final';
        if ($doBackup === true && !file_exists($backupZip)) {
            echo "  Backing up to {$backupZip}...";
            echo passthru('zip -r '.escapeshellarg($backupZip).' '.escapeshellarg($emuPath));
            echo "  done\n";
        }
        if (file_exists($finalDir)) {
            echo "Emulator {$emuId} {$finalDir} => {$emuPath}\n";
            $cmd = 'cp -afv '.escapeshellarg($finalDir).'/* '.escapeshellarg($emuPath).'/';
            echo $cmd."\n";
            echo passthru($cmd, $resultCode);
        }
    }
}