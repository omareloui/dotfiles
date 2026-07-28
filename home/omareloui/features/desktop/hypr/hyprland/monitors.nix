{pkgs, ...}: let
  laptopMonitor = "eDP-1";
  odysseyG8 = "desc:Samsung Electric Company Odyssey G85SD H1AK500000";
  # monitorHotplug = pkgs.writeShellApplication {
  #   name = "monitor-hotplug";
  #   runtimeInputs = with pkgs; [socat jq hyprland];
  #   text = ''
  #     SIGNATURE=$(hyprctl instances -j | jq -r '.[0].instance')
  #     SOCKET="/tmp/hypr/$SIGNATURE/.socket2.sock"
  #
  #     socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do
  #       case "$line" in
  #         monitoradded*{HDMI-A-1,DP-1,DP-2}*)
  #           hyprctl keyword monitor "eDP-1, disable"
  #           hyprctl keyword monitor "HDMI-A-1, preferred, 0x0, 1"
  #           hyprctl keyword monitor "DP-1, preferred, 0x0, 1"
  #           hyprctl keyword monitor "DP-2, preferred, 0x0, 1"
  #           ;;
  #         monitorremoved*{HDMI-A-1,DP-1,DP-2}*)
  #           hyprctl keyword monitor "eDP-1, preferred, auto, 1.5"
  #           ;;
  #       esac
  #     done
  #   '';
  # };
in {
  # home.packages = [monitorHotplug];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "${odysseyG8}, 3440x1440@120, 0x0, 1, vrr, 1"
      "${laptopMonitor}, preferred, auto, 1.5"
      ", preferred, auto, 1"
    ];

    workspaces = [
      "1, ${odysseyG8}, default:true"
    ];

    # exec-once = [
    #   "${monitorHotplug}/bin/monitor-hotplug"
    # ];
  };
}
