[CmdletBinding()]
param(
    [Parameter(Mandatory = $True)] [string] $SourceFolder,
    [Parameter(Mandatory = $True)] [string] $SetupFile,
    [Parameter(Mandatory = $False)] [string] $OutputFolder = ""
)

Copy-Item -Path "$PSScriptRoot\Background.jpg" -Destination "$PSScriptRoot\CorporateBranding\Background.jpg" -Force
Copy-Item -Path "$PSScriptRoot\LockScreen.jpg" -Destination "$PSScriptRoot\CorporateBranding\LockScreen.jpg" -Force
$LockScreenHash = Get-FileHash -Path "$PSScriptRoot\LockScreen.jpg" -Algorithm SHA512
$BackgroundHash = Get-FileHash -Path "$PSScriptRoot\BackGround.jpg" -Algorithm SHA512

$newScriptContent = @'
If ((Test-Path -Path "C:\Windows\Resources\Themes\CorporateBranding.theme") -and (Test-Path -Path "C:\Windows\web\wallpaper\CorporateBranding\BackGround.jpg") -and (Test-Path -Path "C:\Windows\web\wallpaper\CorporateBranding\LockScreen.jpg"))
{

$LockScreenHash = Get-FileHash -Path "C:\Windows\web\wallpaper\CorporateBranding\LockScreen.jpg" -Algorithm SHA512
$BackgroundHash = Get-FileHash -Path "C:\Windows\web\wallpaper\CorporateBranding\BackGround.jpg" -Algorithm SHA512

If ("$($LockScreenHash.Hash)" -eq "TheLockScreenHash" -and "$($BackgroundHash.Hash)" -eq "TheBackgroundHash") {
Return 0
}

}
'@

$newScriptContent = $newScriptContent -replace "TheLockScreenHash","$($LockScreenHash.Hash)" -replace "TheBackgroundHash","$($BackgroundHash.Hash)"
Remove-Item -Path "$PSScriptRoot\BrandingDetection.ps1" -Force -ErrorAction SilentlyContinue
$newScriptContent | Out-File "$PSScriptRoot\BrandingDetection.ps1" -Force 


# Check NuGet version
$MinimumVersion = [version]'2.8.5.201'
$provider = Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue |
Sort-Object Version -Descending |
Select-Object -First 1

if (-not $provider) {
    Write-Verbose 'NuGet Provider Package not detected, installing...'
    Install-PackageProvider -Name NuGet -Force | Out-Null
} elseif ($provider.Version -lt $MinimumVersion) {
    Write-Verbose "NuGet provider v$($provider.Version) is less than required v$MinimumVersion; updating."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    
} else {
    Write-Verbose "NuGet provider meets min requirements (v:$($provider.Version))."
}

# Install and import the module to create the .intunewin file
Install-Module SvRooij.ContentPrep.Cmdlet -MinimumVersion 0.3.0
Import-Module SvRooij.ContentPrep.Cmdlet

# Create the .intunewin file
if ($OutputFolder -eq "") {
    $OutputFolder = $PSScriptRoot
}
New-IntuneWinPackage -SourcePath $SourceFolder -SetupFile $SetupFile -DestinationPath $OutputFolder
