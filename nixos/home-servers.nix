{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };

  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
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
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      openFirewall = true;
    };
    readarr = {
      enable = true;
      openFirewall = true;
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
        openbooks = {
          autoStart = true;
          image = "evanbuss/openbooks";
          ports = ["8080:80"];
          cmd = ["--name" "omareloui" "--persist"];
          volumes = ["/home/media/openbooks:/books"];
        };
      };
    };
  };
}
