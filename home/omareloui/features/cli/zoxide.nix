{config, ...}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = let
    h = config.home.homeDirectory;
  in{
    _ZO_EXCLUDE_DIRS = "${h}/**/.private/**:${h}/**/.private";
  };
}
