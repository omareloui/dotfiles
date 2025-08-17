{
  config,
  lib,
  ...
}: {
  services = {
    sonarr = {
      enable = false;
      openFirewall = config.services.sonarr.enable;
      group = "shared";
    };

    nginx = {
      virtualHosts = {
        "sonarr.homelab" =
          lib.mkIf config.services.sonarr.enable
          {locations."/".proxyPass = "http://localhost:8989";};
      };
    };
  };

  nixpkgs.config.permittedInsecurePackages = lib.mkIf config.services.sonarr.enable [
    "dotnet-sdk-6.0.428"
    "aspnetcore-runtime-6.0.36"
  ];
}
