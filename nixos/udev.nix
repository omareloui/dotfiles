{
  lib,
  pkgs,
  ...
}: {
  # if a package contains udev rules in $out/{etc, lib}/udev You can load them using:
  services = {
    udev = {
      packages = with pkgs; [wally-cli];

      extraRules =
        /*
        hog
        */
        ''
          # Rules for Oryx web flashing and live training
          KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
          KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"

          # TODO: it's not working (THE ATTR{online} and ATTR{type} is the problem)
          # Rule for when switching to battery
          SUBSYSTEM=="power_supply", \
            ACTION=="change", \
            KERNEL=="BAT1", \
            ENV{DISPLAY}=":0", \
            ENV{XDG_RUNTIME_DIR}="/run/user/1000", \
            ATTR{online}=="1", \
            ATTR{type}=="Mains", \
            RUN+="${lib.getExe pkgs.coreutils} --coreutils-prog=touch /tmp/bat-disconn"
          SUBSYSTEM=="power_supply", \
            ACTION=="change", \
            KERNEL=="BAT1", \
            ENV{DISPLAY}=":0", \
            ENV{XDG_RUNTIME_DIR}="/run/user/1000", \
            ATTR{online}=="0", \
            ATTR{type}=="Mains", \
            RUN+="${lib.getExe pkgs.coreutils} --coreutils-prog=touch /tmp/bat-conn"

            # RUN+="${lib.getExe pkgs.coreutils} --coreutils-prog=su omareloui -c \"${lib.getExe pkgs.batplug} connected\""
            # RUN+="${lib.getExe pkgs.coreutils} --coreutils-prog=su omareloui -c \"${lib.getExe pkgs.batplug} connected\""
        '';
    };
  };
}
