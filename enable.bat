set scriptpath=%~dp0
set /p ADAPTERNAME=<"%scriptpath%adapter_name.txt"
netsh interface ipv4 set dnsserver name=%ADAPTERNAME% static 1.1.1.1 primary validate=no
netsh interface ipv4 add dnsserver %ADAPTERNAME% 1.0.0.1 index=2 validate=no
netsh interface ipv6 set dnsserver name=%ADAPTERNAME% static 2606:4700:4700::1111 primary validate=no
netsh interface ipv6 add dnsserver %ADAPTERNAME% 2606:4700:4700::1001 index=2 validate=no
ipconfig /flushdns
