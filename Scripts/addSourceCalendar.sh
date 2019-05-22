#!/bin/bash

if ! [ -f .sourceCalendars ] || [ `cat .sourceCalendars | wc -l` -eq 0 ]
then
  touch .sourceCalendars
fi

if [ -z "$1" ]
then
  echo "Please send the name of the new source calendar when calling this script in the first position."
  exit 1
fi

if [ -z "$2" ]
then
  echo "Please send the url of the new source calendar when calling this script in the second position."
  exit 1
fi

echo "$1|$2" >> .sourceCalendars
