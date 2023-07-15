@echo off
setlocal EnableExtensions EnableDelayedExpansion
:: set CLEAR=cls
set CLEAR=
title tiny11 builder alpha
echo Welcome to the tiny11 image creator!
timeout /t 1 /nobreak
%CLEAR%

set DriveLetter=F
::set /p DriveLetter=Please enter the drive letter for the Windows 11 image:
set "DriveLetter=%DriveLetter%:"
echo.
if not exist "%DriveLetter%\sources\boot.wim" (
	echo.Can't find Windows OS Installation files in the specified Drive Letter..
	echo.
	echo.Please enter the correct DVD Drive Letter..
	goto :Stop
)

if not exist "%DriveLetter%\sources\install.wim" (
	echo.Can't find Windows OS Installation files in the specified Drive Letter..
	echo.
	echo.Please enter the correct DVD Drive Letter..
	goto :Stop
)
md c:\tiny11
echo Copying Windows image...
xcopy.exe /E /I /H /R /Y /J %DriveLetter% c:\tiny11 >log
echo Copy complete!
sleep 1
%CLEAR%

::dism /image:c:\scratchdir /Cleanup-Image /StartComponentCleanup /ResetBase
::dism /unmount-image /mountdir:c:\scratchdir /commit
::rd c:\scratchdir /s /q


echo Getting image information:
dism /Get-WimInfo /wimfile:c:\tiny11\sources\install.wim
set index=1
::set /p index=Please enter the image index:
set "index=%index%"
echo Mounting Windows image. This may take a while.
echo.
md c:\scratchdir
dism /mount-image /imagefile:c:\tiny11\sources\install.wim /index:%index% /mountdir:c:\scratchdir
echo Mounting complete! Performing removal of applications...

dism /image:c:\scratchdir /Get-ProvisionedAppxPackages | findstr PackageName | awk "{print $3}" > pap.lst
dism /image:c:\scratchdir /Get-Packages | findstr Package~ | awk "{print $3}" > pkg.lst

echo Removing of system apps complete! Now proceeding to removal of system packages...
timeout /t 1 /nobreak
%CLEAR%

::-------------------------
set img_dir=c:\scratchdir

dism /image:%img_dir% /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:DirectX.Configuration.Database~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Hello.Face.20134~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Language.Handwriting~~~zh-CN~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Language.OCR~~~zh-CN~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Language.Speech~~~zh-CN~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Language.TextToSpeech~~~zh-CN~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Media.WindowsMediaPlayer~~~~0.0.12.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Wallpapers.Extended~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Notepad.System~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Broadcom.Bcmpciedhd63~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Broadcom.Bcmwl63al~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Broadcom.Bcmwl63a~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwbw02~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwew00~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwew01~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwlv64~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwns64~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwsw00~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwtw02~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwtw04~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwtw06~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwtw08~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Intel.Netwtw10~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Marvel.Mrvlpcie8897~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Qualcomm.Athw8x~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Qualcomm.Athwnx~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Qualcomm.Qcamain10x64~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Ralink.Netr28x~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtl8187se~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtl8192se~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtl819xp~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtl85n64~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtwlane01~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtwlane13~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.Wifi.Client.Realtek.Rtwlane~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:OneCoreUAP.OneSync~~~~0.0.1.0
dism /image:%img_dir% /Remove-Capability /CapabilityName:Print.Management.Console~~~~0.0.1.0

dism /image:%img_dir% /Disable-Feature /FeatureName:Windows-Defender-Default-Definitions
dism /image:%img_dir% /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features
dism /image:%img_dir% /Disable-Feature /FeatureName:MSRDC-Infrastructure
dism /image:%img_dir% /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root
dism /image:%img_dir% /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2
dism /image:%img_dir% /Disable-Feature /FeatureName:WCF-Services45
dism /image:%img_dir% /Disable-Feature /FeatureName:WCF-TCP-PortSharing45
dism /image:%img_dir% /Disable-Feature /FeatureName:MediaPlayback
dism /image:%img_dir% /Disable-Feature /FeatureName:WindowsMediaPlayer
dism /image:%img_dir% /Disable-Feature /FeatureName:SearchEngine-Client-Package
dism /image:%img_dir% /Disable-Feature /FeatureName:WorkFolders-Client
dism /image:%img_dir% /Disable-Feature /FeatureName:Printing-Foundation-Features
dism /image:%img_dir% /Disable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client


