{...}:  {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Omar Eloui";
        email = "contact@omareloui.com";
      };
      ui = {
        allow-init-native = true;
        default-command = "log";
      };
    };
  };
}
