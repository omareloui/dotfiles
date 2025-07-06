{inputs, ...}: let
  gpg_client = "/mnt/c/Program Files (x86)/GnuPG/bin/pinentry-basic.exe";
in {
  imports = [
    ./global
  ];

  colorScheme = inputs.nix-colors.lib.schemeFromYAML "folke-tokyo-night-dark" (builtins.readFile ./assets/themes/folke-tokyo-night-dark.yaml);

  services.gpg-agent = {
    pinentry.package = null;
    extraConfig = ''
      pinentry-program "${gpg_client}"
    '';
  };

  programs.git = {
    signing.key = "973834CA43700F55";
    extraConfig = {
      gpg.openpgp.program = [];
    };
  };

  programs.ssh.matchBlocks."github.com" = {
    hostname = "ssh.github.com";
    port = 443;
  };
}
