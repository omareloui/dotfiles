# Battery notifications and warnings

Run the `setup.sh` file to prepare to move the files where they need to be.

Then setup the cron job to check for the battery level.

## Setup the cron job

Open it by

```bash
crontab -e
```

To check every 5 seconds add this

```bash
* * * * * /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 5; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 10; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 15; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 20; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 25; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 30; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 35; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 40; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 45; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 50; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 55; /home/omareloui/scripts/battery/notify_low.sh
```

Or to check every 10 seconds add this save the file and close and you're good
to go

```bash
* * * * * /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 10; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 20; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 30; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 40; /home/omareloui/scripts/battery/notify_low.sh
* * * * * sleep 50; /home/omareloui/scripts/battery/notify_low.sh
```

You might need to restart the cron service. You can do this by running

```bash
sudo service cron reload
```
