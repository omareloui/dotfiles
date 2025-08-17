{pkgs, ...}: {
  networking = {
    firewall.allowedTCPPorts = [
      8384 # Syncthing
      22000 # Syncthing
      # 7575 # Homarr
      # 8080 # Openbook
    ];
    firewall.allowedUDPPorts = [
      22000 # Syncthing
      21027 # Syncthing?
    ];

    extraHosts = ''
      127.0.0.1 sonarr.homelab
      127.0.0.1 radarr.homelab
      127.0.0.1 prowlarr.homelab
      127.0.0.1 jellyfin.homelab
      127.0.0.1 syncthing.homelab
      127.0.0.1 transmission.homelab
    '';
  };

  services = {
    nginx = {
      enable = true;
      virtualHosts = {
        "jellyfin.homelab" = {
          locations."/" = {
            proxyPass = "http://localhost:8096";
          };
        };
        "sonarr.homelab" = {
          locations."/" = {
            proxyPass = "http://localhost:8989";
          };
        };
        "radarr.homelab" = {
          locations."/" = {
            proxyPass = "http://localhost:7878";
          };
        };
        "prowlarr.homelab" = {
          locations."/" = {
            proxyPass = "http://localhost:9696";
          };
        };
        "syncthing.homelab" = {
          locations."/" = {
            proxyPass = "http://localhost:8384";
          };
        };
        "transmission.homelab" = {
          locations."/" = {
            proxyPass = "http://localhost:9091";
          };
        };
      };
    };

    syncthing = {
      enable = true;
      openDefaultPorts = false;
    };

    transmission = {
      enable = true;
      package = pkgs.transmission_4-gtk;
      openFirewall = true;
      # settings = {
      #   download-dir = "/home/media/torrents";
      #   incomplete-dir = "/home/media/torrents/.incomplete";
      # };
    };
    jellyfin = {
      enable = false;
      openFirewall = true;
      group = "media";
    };
    jellyseerr = {
      enable = false;
      openFirewall = true;
    };
    prowlarr = {
      enable = false;
      openFirewall = true;
    };
    sonarr = {
      enable = false;
      openFirewall = true;
      group = "media";
    };
    radarr = {
      enable = false;
      openFirewall = true;
      group = "media";
    };
    bazarr = {
      enable = false;
      openFirewall = true;
      group = "media";
    };
    readarr = {
      enable = false;
      openFirewall = true;
      group = "media";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    # This is required for sonarr
    "dotnet-sdk-6.0.428"
    "aspnetcore-runtime-6.0.36"
  ];

  virtualisation = {
    oci-containers = {
      containers = {
        homarr = {
          autoStart = false;
          image = "ghcr.io/ajnart/homarr:latest";
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/home/omareloui/.config/homarr/configs:/app/data/configs"
            "/home/omareloui/.config/homarr/icons:/app/public/icons"
            "/home/omareloui/.config/homarr/data:/data"
          ];
          ports = ["7575:7575"];
        };

        openbooks = {
          autoStart = false;
          image = "evanbuss/openbooks";
          ports = ["8080:80"];
          cmd = ["--name" "omareloui" "--persist"];
          volumes = ["/home/media/openbooks:/books"];
        };
      };
    };
  };
}