call:rm_pap Clipchamp.Clipchamp
call:rm_pap Microsoft.549981C3F5F10
call:rm_pap Microsoft.BingNews
call:rm_pap Microsoft.BingWeather
call:rm_pap Microsoft.GamingApp
call:rm_pap Microsoft.GetHelp
call:rm_pap Microsoft.Getstarted
call:rm_pap Microsoft.MicrosoftOfficeHub
call:rm_pap Microsoft.MicrosoftSolitaireCollection
call:rm_pap Microsoft.MicrosoftStickyNotes
call:rm_pap Microsoft.Paint
call:rm_pap Microsoft.People
call:rm_pap Microsoft.PowerAutomateDesktop
call:rm_pap Microsoft.RawImageExtension
call:rm_pap Microsoft.ScreenSketch
call:rm_pap Microsoft.SecHealthUI
call:rm_pap Microsoft.Todos
call:rm_pap Microsoft.WindowsCamera
call:rm_pap microsoft.windowscommunicationsapps
call:rm_pap Microsoft.WindowsFeedbackHub
call:rm_pap Microsoft.WindowsMaps
call:rm_pap Microsoft.Xbox.TCUI
call:rm_pap Microsoft.XboxGameOverlay
call:rm_pap Microsoft.XboxGamingOverlay
call:rm_pap Microsoft.XboxIdentityProvider
call:rm_pap Microsoft.XboxSpeechToTextOverlay
call:rm_pap Microsoft.YourPhone
call:rm_pap Microsoft.ZuneMusic
call:rm_pap Microsoft.ZuneVideo
call:rm_pap MicrosoftCorporationII.MicrosoftFamily
call:rm_pap MicrosoftCorporationII.QuickAssist

call:rm_pkg Microsoft-Windows-Hello-Face
call:rm_pkg Microsoft-Windows-InternetExplorer-Optional
call:rm_pkg Microsoft-Windows-Kernel-LA57-FoD
call:rm_pkg Microsoft-Windows-LanguageFeatures-Handwriting-zh-cn
call:rm_pkg Microsoft-Windows-LanguageFeatures-OCR-zh-cn
call:rm_pkg Microsoft-Windows-LanguageFeatures-Speech-zh-cn
call:rm_pkg Microsoft-Windows-LanguageFeatures-TextToSpeech-zh-cn
call:rm_pkg Microsoft-Windows-MediaPlayer
call:rm_pkg Microsoft-Windows-Notepad-System-FoD
call:rm_pkg Microsoft-Windows-PowerShell-ISE-FOD
call:rm_pkg Microsoft-Windows-Printing-PMCPPC-FoD
call:rm_pkg Microsoft-Windows-StepsRecorder
call:rm_pkg Microsoft-Windows-TabletPCMath
call:rm_pkg Microsoft-Windows-Wallpaper-Content-Extended-FoD
call:rm_pkg Microsoft-Windows-Wifi-Client-Broadcom-Bcmpciedhd63-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Broadcom-Bcmwl63a-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Broadcom-Bcmwl63al-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwbw02-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwew00-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwew01-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwlv64-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwns64-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwsw00-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwtw02-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwtw04-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwtw06-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwtw08-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Intel-Netwtw10-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Marvel-Mrvlpcie8897-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Qualcomm-Athw8x-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Qualcomm-Athwnx-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Qualcomm-Qcamain10x64-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Ralink-Netr28x-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtl8187se-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtl8192se-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtl819xp-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtl85n64-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtwlane-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtwlane01-FOD
call:rm_pkg Microsoft-Windows-Wifi-Client-Realtek-Rtwlane13-FOD
call:rm_pkg Microsoft-Windows-WordPad-FoD

::-------------------------


echo Removing Edge:
rd "C:\scratchdir\Program Files (x86)\Microsoft\Edge" /s /q
rd "C:\scratchdir\Program Files (x86)\Microsoft\EdgeUpdate" /s /q
echo Removing OneDrive:
takeown /f C:\scratchdir\Windows\System32\OneDriveSetup.exe
icacls C:\scratchdir\Windows\System32\OneDriveSetup.exe /grant Administrators:F /T /C
del /f /q /s "C:\scratchdir\Windows\System32\OneDriveSetup.exe"
echo Removal complete!
timeout /t 2 /nobreak
%CLEAR%
echo Loading registry...
reg load HKLM\zCOMPONENTS "c:\scratchdir\Windows\System32\config\COMPONENTS" >log
reg load HKLM\zDEFAULT "c:\scratchdir\Windows\System32\config\default" >log
reg load HKLM\zNTUSER "c:\scratchdir\Users\Default\ntuser.dat" >log
reg load HKLM\zSOFTWARE "c:\scratchdir\Windows\System32\config\SOFTWARE" >log
reg load HKLM\zSYSTEM "c:\scratchdir\Windows\System32\config\SYSTEM" >log
echo Bypassing system requirements(on the system image):
			Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d "1" /f >log 2>&1
