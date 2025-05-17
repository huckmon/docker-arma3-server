#!/usr/bin/env bash

# This script updates the system and

arma_user="docker"
user="arma"

install_dir="/data/"
mod_dir="${install_dir}workshop/content/107410"


# steamcmd start command args
a=1
modlist=".${install_dir}modlist.txt"
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

if [ -r "${install_dir}modlist.txt" ]; then
    modlist_lines=`wc -l < $modlist`
    while [ $a -lt `expr $modlist_lines + 1` ]
    do
        current_line=`sed -n ${a}p $modlist`
        mod_param="$mod_param $mod_prefix$current_line\""
        a=`expr $a + 1`
    done
    mods_loaded="true"
fi


if [ $mods_loaded == "true" ]; then
    echo "|--- Starting Arma 3 server with mods enabled - .$start_cmd_prefix$mod_param$start_cmd_end"
    .$start_cmd_prefix$mod_param$start_cmd_end
else
    echo "|--- Starting Arma 3 server - .$start_cmd_prefix$start_cmd_end"
    .$start_cmd_prefix$start_cmd_end
fi
