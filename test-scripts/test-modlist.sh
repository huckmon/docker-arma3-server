#!/usr/bin/env bash



# steamcmd start command args
a=1
modfile="./modlist.txt"
mod_cmd="" # stores command for mods
mods_loaded="false"
mod_prefix="-mod=\"$mod_dir/"
mod_param=""


echo "|--- checking if $(pwd)/modlist.txt exists ---|"
modfile_lines=`wc -l < $modfile`
while [ $a -lt `expr $modfile_lines + 1` ]
do
    current_line="$(sed -n ${a}p $modfile | grep -E -o '[0-9]+')"
    mod_param="$mod_cmd $mod_prefix$current_line\""
    mod_cmd=$mod_param
    a=`expr $a + 1`
done
mods_loaded="true"
mod_cmd="${mod_cmd} "

echo $mod_cmd
