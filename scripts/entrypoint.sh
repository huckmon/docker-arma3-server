#!/usr/bin/env bash

# This script updates the system and

ARMA_DIR="/home/arma-server"
MOD_DIR="steamapps/workshop/content/107410"
USR="Huck"

# update and install
apt-get update && apt-get upgrade -y && apt-get install coreutils -y && apt-get install rename -y
#apk update && apk upgrade -y

cd "$ARMA_DIR/$MOD_DIR/" # Replace this by having the workingdir point to the server

pwd

# This script renames all workshop files to prevent issues from capitals in mod file names like CUP
find $ARMA_DIR/$MOD_DIR -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;

cd "$ARMA_DIR"

exec ./arma3server_x64 -name=$USR -config=server.cfg -world=empty -mod="$MOD_DIR/2867537125" -mod="$MOD_DIR/450814997" -mod="$MOD_DIR/1779063631" -mod="$MOD_DIR/463939057" -mod="$MOD_DIR/894678801" -mod="$MOD_DIR/1638341685" -mod="$MOD_DIR/1724884525" -mod="$MOD_DIR/497660133" -noSound -netlog
