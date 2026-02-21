{
  config,
  lib,
  ...
}: {
  services = {
    syncthing = {
      enable = lib.mkDefault false;
      openDefaultPorts = config.services.syncthing.enable;
      group = "shared";
      settings = {
        devices = {
          "fold_7" = {
            id = "UIGFQ6R-YR4TMTV-PPOGUPP-FTE2NNS-KIUEYFE-ANWOLH7-TUXSCIW-BY2NRAB";
            name = "Samsung Galaxy Z Fold 7";
          };
        };
        folders = {
          "notes" = {
            id = "rrwsq-soksl";
            path = "/home/shared/notes";
            devices = ["fold_7"];
          };
          "documents" = {
            id = "9p7nq-v2zcq";
            path = "/home/shared/documents";
            devices = ["fold_7"];
          };
          "leatherwork" = {
            id = "hxq6n-smcyd";
            path = "/home/shared/leatherwork";
            devices = ["fold_7"];
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
