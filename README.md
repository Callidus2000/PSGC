﻿<!--
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

