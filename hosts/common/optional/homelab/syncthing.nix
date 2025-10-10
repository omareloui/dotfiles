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
          "galaxy_a24" = {
            id = "ZCBT4LG-BGAA2ZN-AJDFJV7-MDXOYG7-IKLTD27-IDNK3T2-TJYITDH-TWV7OQA";
            name = "Samsung Galaxy A24";
          };
        };
        folders = {
          "notes" = {
            id = "rrwsq-soksl";
            path = "/home/shared/notes";
            devices = ["galaxy_a24"];
          };
          "documents" = {
            id = "9p7nq-v2zcq";
            path = "/home/shared/documents";
            devices = ["galaxy_a24"];
          };
          "leatherwork" = {
            id = "hxq6n-smcyd";
            path = "/home/shared/leatherwork";
            devices = ["galaxy_a24"];
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