echo Disabling Teams:
Reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v "ConfigureChatAutoInstall" /t REG_DWORD /d "0" /f >log 2>&1
echo Disabling Sponsored Apps:
Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "ConfigureStartPins" /t REG_SZ /d "{\"pinnedList\": [{}]}" /f >log 2>&1
echo Enabling Local Accounts on OOBE:
Reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "BypassNRO" /t REG_DWORD /d "1" /f >log 2>&1
copy /y %~dp0autounattend.xml c:\scratchdir\Windows\System32\Sysprep\autounattend.xml
echo Disabling Reserved Storage:
Reg add "HKLM\zSOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d "0" /f >log 2>&1
echo Disabling Chat icon:
Reg add "HKLM\zSOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v "ChatIcon" /t REG_DWORD /d "3" /f >log 2>&1
Reg add "HKLM\zNTUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d "0" /f >log 2>&1
echo Tweaking complete!
echo Unmounting Registry...
reg unload HKLM\zCOMPONENTS >log 2>&1
reg unload HKLM\zDRIVERS >log 2>&1
reg unload HKLM\zDEFAULT >log 2>&1
reg unload HKLM\zNTUSER >log 2>&1
reg unload HKLM\zSCHEMA >log 2>&1
reg unload HKLM\zSOFTWARE >log 2>&1
reg unload HKLM\zSYSTEM >log 2>&1
echo Cleaning up image...
dism /image:c:\scratchdir /Cleanup-Image /StartComponentCleanup /ResetBase
echo Cleanup complete.
echo Unmounting image...
dism /unmount-image /mountdir:c:\scratchdir /commit
echo Exporting image...
Dism /Export-Image /SourceImageFile:c:\tiny11\sources\install.wim /SourceIndex:%index% /DestinationImageFile:c:\tiny11\sources\install2.wim /compress:max
del c:\tiny11\sources\install.wim
ren c:\tiny11\sources\install2.wim install.wim
echo Windows image completed. Continuing with boot.wim.
timeout /t 2 /nobreak
%CLEAR%
echo Mounting boot image:
dism /mount-image /imagefile:c:\tiny11\sources\boot.wim /index:2 /mountdir:c:\scratchdir
echo Loading registry...
reg load HKLM\zCOMPONENTS "c:\scratchdir\Windows\System32\config\COMPONENTS" >log
reg load HKLM\zDEFAULT "c:\scratchdir\Windows\System32\config\default" >log
reg load HKLM\zNTUSER "c:\scratchdir\Users\Default\ntuser.dat" >log
reg load HKLM\zSOFTWARE "c:\scratchdir\Windows\System32\config\SOFTWARE" >log
reg load HKLM\zSYSTEM "c:\scratchdir\Windows\System32\config\SYSTEM" >log
echo Bypassing system requirements(on the setup image):
			Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zDEFAULT\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zNTUSER\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d "0" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f >log 2>&1
			Reg add "HKLM\zSYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d "1" /f >log 2>&1
echo Tweaking complete! 
echo Unmounting Registry...
reg unload HKLM\zCOMPONENTS >log 2>&1
reg unload HKLM\zDRIVERS >log 2>&1
reg unload HKLM\zDEFAULT >log 2>&1
reg unload HKLM\zNTUSER >log 2>&1
reg unload HKLM\zSCHEMA >log 2>&1
reg unload HKLM\zSOFTWARE >log 2>&1
reg unload HKLM\zSYSTEM >log 2>&1
echo Unmounting image...
dism /unmount-image /mountdir:c:\scratchdir /commit 
%CLEAR%
echo the tiny11 image is now completed. Proceeding with the making of the ISO...
echo Copying unattended file for bypassing MS account on OOBE...
copy /y %~dp0autounattend.xml c:\tiny11\autounattend.xml
echo.
echo Creating ISO image...
%~dp0oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bc:\tiny11\boot\etfsboot.com#pEF,e,bc:\tiny11\efi\microsoft\boot\efisys.bin c:\tiny11 %~dp0tiny11.iso
echo Creation completed! Press any key to exit the script...
pause 
echo Performing Cleanup...
rd c:\tiny11 /s /q
rd c:\scratchdir /s /q

goto:eof

:rm_pap
    for /f %%i in ('findstr %~1 pap.lst') do (
    	echo Removing: %%i
        dism /image:%img_dir% /Remove-ProvisionedAppxPackage /PackageName:%%i
    )
    goto:eof

:rm_pkg
    for /f %%j in ('findstr %~1 pkg.lst') do (
    	echo Removing: %%j
        dism /image:%img_dir% /Remove-Package /PackageName:%%j
    )
    goto:eof

::-------------------------
exit





