# Enable PowerShell Scripts #
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Folder_Creation_In_Local_Machine #
Write-Host "Creating Directories on Local Machine" -ForegroundColor Green
New-Item -Path "C:\Install\Download" -ItemType "Directory" -Force
New-Item -Path "C:\Packages" -ItemType "Directory" -Force
Start-Sleep -s 5

Write-Host "Locale Setting to --> Singapore" -ForegroundColor Green 
Set-WinSystemLocale en-SG
Write-Host "Culture Setting to --> Singapore" -ForegroundColor Green 
Set-Culture en-SG
Write-Host "Time Zone Setting to --> Singapore" -ForegroundColor Green 
Set-TimeZone -Id "Singapore Standard Time"
Write-Host "Win Home Location Setting to --> Singapore" -ForegroundColor Green 
Set-WinHomeLocation -GeoId "215" ##**Singapore GeoId is 215**## 
Write-Host "Win User Language Setting to --> Singapore" -ForegroundColor Green 
Set-WinUserLanguageList en-SG -Force
Start-Sleep -s 5



# Visual Studio Code#
Write-Host "Visual Studio Code" -ForegroundColor Green
$Installervscode = "C:\Install\VSCodeSetup-x64-1.63.2.exe";
Invoke-WebRequest "https://update.code.visualstudio.com/1.63.2/win32-x64/stable" -OutFile $Installervscode;
Start-Process -FilePath $Installervscode -ArgumentList " /verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath " -Wait;

# Visual Studio Professional 2022 #
Write-Host "Installing Visual Studio 2022 Professional" -ForegroundColor Green 
$vSInstalleerfilePath = "C:\Install\Download\vs_Professional.exe"
Invoke-WebRequest "https://aka.ms/vs/17/release/vs_professional.exe" -OutFile $vSInstalleerfilePath
$workloadArgument = @(
    '--add Microsoft.VisualStudio.Workload.CoreEditor'
    '--add Microsoft.VisualStudio.Workload.Azure'
    '--add Microsoft.VisualStudio.Workload.Data'
    '--add Microsoft.VisualStudio.Workload.DataScience'
    '--add Microsoft.VisualStudio.Workload.ManagedDesktop'
    '--add Microsoft.VisualStudio.Workload.NativeDesktop'
    '--add Microsoft.VisualStudio.Workload.NetWeb'
    '--add Microsoft.VisualStudio.Workload.Node'
    '--add Microsoft.VisualStudio.Workload.Python'
    '--add Microsoft.VisualStudio.Workload.Universal'
    '--add Microsoft.Component.HelpViewer'
    '--add Microsoft.VisualStudio.Component.ClassDesigner'
    '--add Microsoft.VisualStudio.Component.GraphDocument'
    '--add Microsoft.VisualStudio.Component.DependencyValidation.Community'
    '--add Microsoft.VisualStudio.Component.LinqToSql'
    '--add Microsoft.VisualStudio.Component.AzureDevOps.OfficeIntegration'
    '--add Microsoft.VisualStudio.Component.Git'
    '--add Component.OpenJDK'
) 
$optionsAddLayout          = [string]::Join(" ", $workloadArgument )
$optionsQuiet              = "--passive"
$optionsIncludeRecommended = "--includeRecommended"
$vsOptions = @(
    $optionsIncludeRecommended,
    $optionsAddLayout
    $optionsQuiet
)
Start-Process -FilePath $vSInstalleerfilePath -ArgumentList $vsOptions -Wait

# Node.Js 
Write-Host "Installing Node JS" -ForegroundColor Green
Invoke-WebRequest "https://nodejs.org/dist/v16.13.1/node-v16.13.1-x64.msi" -OutFile "C:\Install\node-v16.13.1-x64.msi" ; Start-Process "msiexec.exe" -Wait -ArgumentList '/i C:\Install\node-v16.13.1-x64.msi /passive'

# Google Chrome
Write-Host "Installing Google Chrome" -ForegroundColor Green
$chromeInstallerPath = "C:\Install"; $chromeInstaller = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $chromeInstallerPath\$chromeInstaller; Start-Process -FilePath $chromeInstallerPath\$chromeInstaller -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $chromeInstallerPath\$chromeInstaller

# Enable Hyper-V
Write-Host "Enable Hyper-V" -ForegroundColor Green
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

