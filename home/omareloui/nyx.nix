{
  inputs,
  config,
  ...
}: {
  imports = [
    ./global
    ./features/desktop
  ];

  colorScheme = inputs.nix-colors.lib.schemeFromYAML "folke-tokyo-night-dark" (builtins.readFile ./assets/themes/folke-tokyo-night-dark.yaml);

  home = {
    sessionVariables = let
      h = config.home.homeDirectory;
      mh = config.home.sessionVariables.MYHOME;
    in {
      MYHOME = "${h}/myhome";

      DOWNLOADS_DIR = "${mh}/downloads";
      MOVIES_DIR = "${mh}/movies";
      REPOS_DIR = "${mh}/repos";
      PICS_DIR = "${mh}/pictures";
      WALLPAPERS_DIR = "${mh}/pictures/wallpapers/.loop_over";
    };

    shellAliases = {
      # BtrFS aliases
      # https://marc.merlins.org/perso/btrfs/post_2014-05-04_Fixing-Btrfs-Filesystem-Full-Problems.html
      btrfs_balance = "(sudo btrfs balance start -musage=0 / && sudo btrfs balance start -dusage=0 / && sudo btrfs balance start -dusage=20 / &) && while :; do sudo btrfs balance status -v /; sleep 60; done";
      btrfs_df = "sudo btrfs filesystem usage /";
      btrfs_show = "sudo btrfs filesystem show";

      depgraph = "nix-du | dot -Tsvg | display";
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = let
    day = 86400;
  in {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;

    defaultCacheTtl = day;
    maxCacheTtl = day;
  };

  services.udiskie.enable = true;

  programs.git = {
    signing.key = "7CA07EEDEEF445E9";
    extraConfig.core.sshCommand = "ssh -i ~/.ssh/id_github_ed25519";
  };
}
