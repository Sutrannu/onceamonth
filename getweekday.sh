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

    # get the weekdays in the month
    weekdays=()
    for d in {1..31}; do
    	if u=$(date -d "$MONTH/$d/$year" +%u 2>/dev/null); then
            if [ $u -lt 6 ]; then
                weekdays+=($d)
            fi
 		else
 			continue
        fi
    done
    numweekdays=${#weekdays[@]}

    # get the remainder of the (year divided by the month) divided by the number of weekdays
    i=$(date -d "$MONTH/1/$year" "+%-m %Y" | awk -v "n=$numweekdays" '{printf "%.0f\n",(($2/$1)%n)}')

    # go to lunch on the weekday index of the result
    day=${weekdays[$i]}
    date -d "$MONTH/$day/$year" "+%a %F"
fi
