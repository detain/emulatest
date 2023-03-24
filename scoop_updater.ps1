$data = Get-Content "$PSScriptRoot/found_emulators.json" -Raw | ConvertFrom-Json
$results = @()
$doBackup = $false
$doStep1 = $false
$doStep2 = $true

if ($doStep1 -eq $true) {
    foreach ($emuId in $data.emus.Keys) {
        $emuData = $data.emus[$emuId]
        $baseDir = "$PSScriptRoot/new/$emuId"
        $moveDir = "$baseDir/extracted"
        $finalDir = "$baseDir/final"

        if (!(Test-Path $finalDir)) {
            Write-Host "Emulator $emuId"
            New-Item -ItemType Directory -Path $moveDir -Force | Out-Null
            Write-Host "  Downloading $($emuData.urls)"
            $resultCode = cmd /c "wget --max-redirect 100 -c $($emuData.urls) -O `"$($baseDir)/$($emuData.urls | Split-Path -Leaf)`""
            if ($resultCode -ne 0) {
                $results += "dl $emuId"
            }
            Write-Host "Got Exit Code $resultCode"
            Write-Host "  Extracting $($emuData.urls)"
            if ($emuData.urls -match '\.tar\.(xz|bz2|gz)$') {
                $resultCode = cmd /c "tar -C `"$moveDir`" -xvf `"$($baseDir)/$($emuData.urls | Split-Path -Leaf)`""
            } else {
                $resultCode = cmd /c "7z x -bb0 -aoa -o`"$moveDir`" `"$($baseDir)/$($emuData.urls | Split-Path -Leaf)`""
            }
            if ($resultCode -ne 0) {
                $results += "7z $emuId"
            }
            Write-Host "Got Exit Code $resultCode"
            if ($emuData.extractDir -and (Test-Path "$moveDir/$($emuData.extractDir)")) {
                $moveDir += "/$($emuData.extractDir)"
            }
            Move-Item $moveDir $finalDir
            $results
        }
    }
}

if ($doStep2 -eq $true) {
    foreach ($emuPath in $data.paths.Keys) {
        $emus = $data.paths[$emuPath]
        if ($emus.Count -ne 1) {
            Write-Host "Wrong count of emus ($($emus -join ','))"
            continue
        }
        $emuId = $emus[0]
        $emuData = $data.emus[$emuId]
        $baseDir = "$PSScriptRoot/new/$emuId"
        $backupZip = "$baseDir/backup_$emuId_$($emuPath -replace '/', '_')_$(Get-Date -Format yyyyMMdd).zip"
        $finalDir = "$baseDir/final"

        if (Test-Path $finalDir) {
            Write-Host "Emulator $emuId $finalDir => $emuPath"
            $cmd = "cp -afv `"$finalDir/*`" `"$emuPath/`""
            Write-Host $cmd
            cmd /c $cmd
        }
    }
}
