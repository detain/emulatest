Convert-Form -Path "E:\dev\emulatest-windows-form\MainWindow.Designer.cs" `
  -Destination "E:\dev\emulatest" -Encoding ascii -Force -Verbose
(Get-Content -Path "E:\dev\emulatest\MainWindow.ps1" -Raw) `
  -replace 'function OnFormClosing_', ". (`".\Functions.ps1`")`n`nfunction OnFormClosing_" `
  | Set-Content -Path "E:\dev\emulatest\MainWindow.ps1"
