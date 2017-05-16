#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
pushd $DIR

# files
files=()

# repos
declare -A repos=( )

# download files
for file in ${files[@]}; do
    if [[ ! -f $(basename $file) ]]; then
        wget $file
    fi
done

# download repos
for repo in "${!repos[@]}"; do
    if [[ ! -d "${repos["$repo"]}" ]]; then
       git clone --depth 1 "$repo" "${repos["$repo"]}"
    else
        pushd "${repos["$repo"]}"
        git pull --depth 1
        popd
    fi
done

popd
