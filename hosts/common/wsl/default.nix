{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "omareloui";
  };

  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = false;
  };

  services.xserver.enable = false;
  networking = {
    hostName = "ocd";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
