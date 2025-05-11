#!/usr/bin/env bash

user="arma"
steam_user=""

install_dir="/data/"
modlist="./data/modlist.txt"
mod_dir="${install_dir}steamapps/workshop/content/107410"

install_cmd=" +force_install_dir ${install_dir} +login ${steam_user} +app_update 233780"

a=1
modlist=".${install_dir}modlist.txt"
mod_cmd="" # stores command for mods
mods_loaded="false"
mod_prefix="+workshop_download_item 107410 "


if [ -r "${install_dir}modlist.txt" ]; then
    modlist_lines=`wc -l < $modlist`
    while [ $a -lt `expr $modlist_lines + 1` ]
    do
        current_line=`sed -n ${a}p $modlist`
        mod_param="$mod_cmd $mod_prefix$current_line"
        a=`expr $a + 1`
    done
    mods_loaded="true"
fi


if [ $mods_loaded == "true" ]; then
    echo "|--- Installing server and mods - steamcmd $install_cmd$mod_cmd +quit"
    steamcmd $install_cmd$mod_cmd +quit
else
    echo "|--- Installing server - steamcmd $install_cmd +quit"
    steamcmd $install_cmd +quit
fi
