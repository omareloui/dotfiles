{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    ./users.nix
    ./udev.nix
    ./fonts.nix

    ../common/global
    ../common/users/omareloui

    ../common/optional/backup.nix
    ../common/optional/bluetooth.nix
    ../common/optional/boot.nix
    ../common/optional/console.nix
    ../common/optional/cron.nix
    ../common/optional/displaymanager.nix
    ../common/optional/gpg.nix
    ../common/optional/hardware.nix
    ../common/optional/homelab
    ../common/optional/hyprland.nix
    ../common/optional/mtr.nix
    ../common/optional/pipewire.nix
    ../common/optional/polkit.nix
    ../common/optional/qmk.nix
    ../common/optional/udisk.nix
    ../common/optional/virtualisation.nix
    ../common/optional/xdg.nix
    ../common/optional/xserver.nix
  ];

  environment = {
    etc =
      lib.mapAttrs' (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

    systemPackages = with pkgs; [
      git
      neovim
      home-manager
    ];

    variables = {EDITOR = "nvim";};
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  networking = {
    hostName = "nyx";
    networkmanager.enable = true;
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
