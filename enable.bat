@echo off
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    set scriptpath=%~dp0

    wmic nicconfig where "(IPEnabled=TRUE)" call SetDNSServerSearchOrder ("1.1.1.1", "1.0.0.1")
    ipconfig /flushdns

    del "%HOMEDRIVE%%HOMEPATH%\Desktop\Enable Cloudflare.lnk"

    echo Set oWS = WScript.CreateObject("WScript.Shell") > UpdateShortcut.vbs
    echo sLinkFile = "%HOMEDRIVE%%HOMEPATH%\Desktop\Disable Cloudflare.lnk" >> UpdateShortcut.vbs
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> UpdateShortcut.vbs
    echo oLink.IconLocation = "%scriptpath%/cloudflare.ico" >> UpdateShortcut.vbs
    echo oLink.TargetPath = "%scriptpath%/disable.bat" >> UpdateShortcut.vbs
    echo oLink.Save >> UpdateShortcut.vbs
    cscript UpdateShortcut.vbs
    del UpdateShortcut.vbs

    setlocal
    for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
    if "%version%" == "10.0" (
       ie4uinit.exe -show 
    ) else ( ie4uinit.exe -ClearIconCache )
    