{...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        hostname = "github.com";
        identityFile = "~/.ssh/id_rsa_github";
      };
      "gitlab.com" = {
        host = "gitlab.com";
        hostname = "gitlab.com";
        identityFile = "~/.ssh/id_rsa_gitlab";
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
    extraConfig = '''';
  };
}
