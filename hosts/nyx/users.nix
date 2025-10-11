{...}: {
  users = {
    users.omareloui = { isNormalUser = true; };

    groups = {
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
