#==============================================================================
# This recipe is based on expat.sh . It parses the website and determines the
# latest version.
#
# TODO: By parsing the website, the appropriate download URL of tarball can be
#        obtained. What is the right way to use the URL in stow-get, rather
#        than constructing the variable $version?
#==============================================================================
inst_type=tarball
get_latest () {
  local output_detail="${1:-0}"
  local zsh_download_url="http://zsh.sourceforge.net/Arc/source.html"
  # local params="$(get_page https://libexpat.github.io/|grep -v Changelog|grep "Changes" -B1|head -n2)"
  local params="$(get_page "${zsh_download_url}" | \
                  grep -v 'doc.tar.gz' | \
                  grep '>zsh-[[:digit:]].*.tar.gz<')"
  local tarfile_name="$(echo "$params" | tail -n1 | cut -d ">" -f2 | cut -d "<" -f1)"
  version="$(echo "${tarfile_name}" | cut -d "-" -f2 | sed 's/.tar.gz//')"
  if [ -z "$version" ];then
    err "Failed to get the latest version for $package."
    return $EXIT_NO_VERSION
  fi
  if [ "$output_detail" -eq 1 ];then
    local d="${params}"
    printf "%15s %8s %20s\n" "$package" "$version" "$d"
  fi
}
get_version
url_prefix=https://sourceforge.net/projects/zsh/files/zsh/$version
tarball=${package}-${version}.tar.gz
