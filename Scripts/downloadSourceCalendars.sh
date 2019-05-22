#!/bin/bash

if ! [ -f .sourceCalendars ] || [ `cat .sourceCalendars | wc -l` -eq 0 ]
then
  cat ${0/.sh/.help}
  exit 1
fi

while read sourceCalendar; do
  calendarName=$(echo $sourceCalendar | cut -f1 -d\|)
  calendarURL=$(echo $sourceCalendar | cut -f2 -d\|)
  echo "Downloading source calendar \"$calendarName\" and extracting events to ./SourceCalendars/\"$calendarName.ics\""
  wget -q -O - "$calendarURL" | sed -n '/BEGIN:VEVENT/,/END:VEVENT/p' | sed -e 's/SUMMARY:/SUMMARY:'$calendarName': /g' > ./SourceCalendars/"$calendarName.ics"
done <.sourceCalendars
