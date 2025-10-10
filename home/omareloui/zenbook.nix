{inputs, ...}: let
  gpg_client = "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe";
in {
  imports = [
    ./global
  ];

  services.gpg-agent = {
    pinentry.package = null;
    extraConfig = ''
      pinentry-program "${gpg_client}"
    '';
  };

  programs.git = {
    signing.key = "52F14BEFFC734AFA";
    extraConfig = {
      gpg.openpgp.program = [];
    };
  };
}
