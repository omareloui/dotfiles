{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        hostname = lib.mkDefault "github.com";
        identityFile = "~/.ssh/id_github";
        extraOptions = {
          AddressFamily = "inet";
          IdentitiesOnly = "yes";
        };
      };
      "gitlab.com" = {
        host = "gitlab.com";
        hostname = "gitlab.com";
      };
      "trustclaim" = {
        host = "68.183.144.184";
        hostname = "68.183.144.184";
        identityFile = "~/.ssh/id_trustclaim";
      };
      "mobile" = {
        host = "192.168.1.8";
        user = "omar";
        extraOptions = {
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
          HostkeyAlgorithms = "+ssh-rsa";
        };
      };
      "pc" = {
        host = "192.168.1.11";
        user = "omar";
        extraOptions = {
          PubkeyAcceptedAlgorithms = "+ssh-rsa";
          HostkeyAlgorithms = "+ssh-rsa";
        };
      };
    };
  };

  # Compatibility with programs that don't respect SSH configurations (e.g. jujutsu's libssh2)
  systemd.user.tmpfiles.rules = [
    "L ${config.home.homeDirectory}/.ssh/known_hosts - - - - ${config.programs.ssh.userKnownHostsFile}"
  ];
}
