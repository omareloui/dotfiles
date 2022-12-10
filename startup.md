# Startup Scripts I use

- Start Telegram to tray

  ```bash
  env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/telegram-desktop_telegram-desktop.desktop /snap/bin/telegram-desktop -startintray -- %u
  ```

- CopyQ

  ```bash
  "/usr/bin/copyq"
  ```

- ULauncher

  ```bash
  env GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window
  ```
