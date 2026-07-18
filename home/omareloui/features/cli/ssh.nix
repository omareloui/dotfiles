{lib, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        Host = "github.com";
        Hostname = lib.mkDefault "github.com";
        IdentityFile = lib.mkDefault "~/.ssh/id_github";
        AddKeysToAgent = "yes";
        AddressFamily = "inet";
        IdentitiesOnly = "yes";
      };
    };
  };

  # Compatibility with programs that don't respect SSH configurations (e.g. jujutsu's libssh2)
  # systemd.user.tmpfiles.rules = [
  #   "L ${config.home.homeDirectory}/.ssh/known_hosts - - - - ${config.programs.ssh.userKnownHostsFile}"
  # ];
}