# WSL 2
Write-Host "Installing WSL 2" -ForegroundColor Green
$Installerwsl2 = "C:\Install\wsl_update_x64.msi" ; 
Invoke-WebRequest "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile $Installerwsl2 ; 
Start-Process "msiexec.exe" -Wait -ArgumentList "/i $Installerwsl2 /passive /norestart"; 

# Enable WSL2
Write-Host "Enable WSL2" -ForegroundColor Green
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart

# 7 Zip
Write-Host "Installing 7 Zip" -ForegroundColor Green
$Installer7Zip = "C:\Install\7z2107-x64.msi" ; 
Invoke-WebRequest "https://www.7-zip.org/a/7z2107-x64.msi" -OutFile $Installer7Zip; 
Start-Process "msiexec.exe" -Wait -ArgumentList "/i $Installer7Zip /passive /norestart"; 

# SQL Server Management Studio
Write-Host "Installing SQL Server Management Studio" -ForegroundColor Green
$InstallerSSMS = "C:\Install\SSMS-Setup-ENU.exe" ;
Invoke-WebRequest "https://aka.ms/ssmsfullsetup" -OutFile $InstallerSSMS; 
Start-Process  -FilePath $InstallerSSMS -ArgumentList " /passive " -Wait; 

# Install Microsoft ODBC Driver for SQL Server. Visual Studio install ODBC driver be driver. Unblock this if it doesnt.
#Write-Host " Microsoft ODBC Driver for SQL Server"
#$Installerodbcsql = "C:\Install\msodbcsql.msi"
#Invoke-WebRequest "https://go.microsoft.com/fwlink/?linkid=2168524" -OutFile $Installerodbcsql
#Start-Process -FilePath $Installerodbcsql  -Wait 

# Notepad ++
Write-Host "Installing Notepad ++" -ForegroundColor Green
$Installernpp = "C:\Install\npp.8.2.Installer.x64.exe";
Invoke-WebRequest "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.2/npp.8.2.Installer.x64.exe" -OutFile $Installernpp;
Start-Process -FilePath $Installernpp -ArgumentList " /S " -Wait;

# Azure CLI
Write-Host "Installing Azure CLI" -ForegroundColor Green
$InstallerAzCli = "C:\Install\azure-cli-2.32.0.msi" ; 
Invoke-WebRequest "https://azcliprod.blob.core.windows.net/msi/azure-cli-2.32.0.msi" -OutFile $InstallerAzCli; 
Start-Process "msiexec.exe" -Wait -ArgumentList "/i $InstallerAzCli /quiet "; 

# Postman
Write-Host "Installing PostMan" -ForegroundColor Green
$InstallerPostman = "C:\Install\Postman-win64-9.7.1-Setup.exe"
Invoke-WebRequest "https://dl.pstmn.io/download/latest/win64" -OutFile $InstallerPostman;
Start-Process -FilePath $InstallerPostman -ArgumentList " /S " -Wait;

# Docker Desktop
Write-Host "Installing Docker Desktop" -ForegroundColor Green
$InstallerDockerDesktop = "C:\Install\Docker%20Desktop%20Installer.exe"
Invoke-WebRequest "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe" -OutFile $InstallerDockerDesktop;
Start-Process -FilePath $InstallerDockerDesktop -ArgumentList "install --quiet" -Wait -NoNewWindow


# WinMerge
Write-Host "Installing WinMerge" -ForegroundColor Green
$InstallerWinMerge = "C:\Install\WinMerge-2.16.16-x64-Setup.exe"
Invoke-WebRequest "https://github.com/WinMerge/winmerge/releases/download/v2.16.16/WinMerge-2.16.16-x64-Setup.exe" -OutFile $InstallerWinMerge
Start-Process -FilePath $InstallerWinMerge -ArgumentList "/verysilent /norestart" -Wait 

# Fiddler
Write-Host "Installing Fiddler" -ForegroundColor Green
$InstallerFiddler = "C:\Install\FiddlerSetup.exe"
Invoke-WebRequest "https://telerik-fiddler.s3.amazonaws.com/fiddler/FiddlerSetup.exe" -OutFile $InstallerFiddler
Start-Process -FilePath $InstallerFiddler -ArgumentList " /S " -Wait

# KeyStore Explorer
Write-Host "Installing KeyStore Explorer" -ForegroundColor Green
$Installerkse = "C:\Install\kse-550-setup.exe"
Invoke-WebRequest "https://github.com/kaikramer/keystore-explorer/releases/download/v5.5.0/kse-550-setup.exe" -OutFile $Installerkse
Start-Process -FilePath $Installerkse -ArgumentList "/silent /allusers /norestart" -Wait 

