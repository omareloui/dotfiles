{
  config,
  pkgs,
  lib,
  ...
}:
pkgs.writeShellScript "batplug" ''
  current_percentage="$(cat /sys/class/power_supply/BAT0/capacity)"

  echo "$(date) ONLINE=$POWER_SUPPLY_ONLINE" >> /tmp/charger-debug.log

  if ((POWER_SUPPLY_ONLINE==1)); then
    TITLE="Charging"
    BODY="$current_percentage% of battery charged."
    ICON="battery-good-charging"
    URGENCY="normal"
    SOUND="/run/current-system/sw/share/sounds/freedesktop/stereo/power-plug.oga"
  elif ((POWER_SUPPLY_ONLINE==0)); then
    TITLE="Disconnected"
    BODY="$current_percentage% of battery remaining."
    ICON="battery-caution"
    URGENCY="low"
    SOUND="/run/current-system/sw/share/sounds/freedesktop/stereo/power-unplug.oga"
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
      -h "string:synchronous:battery"

  ${pkgs.util-linux}/bin/runuser -u ${config.users.users.omareloui.name} -- \
    env XDG_RUNTIME_DIR="/run/user/1000" \
    ${pkgs.pulseaudio}/bin/paplay "$SOUND"
''
