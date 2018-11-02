inst_type=github
user=stedolan
before_configure () {
  execute autoreconf -fi
}
bin_dep=(autoconf)
lib_dep=(oniguruma)
configure_options="--with-oniguruma=${inst_dir}"
if [ -n "$ncurses_check" ];then
  configure_options="${configure_options} --disable-maintainer-mode"
fi

# Substitute "jq-" from the version name
get_version
version="${version#jq-}"
