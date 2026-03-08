{
  config,
  pkgs,
  lib,
  ...
}:
pkgs.writeShellScript "batplug" ''
  NOTIFICATION_ID=4215

  current_percentage="$(cat /sys/class/power_supply/BAT0/capacity)"

  echo "$(date) ONLINE=$POWER_SUPPLY_ONLINE" >> /tmp/charger-debug.log

  if ((POWER_SUPPLY_ONLINE==1)); then
    TITLE="Charging"
    BODY="$current_percentage% of battery charged."
    ICON="battery-caution-charging"
    URGENCY="normal"
    SOUND="power-plug"
  elif ((POWER_SUPPLY_ONLINE==0)); then
    TITLE="Disconnected"
    BODY="$current_percentage% of battery remaining."
    ICON="battery-caution"
    URGENCY="low"
    SOUND="power-unplug"
  else
    exit 0
  fi

  ${pkgs.util-linux}/bin/runuser -u ${config.users.users.omareloui.name} -- \
    env DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" \
    ${lib.getExe pkgs.libnotify} \
      "$TITLE" \
      "$BODY" \
      -i "$ICON" \
      -u "$URGENCY" \
      -r "$NOTIFICATION_ID"

  ${pkgs.util-linux}/bin/runuser -u ${config.users.users.omareloui.name} -- \
    env DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" \
    ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i "$SOUND"
''
