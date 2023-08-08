# initiate.ps1

# Change the current directory to the script's directory
Set-Location $PSScriptRoot

# Get the full path to log/CsvConvertLogging.ps1 and main/CsvConvert.ps1
$LogScriptPath = Join-Path $PSScriptRoot "log\CsvConvertLogging.ps1"
$CsvConvertScriptPath = Join-Path $PSScriptRoot "main\CsvConvert.ps1"

# Get the full path of Modules
$CsvConvertModulePath = Join-Path $PSScriptRoot "main\CsvConvertModule.psm1"
$CsvConvertLogModulePath = Join-Path $PSScriptRoot "log\CsvConvertLogModule.psm1"
$PsqlQueryFilePath = Join-Path $PSScriptRoot ".\main\PsqlQuery.ps1"

#Get the Full Config FilePath
$TableConfigFilePath = Join-Path $PSScriptRoot "main\TableConfig.psd1"
$PsqlConfigFilePath = JOin-Path $PSScriptRoot ".\main\PsqlConfig.psd1"

#Get the Folder Path 
$CsvConvertLogFolderPath = Join-Path $PSScriptRoot "log"
$CsvConvertFolderPath = Join-Path $PSScriptRoot "main"

# Load the LogModule module
Import-Module -Name $CsvConvertLogModulePath -Force

# Create the error log file and export the logFileName
$logFilePath = Export-logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath

# Execute the CsvConvertLogging.ps1 script with the logFileName
. $logScriptPath -CsvConvertLogModulePath $CsvConvertLogModulePath -LogScriptPath $LogScriptPath -CsvConvertLogFolderPath $CsvConvertLogFolderPath -CsvConvertScriptPath $CsvConvertScriptPath -TableConfigFilePath $TableConfigFilePath -CsvConvertFolderPath $CsvConvertFolderPath -logFileName $logFileName

# Execute the PsqlQuery.ps1 script Write-Out to TableConfig.psd1
. $PsqlQueryFilePath -CsvConvertFolderPath $CsvConvertFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath 

# Execute the CsvConvert.ps1 script by reading the TableConfig.psd1  
. $CsvConvertScriptPath -logFilePath $logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath -CsvConvertModulePath $CsvConvertModulePath -TableConfigFilePath $TableConfigFilePath -CsvConvertFolderPath $CsvConvertFolderPath
