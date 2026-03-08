{pkgs, ...} @ args: {
  services = {
    udev = let
      notifyScript = import ./scripts/batplug.nix args;
    in {
      packages = with pkgs; [wally-cli];

      extraRules =
        /*
        hog
        */
        ''
          # for the Voyager
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"

          SUBSYSTEM=="power_supply", \
            ACTION=="change", \
            ATTR{type}=="Mains", \
            RUN+="${notifyScript}"
        '';
    };
  };
}
