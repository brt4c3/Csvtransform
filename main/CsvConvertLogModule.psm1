# CsvConvertLogModule.psm1
function Start-ErrorLogging {
    param (
        [string]$logFilePath 
    )
    Start-Transcript -Path $logFilePath
}

function Stop-ErrorLogging {
    Stop-Transcript
}

function Export-logFilePath ([string]$CsvConvertLogFolderPath) {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $logFileName = "{0}_main.log" -f $timestamp
    $logFilePath = Join-Path $CsvConvertLogFolderPath $logFileName
    return $logFilePath
}
