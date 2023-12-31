#!/bin/zsh

ejectFile="/tmp/toEject.xml"
diskutil list -plist external physical > "$ejectFile"

diskUtilOutput=""
/opt/homebrew/bin/yq -oy ".plist.[].array.[-2].string" "$ejectFile" | while read line; do
	if [ "$line" != "null" ]; then
		diskUtilOutput+=$(diskutil eject "$line")
		diskUtilOutput+="\n"
	else
		diskUtilOutput="No disks to eject found"
		break
	fi
done

osascript -e 'display notification "'"$diskUtilOutput"'" with title "Disks Ejected"'

rm "$ejectFile"