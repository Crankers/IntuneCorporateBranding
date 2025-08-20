@echo off
pushd %~dp0
PowerShell.exe -noprofile -executionpolicy bypass -file makeapp.ps1 -SourceFolder .\CorporateBranding -SetupFile CorporateBranding.ps1
popd
