#!/usr/bin/env bash

install_dir="/data/"
mod_dir="${install_dir}steamapps/workshop/content/107410"

install_cmd=" +force_install_dir ${install_dir} +login $steam_user +app_update 233780"

a=1
modfile="/data/modlist.txt"
mod_cmd="" # stores command for mods
mods_loaded="false"
mod_prefix="+workshop_download_item 107410 "


echo "|--- checking if $(pwd)/modfile.txt exists ---|"

if [ -f "modlist.txt" ]; then
    modfile_lines=`wc -l < $modfile`
    while [ $a -lt `expr $modfile_lines + 1` ]
    do
        current_line=`sed -n ${a}p $modfile`
        mod_param="$mod_cmd $mod_prefix$current_line"
        mod_cmd=$mod_param
        a=`expr $a + 1`
    done
    mods_loaded="true"
else
    echo "|--- No modlist found, installing normally ---|"
fi

if [ $mods_loaded == "true" ]; then
    echo "|--- Installing server and mods - steamcmd $install_cmd$mod_cmd ---|"
    su arma --command="steamcmd $install_cmd$mod_cmd +quit"
else
    echo "|--- Installing server - steamcmd $install_cmd ---|"
    su arma --command="steamcmd $install_cmd +quit"
fi

if [ $mods_loaded == "true" ]; then
    exec "/rename_mods.sh"
else
    # run server
    exec "/start_server.sh"
fi
