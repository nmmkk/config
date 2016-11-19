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

# Source the file for local functions
source ~/.rcfiles/zsh/local_functions.zsh

# vim: foldmethod=marker
