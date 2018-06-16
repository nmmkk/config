# Neovim conflicts with bash and emacs regarding some files.
# If those are installed, stow reports an error.
#==============================================================================
# $ stow --defer=share/info/dir --ignore=.travis.yml neovim-STOW-0.3.0
# WARNING! stowing neovim-STOW-0.3.0 would cause conflicts:
#   * existing target is stowed to a different package: share/applications/nvim.desktop => ../../stow/emacs-STOW-26.1/share/applications/nvim.desktop
#   * existing target is stowed to a different package: share/locale/af/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/af/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/cs/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/cs/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/eo/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/eo/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/fi/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/fi/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/ga/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/ga/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/ja/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/ja/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/nl/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/nl/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/sk/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/sk/LC_MESSAGES/nvim.mo
#   * existing target is stowed to a different package: share/locale/uk/LC_MESSAGES/nvim.mo => ../../../../stow/bash-STOW-5.0-alpha/share/locale/uk/LC_MESSAGES/nvim.mo
#==============================================================================

inst_type=github
get_version
url_prefix=https://github.com/neovim/neovim/archive
tarball=v${version}.tar.gz

make_cmd() {
    execute make \
        CMAKE_BUILD_TYPE=RelWithDebInfo \
        CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$stow_dir/$target"
    execute make install
}

cat <<__EOT__

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
package=${package}
version=${version}
directory=${directory}
tarball=${tarball}
stow_dir=$stow_dir
target=$target
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

__EOT__
