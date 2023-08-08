# CsvConvertLogModule.psm1
function Start-ErrorLogging {
    param (
        [string]$CsvConvertLogFolderPath,
        [string]$logFilePath 
    )

    #$logFileName = (Get-Date).ToString("yyyyMMdd_HHmmss") + "_error.log"
    #$logFilePath = Join-Path $CsvConvertLogFolderPath $logFileName
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
