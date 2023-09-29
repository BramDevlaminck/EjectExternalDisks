#!/bin/zsh

ejectFile="/tmp/toEject.xml"
diskutil list -plist external physical > "$ejectFile"

yq -oy ".plist.[].array.[-1].string" "$ejectFile" | cut -d " " -f2 | while read line; do
	diskutil eject "$line"
done

rm "$ejectFile"
