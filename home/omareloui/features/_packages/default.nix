{
  pkgs,
  outputs,
  ...
}: {
  home = {
    packages = with pkgs;
      [
        #

        age
        autoconf
        awscli2
        bat
        bc
        bison
        bottom
        cloc
        codeium
        corepack_latest
        dconf
        du-dust
        entr
        eva
        fd
        ffmpeg
        file
        flex
        fzf
        gcc
        gh
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
        dotnet-sdk_9
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
      ]
      ++ (
        if !outputs.isWsl
        then [
          # ark
          acpi
          brillo
          btrfs-progs
          calibre
          cliphist
          font-awesome
          font-manager
          fontforge
          gnome-bluetooth
          gnome-disk-utility
          hyprpicker
          keepassxc
          kora-icon-theme
          libcanberra-gtk3
          libiconv
          libnotify
          libreoffice
          libtool
          libusb1
          light
          loupe
          microsoft-edge
          nautilus
          networkmanagerapplet
          nwg-look
          pavucontrol
          pulseaudioFull
          qalculate-gtk
          slack
          slock
          swaylock-effects
          swww
          teams-for-linux
          telegram-desktop
          vlc
          wf-recorder
          whatsapp-for-linux
          wirelesstools
          xorg.xhost
          zathura

          # Custom scripts/packages
          bar_themeswitcher
          batplug
          batsuspend
          batwarning
          cliphist_wrapper
          init_bar
          screenshot
          shade
          wallpaper
        ]
        else []
      );

    sessionVariables = {
      # for pkg-config
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH";
    };
  };
}
