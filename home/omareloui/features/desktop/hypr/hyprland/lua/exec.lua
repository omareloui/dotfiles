hl.on("hyprland.start", function()
  hl.exec_cmd("wl-paste --watch cliphist store")

  hl.exec_cmd("@PYPRLAND@")
  hl.exec_cmd("@TELEGRAM@ -startintray")
  hl.exec_cmd("@INIT_BAR@")
  hl.exec_cmd("@HYPRSHADE@ auto")

  hl.exec_cmd("@BATWARNING@")
  @ANYRUN_DAEMON_CMD@
  @KEEPASSXC_CMD@

  hl.exec_cmd("dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE")
end)
