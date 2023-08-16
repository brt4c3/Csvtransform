# main/CsvConvert.ps1

param (
    [string]$logFilePath,
    [string]$CsvConvertLogFolderPath,
    [string]$CsvConvertModulePath,
    [string]$TableConfigFilePath,
    [string]$MainFolderPath,
    [string]$CsvConvertLogModulePath,
    [string]$mainScriptPath,
    [string]$InputFilePath,
    [string]$OutputFilePath
)
# Load the CsvConvertModulePath module
Import-Module -Name $CsvConvertModulePath -Force

# Call the Export-CSVWithColumns function with arguments
Export-CSVWithColumns -InputFilePath $InputFilePath -OutputFilePath $OutputFilePath -TableConfigFilePath $TableConfigFilePath -logFilePath $logFilePath -MainFolderPath $MainFolderPath

