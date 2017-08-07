#!/bin/bash
## Choose a deterministic weekday to have lunch once a month

readonly MONTH="$1"
year="$2"

# takes a single option, 1-12, the month
if [ -z "$MONTH" ] || ! echo "$MONTH" | grep -Exq '[1-9]|1[0-2]'; then
	echo "bad input. (MONTH [YEAR])"
else
	if [ -z "$year" ]; then
		year=$(date +%Y)
	fi
	# get the workdays in the month
	weekdays=($(cal -m $MONTH | cut -c 4-17 | grep -v '[a-z]' | paste -sd' ' | sed -E 's/ +/ /g'))
	numweekdays=${#weekdays[@]}

	# get the remainder of the (year divided by the month) divided by the number of weekdays
	i=$(date -d "$MONTH/1" "+%-m %Y" | awk -v "n=$numweekdays" '{printf "%.0f\n",(($2/$1)%n)}')

	# go to lunch on the weekday index of the result
	day=${weekdays[$i]}
	date -d "$MONTH/$day/$year" "+%a %F"
fi