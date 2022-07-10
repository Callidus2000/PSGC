function Get-PSGCSumOfDigits {
    <#
    .SYNOPSIS
    Calculates the sum of digits of a given digit.

    .DESCRIPTION
    Calculates the sum of digits of a given digit.

    .PARAMETER Digit
    The input digit

    .PARAMETER ResultLength
    If set >0 the results will be summed up to this digit length.

    .EXAMPLE
    Get-PSGCSumOfDigits "9999999999999999999999999"

    Returns 225 ((25 * 9)= 225)

    .EXAMPLE
    Get-PSGCSumOfDigits "789" -ResultLength 2

    Returns 24 (7+8+9)

    .EXAMPLE
     Get-PSGCSumOfDigits "789" -ResultLength 1

     Returns 6 (7+8+9=24, 2+4=6)

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        $Digit,
        $ResultLength=0
    )
    Write-PSFMessage "calculate sum-of-digits from $Digit"
    $DigitString="$Digit"
    $sum=($DigitString -split '' | Measure-Object -sum).sum
    if ($ResultLength -gt 0 -and "$sum".Length -gt $ResultLength){
        $sum = Get-PSGCSumOfDigits $sum
    }
    Write-PSFMessage "Result=$sum"
    return $sum
}