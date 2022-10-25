#requires -version 7.0

# All internal commands
foreach ($File in (Get-ChildItem -path "$psscriptroot\private\" -Recurse -Filter *.ps1)){
    . $file.FullName
}


# All public commands
foreach ($File in (Get-ChildItem -path "$psscriptroot\public\" -Recurse -Filter *.ps1)){
    . $file.FullName
}

$PublishFunctions = (Get-ChildItem -path "$psscriptroot\public\" -Recurse -Filter *.ps1).BaseName
Export-ModuleMember -Function $PublishFunctions