# Putty
Write-Host "Installing Putty" -ForegroundColor Green
$Installerputty = "C:\Install\putty-64bit-0.76-installer.msi"
Invoke-WebRequest "https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.76-installer.msi" -OutFile $Installerputty
Start-Process "msiexec.exe" -Wait -ArgumentList "/i $Installerputty /passive"; 

# Firefox
Write-Host "Installing Firefox" -ForegroundColor Green
$Installerff = "C:\Install\firefox.msi"
Invoke-WebRequest "https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=en-US" -OutFile $Installerff
Start-Process "msiexec.exe" -Wait -ArgumentList "/i $Installerff /passive"; 

# SourceTree
Write-Host "Installing SourceTree" -ForegroundColor Green
$Installerst = "C:\Install\SourcetreeEnterpriseSetup_3.4.7.msi"
Invoke-WebRequest "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.4.7.msi" -OutFile $Installerst
Start-Process "msiexec.exe"  -ArgumentList "/i $Installerst ACCEPTEULA=1 /qn /norestart " -Wait


# Babel Obfuscator 
Write-Host "Installing Babel Obfuscator" -ForegroundColor Green
$Installerbo = "C:\Install\babel_x64_9.8.0.0_demo.msi"
Invoke-WebRequest "https://www.babelfor.net/?smd_process_download=1&download_id=2706" -OutFile $Installerbo
Start-Process "msiexec.exe" -Wait -ArgumentList "/i $Installerbo /verysilent " 

# Eclipse IDE
# Write-Host "Installing Eclipse IDE" -ForegroundColor Green
# $InstallerEide = "C:\Packages\eclipse-jee-2021-12-R-win32-x86_64.zip"
# Invoke-WebRequest "https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2021-12/R/eclipse-jee-2021-12-R-win32-x86_64.zip&mirror_id=1" -OutFile $InstallerEide

# # Apache Tomcat
# Write-Host "Installing Apache Tomcat" -ForegroundColor Green
# $InstallerAT = "C:\Packages\apache-tomcat-9.0.56-windows-x64.zip"
# Invoke-WebRequest "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56-windows-x64.zip" -OutFile $InstallerAT


# Install Nuget < Visual Studio installs Nuget by default> Enable this if defcault installation does work
# Write-Host "Installing Nuget"
# $InstallerNuget = "C:\Install\nuget.exe"
# Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/v6.0.0/nuget.exe" -OutFile $InstallerNuget
# Start-Process -FilePath $InstallerNuget  -Wait 

# Enable Nuget
Write-Host "Enabling Nuget Provider" -ForegroundColor Green
Install-PackageProvider -Name NuGet -Force
Register-PackageSource -Name nuget.org -Location https://www.nuget.org/api/v2 -ProviderName NuGet


# To restart the Powershell windows for the Install-Package cmdlet to work
Invoke-Command { & "pwsh.exe" } -NoNewScope # PowerShell 7

# Confluent Kafka .Net Library
Write-Host "Installing Confluent Kafka .Net Library" -ForegroundColor Green
Install-Package librdkafka.redist -Force 
Install-Package Confluent.Kafka -Force -SkipDependencies

# Nunit
Write-Host "Installing Nunit" -ForegroundColor Green
Install-Package NUnit -Force -SkipDependencies

# IronPDF
Write-Host "Installing IronPDF" -ForegroundColor Green
Install-Package ironpdf -Force -SkipDependencies

# Angular CLI
Write-Host "Installing Angular CLI" -ForegroundColor Green
npm install -g @angular/cli

# FluentValidation.AspNetCore
Install-Package FluentValidation.AspNetCore -Force 

# Swashbuckle.AspNetCore
Install-Package Swashbuckle.AspNetCore -Force -SkipDependencies

# D365 Customer Engagement Tools
Install-Package Microsoft.CrmSdk.XrmTooling.PluginRegistrationTool -Force
Install-Package Microsoft.CrmSdk.CoreTools -Force
Install-Package Microsoft.CrmSdk.XrmTooling.ConfigurationMigration.Wpf -Force
Install-Package Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf -Force

# Chocolatey
Write-Host "Installing Chocolatey" 
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# fluxctl
Write-Host "Installing fluxctl" 
choco install fluxctl -y 

# jq
# Write-Host "Installing jq" 
# chocolatey install jq -y 

#  yq
Write-Host "Installing yq" 
chocolatey install yq -y 

