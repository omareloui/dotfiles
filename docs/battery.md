# Battery notifications and warnings

Run the `$BOOTSTRAP_FILES/battery.sh` file to prepare to move the files where
they need to be.

Then setup the cron job to check for the battery level.

## Setup the cron job

Open it by

```bash
crontab -e
```

To check every 5 seconds add this

```bash
* * * * * /home/omareloui/.local/bin/batwarning
* * * * * sleep 5; /home/omareloui/.local/bin/batwarning
* * * * * sleep 10; /home/omareloui/.local/bin/batwarning
* * * * * sleep 15; /home/omareloui/.local/bin/batwarning
* * * * * sleep 20; /home/omareloui/.local/bin/batwarning
* * * * * sleep 25; /home/omareloui/.local/bin/batwarning
* * * * * sleep 30; /home/omareloui/.local/bin/batwarning
* * * * * sleep 35; /home/omareloui/.local/bin/batwarning
* * * * * sleep 40; /home/omareloui/.local/bin/batwarning
* * * * * sleep 45; /home/omareloui/.local/bin/batwarning
* * * * * sleep 50; /home/omareloui/.local/bin/batwarning
* * * * * sleep 55; /home/omareloui/.local/bin/batwarning
```

Or to check every 10 seconds add this save the file and close and you're good
to go

```bash
* * * * * /home/omareloui/.local/bin/batwarning
* * * * * sleep 10; /home/omareloui/.local/bin/batwarning
* * * * * sleep 20; /home/omareloui/.local/bin/batwarning
* * * * * sleep 30; /home/omareloui/.local/bin/batwarning
* * * * * sleep 40; /home/omareloui/.local/bin/batwarning
* * * * * sleep 50; /home/omareloui/.local/bin/batwarning
```

You might need to restart the cron service. You can do this by running

```bash
sudo service cron reload
```

## My current cron file

```bash
SHELL=/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/home/omareloui/.local/bin

# For details see man 4 crontabs
# Example of job definition:
# .---------------- minute (0-59)
# | .------------- hour (0-23)
# | | .---------- day of month (1-31)
# | | | .------- month (1-12) OR jan,feb,mar,apr ...
# | | | | .---- day of week (0-6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# | | | | |
# * * * * * user-name command to be executed
* * * * * /home/omareloui/.local/bin/batwarning
* * * * * /home/omareloui/.local/bin/batsuspend
```
