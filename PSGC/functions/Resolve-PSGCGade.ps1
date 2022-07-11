function Resolve-PSGCGade {
    <#
    .SYNOPSIS
    This converts a given word to a Gade.

    .DESCRIPTION
    This converts a given word to a Gade. For further explaination use
    Get-Help about_PSGCGade

    .PARAMETER Word
    The word which should be converted.
    E.g. 'DOSE' would result in
    1 1 4 5 5 9 0 2 3 6 7 8
    A B C D E F G H I J K L

    .PARAMETER Number
    If you've already got a number instead of a word you can pass it directly.

    .PARAMETER Output
    What kind of output should be created?
    hashtable - The default, returns {"a":"1","b":"1","c":"4","d":"5","e":"5","f":"9","g":"0","h":"2","i":"3","j":"6","k":"7","l":"8"}
    twoStrings - @("114559023678", "abcdefghijkl")
    formulaString - 'a=1,b=1,c=4,d=5,e=5,f=9,g=0,h=2,i=3,j=6,k=7,l=8'
    string - "114559023678"

    .EXAMPLE
    Resolve-PSGCGade "DoSe" -output "string"

    Returns "114559023678"

    .NOTES
    General notes
    #>
    param (
        [Parameter(Mandatory = $true, Position = 1,ParameterSetName="word")]
        $Word,
        [Parameter(Mandatory = $true,ParameterSetName="number")]
        $Number,
        [validateset('hashtable', 'twoStrings', 'formulaString', 'string')]
        [string]$Output = 'hashtable'
    )
    if($Word){
        Write-PSFMessage "Converting the letters of $Word to their values"
        $einzelABCWerte = Convert-PSGCLetterValue $Word
    }else{
        $einzelABCWerte = "$Number" -split ''
    }
    Write-PSFMessage "Buchstaben-Werte für $($Word): $($einzelABCWerte -join ' ')"
    $einzelZahlenSortiert = ($einzelABCWerte -join '') -split '' | Sort-Object | Where-Object { $_ -ge 0 }
    Write-PSFMessage "Enthaltene Zahlen: $($einzelZahlenSortiert -join '')"
    for ($index = 0; $index -lt 10; $index++) {
        if (!($einzelZahlenSortiert -contains $index)) {
            $einzelZahlenSortiert += $index
            Write-PSFMessage "Füge hinzu: $index"
        }
    }
    $stringOfDigits = $einzelZahlenSortiert -join ''
    $mappingLetters = (97..(96 + $stringOfDigits.Length)) | foreach-object { [char]$_ } | Join-String ''
    switch ($Output) {
        "string" { return $($einzelZahlenSortiert -join '') }
        "twoStrings" { return $($stringOfDigits, $mappingLetters) }
        "formulaString"{
            $resultArray=@()
            for ($i = 0; $i -lt $stringOfDigits.Length; $i++) {
                $resultArray += "$($mappingLetters[$i])=$($stringOfDigits[$i])"
            }
            return $resultArray-join ','
        }
        "hashtable" {
            Write-PSFMessage "Create hashtable"
            $resultHash=[ordered]@{}
            for ($i = 0; $i -lt $stringOfDigits.Length; $i++) {
                $resultHash."$($mappingLetters[$i])"="$($stringOfDigits[$i])"
            }
            Write-PSFMessage "result=$($resultHash|ConvertTo-Json -Compress)"
            return $resultHash
        }
        Default {}
    }
    Write-PSFMessage "$($einzelZahlenSortiert -join '')"
    Write-PSFMessage "abcdefghijkl"
    for ($index = 0; $index -lt $einzelZahlenSortiert.count; $index++) {
        # Write-PSFMessage "$([char]($index + 97))=$($einzelZahlenSortiert[$index])"
        Set-Variable -Name "$([char]($index + 97))" -Value ([int]($einzelZahlenSortiert[$index])) -Scope Global
        # $hash.add("$([char]($i + 97))", "$($einzelZahlenSortiert[$i])")
    }
}