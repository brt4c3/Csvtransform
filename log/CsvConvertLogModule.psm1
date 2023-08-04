# CsvConvertLogModule.psm1
function Start-ErrorLogging {
    param (
        [string]$LogPath
    )

    $logFileName = (Get-Date).ToString("yyyyMMdd_HHmmss") + "_error.log"
    $logFilePath = Join-Path $LogPath $logFileName

    Start-Transcript -Path $logFilePath
    Export-logFilePath -logFilePath $logFilePath
}

function Stop-ErrorLogging {
    Stop-Transcript
}

function Export-logFilePath ([string]$CsvConvertLogFolderPath) {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $logFileName = "{0}_main.log" -f $timestamp
    $logFilePath = Join-Path $CsvConvertLogFolderPath $logFileName
    Write-Debug $CsvConvertLogFolderPath
    Write-Debug $logFilePath
    return $logFilePath
}
