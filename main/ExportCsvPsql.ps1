
param (
    [string]$MainFolderPath,
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

# Configure the location for the log file and output.csv file
$ExportCsv = Join-Path $MainFolderPath "output/exportfromPSQL.csv"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

# Set the Variables for constructing the Commandline for psql
$LogHeader = Get-Date -Format "yyyy/MM/dd/HH:mm:ss"
$errorMessage = $null

# Create the SQL file with customized variabales
$TableName = 'テスト'
$ExportCsv = "output\export_$TableName.csv"
$Sql_ExportCsv = "COPY (SELECT * FROM $TableName) TO '$ExportCsv' (FORMAT CSV)"
$ExportSqlFile = Join-Path $MainFolderPath "ExportCsv.sql"
$Sql_ExportCsv | Out-File -FilePath $ExportSql

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -d $PsqlDbName -p $PsqlPort -f $ExportSqlFile
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