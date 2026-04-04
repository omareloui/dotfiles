{...}: {
  imports = [
    ../common/global
    ../common/wsl
    ../common/users/omareloui
  ];

  system.stateVersion = "24.05";
  networking.hostName = "ocd";
}
