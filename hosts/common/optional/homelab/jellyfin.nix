{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    jellyfin = {
      enable = lib.mkDefault false;
      openFirewall = config.services.jellyfin.enable;
      group = "shared";
    };
    nginx.virtualHosts = {
      "jellyfin.homelab" = lib.mkIf config.services.jellyfin.enable {locations."/".proxyPass = "http://localhost:8096";};
      "jellyfin2.homelab" = {locations."/".proxyPass = "http://localhost:8097";};
    };
  };

  systemd.services.jellyfin2 = {
    enable = lib.mkDefault false;
    description = "Jellyfin Media Server (Instance 2)";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      User = "jellyfin";
      Group = "shared";
      ExecStart = "${lib.getExe pkgs.jellyfin}";
      Restart = "on-failure";
      StateDirectory = "jellyfin2";
      CacheDirectory = "jellyfin2";
      LogsDirectory = "jellyfin2";
    };
    environment = {
      JELLYFIN_DATA_DIR = "/var/lib/jellyfin2";
      JELLYFIN_CONFIG_DIR = "/var/lib/jellyfin2/config";
      JELLYFIN_LOG_DIR = "/var/log/jellyfin2";
      JELLYFIN_CACHE_DIR = "/var/cache/jellyfin2";
    };
    preStart =
      /*
      bash
      */
      ''
        mkdir -p /var/lib/jellyfin2/config
        if [ ! -f /var/lib/jellyfin2/config/network.xml ]; then
          cat > /var/lib/jellyfin2/config/network.xml <<EOF
        <?xml version="1.0" encoding="utf-8"?>
        <NetworkConfiguration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
          <InternalHttpPort>8097</InternalHttpPort>
          <InternalHttpsPort>8921</InternalHttpsPort>
          <PublicHttpPort>8097</PublicHttpPort>
          <PublicHttpsPort>8921</PublicHttpsPort>
          <AutoDiscovery>true</AutoDiscovery>
          <EnableHttps>false</EnableHttps>
          <RequireHttps>false</RequireHttps>
        </NetworkConfiguration>
        EOF
        fi
      '';
  };

  networking = {
    firewall.allowedTCPPorts = lib.mkIf config.systemd.services.jellyfin2.enable [8097];

    extraHosts = lib.mkMerge [
      (lib.mkIf config.services.jellyfin.enable "127.0.0.1 jellyfin.homelab")
      (lib.mkIf config.systemd.services.jellyfin2.enable "127.0.0.1 jellyfin2.homelab")
    ];
  };

  environment.systemPackages = lib.mkIf (config.services.jellyfin.enable || config.systemd.services.jellyfin2.enable) [pkgs.jellyfin-ffmpeg];
}
