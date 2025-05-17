#!/usr/bin/env bash

install_dir="/data/"
mod_dir="${install_dir}steamapps/workshop/content/107410"


# steamcmd start command args
a=1
modfile="/data/modlist.txt"
mod_cmd="" # stores command for mods
mods_loaded="false"
mod_prefix="-mod=\"$mod_dir/"
mod_param=""

#check if a user to run the server has been listed
if [ $arma_user != "" ]; then
    start_cmd_prefix="${install_dir}arma3server_x64 -name=$arma_user -config=server.cfg -world=empty"
else
    start_cmd_prefix="${install_dir}arma3server_x64 -config=server.cfg -world=empty"
fi
start_cmd_end="-noSound -netlog"

echo "|--- checking if $(pwd)/modlist.txt exists ---|"
if [ -f "modlist.txt" ]; then
    modfile_lines=`wc -l < $modfile`
    while [ $a -lt `expr $modfile_lines + 1` ]
    do
        current_line=`sed -n ${a}p $modfile`
        mod_param="$mod_cmd $mod_prefix$current_line\""
        mod_cmd=$mod_param
        a=`expr $a + 1`
    done
    mods_loaded="true"
else
    echo "|--- No modlist found, starting normally ---|"
fi


if [ $mods_loaded == "true" ]; then
    echo "|--- Starting Arma 3 server with mods enabled - $start_cmd_prefix$mod_cmd$start_cmd_end"
    $start_cmd_prefix$mod_cmd$start_cmd_end
else
    echo "|--- Starting Arma 3 server - $start_cmd_prefix$start_cmd_end"
    $start_cmd_prefix$start_cmd_end
fi
