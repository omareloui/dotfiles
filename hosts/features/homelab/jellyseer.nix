{
  config,
  lib,
  ...
}: {
  services = {
    jellyseerr = {
      enable = false;
      openFirewall = config.services.jellyseerr.enable;
    };
  };
}
