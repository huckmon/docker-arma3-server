#!/usr/bin/env bash

install_dir="/data/"
mod_dir="${install_dir}steamapps/workshop/content/107410"

echo "|--- Renamaing mod files located at ${mod_dir} ---|"
#This script renames all workshop files to prevent issues from capitals in mod file names like CUP
find $mod_dir -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
echo "|--- Finished renamaing mod files ---|"

exec su arma --command="/start_server.sh"
