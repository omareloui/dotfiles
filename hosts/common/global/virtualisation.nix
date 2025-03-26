{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };

    oci-containers = {
      backend = "docker";
    };
  };
}
