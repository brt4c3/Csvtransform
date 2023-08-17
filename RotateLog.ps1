# ログフォルダのパス
$logFolderPath = JOin-Path $PSScriptRoot "log"

# 保存期間（例: 7日以上前のファイルを削除）
$daysToKeep = 1

# 今日から指定した日数前の日付を計算
$deleteThresholdDate = (Get-Date).AddDays(-$daysToKeep)

# ログファイルの削除
Get-ChildItem -Path $logFolderPath -Filter "*.log" | ForEach-Object {
    $logFileName = $_.Name
    $logFileDate = [datetime]::ParseExact($logFileName.Substring(0, 10), "yyyyMMdd_HHmmss", $null)

    if ($logFileDate -lt $deleteThresholdDate) {
        Write-Host "Deleting old log file: $logFileName"
        Remove-Item $_.FullName
    }
}
