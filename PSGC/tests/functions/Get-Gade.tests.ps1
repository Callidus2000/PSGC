Describe  "Tests around Gade" {
    BeforeAll {
        # import-Module -force C:\DEVEL\Code\Github\PSGC\PSGC\PSGC.psd1
    }
    AfterAll {
    }
    It "Returns numberstring"     {
        Resolve-PSGCGade "DoSe" -Verbose -output "string" | Should -Be "114559023678"
    }
    It "Returns two strings as an array"     {
        Resolve-PSGCGade "DoSe" -Verbose -output "twoStrings" | Should -Be @("114559023678", "abcdefghijkl")
    }
    It "Returns formulaString"     {
        Resolve-PSGCGade "DoSe" -Verbose -output "formulaString" | Should -Be 'a=1,b=1,c=4,d=5,e=5,f=9,g=0,h=2,i=3,j=6,k=7,l=8'
    }
    It "Returns hashTable"     {
        $shouldBeValues = @{ a = "1"; b = "1"; c = "4"; d = "5"; e = "5"; f = "9"; g = "0"; h = "2"; i = "3"; j="6"; k="7";l="8" }
        $result=Resolve-PSGCGade "DoSe" -Verbose -output "hashtable"
        $result | Should -BeOfType [System.Collections.Specialized.OrderedDictionary] # 'a=1,b=1,c=4,d=5,e=5,f=9,g=0,h=2,i=3,j=6,k=7,l=8'
        $shouldBeValues.Keys | ForEach-Object { $result.$_ | Should -be $shouldBeValues.$_}
    }
    It "Returns numberstring from number-Input"     {
        Resolve-PSGCGade -Number "61796" -Verbose -output "string" | Should -Be "16679023458"
    }
}