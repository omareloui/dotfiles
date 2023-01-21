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
