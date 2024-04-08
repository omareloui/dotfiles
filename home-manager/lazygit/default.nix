{...}: {
  programs.
    lazygit = {
    enable = true;
    settings = {
      gui.showIcons = true;
      git = {
        paging = {
          colorArgs = "always";
          pager = "delta --dark --diff-so-fancy --paging=never --line-numbers";
        };
      };
    };
  };
}
