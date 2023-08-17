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
$ImportCsv = Join-Path $MainFolderPath "output/output.csv"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

# Set the Variables for constructing the Commandline for psql
$LogHeader = Get-Date -Format "yyyy/MM/dd/HH:mm:ss"
$errorMessage = $null

# Create the SQL file with customized variabales
$TableName = 'テスト'
$ImportCsv = "input\Import_$TableName.csv"
$Sql_ImportCsv = "COPY (SELECT * FROM $TableName) FROM '$ImportCsv' (FORMAT CSV WITH HEADER)"
$ImportSqlFile = Join-Path $MainFolderPath "ExportCsv.sql"
$Sql_ImportCsv | Out-File -FilePath $ImportSql

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -d $PsqlDbName -p $PsqlPort -f $ImportSqlFile
} catch {
    $errorMessage = $_.Exception.Message
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
    if($null -eq $errorMessage) {
            "$LogHeader : Successfully Imported" | Out-File -FilePath $logFilePath -Append
    } else {
            "$LogHeader : '$errorMessage'" | Out-File -FilePath $logFilePath -Append
    }
    "$LogHeader : Import from '$ImportCsv'" | Out-File -FilePath $logFilePath -Append
}

