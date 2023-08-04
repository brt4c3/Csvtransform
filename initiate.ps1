# initiate.ps1

# Change the current directory to the script's directory
Set-Location $PSScriptRoot

# Get the full path to log/CsvConvertLogging.ps1 and main/CsvConvert.ps1
$LogScriptPath = Join-Path $PSScriptRoot "log\CsvConvertLogging.ps1"
$CsvConvertScriptPath = Join-Path $PSScriptRoot "main\CsvConvert.ps1"

# Get the full path of Modules
$CsvConvertModulePath = Join-Path $PSScriptRoot "main\CsvConvertModule.psm1"
$CsvConvertLogModulePath = Join-Path $PSScriptRoot "log\CsvConvertLogModule.psm1"

#Get the Full Config FilePath
$TableConfigFilePath = Join-Path $PSScriptRoot "main\TableConfig.psd1"

#Get the Folder Path 
$CsvConvertLogFolderPath = Join-Path $PSScriptRoot "log"
$CsvConvertFolderPath = Join-Path $PSScriptRoot "main"

# Execute the CsvConvertLogging.ps1 script
. $logScriptPath -CsvConvertLogModulePath $CsvConvertLogModulePath -LogScriptPath $LogScriptPath -CsvConvertLogFolderPath $CsvConvertLogFolderPath -CsvConvertScriptPath $CsvConvertScriptPath -TableConfigFilePath $TableConfigFilePath -CsvConvertFolderPath $CsvConvertFolderPath

# Load the LogModule module
Import-Module -Name $CsvConvertLogModulePath -Force

# Create the error log file
$logFilePath = Export-logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath

# Execute the CsvConvert.ps1 script 
. $CsvConvertScriptPath -logFilePath $logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath -CsvConvertModulePath $CsvConvertModulePath -TableConfigFilePath $TableConfigFilePath -CsvConvertFolderPath $CsvConvertFolderPath
