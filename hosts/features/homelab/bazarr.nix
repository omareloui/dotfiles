{
  config,
  lib,
  ...
}: {
  services = {
    bazarr = {
      enable = false;
      openFirewall = config.services.bazarr.enable;
      group = "shared";
    };
  };
}
