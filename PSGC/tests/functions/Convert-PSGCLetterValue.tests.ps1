Describe  "Tests around Letter values" {
    BeforeAll {
        # import-Module -force C:\DEVEL\Code\Github\PSGC\PSGC\PSGC.psd1 
    }
    AfterAll {
    }
    It "Returns array of values"     {
        Convert-PSGCLetterValue "ABCz"|Should -Be (@(1..3)+26)
        Convert-PSGCLetterValue -Character @('a','b','c','z') |Should -Be (@(1..3)+26)
    }
    It "Returns array of single digit values"     {
        Convert-PSGCLetterValue "ABCz" -Operation singleDigit|Should -Be (@(1..3)+8)
    }
    It "Returns joined string"     {
        Convert-PSGCLetterValue "ABC" -Operation join -Verbose|Should -Be "123"
        Convert-PSGCLetterValue "ABCz" -Operation join -Verbose|Should -Be "12326"
        Convert-PSGCLetterValue "ABCz" -Operation singleDigit,join -Verbose | Should -Be "1238"
    }
    It "Use reverse letter order"     {
        Convert-PSGCLetterValue "zyx" -Operation join -PositionMatrix "zyxwvutsrqponmlkjihgfedcba" -Verbose | Should -Be "123"
    }
}