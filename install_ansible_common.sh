#!/bin/bash
set -e

# Always make sure the script runs from the directory this script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

# Link files in the current directory to the parent directory
#find  ./ -maxdepth 1 -type f ! -name '.*' -exec ln -frs {} ../{} \;
declare -a fileArray
while IFS= read -r -d $'\0' file; do
    fileArray+=("$file")
done < <(find ./ -maxdepth 1 -type f ! -name ".*" -print0)

for file in "${fileArray[@]}"; do
    if [ $(basename $file) == "README.md" ]; then
        continue
    else
        if [ ! -L ../$(basename $file) ]; then
            ln -frs ./$(basename $file) ../$(basename $file)
        fi
    fi
done

# Link directories in the current directory to the parent directory
directories=$(ls -d -- */)

# Remove trailing slash from directory names
directories=${directories%/}

for dir in $directories; do
    if [ ! -d ../$dir ]; then
        mkdir ../$dir
    fi
done

for dir in $directories; do
    contents=$(ls -A $dir)
    for content in $contents; do
        if [ ! -L ../$dir/$content ]; then
            ln -frs ./$dir/$content ../$dir/$content
        fi
    done
done

rm -f ../install_ansible_common.sh
