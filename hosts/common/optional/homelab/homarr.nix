{
  lib,
  config,
  ...
}: {
  virtualisation.oci-containers.containers = {
    homarr = {
      autoStart = lib.mkDefault false;
      image = "ghcr.io/homarr-labs/homarr:v1.51.0";
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/home/omareloui/.config/homarr/appdata:/appdata"
      ];
      ports = ["7575:7575"];
      environment = {
        # TODO: Generate this value and store it in a file, then read it here.
        SECRET_ENCRYPTION_KEY = "fde16779e559ebf3405cdf9270662b0ee5fc87cf642d7c87ee6ef8068a320cb8";
      };
    };
  };

  services.nginx.virtualHosts."homarr.homelab" =
    lib.mkIf config.virtualisation.oci-containers.containers.homarr.autoStart
    {locations."/".proxyPass = "http://localhost:7575";};

  networking.extraHosts = lib.mkIf config.virtualisation.oci-containers.containers.homarr.autoStart "127.0.0.1 homarr.homelab";
}
