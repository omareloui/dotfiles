{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = "btrfs";
    };

    oci-containers = {
      backend = "docker";
    };
  };
}
