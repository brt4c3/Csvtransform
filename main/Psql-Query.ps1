
$pg_bin = "C:\Program Files\PostgreSQL\14\bin\psql.exe"
#$host = "localhost"
$user = "postgres"
$database = "postgres"
$port = 5432
$query = "SELECT * FROM test;"
$output_file = "C:\work\output.csv"
$log_file = "C:\work\error.log"

# Set the PGPASSWORD environment variable with your PostgreSQL password
$env:PGPASSWORD = "YourPasswordHere"

try {
    & $pg_bin -h $host -U $user -d $database -p $port -c $query -A -F "," | Out-File -FilePath $output_file -Encoding UTF8
    Write-Host "Command executed successfully!"
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Error occurred: $errorMessage"
    $errorMessage | Out-File -FilePath $log_file -Encoding UTF8
} finally {
    # Unset the PGPASSWORD environment variable after executing the command
    $env:PGPASSWORD = $null
}

