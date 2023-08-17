# ExportCsv.ps1
param (
    [string]$MainFolderPath,
    [string]$PsqlConfigFilePath,
    [string]$logFilePath,
    [string]$CsvConvertLogFolderPath,
    [string]$TableName
)

# Make sure the psql.exe file path is Correct
$pg_dump = "C:\Program Files\PostgreSQL\14\bin\pg_dump.exe"

# PSQL parameter for connection 
$PsqlConn = Import-PowerShellDataFile -Path $PsqlConfigFilePath
$PsqlServer = $PsqlConn.PsqlServer
$PsqlUser = $PsqlConn.PsqlUser
$PsqlDbName = $PsqlConn.PsqlDbName
$PsqlPort = $PsqlConn.PsqlPort
$PsqlPassword = $PsqlConn.PsqlPassword

# set timestamp
$timestamp = Get-Date -Format "yyyyMMdd"

# Set Table name 
$TableName = GetJapanese -japanese $TableName
function GetJapanese{param($japanese)
    $utf8string=[Text.Encoding]::UTF8.GetBytes($japanese)
    $decodedstring =[Text.Encoding]::UTF8.GetString($utf8string)
    return $decodedstring
    }

# Configure the location for the log file and output.csv file
$output_file = Join-Path $MainFolderPath "output_$timestamp.csv"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

try {
    & $pg_dump -h $PsqlServer -U $PsqlUser -f $output_file -d $PsqlDbName -p $PsqlPort -t $TableName --no-owner --no-comments --format = csv 
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Dump file has been exported" | Out-File -FilePath $svrunLogFile 
} catch {
    $errorMessage = $_.Exception.Message
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): '$errorMessage' " | Out-File -FilePath $logFilePath -Append
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

