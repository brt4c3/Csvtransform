# initiate.ps1

# Get the full path to log/ErrorLogging.ps1 and main/Main.ps1
$logScriptPath = Join-Path $PSScriptRoot "log\ErrorLogging.ps1"
$mainScriptPath = Join-Path $PSScriptRoot "main\Main.ps1"
$myFunctionScriptPath = Join-Path $PSScriptRoot "main\MyFunction.ps1"

# Change the current directory to the script's directory
Set-Location $PSScriptRoot

# Execute the ErrorLogging.ps1 script
. $logScriptPath

# Load the MyFunction script
. $myFunctionScriptPath

# Execute the Main.ps1 script and pass the $logFilePath as an argument
$logFilePath = Create-ErrorLogFile
. $mainScriptPath -logFilePath $logFilePath
