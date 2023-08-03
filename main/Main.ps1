# main/Main.ps1

param (
    [string]$logFilePath
)

# Get the current directory path
$currentDirectory = Get-Location

# Build the full path to MyModule.psm1
$modulePath = Join-Path $currentDirectory "MyModule.psm1"

# Change the current directory to the script's directory
Set-Location $PSScriptRoot
Write-Host $PSScriptRoot

# Load the MyModule module
Import-Module -Name $modulePath -Force
Write-Host $modulePath
# Import the functions from MyFunction.ps1
. .\MyFunction.ps1

# Call the Export-CSVWithColumns function with arguments
Export-CSVWithColumns -InputFilePath ".\input\sample.csv" -OutputFilePath ".\output\output.csv" -ConfigFilePath ".\ColumnsConfig.psd1" -logFilePath $logFilePath
