param (
    [string]$MainFolderPath,
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

# Configure the location for the log file and output.csv file
$ExportCsv = Join-Path $MainFolderPath "output/exportfromPSQL.csv"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -d $PsqlDbName -p $PsqlPort "$(COPY "テスト" TO $ExportCsv WITH CSV)" ;
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Command executed successfully!"| Out-File -FilePath $logFilePath -Append
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Import from $ExportCsv" | Out-File -FilePath $logFilePath -Append
} catch {
    $errorMessage = $_.Exception.Message
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -FilePath $logFilePath -Append
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Import from $ExportCsv" | Out-File -FilePath $logFilePath -Append
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

