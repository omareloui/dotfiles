{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports =
    [
      ./homelab.nix
      ./sops.nix
      ./users.nix
    ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with flake
    registry =
      (lib.mapAttrs (_: flake: {inherit flake;}))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = ["/etc/nix/path"];
  };

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

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3";
    };
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
  };

  time.timeZone = "Egypt";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = let
      gs = "graphical-session.target";
    in {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [gs];
      wants = [gs];
      after = [gs];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };

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

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  programs.zsh.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
