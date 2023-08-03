# LogModule.psm1

function Start-ErrorLogging {
    param (
        [string]$LogPath
    )

    $logFileName = (Get-Date).ToString("yyyyMMdd_HHmmss") + ".log"
    $logFilePath = Join-Path $LogPath $logFileName

    Start-Transcript -Path $logFilePath
}

function Stop-ErrorLogging {
    Stop-Transcript
}
