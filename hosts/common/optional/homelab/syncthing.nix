{
  config,
  lib,
  ...
}: {
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = config.services.syncthing.enable;
      group = "shared";
      settings = {
        devices = {
          "device1" = {
            id = "IGUWK2P-ESQ3GYD-RGZJYFF-3U77V4B-K5RX5GC-5KYCCEQ-EI2U4ZX-MP2OFAP";
            name = "Samsung Galaxy A24";
          };
        };
        folders = {
          "notes" = {
            id = "rrwsq-soksl";
            path = "/home/shared/notes";
            devices = ["device1"];
          };
          "documents" = {
            id = "9p7nq-v2zcq";
            path = "/home/shared/documents";
            devices = ["device1"];
          };
          "leatherwork" = {
            id = "hxq6n-smcyd";
            path = "/home/shared/leatherwork";
            devices = ["device1"];
          };
        };
      };
    };

    nginx.virtualHosts."syncthing.homelab" =
      lib.mkIf config.services.syncthing.enable
      {locations."/".proxyPass = "http://localhost:8384";};
  };

  networking.extraHosts = lib.mkIf config.services.syncthing.enable "127.0.0.1 syncthing.homelab";
}
