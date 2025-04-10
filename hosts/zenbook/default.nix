{
  lib,
  inputs,
  ...
}: {
  imports = [
    ../common/global
    ../common/users/omareloui
    inputs.nixos-wsl.nixosModules.default
  ];
  system.stateVersion = "24.05";

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
    hostName = "zenbook";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
