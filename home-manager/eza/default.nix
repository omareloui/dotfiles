{...}: {
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  home.shellAliases = {
    ls = "eza -l --no-time --icons --sort=type";
    ll = "eza -alg --icons --sort=type";
    la = "eza -al --no-time --icons --sort=type";
    l = "eza";
  };
}
