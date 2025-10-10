{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        hostname = lib.mkDefault "github.com";
        identityFile = lib.mkDefault "~/.ssh/id_github";
        addKeysToAgent = "yes";
        extraOptions = {
          AddressFamily = "inet";
          IdentitiesOnly = "yes";
        };
      };
    };
  };

  # Compatibility with programs that don't respect SSH configurations (e.g. jujutsu's libssh2)
  # systemd.user.tmpfiles.rules = [
  #   "L ${config.home.homeDirectory}/.ssh/known_hosts - - - - ${config.programs.ssh.userKnownHostsFile}"
  # ];
}
