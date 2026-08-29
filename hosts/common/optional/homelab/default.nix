{...}: {
  imports = [
    ./bazarr.nix
    ./homarr.nix
    ./jellyfin.nix
    ./seerr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./readarr.nix
    ./sonarr.nix
    ./syncthing.nix
    ./transmission.nix
  ];

  services = {
    nginx.enable = true;

    bazarr.enable = true;
    flaresolverr.enable = true;
    jellyfin.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    seerr.enable = true;
    sonarr.enable = true;
    syncthing.enable = true;
    transmission.enable = true;
  };
  virtualisation.oci-containers.containers.homarr.autoStart = true;
}
