param (
    [string]$CsvConvertFolderPath,
    [string]$PsqlConfigFilePath,
    [string]$logFilePath 
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
$timestamp = $timestamp = Get-Date -Format "yyyyMMdd"
$Timestamp2 = Get-Date -Format "yyyy/MM/dd hh:mm:ss"

# Configure the location for the log file and output.csv file
$output_file = "C:\work\rkbkup_$timestamp.dump"
$svrunLogFile = "C:\work\log\svrun_$timstamp.log"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

try {
    & $pg_dump -h $PsqlServer -U $PsqlUser -f $PsqlQuery -d $PsqlDbName -p $PsqlPort -A -F "," | Out-File -FilePath $output_file -Encoding UTF8
    "ユーザ、組織情報の取り込み開始。 $Timestamp2 " | Out-File -FilePath $svrunLogFile -Encoding UTF8
    Write-Host "Command executed successfully!"
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Error occurred: $errorMessage"
    $errorMessage | Out-File -FilePath $logFilePath -Encoding UTF8 -Append
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

