# Assets

All files here will be copied by other scripts (not symlinked).

## Icons

- Icons for battery notification.
- Icons for screenshot script.

## Sounds

- Sound for screenshot script.

## Themes

- Catppucin cursors.
- Catppucin for Thunderbird.

## UDev rules

- `99-power.rules`: to notify plug and unplug the power supply.
- `99-backlight.rules`: to allow all the users in `video` group to change backlight.
  - to add a user to video group `sudo usermod -aG video <user>`

You mostly won't need this, but if you want to manually reload udev rules
`sudo udevadm control --reload-rules && sudo udevadm trigger`

## Service

- `suspend@.service`: to lock the screen before suspending
  1. copy the file to `/etc/systemd/system`.
  1. enable the service with `sudo systemctl enable --now suspend@<username>.service`.

## Fonts

- Fonts for rofi [check install script for more info](../bootstrap/packages/rofi.sh).
