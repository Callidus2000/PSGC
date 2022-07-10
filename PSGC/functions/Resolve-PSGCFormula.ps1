function Resolve-PSGCFormula {
    <#
    .SYNOPSIS
    Takes a formula (e.g. for final coordinates) and a Hashtable of well known values and computes the formula.
    
    .DESCRIPTION
    Takes a formula (e.g. for final coordinates) and a Hashtable of well known values and computes the formula.
    Attention! The keys from the KnownValues will be searched CaseSensitive by default
    
    .PARAMETER Formula
    The Formula like "N54° 38.(a + c)(b - 3)(d -4)  E009° 57.(b - a)(e - c)(a + b)"
    
    .PARAMETER KnownValues
    A HashTable with the known values.

    .PARAMETER CaseInSensitive
    If not used the keys from the hashtable will be searched in the formula case insensitive.
    
    .EXAMPLE
    $knownParameter = @{
                "a"=1
                "b"=5
                "c"=6
                "d"=5
                "e"=2
        }
    Resolve-PSGCFormula "N54° 38.(a + c)(b - 3)(d -4)  E009° 57.(b - a)(e + c)(a + b)" $knownParameter
    
    Returns "N54° 38.721  E009° 57.486"

    
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '')]
    param (
        [Parameter(Mandatory=$true,Position=1)]
        [string]$Formula,
        [Parameter(Mandatory=$true,Position=2)]
        [hashtable]$KnownValues,
        [switch]$CaseInSensitive
    )
    Write-PSFMessage "Formula=$Formula"
    Write-PSFMessage "`$KnownValues=$($KnownValues|ConvertTo-Json)"
    $newFormula = $Formula -replace '\(','$('
    foreach ($key in $KnownValues.Keys){
        if ($CaseInSensitive){
            $newFormula = $newFormula -replace $key, "`$(þ.$key)"
        }else{
            $newFormula = $newFormula -creplace $key, "`$(þ.$key)"
        }
    }
    $newFormula = $newFormula -creplace 'þ', "`$KnownValues"
    Write-PSFMessage "`$newFormula=$newFormula"
    try {
        $result = Invoke-Expression "`"$newFormula`""
        Write-PSFMessage "Ergebnis der Formel $Formula=$result"
        return $result
    }
    catch {
        throw  $_
    }
}