{...}: {
  programs.
    lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        showFileTree = false;
        nerdFontsVersion = "3";
      };
      git = {
        paging = {
          colorArgs = "always";
          pager = "delta --dark --diff-so-fancy --paging=never --line-numbers";
        };
      };
    };
  };
}
