<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPLv3 License][license-shield]][license-url]


<br />
<p align="center">
<!-- PROJECT LOGO
  <a href="https://github.com/Callidus2000/PSGC">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
-->

  <h3 align="center">PSGC Powershell Module</h3>

  <p align="center">
    This Powershell Module provides helper functions for solving Geocaches.
    <br />
    <a href="https://github.com/Callidus2000/PSGC"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Callidus2000/PSGC/issues">Report Bug</a>
    ·
    <a href="https://github.com/Callidus2000/PSGC/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
        <li><a href="#installation">Installation</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This Powershell Module provides helper functions for solving Geocaches. If you do not know what geocaching is about take a look at https://geocaching.com/.

Especially mystery caches often need complex calculations which can be done in Powershell very easy, but some kind of calculation can be hard to code. This is where the module can become quite handy.

### Built With

* [PSModuleDevelopment](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment)
* [psframework](https://github.com/PowershellFrameworkCollective/psframework)



<!-- GETTING STARTED -->
## Installation

The releases are published in the Powershell Gallery, therefor it is quite simple:
  ```powershell
  Install-Module PSGC -Force -AllowClobber
  ```
The `AllowClobber` option is currently neccessary because of an issue in the current PowerShellGet module. Hopefully it will not be needed in the future any more.
All prerequisites will be installed automatically.

<!-- USAGE EXAMPLES -->
## Usage
### Formula Evaluation
```Powershell
# function Resolve-PSGCFormula
# Takes a formula (e.g. for final coordinates) and a Hashtable of well known values and computes the formula.
$knownParameter = @{
            "a"=1
            "b"=5
            "c"=6
            "d"=5
            "e"=2
    }
Resolve-PSGCFormula "N54° 38.(a + c)(b - 3)(d -4)  E009° 57.(b - a)(e + c)(a + b)" $knownParameter

Returns "N54° 38.721  E009° 57.486"
```

### Convert Letters to their value (A=1,B=2,C=3,...)
```Powershell
Convert-PSGCLetterValue "ABCz"

# returns @(1,2,3,26)

Convert-PSGCLetterValue "ABCz" -Operation singleDigit

# returns @(1,2,3,8)

Convert-PSGCLetterValue "ABCz" -Operation join

# returns "12326"
```

### Calculate the sum of digits of a given digit
```Powershell
Get-PSGCSumOfDigit "9999999999999999999999999"
# Returns 225 ((25 * 9)= 225)

Get-PSGCSumOfDigit "789" -ResultLength 2
# Returns 24 (7+8+9)

Get-PSGCSumOfDigit "789" -ResultLength 1
#Returns 6 (7+8+9=24, 2+4=6)
```

### Gade
"Gade" is the person that made this clever system.

A Danish enthusiastic geocacher, which itself has its own radio show about geocaching every Monday night.

Gade found it an honor that a cache in Netherlands is made with his name.
If you have  translated  his name into English it  means Mr. Street.

To find the geocache, you have to find some numbers. E.g. you could have to
convert the letters from a word to their Values.
As an example "MyCache" would result in  the values 13, 25, 3, 1, 3, 8 and 5.
When you have found the numbers, do this:

Sort the **individual** digits - low to high.
If, for instance, the numbers you found were 13, 25, 3, 1, 3, 8 and 5 sort the digits like this: 112333558
Pay attention that digits may be contained more than once!
In the final result every digit from 1234567890 has to be included.
Theirfor complete the line, with the missing digits 112333558*04679* now you have:
11233355804679

Now take the letters from the alphabet and write them below:
11233355804679
abcdefghijklmn

That makes a=1,b=1,c=2,d=3,e=3,f=3,g=5,h=5,i=8,j=0,k=4,l=6,m=7,n=9

Nice and complex, right? And nasty if you want to try a few solution attempts for a mystery cache.

Use the module and it's easy:
```Powershell
Resolve-PSGCGade "MyCache" -Verbose -output formulaString

# Returns a=1,b=1,c=2,d=3,e=3,f=3,g=5,h=5,i=8,j=0,k=4,l=6,m=7,n=9
```

Combined with other functions it can be so easy:
```Powershell
$sumOfDigits=Convert-PSGCLetterValue -Word "sport" # =1916151820
$hash = Resolve-PSGCGade -Number "$sumOfDigits" #=a=0,b=1,c=1,d=1,e=1,f=2,g=5,h=6,i=8,j=9,k=3,l=4,m=7

Resolve-PSGCFormula -Formula 'N51° 29.e(j-g)b E10° 47.(f-d)k(i-h)' -KnownValues $hash
# N51° 29.141 E10° 47.132
```


<!-- ROADMAP -->
## Roadmap
New features will be added if any of my scripts need it ;-)

See the [open issues](https://github.com/Callidus2000/PSGC/issues) for a list of proposed features (and known issues).

If you need a special function feel free to contribute to the project.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. For more details please take a look at the [CONTRIBUTE](docs/CONTRIBUTING.md#Contributing-to-this-repository) document

Short stop:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- LICENSE -->
## License

Distributed under the GNU GENERAL PUBLIC LICENSE version 3. See `LICENSE.md` for more information.



<!-- CONTACT -->
## Contact


Project Link: [https://github.com/Callidus2000/PSGC](https://github.com/Callidus2000/PSGC)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Callidus2000/PSGC.svg?style=for-the-badge
[contributors-url]: https://github.com/Callidus2000/PSGC/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Callidus2000/PSGC.svg?style=for-the-badge
[forks-url]: https://github.com/Callidus2000/PSGC/network/members
[stars-shield]: https://img.shields.io/github/stars/Callidus2000/PSGC.svg?style=for-the-badge
[stars-url]: https://github.com/Callidus2000/PSGC/stargazers
[issues-shield]: https://img.shields.io/github/issues/Callidus2000/PSGC.svg?style=for-the-badge
[issues-url]: https://github.com/Callidus2000/PSGC/issues
[license-shield]: https://img.shields.io/github/license/Callidus2000/PSGC.svg?style=for-the-badge
[license-url]: https://github.com/Callidus2000/PSGC/blob/master/LICENSE

