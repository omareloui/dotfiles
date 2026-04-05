{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
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
    ./nvim.nix
    ./pay-respects.nix
    ./qmk.nix
    ./ssh.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    age
    android-file-transfer
    autoconf
    bc
    bison
    bottom
    claude-code
    cloc
    codeium
    dconf
    dust
    dysk
    eva
    fastfetch
    fd
    ffmpeg
    file
    flex
    gcc
    ghostscript
    git
    gvfs
    imagemagick
    jq
    lsof
    lux
    mpg123
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
    zip

    # pandoc # transform between markup formats (e.g. markdown to pdf)
    # texliveFull # For `pandoc`. NOTE: this is a large package

    # Custom scripts/packages
    cloud_backup
    genpdf
    gengif
    optimize
    sortpics
    zj_sessions

    # Nix Utilities
    nh
    nix-du
    graphviz # For `nix-du`

    ### Development ###
    # Go
    air
    delve
    go-mockery
    goose
    sqlc
    templ

    # Clang
    libclang
    clang-manpages
    linux-manual # docs for C
    man-pages # docs for C
    man-pages-posix # docs for C

    # Rust
    rustc
    cargo

    # JS
    deno
    nodejs
    # corepack
    # nodePackages.prisma
    # prisma-engines

    # Lua
    lua
    luarocks

    # Python
    (pkgs.python314.withPackages (ppkgs:
      with ppkgs; [
        django
        inkex
        pip
        pyclipper
      ]))

    # Shell
    shc

    # ProtoBuffers
    grpcui
    grpcurl
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # DB
    sqlite
    mongodb-compass
    sqlitebrowser

    # Build tools
    automake
    gnumake
    makeWrapper

    # Misc
    # awscli2
    entr
    lazydocker
    openssl
    openssl.dev
    postman

    # tree-sitter-cli for nvim
    (pkgs.rustPlatform.buildRustPackage rec {
      pname = "tree-sitter-cli";
      version = "0.26.1";

      src = pkgs.fetchFromGitHub {
        owner = "tree-sitter";
        repo = "tree-sitter";
        rev = "v${version}";
        hash = "sha256-k8X2qtxUne8C6znYAKeb4zoBf+vffmcJZQHUmBvsilA=";
      };

      cargoLock = {
        lockFile = "${src}/Cargo.lock";
      };

      cargoBuildFlags = ["-p" "tree-sitter-cli"];

      doCheck = false;

      nativeBuildInputs = with pkgs; [
        pkg-config
      ];

      buildInputs = with pkgs;
        [openssl clang glibc llvmPackages.libclang]
        ++ lib.optionals stdenv.isDarwin [darwin.apple_sdk.frameworks.Security];

      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
      BINDGEN_EXTRA_CLANG_ARGS = "-isystem ${pkgs.glibc.dev}/include";
    })
  ];

  home = {
    sessionPath = [
      "/usr/local/go/bin"
      "$HOME/.local/share/pnpm"
      "$HOME/.cargo/bin"
      "$HOME/.deno/bin"
    ];
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";

      NVM_DIR = "${config.home.homeDirectory}/.nvm";

      # for pkg-config
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH";

      FLAKE = lib.mkDefault "${config.home.homeDirectory}/.dotfiles";
      NH_FLAKE = config.home.sessionVariables.FLAKE;
    };

    shellAliases = {
      edot = lib.mkDefault "cd ${config.home.sessionVariables.FLAKE} && ${config.home.sessionVariables.EDITOR} .";

      py = "python3";
      pve = "python3 -m venv ./env";
      pva = lib.mkDefault "source ./env/bin/activate";

      cat = "bat --color always --plain";
      du = "dust";

      df = "dysk";

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
      ngc = lib.mkDefault "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      nu = lib.mkDefault "cd ${config.home.sessionVariables.FLAKE} && nix flake update";

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
