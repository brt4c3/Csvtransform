# main/CsvConvert.ps1

param (
    [string]$logFilePath,
    [string]$CsvConvertLogFolderPath,
    [string]$CsvConvertModulePath,
    [string]$TableConfigFilePath,
    [string]$CsvConvertFolderPath
)

# Load the MyModule module
Import-Module -Name $CsvConvertModulePath -Force

# Call the Export-CSVWithColumns function with arguments
Export-CSVWithColumns -InputFilePath ".\input\sample.csv" -OutputFilePath ".\output\output.csv" -TableConfigFilePath $TableConfigFilePath -logFilePath $logFilePath -CsvConvertFolderPath $CsvConvertFolderPath
