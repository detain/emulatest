Convert-Form -Path "E:\dev\emulatest-windows-form\MainWindow.Designer.cs" `
  -Destination "E:\dev\emulatest" -Encoding ascii -Force -Verbose
(Get-Content -Path "E:\dev\emulatest\MainWindow.ps1" -Raw) `
  -replace '\$BucketsTable\.(Row|Column)Styles\.Add\(New-Object System\.Windows\.Forms\.(Row|Column)Style\(System\.Windows\.Forms\.SizeType\.(Percent|Absolute), (.*)F\)\)', `
  '$BucketsTable.$1Styles.Add((New-Object System.Windows.Forms.$2Style([System.Windows.Forms.SizeType]::$3, $4)))' `
  -replace 'function OnFormClosing_MainWindow\{', `
  ". (`".\scoop_finder.ps1`")`n. (`".\Functions.ps1`")`n`nfunction OnFormClosing_MainWindow{`n`tRemove-Repo" `
  -replace '\$EmulatorsTable\.Columns\.AddRange\(@\((\s*\$Select,\s*\$Path,\s*\$Emulator,\s*\$CurrentVersion,\s*\$NewVersion\s*)\)\)', `
  '$EmulatorsTable.Columns.AddRange($1)' `
  -replace '\.FillWeight = (\d+)F', `
  '.FillWeight = $1'
  | Set-Content -Path "E:\dev\emulatest\MainWindow.ps1"
