# Custom iCalendar Merge Tool

This project will allow you to merge multiple [iCalendar files](https://en.wikipedia.org/wiki/ICalendar) (ICS files) into one or more single ICS files. It uses a collection of bash scripts to accomplist the calendar merges. This is useful for maintaining individual calendars (for better organization) and then merging a subset of the individual calendars together into one or more of single ICS calendars. 

This was originally developed to support individualized calendar feeds for each member of a team, where members can be on multiple teams. This simplifies the maintenance of calendars by allowing a team manager to keep a calendar for each team. The team manager can also specify a custom merged calendar for each member by specifying which individual calendars the merged calendar should built from. This also greatly simplifies the calendar subscription/import process for the team member who can subscribe to just one calendar instead of several.

## Getting Started

1. Clone this repo

        git clone https://github.com/KevinRaney/CustomICSMergeTool.git

2. Change into the repo directory. 

        cd CustomICSMergeTool

3. Run the following script to configure a new source calendar.

        Script/addSourceCalendar "New Source Calendar Name" "https://calendarhosting.com/anycalendar.ics"

4. Run the following script to configure a new merge calendar.

        Script/addMergedCalendar "New Merged Calendar Name"

5. Update the list of source calendars you want to merge into your new merge calendar

        vi .mergeCalendars
        New Merged Calendar Name|9fa96b3f6dfcc676fae0bbea16213af3|"New Source Calendar Name.ics"
        :wq

## Source Calendar List

You will maintain a list of calendar names and urls in the file `.sourceCalendars` that you want to download.

This file is pipe delimited and has two columns, calendar name and calendar url. This file doesn't support a header row. Below is an example file:

```
Any Calendar|https://calendarhosting.com/anycalendar.ics
A Specific Calendar|https://calendarhosting.com/ASpecificCalendar.ics
Google|https://calendar.google.com/9fa96b3f6dfcc676fae0bbea16213af3.ics
```

The calendar name can be anything you want, but please keep in mind the following:
- The name should be descriptive and short (oxymoron?), since it will be used to prefix all event summaries.
- The name should not contain any characters that are invalid for filenames, since it will be used to name the extracted and modified source calendar.

Actions performed for each source calendar:
1. The calendar ics file is downloaded.
2. The events are extracted (other calendar metadata is removed).
3. The summary of each event is prefixed with the calendar name you specified in the source calendar list.
4. The modified file is saved in the `SourceCalendars` directory and named after the calendar name `"Any Calendar.ics"`

The source calendars that are stored in `SourceCalendars` are intentionally malformed and cannot be imported or subscribed to, more on that later.

## Merge Calendar List


## Scripts
- add download a standard set of ICS files, extract the events from the file

## Templates

The templates directory contains the following files and can be modifed to suit your specific needs:
- `Header.icstemplate` - All ICS lines to be included before the merged events.
- `Footer.icstemplate` - All ICS lines to be included after the merged events.

## Contributing

Feel free to fork this repo and submit PRs