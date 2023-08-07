param (
    [string]$CsvConvertFolderPath,
    [string]$PsqlConfigFilePath,
    [string]$logFilePath 
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
$QueryFileName = "SampleQuery.sql"
$PsqlQuery = Join-Path $CsvConvertFolderPath $QueryFileName

# Configure the location for the log file and output.csv file
$output_file = "C:\work\QueryResult.csv"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -f $PsqlQuery -d $PsqlDbName -p $PsqlPort -A -F "," | Out-File -FilePath $output_file -Encoding UTF8
    Write-Host "Command executed successfully!"
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Error occurred: $errorMessage"
    $errorMessage | Out-File -FilePath $logFilePath -Encoding UTF8 -Append
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

