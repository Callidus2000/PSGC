Describe  "Tests around Get-PSGCSumOfDigit" {
    BeforeAll {
        # import-Module -force C:\DEVEL\Code\Github\PSGC\PSGC\PSGC.psd1 
    }
    AfterAll {
    }
    It "Simple Sum"     {
        Get-PSGCSumOfDigit 123|Should -Be 6
        Get-PSGCSumOfDigit "123"|Should -Be 6
        Get-PSGCSumOfDigit "123567890"|Should -Be 41
    }
    It "SumUp to one digit"     {
        Get-PSGCSumOfDigit "123567890"|Should -Be 41
        Get-PSGCSumOfDigit "123567890" -ResultLength 3|Should -Be 41
        Get-PSGCSumOfDigit "123567890" -ResultLength 2|Should -Be 41
        Get-PSGCSumOfDigit "123567890" -ResultLength 1|Should -Be 5
    }
    It "SumUp to two digit"     {
        Get-PSGCSumOfDigit "9999999999999999999999999" -Verbose | Should -Be (25 * 9) #225
        Get-PSGCSumOfDigit "9999999999999999999999999" -ResultLength 2 -Verbose | Should -Be 9
        Get-PSGCSumOfDigit "99999999999999999999999999" -ResultLength 1 -Verbose | Should -Be 9
        Get-PSGCSumOfDigit "789" -ResultLength 2 -Verbose | Should -Be 24
        Get-PSGCSumOfDigit "789" -ResultLength 1 -Verbose | Should -Be 6
    }
}