
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

# Set the Variables for constructing the Commandline for psql
$TableName = "テスト"
$CommandLine = \COPY $TableName TO '$ExportCsv' WITH CSV HEADER
$LogHeader = Get-Date -Format "yyyy/MM/dd/HH:mm:ss"
$errorMessage = $null

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -d $PsqlDbName -p $PsqlPort -c $CommandLine
} catch {
    $errorMessage = $_.Exception.Message
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
    if ($null -eq $errorMessage) {
        "$LogHeader : Successfully Exported" | Out-File -FilePath $logFilePath -Append
    } else {
        "$LogHeader : '$errorMessage'" | Out-File -FilePath $logFilePath -Append
    }
    "$LogHeader : Export to '$ExportCsv'" | Out-File -FilePath $logFilePath -Append
}