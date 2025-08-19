# Microsoft Intune Branding
This repository provides a sample PowerShell script designed to customize Windows 11 devices using Microsoft Intune. 

The script can be packaged as a Win32 app for deployment via Intune.

## 📦 Requirements
Uses the Microsoft Win32 Content Prep Tool (IntuneWinAppUtil.exe) to package the PowerShell script and assets into a .intunewin file.

Download the tool from: Microsoft-Win32-Content-Prep-Tool

## 🛠️ Setup Instructions
Replace Background.jpg and LockScreen.jpg with your custom branding images.

Run makeapp.cmd from a command prompt to build the .intunewin package.

The detection script BrandingDetection.ps1 will be automatically generated.

## 🚀 Deployment
Upload the .intunewin package and BrandingDetection.ps1 to Intune.

Use the following install command:

powershell.exe -noprofile -executionpolicy bypass -file .\CorporateBranding.ps1

## Credits

This branding app is based off of https://github.com/mtniehaus/AutopilotBranding
