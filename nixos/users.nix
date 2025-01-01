{pkgs, ...}: {
  users.users.omareloui = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "docker"
      "media"
      "syncthing"
    ];
    shell = pkgs.zsh;
    packages = [];
  };

  users.groups.media.members = [
    "omareloui"
    "syncthing"
    "jellyfin"
    "prowlarr"
    "sonarr"
    "radarr"
    "bazarr"
    "transmission"
  ];
}
