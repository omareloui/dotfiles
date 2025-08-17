{pkgs, ...}: {
  users = {
    users.omareloui = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "docker"
        "shared"
        "syncthing"
        "plugdev"
      ];
      packages = [];
    };

    groups = {
      # Create the group for the ZSA udev rules
      plugdev = {};

      shared.members = [
        "omareloui"
        "syncthing"
        "jellyfin"
        "prowlarr"
        "sonarr"
        "radarr"
        "bazarr"
        "transmission"
      ];
    };
  };
}
