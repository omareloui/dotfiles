{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };

  services = {
    transmission = {
      enable = true;
      package = pkgs.transmission_4-gtk;
      openFirewall = true;
      settings = {
        download-dir = "/home/media/torrents";
        incomplete-dir = "/home/media/torrents/.incomplete";
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    bazarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    readarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
  };

  virtualisation = {
    oci-containers = {
      containers = {
        homarr = {
          autoStart = true;
          image = "ghcr.io/ajnart/homarr:latest";
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "/home/omareloui/.config/homarr/configs:/app/data/configs"
            "/home/omareloui/.config/homarr/icons:/app/public/icons"
            "/home/omareloui/.config/homarr/data:/data"
          ];
          ports = ["7575:7575"];
        };

        # openbooks = {
        #   autoStart = true;
        #   image = "evanbuss/openbooks";
        #   ports = ["8080:80"];
        #   cmd = ["--name" "omareloui" "--persist"];
        #   volumes = ["/home/media/openbooks:/books"];
        # };
      };
    };
  };
}
