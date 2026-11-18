{
  config,
  inputs,
  ...
}: {
  imports = [inputs.nix-index-database.homeModules.nix-index];

  programs = {
    pay-respects = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    nix-index = {
      enable = config.programs.pay-respects.enable;
      enableZshIntegration = false;
      enableBashIntegration = false;
      enableFishIntegration = false;
    };

    nix-index-database.comma.enable = false;
  };
}
