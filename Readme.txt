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


editting