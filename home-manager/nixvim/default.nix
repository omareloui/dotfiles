{
  config,
  pkgs,
  ...
}: let
  extraPackages = with pkgs; [
    # astro-language-server
    # buf
    # buf-language-server
    # buildifier
    # elixir-ls
    # nixfmt
    # prisma-language-server
    # templ
    alejandra
    dockerfile-language-server-nodejs
    emmet-ls
    eslint_d
    gitlint
    golangci-lint
    gopls
    hadolint
    htmlhint
    lua-language-server
    luajitPackages.luacheck
    markdownlint-cli
    marksman
    nil
    nodePackages.bash-language-server
    nodePackages.cspell
    nodePackages.prisma
    nodePackages.sql-formatter
    nodePackages.typescript-language-server
    nodePackages.volar
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    prettierd
    shellcheck
    shfmt
    shfmt
    sqlfluff
    stylua
    tailwindcss-language-server
    yaml-language-server
    yamlfmt
    yamllint
  ];
in {
  programs.nixvim = {
    inherit extraPackages;

    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.base16 = {
      enable = true;
      package = pkgs.vimPlugins.base16-vim;
      customColorScheme = config.colorScheme.palette;
    };

    options = let
      undodir = config.home.homeDirectory + "/.cache/nvim/undodir";
    in {
      inherit undodir;
      autowrite = true;
      guifont = ["" ":h10"];
      swapfile = false;
      colorcolumn = ["80" "120"];
      # cursorcolumn = true;
      cursorline = true;
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      fillchars = {
        eob = " ";
        foldopen = "";
        foldclose = "";
      };
      hlsearch = false;
      linebreak = true;
      list = true;
      # conceallevel = 2;
      listchars = {
        tab = "» ";
        lead = "·";
        trail = "·";
        eol = "↲";
        nbsp = "☠";
      };
      relativenumber = true;
      scrolloff = 4;
      sidescrolloff = 4;
      spell = false;
      # spelllang = ["en_us"];
      # spelloptions = "camel";
      wrap = false;
      laststatus = 3; # -- global statusline;
      showmode = false;
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      softtabstop = 2;
      tabstop = 2;
      ignorecase = true;
      mouse = "";
      smartcase = true;
      number = true;
      numberwidth = 2;
      ruler = false;
      signcolumn = "yes";
      splitbelow = true;
      splitright = true;
      termguicolors = true;
      undofile = true;
      timeoutlen = 300;
      updatetime = 200;
      diffopt = "vertical";
      cmdheight = 1;
      # smoothscroll = true;

      # go to previous/next line with h,l,left arrow and right arrow;
      # when cursor reaches end/beginning of line;
      # whichwrap:append "<>[]hl"
      # opt.whichwrap:append "<>[]hl"

      # considers "-" as a part of a word.
      # opt.iskeyword:append "-"

      # TODO: add this auto cmds
      # stop continuous comments;
      # vim.api.nvim_create_autocmd("FileType", { command = "set formatoptions-=cro" })
    };

    # keymaps = [
    #   {
    #     action = "<Cmd>make<CR>";
    #     key = "<C-m>";
    #     lua = false;
    #     mode = ["n"];
    #     options = {
    #       silent = true;
    #       desc = "Make the project";
    #     };
    #   }
    # ];
  };
}
