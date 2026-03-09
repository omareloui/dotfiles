{
  config,
  lib,
  ...
}: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-positionX = "none";
      control-center-positionY = "none";
      control-center-margin-top = 8;
      control-center-margin-bottom = 8;
      control-center-margin-right = 8;
      control-center-margin-left = 8;
      control-center-width = 500;
      control-center-height = 600;
      fit-to-screen = false;

      layer = "overlay";
      control-center-layer = "overlay";
      cssPriority = "user";
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      notification-inline-replies = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = ["inhibitors" "title" "dnd" "mpris" "notifications"];

      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = false;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label text";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };

    style =
      /*
      css
      */
      lib.mkForce ''
        :root {
          /* catppuccin mocha palette */
          --crust: #11111b;
          --base: #1e1e2e;
          --mantle: #181825;
          --surface0: #313244;
          --surface1: #45475a;
          --surface2: #585b70;
          --text: #cdd6f4;
          --subtext0: #a6adc8;
          --subtext1: #bac2de;
          --blue: #89b4fa;
          --sapphire: #74c7ec;
          --red: #f38ba8;
          --maroon: #eba0ac;
          --pink: #f5c2e7;
          --yellow: #f9e2af;

          /* shared values */
          --radius-lg: 12.6px;
          --radius-md: 8px;
          --radius-sm: 7px;
          --radius-xs: 6.3px;
          --padding-base: 7px;
          --padding-lg: 14px;
          --border-inner: inset 0 0 0 1px var(--surface1);
          --shadow-outer: 0 0 8px 0 rgba(0, 0, 0, 0.8);
          --transition-speed: 200ms;
        }

        * {
          all: unset;
          font-size: 14px;
          font-family: "Ubuntu Nerd Font";
          transition: var(--transition-speed);
        }

        /* ── scale / slider ─────────────────────────────────────────── */

        trough highlight {
          background: var(--text);
        }

        scale {
          margin: 0 7px;
        }

        scale trough {
          margin: 0rem 1rem;
          min-height: 8px;
          min-width: 70px;
          border-radius: var(--radius-lg);
        }

        trough slider {
          margin: -10px;
          border-radius: var(--radius-lg);
          box-shadow: 0 0 2px rgba(0, 0, 0, 0.8);
          transition: all 0.2s ease;
          background-color: var(--blue);
        }

        trough slider:hover {
          box-shadow:
            0 0 2px rgba(0, 0, 0, 0.8),
            0 0 8px var(--blue);
        }

        trough {
          background-color: var(--surface0);
        }

        /* ── notifications ──────────────────────────────────────────── */

        .notification-background {
          box-shadow: var(--border-inner);
          border-radius: var(--radius-lg);
          margin: 18px;
          background-color: color-mix(in srgb, var(--mantle) 50%, transparent);
          color: var(--text);
          padding: 0;
        }

        .notification-background:hover {
          background-color: color-mix(in srgb, var(--mantle) 60%, transparent);
        }

        .notification-background .notification {
          padding: var(--padding-base);
          border-radius: var(--radius-lg);
        }

        .notification-background .notification.critical {
          box-shadow: inset 0 0 7px 0 var(--red);
        }

        .notification .notification-content {
          margin: var(--padding-base);
        }

        .notification .notification-content overlay {
          margin: 4px;
        }

        .notification-content .summary {
          color: var(--text);
        }

        .notification-content .time {
          color: var(--subtext0);
        }

        .notification-content .body {
          color: var(--subtext1);
        }

        .notification > *:last-child > * {
          min-height: 3.4em;
        }

        .notification-background .close-button {
          margin: var(--padding-base);
          padding: 2px;
          border-radius: var(--radius-xs);
          color: var(--base);
          background-color: var(--red);
        }

        .notification-background .close-button:hover {
          background-color: var(--maroon);
        }

        .notification-background .close-button:active {
          background-color: var(--pink);
        }

        .notification .notification-action {
          border-radius: var(--radius-sm);
          color: var(--text);
          box-shadow: var(--border-inner);
          margin: 4px;
          padding: 8px;
          font-size: 0.2rem; /* controls button size, not text */
          background-color: var(--surface0);
        }

        .notification .notification-action:hover {
          background-color: var(--surface1);
        }

        .notification .notification-action:active {
          background-color: var(--surface2);
        }

        .notification.critical progress {
          background-color: var(--red);
        }

        .notification.low progress,
        .notification.normal progress {
          background-color: var(--blue);
        }

        .notification progress,
        .notification trough,
        .notification progressbar {
          border-radius: var(--radius-lg);
          padding: 3px 0;
        }

        /* ── control center ─────────────────────────────────────────── */

        .control-center {
          border-radius: var(--radius-lg);
          background-color: color-mix(in srgb, var(--base) 50%, transparent);
          color: var(--text);
          padding: var(--padding-lg);
        }

        .control-center .notification-background {
          border-radius: var(--radius-sm);
          box-shadow: var(--border-inner);
          margin: 4px 10px;
        }

        .control-center .notification-background .notification {
          border-radius: var(--radius-sm);
        }

        .control-center .notification-background .notification.low {
          opacity: 0.8;
        }

        .control-center .widget-title > label {
          color: var(--text);
          font-size: 1.3em;
        }

        .control-center .widget-title button {
          border-radius: var(--radius-sm);
          color: var(--text);
          background-color: var(--surface0);
          box-shadow: var(--border-inner);
          padding: 8px;
        }

        .control-center .widget-title button:hover {
          background-color: var(--surface1);
        }

        .control-center .widget-title button:active {
          background-color: var(--surface2);
        }

        .control-center .notification-group {
          margin-top: 10px;
        }

        .control-center .notification-group:focus .notification-background {
          background-color: var(--surface0);
        }

        /* ── scrollbar ──────────────────────────────────────────────── */

        scrollbar slider {
          margin: -3px;
          opacity: 0.8;
        }

        scrollbar trough {
          margin: 2px 0;
        }

        /* ── dnd ────────────────────────────────────────────────────── */

        .widget-dnd {
          margin-top: 5px;
          border-radius: var(--radius-md);
          font-size: 1.1rem;
        }

        .widget-dnd > switch {
          font-size: initial;
          border-radius: var(--radius-md);
          background: var(--surface0);
          box-shadow: none;
        }

        .widget-dnd > switch:checked {
          background: var(--blue);
        }

        .widget-dnd > switch slider {
          background: var(--surface1);
          border-radius: var(--radius-md);
        }

        /* ── mpris ───────────────────────────────────────────────────── */

        .widget-mpris-player {
          background: var(--surface0);
          border-radius: var(--radius-lg);
          color: var(--text);
        }

        .mpris-overlay {
          background-color: var(--surface0);
          opacity: 0.9;
          padding: 15px 10px;
        }

        .widget-mpris-album-art {
          /* gtk4: -gtk-icon-size replaced with explicit sizing */
          min-width: 100px;
          min-height: 100px;
          border-radius: var(--radius-lg);
          margin: 0 10px;
        }

        .widget-mpris-title {
          font-size: 1.2rem;
          color: var(--text);
        }

        .widget-mpris-subtitle {
          font-size: 1rem;
          color: var(--subtext1);
        }

        .widget-mpris button {
          border-radius: var(--radius-lg);
          color: var(--text);
          margin: 0 5px;
          padding: 2px;
        }

        .widget-mpris button image {
          /* gtk4: -gtk-icon-size replaced with explicit sizing */
          min-width: 1.8rem;
          min-height: 1.8rem;
        }

        .widget-mpris button:hover {
          background-color: var(--surface0);
        }

        .widget-mpris button:active {
          background-color: var(--surface1);
        }

        .widget-mpris button:disabled {
          opacity: 0.5;
        }

        /* ── menubar / power / screenshot ───────────────────────────── */

        .widget-menubar > box > .menu-button-bar > button > label {
          font-size: 3rem;
          padding: 0.5rem 2rem;
        }

        .widget-menubar > box > .menu-button-bar > :last-child {
          color: var(--red);
        }

        .power-buttons button:hover,
        .powermode-buttons button:hover,
        .screenshot-buttons button:hover {
          background: var(--surface0);
        }

        /* ── widgets ─────────────────────────────────────────────────── */

        .control-center .widget-label > label {
          color: var(--text);
          font-size: 2rem;
        }

        .widget-buttons-grid {
          padding-top: 1rem;
        }

        .widget-buttons-grid > flowbox > flowboxchild > button label {
          font-size: 2.5rem;
        }

        /* ── volume ──────────────────────────────────────────────────── */

        .widget-volume {
          padding: 1rem 0;
        }

        .widget-volume label {
          color: var(--sapphire);
          padding: 0 1rem;
        }

        .widget-volume trough highlight {
          background: var(--sapphire);
        }

        /* ── backlight ───────────────────────────────────────────────── */

        .widget-backlight trough highlight {
          background: var(--yellow);
        }

        .widget-backlight label {
          font-size: 1.5rem;
          color: var(--yellow);
        }

        .widget-backlight .KB {
          padding-bottom: 1rem;
        }

        .image {
          padding-right: 0.5rem;
        }
      '';
  };

  services.swayosd = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings = lib.mkIf config.services.swayosd.enable {
    bind = [
      ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

      ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
    ];
  };

  home.file.".config/swayosd/style.css".text =
    lib.mkIf config.services.swayosd.enable
    /*
    css
    */
    ''
      :root {
        --base: #1e1e2e;
        --mantle: #181825;
        --surface0: #313244;
        --surface1: #45475a;
        --surface2: #585b70;
        --text: #cdd6f4;
        --subtext1: #bac2de;
        --blue: #89b4fa;
        --sapphire: #74c7ec;
        --red: #f38ba8;
        --yellow: #f9e2af;
        --radius-lg: 12.6px;
      }

      /* ── osd window ─────────────────────────────────────────────── */

      window#osd {
        padding: 12px 20px;
        border: 1px solid var(--surface1);
        background: alpha(var(--base), 0.3);
      }

      /* ── icon ────────────────────────────────────────────────────── */

      window#osd image {
        color: var(--text);
        margin-right: 10px;
        min-width: 24px;
        min-height: 24px;
      }

      /* ── text label (caps lock, etc.) ────────────────────────────── */

      window#osd label {
        color: var(--text);
        font-family: "Ubuntu Nerd Font";
        font-size: 14px;
      }

      /* ── level bar (volume / brightness) ─────────────────────────── */

      window#osd levelbar {
        min-height: 8px;
        border-radius: var(--radius-lg);
      }

      window#osd levelbar trough {
        background-color: var(--surface0);
        border-radius: var(--radius-lg);
        min-height: 8px;
        padding: 0;
      }

      window#osd levelbar trough block.filled {
        background-color: var(--blue);
        border-radius: var(--radius-lg);
      }

      window#osd levelbar trough block.empty {
        background-color: var(--surface0);
        border-radius: var(--radius-lg);
      }

      /* ── progress bar fallback (older swayosd) ───────────────────── */

      window#osd progressbar {
        min-height: 8px;
        border-radius: var(--radius-lg);
      }

      window#osd progressbar trough {
        background-color: var(--surface0);
        border-radius: var(--radius-lg);
        min-height: 8px;
      }

      window#osd progressbar progress {
        background-color: var(--blue);
        border-radius: var(--radius-lg);
        min-height: 8px;
      }

      /* ── muted state ─────────────────────────────────────────────── */

      window#osd.muted levelbar trough block.filled,
      window#osd.muted progressbar progress {
        background-color: var(--red);
      }

      window#osd.muted image {
        color: var(--red);
      }

      /* ── brightness overrides ────────────────────────────────────── */

      window#osd.brightness levelbar trough block.filled,
      window#osd.brightness progressbar progress {
        background-color: var(--yellow);
      }

      window#osd.brightness image {
        color: var(--yellow);
      }

      /* ── caps / num / scroll lock ────────────────────────────────── */

      window#osd.caps-lock image,
      window#osd.num-lock image,
      window#osd.scroll-lock image {
        color: var(--text);
      }

      window#osd.caps-lock-on image,
      window#osd.num-lock-on image,
      window#osd.scroll-lock-on image {
        color: var(--blue);
      }
    '';
}
