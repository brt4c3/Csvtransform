# initiate.ps1

# Change the current directory to the script's directory
Set-Location $PSScriptRoot

# Get the full path to log/CsvConvertLogging.ps1 and main/CsvConvert.ps1
$CsvConvertScriptPath = Join-Path $PSScriptRoot "main\CsvConvert.ps1"

# Get the full path of Modules
$CsvConvertModulePath = Join-Path $PSScriptRoot "main\CsvConvertModule.psm1"
$CsvConvertLogModulePath = Join-Path $PSScriptRoot "main\CsvConvertLogModule.psm1"
$CreateTableFilePath= Join-Path $PSScriptRoot "main\CreateTablePsql.ps1"
$PsqlDumpFilePath = Join-Path $PSScriptRoot "main\PgDump.ps1" 

#Get the Full Config FilePath
$TableConfigFilePath = Join-Path $PSScriptRoot "main\TableConfig.psd1"
$PsqlConfigFilePath = Join-Path $PSScriptRoot "main\ConfigPsql.psd1"

#Get the Folder Path 
$CsvConvertLogFolderPath = Join-Path $PSScriptRoot "log"
$MainFolderPath = Join-Path $PSScriptRoot "main"

#Get the input output Files path
$InputFilePath = Join-Path $PSScriptRoot "main\input\sample.csv"
$OutputFilePath = Join-Path $PSScriptRoot "main\output\output.csv"

# Load the LogModule module
Import-Module -Name $CsvConvertLogModulePath -Force

try{
# Create the error log file and export the logFileName
$logFilePath = Export-logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath
}catch{}

$TableName = "Test"

# Set the Query file for the SQL injection 
$QueryFileName = "Update.sql"

# Execute the PsqlDump.ps1 script Write-Out to TableConfig.psd1
. $PsqlDumpFilePath -MainFolderPath $MainFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath 

#importCsv from PSQL
$ImportCsv = Join-Path $PSScriptRoot  "main\ImportCsvPsql.ps1"
. $ImportCsv -MainFolderPath $MainFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath -TableName $TableName

#exportCsv from PSQL
$ExportCsv = Join-Path $PSScriptRoot "main\ExportCsvPsql.ps1"
. $ExportCsv -MainFolderPath $MainFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath -TableName $TableName

# Execute the PsqlQuery.ps1 script Write-Out to TableConfig.psd1
. $CreateTableFilePath -MainFolderPath $MainFolderPath -PsqlConfigFilePath $PsqlConfigFilePath -logFilePath $logFilePath -QueryFileName $QueryFileName

# Execute the CsvConvert.ps1 script by reading the TableConfig.psd1  
. $CsvConvertScriptPath -InputFilePath $InputFilePath -OutputFilePath $OutputFilePath -logFilePath $logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath -CsvConvertModulePath $CsvConvertModulePath -TableConfigFilePath $TableConfigFilePath -MainFolderPath $MainFolderPath
