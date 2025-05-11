#!usr/bin/env bash

set -e

addgroup --gid 1000 arma
adduser --system --shell /bin/false --uid 1000 --ingroup arma --home /home/arma arma
