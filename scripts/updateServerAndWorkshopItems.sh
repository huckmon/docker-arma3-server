#!/usr/bin/env bash

USRNAME=""
PASSWD=""

cd /home/arma-server

steamcmd +force_install_dir /home/arma-server/ +login ${USRNAME} +app_update 233780 validate +107410 workshop_download_item 2867537125 +workshop_download_item 107410 1638341685 +workshop_download_item 107410 1724884525 +workshop_download_item 107410 1779063631 +workshop_download_item 107410 2867537125 +workshop_download_item 107410 450814997 +workshop_download_item 107410 463939057 +workshop_download_item 107410 894678801 +workshop_download_item 107410 497660133
#force_install_dir /home/arma-server/
#login ${usrname}
#app_update 233780 validate
#workshop_download_item 107410 1638341685 # DUI Squad radar
#workshop_download_item 107410 1724884525 # AGC Advanced Garbage Collector
#workshop_download_item 107410 1779063631 # Zeus Enhanced
#workshop_download_item 107410 2867537125 # Antistasi
#workshop_download_item 107410 450814997 # CBA_A3
#workshop_download_item 107410 463939057 # ace
#workshop_download_item 107410 894678801 # TFAR beta
#workshop_download_item 107410 497660133 # CUPS weapons
