#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for gitconfig.
GH_REPO="https://github.com/0ghny/gitconfig"
TOOL_NAME="gitconfig"
TOOL_TEST="gitconfig --help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if gitconfig is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # TODO: Adapt this. By default we simply list the tag names from GitHub releases.
  # Change this function if gitconfig has other means of determining installable versions.
  list_github_tags
}

download_release() {
  local version filename url
  local -r platform="$(get_platform)"
  local -r arch="$(get_arch)"
  version="$1"
  filename="$2"

  # TODO: Adapt the release URL convention for gitconfig
  url="$GH_REPO/releases/download/v${version}/${TOOL_NAME}_${version}_${platform}_${arch}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version ${platform}/${arch}..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    echo "Installing from $ASDF_DOWNLOAD_PATH to $install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"
    test -x "$install_path/$TOOL_NAME" || fail "Expected $install_path/$TOOL_NAME binary not found."
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}


# Credits: https://github.com/asdf-community/asdf-hashicorp/blob/bc4dec6e99c501d126bf2f699190e4a0c9a10b3e/bin/install#L106
# LICENSE: MIT (https://github.com/asdf-community/asdf-hashicorp/blob/bc4dec6e99c501d126bf2f699190e4a0c9a10b3e/LICENSE#L1)
get_platform() {
  local -r kernel="$(uname -s)"
  if [[ ${OSTYPE} == "msys" || ${kernel} == "CYGWIN"* || ${kernel} == "MINGW"* ]]; then
    echo windows
  else
    uname | tr '[:upper:]' '[:lower:]'
  fi
}

get_arch() {
  local -r machine="$(uname -m)"
  local -r tool_specific_arch_override="ASDF_gitconfig_OVERWRITE_ARCH"

  OVERWRITE_ARCH=${!tool_specific_arch_override:-${ASDF_gitconfig_OVERWRITE_ARCH:-"false"}}

  if [[ ${OVERWRITE_ARCH} != "false" ]]; then
    echo "${OVERWRITE_ARCH}"
  elif [[ ${machine} == "arm64" ]] || [[ ${machine} == "aarch64" ]]; then
    echo "arm64"
  elif [[ ${machine} == *"arm"* ]] || [[ ${machine} == *"aarch"* ]]; then
    echo "arm"
  elif [[ ${machine} == *"386"* ]]; then
    echo "386"
  else
    echo "amd64"
  fi
}
