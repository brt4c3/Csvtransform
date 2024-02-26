# 概要
Psql を使用したPowershellスクリプトの例をモジュールとして紹介しています。

//* MAP of this Project
- initiate.ps1
- main/
  - TableConfig.psd1
  - MyFunction.ps1
  - MyModule.psm1
  - CsvConvert.ps1
  - Psql-Query.ps1
  - SampleQuery.sql
  - input/
    - sample.csv
  - output/
    - output.csv
- log/
  - CsvConvertLogging.ps1
  - CsvConvertLogModule.psm1
*//

// Logic Flow //

// * STEP1 - PSQL connection ans SQL injection 
- Connect to PSQL 
- Select Table && get the Header order 
- WriteOut HeaderOrder to TableConfig
*//

// * STEP2 - CSV convert 
- read CSV from \input folder 
- sort with HeaderOrder from TableConfig
- output to \output folder 
- if Error write-out to 'yyyyMMdd_HHmmss'_main.log 
*//

// * STEP3 - Logging 
 
write-out to 'yyyyMMdd_HHmmss'_error.log
*//


# Docker Image Documentation
See here for PowerShell-Docker
https://github.com/PowerShell/PowerShell-Docker/tree/master
## Usage 
```
Usage: pwsh[.exe] [-Login] [[-File] <filePath> [args]]
                  [-Command { - | <script-block> [-args <arg-array>]
                                | <string> [<CommandParameters>] } ]
                   [-CommandWithArgs <string> [<CommandParameters>]
                   [-ConfigurationName <string>] [-ConfigurationFile <filePath>]
                   [-CustomPipeName <string>] [-EncodedCommand <Base64EncodedCommand>]
                   [-ExecutionPolicy <ExecutionPolicy>] [-InputFormat {Text | XML}]
                   [-Interactive] [-MTA] [-NoExit] [-NoLogo] [-NonInteractive] [-NoProfile]
                   [-NoProfileLoadTime] [-OutputFormat {Text | XML}] 
                   [-SettingsFile <filePath>] [-SSHServerMode] [-STA] 
                   [-Version] [-WindowStyle <style>] 
                   [-WorkingDirectory <directoryPath>]
 
        pwsh[.exe] -h | -Help | -? | /?
 
 PowerShell Online Help https://aka.ms/powershell-docs
```

# See here for PosgreSQL Docker Documentation
https://hub.docker.com/layers/library/postgres/14/images/sha256-54c27ef60bfde62c39a04974ed8c4ea6a4e1737217635d6471e54378e830b44f?context=explore
