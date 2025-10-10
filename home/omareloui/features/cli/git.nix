{lib, ...}: let
  user = {
    name = "Omar Eloui";
    email = "contact@omareloui.com";
  };
in {
  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;

    signing = {
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      commit.verbose = true;
      column.ui = "auto";
      branch.sort = "committerdate";
      rerere.enabled = true;

      core = {
        editor = "nvim";
        sshCommand = lib.mkDefault "ssh -i ~/.ssh/id_github";
      };
    };

    delta = {
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        paging = "never";
      };
    };

    aliases = {
      uc = "reset HEAD^ --soft";
      uncommit = "reset HEAD^ --soft";
      stash = "stash --all";
      l = ''
        log --pretty=format:"%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --graph --date=relative --decorate --all'';
      p = "pull --ff-only";
      ff = "merge --ff-only";
      graph = "log --decorate --oneline --graph";
      pushall = "!git remote | xargs -L1 git push --all";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
      sync = "!MAIN_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p') git switch --detach --quiet HEAD && git fetch origin $MAIN_BRANCH:$MAIN_BRANCH && git switch --quiet -";
    };

    ignores = [
      ".direnv"
      "result"
      ".jj"
    ];
  };
}
