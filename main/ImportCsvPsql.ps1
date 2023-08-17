param (
    [string]$MainFolderPath,
    [string]$PsqlConfigFilePath,
    [string]$logFilePath,
    [string]$QueryFileName,
    [string]$TableName
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

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = $PsqlPassword

# Create the SQL file with customized variabales
$TableName = GetJapanese -japanese $TableName
function GetJapanese{param($japanese)
    $utf8string=[Text.Encoding]::UTF8.GetBytes($japanese)
    $decodedstring =[Text.Encoding]::UTF8.GetString($utf8string)
    return $decodedstring
    }

$ImportCsvFile = Join-Path $MainFolderPath input\$TableName.csv

try {
    & $pg_bin -h $PsqlServer -U $PsqlUser -d $PsqlDbName -p $PsqlPort -c "COPY ($TableName) FROM $ImportCsvFile STDIN WITH CSV DELIMITER E',' FORCE QUOTE * NULL AS '' HEADER;"   
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Import executed successfully!"| Out-File -FilePath $logFilePath -Append
} catch {
    $errorMessage = $_.Exception.Message
    "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Import $errorMessage"| Out-File -FilePath $logFilePath -Append
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

