set scriptpath=%~dp0
set /p ADAPTERNAME=<"%scriptpath%adapter_name.txt"
netsh interface ipv4 set dns %ADAPTERNAME% dhcp
netsh interface ipv6 set dns %ADAPTERNAME% dhcp
ipconfig /flushdns
