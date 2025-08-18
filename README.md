# Microsoft Intune Branding

This repository contains a sample PowerShell script that can be packaged into an Intune Win32 app to customize Windows 11 devices via Microsoft Intune

## Requirements and Dependencies
This uses the Microsoft Win32 Content Prep Tool (a.k.a. IntuneWinAppUtil.exe, available from https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool) to package the PowerShell script and related files into a .intunewin file that can be uploaded to Intune as a Win32 app. 

## Building
Replace the Background.jpg and LockScreen.jpg

Run the makeapp.cmd file from a command prompt

The detection rule script is generated and named BrandingDetection.ps1

## Using
Add the resulting Win32 app (.intunewin) to Intune.  

The installation command line should be:
powershell.exe -noprofile -executionpolicy bypass -file .\CorporateBranding.ps1

Load the detection script to your app BrandingDetection.ps1

## Credits

This branding app is based off of https://github.com/mtniehaus/AutopilotBranding
