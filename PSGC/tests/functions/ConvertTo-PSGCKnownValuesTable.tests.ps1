Describe  "ConvertTo-PSGCKnownValuesTable Tests" {
    Context "Simple ABCD 1234" {
        BeforeAll {
            # import-Module -force C:\DEVEL\Code\Github\PSGC\PSGC\PSGC.psd1
            $shouldBeValues = @{ a = "1"; b = "2"; c = "3"; d = "4" }
        }
        AfterAll {
        }
        It "Simple ABCD association" {
            $result = ConvertTo-PSGCKnownValuesTable -NumberString "1234" -Placeholder "abcd"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
        }
        It "Simple DCBA association" {
            $result = ConvertTo-PSGCKnownValuesTable -NumberString "4321" -Placeholder "DCBA"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
        }
        It "Whitespaces are ok" {
            $result = ConvertTo-PSGCKnownValuesTable -NumberString "12344" -Placeholder "abc d"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
        }
        It "More Placeholders will be ignored" {
            $result = ConvertTo-PSGCKnownValuesTable -NumberString "1234" -Placeholder "abcde"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
            $shouldBeValues.Keys | Should -HaveCount 4
        }
        It "More Numbers will be ignored" {
            $result = ConvertTo-PSGCKnownValuesTable -NumberString "1234567" -Placeholder "abcd"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
            $shouldBeValues.Keys | Should -HaveCount 4
        }
    }
    Context "More Complex" {
        BeforeAll {
            # import-Module -force C:\DEVEL\Code\Github\PSGC\PSGC\PSGC.psd1
        }
        AfterAll {
        }
        It "333,33333" {
            $shouldBeValues = @{ a = "3"; b = "3"; c = "3"; d = "3" }
            $result = ConvertTo-PSGCKnownValuesTable -NumberString (1000/3) -Placeholder "abc d"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
        }
        It "No placeholder" {
            $shouldBeValues = @{ a = "3"; b = "3"; c = "3"; d = "3" }
            $result = ConvertTo-PSGCKnownValuesTable -NumberString "3333"
            $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary]
            $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_ }
        }
    }
}