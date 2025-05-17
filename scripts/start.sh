#!/usr/bin/env bash

chown -R arma:arma /data

# run server file validation and install if needed

exec su arma --comand="/install_server.sh"

