{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      ubuntu_font_family
      font-awesome
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts

      nerd-fonts.dejavu-sans-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.inconsolata
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only

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
