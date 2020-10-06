#!/usr/bin/env bash
set -e

cd "$(qmk config user.qmk_home | cut -d= -f2)"

KB="${1:-$(qmk config user.keyboard | cut -d= -f2)}"
KM="${2:-$(qmk config user.keymap | cut -d= -f2)}"
TARGET="$KB:$KM"

echo -e "*** Building $KB:$KM\n\n"
util/docker_build.sh "$KB:$KM"
echo -e "\n\n*** Build successful!"

BIN="$(realpath .build/$(echo $TARGET | tr :/ _).bin)"
cd "$(dirname $(which mdloader))"

echo -e "*** Flashing $BIN...\n\n"
./mdloader --first --download $BIN --restart
echo -e "\n\n*** Flash complete!"
