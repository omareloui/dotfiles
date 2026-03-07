{...}: {
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      GUI = {
        ApplicationTheme = "dark";
        HidePasswords = false;

        MinimizeOnStartup = true;
        ShowTrayIcon = true;
        MinimizeToTray = true;
        MinimizeOnClose = true;
      };
      Browser = {
        Enabled = true;
      };

      General = {
        ConfigVersion = 2;
        UseAtomicSaves = false;
      };

      KeeShare = {
        Active = "<?xml version=\"1.0\"?><KeeShare><Active/></KeeShare>\n";
        QuietSuccess = true;
      };

      PasswordGenerator = {
        Length = 16;
      };

      Security = {
        ClearClipboardTimeout = 20;
        LockDatabaseIdle = false;
        LockDatabaseScreenLock = false;
      };
    };
  };
}
