#!usr/bin/env bash

set -e

deluser ubuntu

groupadd --gid 1000 arma
useradd --system --shell /bin/false --uid 1000 -ingroup arma --home /data arma
