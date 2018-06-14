inst_type=tarball
package=ts
version=1.0
tarball=${package}-${version}.tar.gz
url_prefix=http://vicerveza.homeunix.net/~viric/soft/ts/

# As task-spooler does not have configure script, prefix needs to be given to
# Maekfile as a parameter.
target="${package}-STOW-${version}"
my_prefix="${stow_dir}/${target}"

before_configure() {
    # As the name manual "ts.1" conflicts with the same name of item in openssl, we
    # rename it by tweaking the Makefile.
    mv ts.1 tsp.1
    # Also rename the command name from "ts" to "tsp".
    # First, make a backup
    cp -av Makefile Makefile-original
    # To make the renaming work easier, temporary rename "tsretry"
    sed -i.bak 's/tsretry/TMPTSRETRY/g' Makefile
    # Now all strings "ts" can be renamed to "tsp"
    sed -i.bak 's/ts/tsp/g' Makefile
    # Finally restore the name "tsretry"
    sed -i.bak 's/TMPTSRETRY/tsretry/g' Makefile
}

configure_cmd() {
    :
}

make_cmd () {
    execute make
    execute make install PREFIX="${my_prefix}"
}

# To suppress the following installation error, define the variable "ret" with 0.
# It seems stow-get needs a fix in mylog() sub-routine; as the given command is
# executed in a sub-shell by '()', the variable $ret" is never set by the
# command.
#
# The error message during installation is:
# ```
# $ stow-get install task-spooler
# ################################################################################
# # Installing /home/chiyoda/.local/share/stow-get/usr/local/stow/ts-STOW-1.0
# ################################################################################
# /path/to/stow-get: line 1012: [: -eq: unary operator expected
# /path/to/stow-get: line 1021: [: -ne: unary operator expected
# ```
#
# Line 1011-1027 is excerpted as below:
# ```
#   mylog stow_install_wrapper
#   if [ $ret -eq 0 ];then
#     mylog echo "# stow installation"
#     mylog add_package
#     ret=$?
#   fi
#   if [ $dryrun -eq 1 ];then
#     echo -e "$log"
#   fi
#
#   if [ $ret -ne 0 ];then
#     if [ "$verbose" -eq 0 ];then
#       echo -e "$log"
#     fi
#     err "Failed to install $package"
#     exit $ret
#   fi
# ```
#
# And mylog() is defined as below.
# ```
# mylog () {
#   if [ "$verbose" -eq 1 ];then
#     "$@"
#   else
#     log="${log}$("$@" 2>&1)\\n"
#   fi
# }
# ```
ret=0
