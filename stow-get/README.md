# Summary

This directory is to store files for `stow-get`.

* [GitHub - rcmdnk/stow-get: Package manager with stow.](https://github.com/rcmdnk/stow-get)
* [rcmdnk's blog -- stow-get: Stowを使ったパッケージマネージャー](https://rcmdnk.com/blog/2017/05/11/computer-linux-bash/)


# Config

The directory `conf/` is to store custom configuration files. The path is
defined in the stow-get dotfile as part of `conf_dir` list.


# Install

```
cd Downloads
curl -fSLOR https://raw.github.com/rcmdnk/stow-get/install/install.sh
prefix=${XDG_DATA_HOME}/stow-get/usr/local bash install.sh
```

