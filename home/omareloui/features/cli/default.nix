{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./nvim
    ./yazi
    ./zellij

    ./atuin.nix
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./go.nix
    ./gpg.nix
    ./jujutsu.nix
    ./lazygit.nix
    ./nushell.nix
    ./ssh.nix
    ./starship.nix
    ./thefuck.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    age
    autoconf
    awscli2
    bc
    bison
    bottom
    cloc
    codeium
    corepack_latest
    dconf
    du-dust
    eva
    fd
    ffmpeg
    file
    flex
    gcc
    ghostscript
    git
    imagemagick
    jq
    lsof
    lux
    mpg123
    neofetch
    neovide
    p7zip
    parallel
    patchelf
    pkg-config
    playerctl
    polkit_gnome
    poppler
    pv
    rclone
    rink
    ripgrep
    socat
    sops
    srm
    ssh-to-age
    termdown
    tldr
    trashy
    tree
    unrar
    unzip
    wev
    wget
    wl-clipboard
    yarn
    zip

    # Custom scripts/packages
    # moviesscripts
    sortpics
    gengif
    cloud_backup
    optimize
    zj_sessions

    # Nix Utilities
    nh
    nix-du
    graphviz # For `nix-du`

    # QMK and Keyboards Related
    qmk
    wally-cli

    # Development
    air
    automake
    cargo
    delve
    deno
    entr
    gnumake
    go-mockery
    goose
    grpcui
    grpcurl
    lazydocker
    libclang
    lua
    luarocks
    makeWrapper
    mongodb-compass
    nodejs
    omnisharp-roslyn
    postman
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    rustc
    shc
    sqlc
    sqlite
    sqlitebrowser
    templ

    nodePackages.prisma
    prisma-engines
    openssl
    openssl.dev

    (pkgs.python312.withPackages (ppkgs:
      with ppkgs; [
        django
        inkex
        pip
        pyclipper
      ]))
  ];

  home = {
    sessionPath = [
      "/usr/local/go/bin"
      "$HOME/.local/share/pnpm"
      "$HOME/.cargo/bin"
      "$HOME/.deno/bin"
    ];
    sessionVariables = let
      editor = "nvim";
    in {
      VISUAL = editor;
      EDITOR = editor;

      NVM_DIR = "${config.home.homeDirectory}/.nvm";

      # for pkg-config
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH";

      FLAKE = lib.mkDefault "${config.home.homeDirectory}/.dotfiles";
    };

    shellAliases = {
      edot = "cd ${config.home.sessionVariables.FLAKE}; ${config.home.sessionVariables.EDITOR} .";

      py = "python3";
      pve = "python3 -m venv ./env";
      # pva = "source ./env/bin/activate";

      cat = "bat --color always --plain";
      du = "dust";

      lg = "lazygit";

      docker_clean = "docker builder prune -a --force";
      docker_clean_images = lib.mkDefault "docker rmi $(docker images -a --filter=dangling=true -q)";
      docker_clean_ps = lib.mkDefault "docker rm $(docker ps --filter=status=exited --filter=status=created -q)";

      distro = "cat /etc/*-release | awk -F'=' '/DISTRIB_ID/ {print $2}'";

      pnpx = "pnpm dlx";

      # Nix aliases
      nix = "noglob nix";
      ngen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      hgen = "home-manager generations";

      ngc = "nix-collect-garbage -d; sudo nix-collect-garbage -d";

      nu = "cd ${config.home.sessionVariables.FLAKE};  nix flake update";

      nb = "nh os build";
      ns = "nh os switch";

      hm = "home-manager";
      hb = "nh home build";
      hs = "nh home switch";

      # Zellij aliases
      zj = "zellij";
    };
  };
}
