
Usage:

1. Add/Remove ruby variables to cron:

    rvm cron {setup|remove}

2. Manage rvm on single command level

    rvm cron command <"schedule"> <command> <params...>


Example 1 set one ruby for all cron jobs:

    cd /project/dir  # go to project dir, or `rvm use ...`
    rvm cron setup   # initialize cron with ruby settings
    crontab -e       # add tasks to cron

After project ruby changes:

    rvm cron setup   # update cron with new ruby settings



Example 2 add single job using current dir for rvm:

    cd /project/dir  # go to project dir, or `rvm use ...`
    rvm cron command "@daily" rake calculate:stats

Refer to `man 5 crontab` for definitions of time/date, examples:

    "*/5 * * * *" - Every 5 minutes
    "@hourly"     - Once an hour
    "* */4 * * *" - Every 4 hours
    "0 6 * * *"   - Everyday at 6am
    "0 7 * * 5"   - Every Friday at 7am

NOTE! Do not forget to set notification email in `crontab -e`:

    MAILTO=someone@project.com
