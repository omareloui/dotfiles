{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.3;};
      width = {fraction = 0.3;};
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libdictionary.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libshell.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/libtranslate.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
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

  home.file.".config/anyrun/plugins/libcurrency.so".source =
    lib.mkIf config.programs.anyrun.enable
    ./plugins/currency/builds/libcurrency-0.1.1.so;
}
