@echo off
taskkill /f /im explorer.exe
start explorer.exe
:loop_start
start cmd /k "echo test"
start "" powershell -NoExit -Command ^
    "$w=Add-Type -MemberDefinition '[DllImport(\"user32.dll\")]public static extern bool MoveWindow(IntPtr hWnd,int X,int Y,int nW,int nH,bool bR);' -Name 'W' -Namespace 'W' -PassThru;" ^
    "$h=(Get-Process -Id $PID).MainWindowHandle;Clear-Host;Write-Host 'test';" ^
    "$s=[System.Windows.Forms.Screen]::PrimaryScreen.Bounds;$wW=400;$wH=300;" ^
    "$x=(Get-Random -Min 0 -Max ($s.Width-$wW));$y=(Get-Random -Min 0 -Max ($s.Height-$wH));" ^
    "$dx=if((Get-Random -Min 0 -Max 2) -eq 0){10}else{-10};$dy=if((Get-Random -Min 0 -Max 2) -eq 0){10}else{-10};" ^
    "while($true){" ^
    "  $x+=$dx;$y+=$dy;" ^
    "  if($x -le 0 -or $x+$wW -ge $s.Width){$dx=-$dx};if($y -le 0 -or $y+$wH -ge $s.Height){$dy=-$dy};" ^
    "  [W.W]::MoveWindow($h,$x,$y,$wW,$wH,$True);" ^
    "  Start-Sleep -Milliseconds 10;" ^
    "}"
goto loop_start
