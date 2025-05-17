#!usr/bin/env bash

set -e

groupadd --gid 777 arma
useradd --system --shell /bin/false --uid 777 -g arma --home-dir /home/arma arma
