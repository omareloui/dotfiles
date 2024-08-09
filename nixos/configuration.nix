{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./fonts.nix
    ./home-servers.nix
    ./sops.nix
    ./udev.nix
    ./users.nix

    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {allowUnfree = true;};
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry =
    (lib.mapAttrs (_: flake: {inherit flake;}))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];

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

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
      8384 # Syncthing
      22000 # Syncthing
      7575 # Homarr
      8080 # Openbook
    ];
    firewall.allowedUDPPorts = [
      22000 # Syncthing
      21027 # Syncthing?
    ];
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
    };
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["iwlwifi"];
    extraModprobeConfig = ''
      options iwlwifi bt_coex_active=0
    '';
  };

  time.timeZone = "Egypt";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  hardware = {
    opengl.enable = true;
    pulseaudio.enable = false;
    acpilight.enable = true;
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

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
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
      };
    };

    udisks2.enable = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  security = {
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            ) {
            return polkit.Result.YES;
          }
        })
      '';
    };
    rtkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {default = ["gtk"];};
      pantheon = {
        default = ["pantheon" "gtk"];
        "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      };
      x-cinnamon = {default = ["xapp" "gtk"];};
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs.mtr.enable = true;
  programs.zsh.enable = true;
  programs.light = {
    enable = true;
    brightnessKeys.enable = true;
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
