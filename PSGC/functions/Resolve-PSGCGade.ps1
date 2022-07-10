function Resolve-PSGCGade {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Word
    Parameter description

    .EXAMPLE
    An example

    has to be provided

    .NOTES
    General notes
    #>
    param (
        $Word
    )
    $wort = $Word.ToLower()
    $einzelABCWerte = [int[]][char[]]$wort | ForEach-Object { $_ - 96 } | Where-Object { $_ -ge 0 }
    Write-PSFMessage "Buchstaben-Werte: $($einzelABCWerte -join ' ')"
    $einzelZahlenSortiert = ($einzelABCWerte -join '') -split '' | Sort-Object | Where-Object { $_ -ge 0 }
    Write-PSFMessage "Enthaltene Zahlen: $($einzelZahlenSortiert -join '')"
    for ($index = 0; $index -lt 10; $index++) {
        if (!($einzelZahlenSortiert -contains $iindex)) {
            $einzelZahlenSortiert += $index
            Write-PSFMessage "Füge hinzu: $index"
        }
    }
    Write-PSFMessage "$($einzelZahlenSortiert -join '')"
    Write-PSFMessage "abcdefghijkl"
    for ($index = 0; $index -lt $einzelZahlenSortiert.count; $index++) {
        # Write-PSFMessage "$([char]($index + 97))=$($einzelZahlenSortiert[$index])"
        Set-Variable -Name "$([char]($index + 97))" -Value ([int]($einzelZahlenSortiert[$index])) -Scope Global
        # $hash.add("$([char]($i + 97))", "$($einzelZahlenSortiert[$i])")
    }
}