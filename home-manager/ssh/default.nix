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
    };
    extraConfig = ''
      Host 192.168.1.8
      User omar
      PubkeyAcceptedAlgorithms +ssh-rsa
      HostkeyAlgorithms +ssh-rsa

      Host 192.168.1.11
      User omar
      PubkeyAcceptedAlgorithms +ssh-rsa
      HostkeyAlgorithms +ssh-rsa
    '';
  };
}
