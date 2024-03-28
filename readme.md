explodeSxS
==========
A collection of scripts showcasing the process of staging Windows installation images using [SxSFounder](https://github.com/WitherOrNot/sxsfounder) and [CbsExploder](https://github.com/WitherOrNot/cbsexploder). Effectively, this project is a successor of [stageSxS](https://github.com/asdcorp/stageSxS).

Usage
-----
Run `cbss.cmd` to stage an image. Staged image can be captured into `install.wim` using `captureimg.cmd` script.

A fast disk (for example, RamDisk) mounted as `X:\`, which will be formatted during the operation, is required to use these scripts.

The process can be customized by modifying the scripts and a `skuassembly.txt` file found in the `files` directory.

In order to use these scripts, required packages and a language pack need to be sourced from UUP and extracted to the `sxs` directory. For the list, see example manifests included in the `sxs` directory and the scripts.

License
-------
The project is licensed under the terms of the GNU General Public License v3.0
