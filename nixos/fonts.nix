{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      ubuntu_font_family
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
          "Inconsolata"
          "JetBrainsMono"
        ];
      })
      (google-fonts.override {
        fonts = [
          "Zeyada"
          "Great Vibes"
          "WindSong"
          "Luxurious Script"
          "Cairo"
          # "Poppins"
          # "Cinzel"
          # "Cinzel Decorative"
        ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = ["Ubuntu" "Cairo"];
      sansSerif = ["Ubuntu" "Cairo"];
      monospace = ["FiraCode" "Cairo"];
    };
  };
}
