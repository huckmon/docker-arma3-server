#!usr/bin/env bash

set -e

deluser ubuntu

groupadd --gid 1000 arma
useradd --uid 1000 -ingroup arma --home /data arma
