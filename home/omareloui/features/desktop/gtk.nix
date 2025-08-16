{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (builtins) hashString toJSON;
  rendersvg = pkgs.runCommand "rendersvg" {} ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
  materiaTheme = name: colors:
    pkgs.stdenv.mkDerivation {
      name = "generated-gtk-theme";
      src = pkgs.fetchFromGitHub {
        owner = "nana-4";
        repo = "materia-theme";
        rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
        sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
      };
      buildInputs = with pkgs; [
        sassc
        bc
        which
        rendersvg
        meson
        ninja
        nodePackages.sass
        gtk4.dev
        optipng
      ];
      phases = ["unpackPhase" "installPhase"];
      installPhase = ''
        HOME=/build
        chmod 777 -R .
        patchShebangs .
        mkdir -p $out/share/themes
        mkdir bin
        sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

        cat > /build/gtk-colors << EOF
          BTN_BG=${colors.base01}
          BTN_FG=${colors.base07}
          BG=${colors.base00}
          FG=${colors.base07}
          HDR_BTN_BG=${colors.base02}
          HDR_BTN_FG=${colors.base07}
          ACCENT_BG=${colors.base0D}
          ACCENT_FG=${colors.base00}
          HDR_BG=${colors.base00}
          HDR_FG=${colors.base07}
          MATERIA_SURFACE=${colors.base00}
          MATERIA_VIEW=${colors.base01}
          MENU_BG=${colors.base00}
          MENU_FG=${colors.base07}
          SEL_BG=${colors.base0D}
          SEL_FG=${colors.base00}
          TXT_BG=${colors.base00}
          TXT_FG=${colors.base07}
          WM_BORDER_FOCUS=${colors.base0D}
          WM_BORDER_UNFOCUS=${colors.base03}
          UNITY_DEFAULT_LAUNCHER_STYLE=False
          NAME=${name}
          MATERIA_STYLE_COMPACT=True
        EOF

        echo "Changing colours:"
        ./change_color.sh -o ${name} /build/gtk-colors -i False -t "$out/share/themes"
        chmod 555 -R .
      '';
    };
in rec {
  gtk = {
    enable = true;
    font = {
      inherit (config.fontProfiles.regular) name size;
    };
    theme = let
      inherit (config.colorScheme) mode palette;
      name = "generated-${hashString "md5" (toJSON palette)}-${mode}";
    in {
      inherit name;
      package = materiaTheme name (
        lib.mapAttrs (_: v: lib.removePrefix "#" v) palette
      );
    };
    iconTheme = {
      # name = "Papirus-${
      #   if config.colorscheme.mode == "dark"
      #   then "Dark"
      #   else "Light"
      # }";
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
      "Net/IconThemeName" = "${gtk.iconTheme.name}";
    };
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
