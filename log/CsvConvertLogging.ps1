# log/CsvConvertLogging.ps1

param (
    [string]$CsvConvertLogModulePath,
    [string]$CsvConvertLogFolderPath,
    [string]$mainScriptPath,
    [string]$CsvConvertFolderPath,
    [string]$TableConfigFilePath,
    [string]$logFileName
)

# Load the LogModule module
Import-Module -Name $CsvConvertLogModulePath -Force

# Start error logging
Start-ErrorLogging -LogPath $CsvConvertLogFolderPath -logFileName $logFileName

# Stop error logging
Stop-ErrorLogging
