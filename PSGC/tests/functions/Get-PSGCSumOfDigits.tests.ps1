Describe  "Tests around Get-PSGCSumOfDigits" {
    BeforeAll {
        # import-Module -force C:\DEVEL\Code\Github\PSGC\PSGC\PSGC.psd1 
    }
    AfterAll {
    }
    It "Simple Sum"     {
        Get-PSGCSumOfDigits 123|Should -Be 6
        Get-PSGCSumOfDigits "123"|Should -Be 6
        Get-PSGCSumOfDigits "123567890"|Should -Be 41
    }
    It "SumUp to one digit"     {
        Get-PSGCSumOfDigits "123567890"|Should -Be 41
        Get-PSGCSumOfDigits "123567890" -ResultLength 3|Should -Be 41
        Get-PSGCSumOfDigits "123567890" -ResultLength 2|Should -Be 41
        Get-PSGCSumOfDigits "123567890" -ResultLength 1|Should -Be 5
    }
    It "SumUp to two digit"     {
        Get-PSGCSumOfDigits "9999999999999999999999999" -Verbose | Should -Be (25 * 9) #225
        Get-PSGCSumOfDigits "9999999999999999999999999" -ResultLength 2 -Verbose | Should -Be 9
        Get-PSGCSumOfDigits "99999999999999999999999999" -ResultLength 1 -Verbose | Should -Be 9
        Get-PSGCSumOfDigits "789" -ResultLength 2 -Verbose | Should -Be 24
        Get-PSGCSumOfDigits "789" -ResultLength 1 -Verbose | Should -Be 6
    }
}