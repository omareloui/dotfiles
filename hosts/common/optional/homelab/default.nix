{...}: {
  imports = [
    ./bazarr.nix
    ./byparr.nix
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

  services = {
    nginx.enable = true;

    bazarr.enable = true;
    jellyfin.enable = true;
    jellyseerr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    sonarr.enable = true;
    syncthing.enable = true;
    transmission.enable = true;
  };
  systemd.services.jellyfin2.enable = true;
  virtualisation.oci-containers.containers.byparr.autoStart = true;
  virtualisation.oci-containers.containers.homarr.autoStart = true;
}
