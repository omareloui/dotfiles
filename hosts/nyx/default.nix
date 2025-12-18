{
  inputs,
  outputs,
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
    ../common/optional/homelab
    ../common/optional/qmk.nix
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

    kernel.sysctl."kernal.yama.ptrace_scope" = lib.mkOverride 499 0;
  };

  time.timeZone = "Egypt";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  hardware = {
    graphics.enable = true;
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
    pulseaudio.enable = false;

    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    udisks2.enable = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    cron = {
      enable = true;
      systemCronJobs =
        if true
        then [
          "0 0 */1 * * ${config.users.users.omareloui.name} ${outputs.packages.${pkgs.stdenv.hostPlatform.system}.cloud_backup}"
        ]
        else [];
    };

    # solaar = {
    #   enable = true;
    # };
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
