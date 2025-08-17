{
  config,
  lib,
  ...
}: {
  services = {
    readarr = {
      enable = false;
      openFirewall = config.services.readarr.enable;
      group = "shared";
    };
  };
}
