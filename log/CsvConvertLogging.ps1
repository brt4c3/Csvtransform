# log/CsvConvertLogging.ps1

param (
    [string]$CsvConvertLogModulePath,
    [string]$CsvConvertLogFolderPath,
    [string]$mainScriptPath,
    [string]$CsvConvertFolderPath,
    [string]$TableConfigFilePath
)

# Load the LogModule module
Import-Module -Name $CsvConvertLogModulePath -Force

# Create the error log file
#$logFilePath = Export-logFilePath -CsvConvertLogFolderPath $CsvConvertLogFolderPath

# Start error logging
Start-ErrorLogging -LogPath $CsvConvertLogFolderPath

# Call the script containing CsvConvert.ps1 and pass the $logFilePath as an argument
#Invoke-Expression "& '$mainScriptPath' -logFilePath '$logFilePath' -logFilePath '$logFilePath' -CsvConvertModulePath '$CsvConvertModulePath' -TableConfigFilePath '$TableConfigFilePath' -CsvConvertFolderPath '$CsvConvertFolderPath'"

# Stop error logging
Stop-ErrorLogging
