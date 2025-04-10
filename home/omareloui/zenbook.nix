{
  inputs,
  config,
  ...
}: {
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
}
