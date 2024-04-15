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
      font-awesome
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      (nerdfonts.override {
        fonts = [
          "DejaVuSansMono"
          "DroidSansMono"
          "FiraCode"
          "Inconsolata"
          "Iosevka"
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
        ];
      })
      (google-fonts.override {
        fonts = [
          "Cairo"
          "Cinzel Decorative"
          "Cinzel"
          "Fira Sans"
          "Great Vibes"
          "Luxurious Script"
          "Poppins"
          "Rubik"
          "WindSong"
          "Zeyada"
        ];
      })
    ];

    fontconfig.defaultFonts = let
      arabic = "Rubik";
      icons = ["font-awesome"];
    in {
      serif = icons ++ ["Ubuntu" arabic];
      sansSerif = icons ++ ["Ubuntu" arabic];
      monospace = icons ++ ["NerdFontsSymbolsOnly" "Iosevka" arabic];
    };
  };
}
