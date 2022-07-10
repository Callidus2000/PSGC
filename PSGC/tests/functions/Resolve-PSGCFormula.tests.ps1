Describe  "Tests around formula resolvement" {
    BeforeAll {
        $knownParameter = @{
                "a"=1
                "b"=5
                "c"=6
                "d"=5
                "e"=2
        }
    }
    AfterAll {
    }
    It "Coord-Formula"     {
        Resolve-PSGCFormula "N54° 38.(a + c)(b - 3)(d -4)  E009° 57.(b - a)(e + c)(a + b)" $knownParameter | Should -be "N54° 38.721  E009° 57.486"
    }
    It "Coord-Formula, wrong case sensitive"     {
        Resolve-PSGCFormula "N54° 38.(a + c)(b - 3)(d -4)  E009° 57.(b - a)(e + c)(a + b)" $knownParameter -CaseInSensitive | Should -be "N54° 38.721  2009° 57.486"
    }
    It "No known parameter" {
        $missing = @{}
        {Resolve-PSGCFormula "N54° 38.(a + c)(b - 3)(d -4)  E009° 57.(b - a)(e + c)(a + b)" $missing }        | Should -Throw
    }
}