# log/ErrorLogging.ps1

# Function to create the error log file with the $timestamp _main.log file name
function Create-ErrorLogFile {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $logFileName = "{0}_main.log" -f $timestamp
    $logFilePath = Join-Path $PSScriptRoot $logFileName
    return $logFilePath
}

# Load the LogModule module
$modulePath = Join-Path $PSScriptRoot "log\LogModule.psm1"
Import-Module -Name $modulePath -Force

# Create the error log file
$logFilePath = Create-ErrorLogFile

# Start error logging
Start-ErrorLogging -LogPath ".\log"

# Call the script containing Main.ps1 and pass the $logFilePath as an argument
$mainScriptPath = Join-Path $PSScriptRoot "..\main\Main.ps1"
Invoke-Expression "& '$mainScriptPath' -logFilePath '$logFilePath'"

# Stop error logging
Stop-ErrorLogging
