{pkgs, ...}: {
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  home.packages = with pkgs; [
    nix-search
  ];
}
