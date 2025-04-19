{
  inputs,
  config,
  ...
}: let
  gpg_client = "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe";
in {
  imports = [
    ./global
  ];

  colorScheme = inputs.nix-colors.lib.schemeFromYAML "folke-tokyo-night-dark" (builtins.readFile ./assets/themes/folke-tokyo-night-dark.yaml);

  home = {
    sessionVariables = let
      h = config.home.homeDirectory;
    in {
      # Used by the nix helper `nh`
      FLAKE = "${h}/.dotfiles";
    };

    shellAliases = {
      "." = "cd ${config.home.sessionVariables.FLAKE} && ${config.home.sessionVariables.EDITOR}";

      q = "exit";
      ":q" = "exit";
    };
  };

  services.gpg-agent = {
    pinentryPackage = null;
    extraConfig = ''
      pinentry-program "${gpg_client}"
    '';
  };

  programs.git.extraConfig.gpg.openpgp.program = [];
}
