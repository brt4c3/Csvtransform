# main/CsvConvertModule.psm1
function Export-CSVWithColumns {
    param (
        [string]$InputFilePath,
        [string]$OutputFilePath,
        [string]$TableConfigFilePath,
        [string]$logFilePath,
        [string]$CsvConvertFolderPath
    )

    # Load the configuration from the .psd1 file using Import-PowerShellDataFile
    try {
        $config = Import-PowerShellDataFile -Path $TableConfigFilePath
        $columns = $config.Columns -split ','
    } catch {
        $errorMessage = "Error: Unable to load configuration from $TableConfigFilePath. Make sure the file is properly formatted."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append -Encoding UTF8 -FilePath $logFilePath
        return
    }

    # Read the CSV file from input folder
    try {
        $data = Import-Csv -Path $InputFilePath
    } catch {
        $errorMessage = "Error: Unable to read CSV file from $InputFilePath. Make sure the file exists and has valid data."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append -Encoding UTF8 -FilePath $logFilePath
        $CHK_FLG = 1
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): 中断処理フラグ：$CHK_FLG" | Out-File -Append -Encoding UTF8 -FilePath $logFilePath
        return $CHK_FLG
    }

    # Check if the CSV file is missing the delimiter
    if ($null -eq $data) {
        $errorMessage = "Error: The CSV file '$InputFilePath' is missing the delimiter."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append  -Encoding UTF8 -FilePath $logFilePath
        return
    }
    else{
        $CHK_FLG =0
        return $CHK_FLG
    }

    # Select the specified columns from the data
    $selectedData = $data | Select-Object $columns

    # Export the selected data to a new CSV file
    try {
        $selectedData | Export-Csv -Path $OutputFilePath -NoTypeInformation
    } catch {
        $errorMessage = "Error: Unable to export the data to $OutputFilePath. Please check the file path and permissions."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append  -Encoding UTF8 -FilePath $logFilePath
    }
}


