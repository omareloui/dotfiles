{...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
        showFileTree = false;
        nerdFontsVersion = "3";
      };
      git = {
        paging.pager = "delta";
      };
    };
  };
}
