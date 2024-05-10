#!/bin/bash
set -e

# Always make sure the script runs from the directory this script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

# Copy files and folders to the parent directory
find  ./ -maxdepth 1 -type f ! -name '.*' -exec ln -frs {} ../{} \;

directories=$(ls -d -- */)

# Remove trailing slash from directory names
directories=${directories%/}

for dir in $directories; do
    if [ -d ../$dir ]; then
        ln -frs ./$dir/* ../$dir/
    else
        mkdir ../$dir
        ln -frs ./$dir/* ../$dir/
    fi
done

rm -f ../install_ansible_common.sh