set /p ADAPTERNAME=<adapter_name.txt
netsh interface ipv4 add dnsserver %ADAPTERNAME% 1.1.1.1 index=1
netsh interface ipv4 add dnsserver %ADAPTERNAME% 1.0.0.1 index=2
netsh interface ipv6 add dnsserver %ADAPTERNAME% 2606:4700:4700::1111 index=1
netsh interface ipv6 add dnsserver %ADAPTERNAME% 2606:4700:4700::1001 index=2