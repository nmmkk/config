inst_type=github
user=stedolan
before_configure () {
  execute autoreconf -fi
}
bin_dep=(autoconf)
lib_dep=(oniguruma)
if [ -n "$ncurses_check" ];then
  configure_flags="--disable-maintainer-mode"
fi

# Substitute "jq-" from the version name
get_version
target_postfix="${version#jq-}"
