# This file is to define functions okay to be public

function euc() { # 文字コードを euc-jp に変換 {{{1
    for i in "$@"; do
        nkf -e -Lu $i >! /tmp/euc.$$ # -Lu :改行を LF にする
        mv -f /tmp/euc.$$ $i
    done
} #}}}1

function sjis() { # 文字コードを shift-jis に変換 {{{1
    for i in "$@"; do
        nkf -s -Lw $i >! /tmp/sjis.$$ # -Lw :改行を CRLF にする
        mv -f /tmp/sjis.$$ $i
    done
} #}}}1

function utf8() { # 文字コードを utf8 に変換 {{{1
    for i in "$@"; do
        nkf -w -Lu $i >! /tmp/utf8.$$ # -Lu :改行を LF にする
        mv -f /tmp/utf8.$$ $i
    done
} #}}}1

function bak() {  # タイムスタンプやi-nodeを保持してバックアップ {{{1
    for f in "$@"; do
        mv $f $f.bak && cp $f.bak $f;
    done
} #}}}1

function bakd() {  # Make backup of files with holding timestamp and i-node {{{1
    local directory=${PWD}/.backup_files
    local timestamp=
    mkdir -p ${directory}
    for f in "$@"; do
        timestamp=$(/bin/ls --full-time ${f} | awk '{print $6"T"$7}')
        mv ${f} ${directory}/${f}.${timestamp} && cp -a ${directory}/${f}.${timestamp} ${f};
    done
} #}}}1

function make-cscope() {  # Generate cscope files {{{1
    find . \( -name .svn -o -name Build -o -name build -o -name Output \) -prune \
        -o \( -name '*.[csh]' -o -name 'Makefile.*' \
        -o -name 'GNUmakefile*' -o -name 'config.*' -o -name '*.js' \
        -o -name '*.asp' -o -name '*.java' -o -name '*.cpp' \) -type f \
        -print >! cscope.files
    cscope -bq
    ctags -R --exclude=Output
} #}}}1

function extract_rpm_scripts() { # {{{1
    local rpm_basename="${1##*/}"
    local rpm_dirname="${1%/*}"
    local extract_to_here="${HOME}/work/rpm-scripts/${rpm_basename}"

    if [ ! -e "${rpm_dirname}/${rpm_basename}" ]; then
        echo "ERROR: Given RPM file does not exist." 1>&2
        return 1
    fi
    if [ ! -f "${rpm_dirname}/${rpm_basename}" ]; then
        echo "ERROR: Given RPM name is not of a file." 1>&2
        return 2
    fi

    mkdir -p "${extract_to_here%/*}"
    rpm -qp --scripts "${rpm_dirname}/${rpm_basename}" > "${extract_to_here}"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed in rpm command: rpm -qp --scripts \"${rpm_dirname}/${rpm_basename}\"" 1>&2
        return 3
    fi

    echo "RPM scripts are just extracted to ${extract_to_here}"
} #}}}1

function extract_rpm_files() { # {{{1
    local rpm_basename="${1##*/}"
    local rpm_dirname="${1%/*}"
    local extract_to_here="${HOME}/work/rpm-files/${rpm_basename}"

    if [ ! -e "${rpm_dirname}/${rpm_basename}" ]; then
        echo "ERROR: Given RPM file does not exist." 1>&2
        return 1
    fi
    if [ ! -f "${rpm_dirname}/${rpm_basename}" ]; then
        echo "ERROR: Given RPM name is not of a file." 1>&2
        return 2
    fi

    mkdir -p "${extract_to_here}"
    cd "${extract_to_here}" || return $?
    rpm2cpio ${rpm_dirname}/${rpm_basename} | cpio -idmv
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed in rpm command: rpm2cpio \"${rpm_dirname}/${rpm_basename}\" | cpio -idmv" 1>&2
        return 3
    fi
    cd - >/dev/null

    echo "RPM files are just extracted to ${extract_to_here}"
} #}}}1

function is_os() { # {{{1
    local this="$1"
    local os=$(uname)

    case "${os}" in
        "${this}" )
            return 0
            ;;
        * )
            echo "You are not on ${this}" 1>&2
            return 1
            ;;
    esac
} #}}}1

function enable_linuxbrew() { # {{{1
    is_os "Linux" || return 0

    PATH=${LB_PATH}
    MANPATH=${LB_MANPATH}
    INFOPATH=${LB_INFOPATH}
    # PKG_CONFIG_PATH=${LB_PKG_CONFIG_PATH}
    XDG_DATA_DIRS=${LB_XDG_DATA_DIRS}
} #}}}1

function disable_linuxbrew() { # {{{1
    is_os "Linux" || return 0

    PATH=${ORIG_PATH}
    MANPATH=${ORIG_MANPATH}
    INFOPATH=${ORIG_INFOPATH}
    # PKG_CONFIG_PATH=${ORIG_PKG_CONFIG_PATH}
    XDG_DATA_DIRS=${ORIG_XDG_DATA_DIRS}
} #}}}1

# Source the file for local functions
if [ -f ~/.rcfiles/zsh/local_functions.zsh ]; then
    source ~/.rcfiles/zsh/local_functions.zsh
fi

# vim: foldmethod=marker
