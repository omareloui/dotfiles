{
  config,
  lib,
  ...
}: {
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = config.services.syncthing.enable;
      group = "media";
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
            path = "/home/media/notes";
            devices = ["device1"];
          };
          "documents" = {
            id = "9p7nq-v2zcq";
            path = "/home/media/documents";
            devices = ["device1"];
          };
          "leatherwork" = {
            id = "hxq6n-smcyd";
            path = "/home/media/leatherwork";
            devices = ["device1"];
          };
        };
      };
    };

    nginx.virtualHosts."syncthing.homelab" =
      lib.mkIf config.services.syncthing.enable
      {locations."/".proxyPass = "http://localhost:8384";};
  };

  users.users.syncthing.extraGroups = lib.mkIf config.services.syncthing.enable ["media"];

  networking.extraHosts = lib.mkIf config.services.syncthing.enable "127.0.0.1 syncthing.homelab";
}
