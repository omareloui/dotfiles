{...}: let
  user = {
    name = "Omar Eloui";
    email = "contact@omareloui.com";
  };
in {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = user;
      ui = {
        allow-init-native = true;
        default-command = "log";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;

    extraConfig = {
      user.signingKey = "contact@omareloui.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      commit.gpgSign = true;
      tag.gpgSign = true;
      core = {
        editor = "nvim";
        sshCommand = "ssh -i ~/.ssh/id_rsa_github";
      };
    };

    delta = {
      enable = false;
      options = {
        side-by-side = true;
        diff-so-fancy = true;
        line-numbers = true;
      };
    };

    aliases = {
      uc = "reset HEAD^ --soft";
      uncommit = "reset HEAD^ --soft";
      l = ''
        log --pretty=format:"%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --graph --date=relative --decorate --all'';
    };
  };
}
