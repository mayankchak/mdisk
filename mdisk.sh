#!/bin/bash

main() {
	mdisk "$@"
}

usage() {
	echo "mdisk reuires valid option, arguments.
	      Usage: -n) new partition table
	      	     -e) existing partition table."
}

mdisk() {
	while getopts ":ne" opt; do
		case $opt in 
			n) new_part "$@" ;;
			e) exist_part "$@" ;;
			\?) usage "$@" ;;
		esac
	done
		
}

new_part() {
	parted --script /dev/$2 mklabel $3 mkpart $4 $5 $6 $7 2>/dev/null
	sleep 1 

	mkfs.$5 -f /dev/$8
	sleep 1

	mount /dev/$8 $9 2> /dev/null
	if [ $? -ne 0 ];
	then
		mkdir -p $9
		mount /dev/$8 $9
	fi
}

exist_part() {
	parted --script /dev/$2  mkpart $3 $4 $5 $6 2>/dev/null
        sleep 1

        mkfs.$4 -f /dev/$7
        sleep 1

        mount /dev/$7 $8 2> /dev/null
        if [ $? -ne 0 ];
	then
                mkdir -p $8
                mount /dev/$7 $8
        fi

}

main "$@"
