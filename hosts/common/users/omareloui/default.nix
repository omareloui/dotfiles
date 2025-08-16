{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.omareloui = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [];
    extraGroups = ifTheyExist [
      "wheel"
      "networkmanager"
      "video"
      "docker"
      "syncthing"
      "plugdev"
      "jellyfin"
      "prowlarr"
      "sonarr"
      "radarr"
      "bazarr"
      "transmission"
    ];
    shell = pkgs.zsh;
    packages = [pkgs.home-manager];
  };
}
