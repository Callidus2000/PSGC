function Convert-PSGCLetterValue {
    <#
    .SYNOPSIS
    Converts the letters of a string/character array to the ABC value representive.

    .DESCRIPTION
    Converts the letters of a string/character array to the ABC value representive.
    A=1
    B=2
    C=3
    ...

    .PARAMETER Word
    The input string

    .PARAMETER Character
    The input string as array of characters

    .PARAMETER Operation
    Additional operations which should be performed.
    singleDigit - E.g. Z=26 => 2+6= 8
    sum - ABC > 123 > 6
    join - joins the values to a string

    .PARAMETER PositionMatrix
    String with representatives of each letter, position-index will be used as letter-value.
    Defaults to "abcdefghijklmnopqrstuvwxyz", for reverse use
    "zyxwvutsrqponmlkjihgfedcba"

    .EXAMPLE
     Convert-PSGCLetterValue "ABCz"

     returns @(1,2,3,26)

    .EXAMPLE
     Convert-PSGCLetterValue "ABCz" -Operation singleDigit

     returns @(1,2,3,8)

    .EXAMPLE
     Convert-PSGCLetterValue "ABCz" -Operation join

     returns "12326"

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = "string")]
        [string]$Word,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = "charArray")]
        [char[]]$Character,
        [validateset('none', 'singleDigit', 'sum', 'join')]
        [string[]]$Operation = 'none',
        [string]$PositionMatrix = "abcdefghijklmnopqrstuvwxyz"
    )
    if ($Character) {
        Write-PSFMessage "Combining Characters to string to lowerCase them"
        $Word = $Character -join ''
    }
    $Word = $Word.ToLower()
    $PositionMatrix = $PositionMatrix.ToLower()
    $currentValue = [char[]]$Word  | ForEach-Object { $PositionMatrix.IndexOf($_) + 1 } | Where-Object { $_ -ge 0 }
    foreach ($op in $Operation) {
        Write-PSFMessage "Operation: $op, Input= $currentValue"
        switch ($op) {
            'join' { $currentValue = $currentValue -join '' }
            'singleDigit' {
                $currentValue = $currentValue  | ForEach-Object { Get-PSGCSumOfDigit $_ -ResultLength 1 }
            }
            'sum' { $currentValue= ($currentValue | Measure-Object -Sum).Sum }
            'toString' { $currentValue = $currentValue | Out-String }
        }
        Write-PSFMessage     "Operation: $op, Output= $currentValue"
    }
    return $currentValue
}