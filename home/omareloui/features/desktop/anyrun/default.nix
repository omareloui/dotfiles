{pkgs, ...}: let
  buildAnyrunPlugin = import ./lib/build-anyrun-plugin.nix {inherit pkgs;};

  pluginsOutputHashes = {
    "anyrun-interface-25.12.0" = "sha256-zcKI1OUg+Ukst0nasodrhKgBi61XT8vbvdK6/nuuApk=";
    "anyrun-macros-25.12.0" = "sha256-KEEJLERvo04AsPo/SWHFJUmHaGGOVjUoGwA9e8GVIQQ=";
  };
in {
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
      maxEntries = 15;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libkidex.so"
        "${pkgs.anyrun}/lib/libnix_run.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libstdin.so"
        "${pkgs.anyrun}/lib/libtranslate.so"
        "${pkgs.anyrun}/lib/libdictionary.so"
        "${pkgs.anyrun}/lib/libniri_focus.so"
        "${pkgs.anyrun}/lib/librandr.so"
        "${pkgs.anyrun}/lib/libshell.so"
        # "${pkgs.anyrun}/lib/libsymbols.so"

        (
          (buildAnyrunPlugin
            {
              name = "currency";
              version = "0.1.2";
              src = ./plugins/currency;
              cargoLock = {
                lockFile = ./plugins/currency/Cargo.lock;
                outputHashes = pluginsOutputHashes;
              };
              buildInputs = [pkgs.openssl];
            })
          + "/lib/libcurrency.so"
        )

        (
          (buildAnyrunPlugin
            {
              name = "websearchplus";
              version = "0.1.2";
              src = ./plugins/websearchplus;
              cargoLock = {
                lockFile = ./plugins/websearchplus/Cargo.lock;
                outputHashes = pluginsOutputHashes;
              };
              buildInputs = [pkgs.openssl];
            })
          + "/lib/libwebsearchplus.so"
        )
      ];
    };

    extraConfigFiles = {
      "nix-run.ron".text =
        /*
        ron
        */
        ''
          Config(
            prefix: ":nr ",
            allow_unfree: true,
            channel: "nixpkgs-unstable",
            max_entries: 15,
          )
        '';

      "websearchplus.ron".text =
        /*
        ron
        */
        ''
          Config(
            prefix: "?",
            engines: [
              Google,
              Custom(
                name: "YouTube",
                url: "youtube.com/results?search_query={}",
                secondary_prefix: "yt",
              )
            ]
          )
        '';

      "stdin.ron".text =
        /*
        ron
        */
        ''
          Config(
            allow_invalid: false,
            max_entries: 10,
            preserve_order: false,
          )
        '';
    };

    extraCss =
      /*
      css
      */
      ''
        /* ===== Color variables ===== */
        :root {
          --bg-color: #313244;
          --fg-color: #cdd6f4;
          --primary-color: #89b4fa;
          --secondary-color: #cba6f7;
          --border-color: var(--primary-color);
          --selected-bg-color: var(--primary-color);
          --selected-fg-color: var(--bg-color);
        }

        /* ===== Global reset ===== */
        * {
          all: unset;
          font-family: "JetBrainsMono Nerd Font", monospace;
        }

        /* ===== Transparent window ===== */
        window {
          background: transparent;
        }

        /* ===== Main container ===== */
        box.main {
          border-radius: 16px;
          background-color: color-mix(in srgb, var(--bg-color) 30%, transparent);
          padding: 12px; /* add uniform padding around the whole box */
        }

        /* ===== Input field ===== */
        text {
          font-size: 1.3rem;
          background: transparent;
          /* border: 1px solid var(--border-color); */
          border-radius: 16px;
          padding: 5px 10px;
          min-height: 44px;
          caret-color: var(--primary-color);
        }

        /* ===== List container ===== */
        .matches {
          background-color: transparent;
        }

        /* ===== Single match row ===== */
        .match {
          font-size: 1.1rem;
          padding: 4px 10px; /* tight vertical spacing */
          border-radius: 6px;
        }

        /* Remove default label margins */
        .match * {
          margin: 0;
          padding: 0;
          line-height: 1;
        }

        /* Selected / hover state */
        .match:selected,
        .match:hover {
          background-color: var(--selected-bg-color);
          color: var(--selected-fg-color);
        }

        .match:selected label.plugin.info,
        .match:hover label.plugin.info {
          color: var(--selected-fg-color);
        }

        .match:selected label.match.description,
        .match:hover label.match.description {
          color: color-mix(in srgb, var(--selected-fg-color) 90%, transparent);
        }

        /* ===== Plugin info label ===== */
        label.plugin.info {
          color: var(--fg-color);
          font-size: 1rem;
          min-width: 160px;
          text-align: left;
        }

        /* ===== Description label ===== */
        label.match.description {
          font-size: 0.8rem;
          margin-top: 0.2rem;
          color: var(--fg-color);
        }
      '';
  };
}
