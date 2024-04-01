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
          "FiraCode"
          "DroidSansMono"
          "Inconsolata"
          "JetBrainsMono"
        ];
      })
      (google-fonts.override {
        fonts = [
          "Fira Sans"
          "Zeyada"
          "Great Vibes"
          "WindSong"
          "Luxurious Script"
          "Cairo"
          "Poppins"
          "Cinzel"
          "Cinzel Decorative"
          "Rubik"
        ];
      })
    ];

    fontconfig.defaultFonts = let
      arabic = "Rubik";
      icons = ["font-awesome"];
    in {
      serif = icons ++ ["Ubuntu" arabic];
      sansSerif = icons ++ ["Ubuntu" arabic];
      monospace = icons ++ ["FiraCode" arabic];
    };
  };
}
