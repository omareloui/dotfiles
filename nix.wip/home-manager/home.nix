{ inputs, outputs, lib, config, pkgs, ... }: {
  home.stateVersion = "23.11";

  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  systemd.user.startServices = "sd-switch";
  home = {
    username = "omareloui";
    homeDirectory = "/home/omareloui";
  };

  # home.packages = with pkgs; [ ];

  programs.yazi.enable = true;
  home.file.".config/yazi/plugins/smart-enter.yazi/init.lua".text = ''
    return {
    	entry = function()
    		local h = cx.active.current.hovered
    		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", {})
    	end,
    }
  '';
  programs.yazi.settings = {
    manager = {
      ratio = [ 1 4 3 ];
      linemode = "size";

    };
  };
  programs.yazi.keymap = {
    manager = {
      prepend_keymap = [
        {
          on = [ "l" ];
          exec = "plugin --sync smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = [ "w" ];
          exec = "shell --confirm 'wallpaper $1'";
          desc = "Set the image as wallpaper";
        }
        {
          on = [ "A" ];
          exec = ''
            shell --block --confirm '
              read -p "Write directory name: " dir
              mkdir -p $dir
              mv $@ $dir
            '
          '';
          desc = "Add selected to a new directory";
        }
        {
          on = [ "F" ];
          exec = ''
            shell --confirm '
              for folder in $@; do
                if [[ -d $folder ]]; then
                  fd -IHd1 . "$folder" | xargs -I{} mv {} .
                  rmdir "$folder"
                fi
              done
            '
          '';
          desc = "Flatten the selected directories";
        }

      ];
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # TODO: needs configuration the nix way
  # programs.zsh.enable = true;

  # TODO: doesn't work for now!
  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

}
