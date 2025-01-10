{
  inputs,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.0;};
      width = {fraction = 0.3;};
      height = {absolute = 0;};

      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.dictionary
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.shell
        inputs.anyrun.packages.${pkgs.system}.symbols
        inputs.anyrun.packages.${pkgs.system}.translate
        inputs.anyrun.packages.${pkgs.system}.websearch
        "libcurrency.so"
      ];
    };

    extraCss =
      /*
      css
      */
      ''
        #window {
          background: none;
          border: none;
        }
      '';
  };

  home.file.".config/anyrun/plugins/libcurrency.so".source = ./plugins/currency/builds/libcurrency-0.1.0.so;
}
