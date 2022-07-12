function ConvertTo-PSGCKnownValuesTable {
    <#
    .SYNOPSIS
    Function to create a hashtable from value/variable strings.

    .DESCRIPTION
    Function to create a hashtable from value/variable strings.

    .PARAMETER NumberString
    The string containing the numbers

    .PARAMETER PlaceHolder
    The placeholders the numbers should be associated within the hashtable

    .EXAMPLE
    ConvertTo-PSGCKnownValuesTable -NumberString "1234" -Placeholder "abcd"

    Returns @{ a = "1"; b = "2"; c = "3"; d = "4" }
    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "numberString")]
        [Parameter(Mandatory = $true, ParameterSetName = "numberStringOnly")]
        [string]$NumberString,
        [Parameter(Mandatory = $true, ParameterSetName = "numberString")]
        [string]$PlaceHolder
    )
    Write-PSFMessage "Create hashtable"
    if ([string]::IsNullOrEmpty($PlaceHolder)) {
        $PlaceHolder = "abcdefghijklmnopqrstuvwxyz"
        Write-PSFMessage -Level Warning "No -PlaceHolder given, assuming '$PlaceHolder'"
    }
    $PlaceHolder = $PlaceHolder.ToLower()
    $resultHash = [ordered]@{}
    for ($i = 0; $i -lt $PlaceHolder.Length -and $i -lt $NumberString.Length; $i++) {
        # Query current letter
        $key = $PlaceHolder[$i]
        # Check if it's a letter from a-z, otherwise continue in the loop
        if ($key -notmatch '[a-z]') { continue }
        $resultHash."$key" = "$($NumberString[$i])"
    }
    Write-PSFMessage "result=$($resultHash|ConvertTo-Json -Compress)"
    $resultHash
}