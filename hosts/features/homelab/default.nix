{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./bazarr.nix
    ./homarr.nix
    ./jellyfin.nix
    ./jellyseer.nix
    ./prowlarr.nix
    ./radarr.nix
    ./readarr.nix
    ./sonarr.nix
    ./syncthing.nix
    ./transmission.nix
  ];

  services.nginx.enable = true;
}
