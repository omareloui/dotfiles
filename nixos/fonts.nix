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
        ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = ["Cairo" "Ubuntu"];
      sansSerif = ["Cairo" "Ubuntu"];
      monospace = ["Cairo" "FiraCode"];
    };
  };
}