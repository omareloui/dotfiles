{lib, ...}: {
  time.timeZone = "Egypt";
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "ar_EG.UTF-8/UTF-8"
    ];
  }
  time.timeZone = lib.mkDefault "Egypt";
}
