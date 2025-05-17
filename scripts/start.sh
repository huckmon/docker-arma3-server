#!/usr/bin/env bash

chown -R arma:arma /data

#create if statement to check if steamcmd exits
exec su arma --command="steamcmd +exit"

# run server file validation and install if needed

exec su arma --comand="/install_server.sh"

# run server
exec su arma --command="/start_server.sh"

