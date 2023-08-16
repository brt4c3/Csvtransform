# initiate.ps1

# Change the current directory to the script's directory
Set-Location $PSScriptRoot

# Get the full path to log/CsvConvertLogging.ps1 and main/CsvConvert.ps1
$CsvConvertScriptPath = Join-Path $PSScriptRoot "main\CsvConvert.ps1"

# Get the full path of Modules
$CsvConvertModulePath = Join-Path $PSScriptRoot "main\CsvConvertModule.psm1"
$CsvConvertLogModulePath = Join-Path $PSScriptRoot "main\CsvConvertLogModule.psm1"
$PsqlQueryFilePath = Join-Path $PSScriptRoot "main\PsqlQuery.ps1"
$PsqlDumpFilePath = Join-Path $PSScriptRoot "main\PsqlDump.ps1" 

#Get the Full Config FilePath
$TableConfigFilePath = Join-Path $PSScriptRoot "main\TableConfig.psd1"
$PsqlConfigFilePath = Join-Path $PSScriptRoot "main\PsqlConfig.psd1"

#Get the Folder Path 
$CsvConvertLogFolderPath = Join-Path $PSScriptRoot "log"
$CsvConvertFolderPath = Join-Path $PSScriptRoot "main"

#Get the input output Files path
$InputFilePath = Join-Path $PSScriptRoot "main\input\sample.csv"
$OutputFilePath = Join-Path $PSScriptRoot "main\output\output.csv"

# Load the LogModule module
Import-Module -Name $CsvConvertLogModulePath -Force

try{
# Create the error log file and export the logFileName
$logFilePath = Export-logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath
}catch{
    
}

# Set the Query file for the SQL injection 
$QueryFileName = "SampleQuery.sql"

# Execute the PsqlQuery.ps1 script Write-Out to TableConfig.psd1
. $PsqlQueryFilePath -CsvConvertFolderPath $CsvConvertFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath -QueryFileName $QueryFileName

# Execute the PsqlDump.ps1 script Write-Out to TableConfig.psd1
. $PsqlDumpFilePath -CsvConvertFolderPath $CsvConvertFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath 

# Execute the CsvConvert.ps1 script by reading the TableConfig.psd1  
. $CsvConvertScriptPath -InputFilePath $InputFilePath -OutputFilePath $OutputFilePath -logFilePath $logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath -CsvConvertModulePath $CsvConvertModulePath -TableConfigFilePath $TableConfigFilePath -CsvConvertFolderPath $CsvConvertFolderPath
