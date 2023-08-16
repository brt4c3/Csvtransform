# main/CsvConvertModule.psm1
function Export-CSVWithColumns {
    param (
        [string]$InputFilePath,
        [string]$OutputFilePath,
        [string]$TableConfigFilePath,
        [string]$logFilePath,
        [string]$MainFolderPath
    )

    # Load the configuration from the .psd1 file using Import-PowerShellDataFile
    try {
        $config = Import-PowerShellDataFile -Path $TableConfigFilePath
        $columns = $config.Columns -split ','
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Succesfully Load the configuration from the .psd1 file using Import-PowerShellDataFile" | Out-File -Append  -FilePath $logFilePath
    } catch {
        $errorMessage = "Error: Unable to load configuration from $TableConfigFilePath. Make sure the file is properly formatted."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append -FilePath $logFilePath
        return
    }

    # Read the CSV file from input folder
    try {
        $data = Import-Csv -Path $InputFilePath
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Succesfully Read the CSV file from input folder" | Out-File -Append  -FilePath $logFilePath
    } catch {
        $errorMessage = "Error: Unable to read CSV file from $InputFilePath. Make sure the file exists and has valid data."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append  -FilePath $logFilePath
        $CHK_FLG = 1
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Abbend due to missing csv file : ErrorCode: $CHK_FLG" | Out-File -Append  -FilePath $logFilePath
    }

    # Check if the CSV file is missing the delimiter
    if ($null -eq $data) {
        $errorMessage = "Error: The CSV file '$InputFilePath' is missing the delimiter."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append  -FilePath $logFilePath
        return
    }
    else{
        $CHK_FLG =0
    }

    # Select the specified columns from the data
    $selectedData = $data | Select-Object $columns

    # Export the selected data to a new CSV file
    try {
        $selectedData | Export-Csv -Path $OutputFilePath -NoTypeInformation
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): Succesfully Export the selected data to a new CSV file" | Out-File -Append  -FilePath $logFilePath
    } catch {
        $errorMessage = "Error: Unable to export the data to $OutputFilePath. Please check the file path and permissions."
        Write-Host $errorMessage
        Write-Output "$(Get-Date -Format "yyyy/MM/dd/HH:mm:ss"): $errorMessage" | Out-File -Append  -FilePath $logFilePath
    }
}


