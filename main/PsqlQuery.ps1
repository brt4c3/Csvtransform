param (
    [string]$CsvConvertFolderPath,
    [string]$PsqlConfigFilePath,
    [string]$logFilePath,
    [string]$QueryFileName
)

# Make sure the psql.exe file path is Correct
$pg_bin = "C:\Program Files\PostgreSQL\14\bin\psql.exe"

# PSQL parameter for connection 
$PsqlConn = Import-PowerShellDataFile -Path $PsqlConfigFilePath
$PsqlServer = $PsqlConn.PsqlServer
$PsqlUser = $PsqlConn.PsqlUser
$PsqlDbName = $PsqlConn.PsqlDbName
$PsqlPort = $PsqlConn.PsqlPort
$PsqlPassword = $PsqlConn.PsqlPassword

# PSQL parameter for Query injection 
$PsqlQuery = Join-Path $CsvConvertFolderPath $QueryFileName

# Configure the location for the log file and output.csv file
$output_file = "output\QueryResult_$QueryFileName.csv"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -f $PsqlQuery -d $PsqlDbName -p $PsqlPort -A -F "," | Out-File -FilePath $output_file 
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Command executed successfully!"| Out-File -FilePath $logFilePath -Append
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Read from $PsqlQuery" | Out-File -FilePath $logFilePath -Append
} catch {
    $errorMessage = $_.Exception.Message
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -FilePath $logFilePath -Append
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Read from $PsqlQuery" | Out-File -FilePath $logFilePath -Append
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

