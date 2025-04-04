{...}: {
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  home.shellAliases = let
    defaultLs = "eza -l --no-time --icons --sort=type --no-quotes --git";
  in {
    ls = defaultLs;
    la = "${defaultLs} -a";
    ll = "eza -agl --icons --sort=type --no-quotes --git --links";
    lll = "eza -aglo --icons --sort=type --no-quotes --git --git-repos-no-status --links";
    lt = "eza --icons --sort=type --tree --level 5";
    l = "eza";
  };
}
