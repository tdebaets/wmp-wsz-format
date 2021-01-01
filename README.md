Windows Media Player WSZ skin format
====================================

Windows Media Player's appearance can be customized using skins. These skins must be defined in an XML-based format with its own set of element tags and attributes. Such 'skin definition files' have a `.wms` file extension and their format is [documented at MSDN](https://msdn.microsoft.com/en-us/library/windows/desktop/dd564354(v=vs.85).aspx).

But Windows Media Player also uses the same skin technology for its own standard interface, for example for the Library and Now Playing mode. If you open the `wmploc.dll` file in a PE resource viewer, you will indeed see several resources that correspond to internal skins, like `MAINAPPSKIN2.WSZ` and `NOWPLAYING.WSZ`. Note how they all end with `.WSZ`.

Unlike the XML-based WMS skin format, the internal WSZ skin format is binary and completely undocumented. The purpose of this project is to reverse engineer the WSZ format. Another purpose is to provide a program that can eventually convert a WSZ-format skin into its human-readable WMS version, and perhaps also even convert it back to WSZ.

For a (non-formal) description of the binary WSZ format, see [`wsz-format.md`](wsz-format.md)

For the Delphi source code of the WSZ skin converter, see the [`Source`](Source) directory. Note that this only contains the front-end code of the converter. The code that is specific to the WSZ format itself can be found in the [`WMPWSZFormat.pas`](https://github.com/tdebaets/common/blob/master/Delphi/LibUser/WMPWSZFormat.pas) file in the `common` repository.

Obtaining the source code
-------------------------

First make sure that you have a recent version of the [Git client](https://git-scm.com/) (`git`) installed. Then open a Windows command prompt window (note that Git Bash isn't supported). In the command prompt, run these commands:
```
> git clone https://github.com/tdebaets/wmp-wsz-format.git wmp-wsz-format
> cd wmp-wsz-format
```

Finally, run the `postclone.bat` script. This will take care of further setting up the repository, installing Git hooks, creating output directories etc.:
```
> postclone.bat
```

To keep your repository up-to-date, run the `update.bat` script. This script essentially runs a `git pull` but also performs some basic checks before pulling. It also runs a `git submodule update` after the pull to update the `common` submodule as well.

If you want to contribute to this project, don't clone its main repository, but create your own fork first and clone that fork instead. Then commit/push your work on a topic branch and submit a pull request. For details, see the [generic instructions for contributing to projects](https://github.com/tdebaets/common/blob/master/CONTRIBUTING.md) in the `common` repository.

Building
--------

The WSZ skin converter has been written in Borland Delphi 4. This means that in order to build this project, you'll need to have Borland Delphi 4 installed and properly set up. See the [generic instructions for building Delphi projects](https://github.com/tdebaets/common/blob/master/Delphi/Building.md) in the `common` repository.

License
-------

WMP WSZ Format is Copyright © 2017-2020 Tim De Baets. It is licensed under the Apache License version 2.0, see [LICENSE](LICENSE) for details.
