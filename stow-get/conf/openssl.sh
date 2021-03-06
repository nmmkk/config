inst_type=github
#version_safe=1_0_2l
version_safe=1_1_0f
openssl_version=${openssl_version:-1_1}
configure_file="./config"
configure_opstions="--openssldir="$stow_dir/$target/ssl

get_latest () {
  echo "*** This is a locally hacked version of openssl.sh ***"
  local output_detail="${1:-0}"
  local url="https://github.com/openssl/openssl/releases"
  local html="$(get_page "$url")"
  # The following does not work anymore since Aug. 2018.
  # No match is found with "grep tag-name".
  # version=$(echo "$html"|grep tag-name|grep "OpenSSL_${openssl_version}"|head -n1|cut -d ">" -f2 |cut -d"<" -f1|sed 's/OpenSSL_//')
  version=$(echo "$html"|grep "/releases/tag/"|grep "OpenSSL_${openssl_version}"|head -n1|cut -d "=" -f2|cut -d'"' -f2|sed 's/.*OpenSSL_//')
  echo "DEBUG: version=<${version}>"
  if [ -z "$version" ];then
    err "Failed to get the latest version for $package."
    return $EXIT_NO_VERSION
  fi
  if [ "$output_detail" -eq 1 ];then
    printf "%15s %8s\n" "$package" "$version"
  fi
}
get_version
directory=openssl-OpenSSL_${version}
tarball=OpenSSL_${version}.tar.gz
