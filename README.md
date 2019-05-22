# iCalendar Merge Tool

This project will allow you to merge multiple [iCalendar files](https://en.wikipedia.org/wiki/ICalendar) (`.ics` files) into one or more merged `.ics` files. It uses a collection of bash scripts to accomplish the calendar merges. This tool is useful for maintaining separate source calendars, for better organization, then merging one or more of the source calendars into any number of customizable sets of merged calendars. 

This was originally developed to support individualized calendar feeds for each member of a team, where members can be on multiple teams and therefore need to attend events from multiple calendars. This tool simplifies the maintenance of calendars by allowing a team manager to keep a calendar for each team/set of related events. The team manager can also specify any number of custom merged calendars for each team member by specifying a name, key (can be anything but is randomly generated for privacy and uniqueness) and which source calendars the merged calendar should be built from. This method also greatly simplifies the calendar subscription/import process for the team member who can now subscribe/import one calendar instead of several.

## Getting Started

1. Clone this repo

        git clone https://github.com/KevinRaney/iCalendarMergeTool.git

2. Change into the repo directory. 

        cd iCalendarMergeTool

3. Run the following script to configure a new source calendar.

        Scripts/addSourceCalendar "NewSource" "https://calendarhosting.com/anycalendar.ics"

4. Run the following script to configure a new merge calendar.

        Scripts/addMergeCalendar "New Merged Calendar Name"

5. Update the list of source calendars you want to merge into your new merged calendar.

    ```
    vi .mergeCalendars
    ```

    Example `.mergeCalendars`:
    ```
    New Merged Calendar Name|9fa96b3f6dfcc676fae0bbea16213af3|"New Source Calendar Name.ics"
    ```

6. Run the following script to download all the source calendars.

        Scripts/downloadSourceCalendars

7. Run the following script to generate/update all your merged calendars.

        Scripts/mergeCalendars

8. After you have setup your `.sourceCalendars` and `.mergeCalendars` files you can run `downloadSourceCalendars` and `mergeCalendars` as often as you like. Typically you will setup a cron job to run it automatically.

    ```
    vi /etc/cron.d/iCalendarMergeTool
    ```

    Example cron:

    ```
    SHELL=/bin/sh
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/var/iCalendarMergeTool/Scripts
    MAILTO=""
    */5 * * * *   root   cd /var/iCalendarMergeTool && downloadSourceCalendars && mergeCalendars
    ```

## Source Calendar List

You will maintain a list of calendar names and urls in the file `.sourceCalendars` that you want to download and keep updated.

This file is pipe delimited and has two columns, calendar name and calendar url. This file doesn't support a header row.

Below is an example file:

```
AnyCalendar|https://calendarhosting.com/anycalendar.ics
A_Specific_Calendar|https://calendarhosting.com/ASpecificCalendar.ics
Google-Cal|https://calendar.google.com/9fa96b3f6dfcc676fae0bbea16213af3.ics
```

The calendar name can be anything you want, but please keep in mind the following:

- The name should be descriptive and short (oxymoron?), since it will be used to prefix all event summaries.
- The name should not contain any characters that are invalid for filenames, since it will be used to name the extracted and modified source calendar.

Actions performed for each source calendar:

1. The calendar `.ics` file is downloaded.
2. The events are extracted and other calendar metadata is removed.
3. The summary of each event is prefixed with the calendar name you specified in the source calendar list.
4. The modified file is saved in the `SourceCalendars` directory and named after the calendar name `"AnyCalendar.ics"`

The source calendars that are stored in the `SourceCalendars` directory and are intentionally malformed and cannot be imported or subscribed to, more on that later.

## Merge Calendar List

> TODO: this section still needs some work.

## Scripts

- `addSourceCalendar` Adds a new source calendar to the .sourceCalendars file.
- `addMergeCalendar` Adds a new merge calendar to the .mergeCalendars file.
- `downloadSourceCalendars` Downloads all source calendars listed in .sourceCalendars, extracts all events, prepend the description field with the source calendar name and save the data in the SourceCalendars directory.
- `mergeCalendars` Creates all merged calendars listed in .mergeCalendars by combining the source calendars listed.

## Templates

The templates directory contains the following files and can be modifed to suit your specific needs:
- `header.icstemplate` - All ICS lines to be included before the merged events.
- `footer.icstemplate` - All ICS lines to be included after the merged events.

## Contributing

Feel free to fork this repo and submit PRs by working on issues or adding features you think would be nice to have.
