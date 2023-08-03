# main/MyModule.psm1

# Import the functions from MyFunction.ps1
. .\MyFunction.ps1

# Export the functions as a module
Export-ModuleMember -Function Export-CSVWithColumns
