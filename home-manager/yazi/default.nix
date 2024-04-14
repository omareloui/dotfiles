{
  pkgs,
  lib,
  ...
}: {
  programs.yazi = {
    enable = true;
    settings = {
      headsup = {
        disable_exec_warn = true;
      };

      manager = {
        ratio = [1 4 4];
        linemode = "mylinemode";
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
      };

      opener = {
        default = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open with default system application";
          }
        ];

        pdf = [
          {
            run = ''zathura $@'';
            desc = "Open pdf files";
          }
        ];

        image = [
          {
            run = ''loupe $@'';
            desc = "Open images";
          }
        ];

        video = [
          {
            run = ''vlc "$@"'';
            orphan = true;
            desc = "Open videos";
          }
        ];

        text = [
          {
            run = ''nvim "$@"'';
            desc = "Open with the text editor";
            block = true;
          }
        ];

        archive = [
          {
            run = ''ark "$0"'';
            desc = "Open a gui to view/extract the archive";
            block = true;
          }
        ];
      };

      open = {
        rules = [
          {
            mime = "text/*";
            use = "text";
          }
          {
            name = "*.{json,yaml,yml,md}";
            use = "text";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            mime = "video/*";
            use = "video";
          }
          {
            mime = "application/pdf";
            use = "pdf";
          }
          {
            mime = "application/zip";
            use = "archive";
          }
          {
            mime = "application/x-rar";
            use = "archive";
          }
          {
            mime = "application/x-tar";
            use = "archive";
          }
        ];
      };

      plugin = {
        prepend_previewers = [
          {
            mime = "audio/*";
            run = "mpg123";
          }
          {
            mime = "application/x-subrip";
            run = "code";
          }
        ];
        append_previewers = [
          {
            mime = "*";
            run = "code";
          }
        ];
      };
    };

    keymap = let
      leader = "<Tab>";
    in {
      manager = {
        prepend_keymap = [
          {
            on = ["<A-j"];
            run = "seek 10";
            desc = "Seek down half a page";
          }
          {
            on = ["<A-k"];
            run = "seek -10";
            desc = "Seek up half a page";
          }
          {
            on = ["l"];
            run = "plugin --sync smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = ["w"];
            run = ''shell --confirm '${lib.getExe pkgs.wallpaper} "$0"' '';
            desc = "Set the image as wallpaper";
          }
          {
            on = ["A"];
            run = "plugin fold";
            # run = ''
            #   shell --block --confirm '
            #     read -p "Write directory name: " dir
            #     mkdir -p $dir
            #     mv $@ $dir
            #   '
            # '';
            desc = "Add selected to a new directory";
          }
          {
            on = [leader "f"];
            run = ''
              shell --confirm '
                for folder in $@; do
                  if [[ -d $folder ]]; then
                    fd -IHd1 . "$folder" | xargs -I{} mv {} .
                    rmdir "$folder"
                  fi
                done
              '
            '';
            desc = "Flatten the selected directories";
          }
          {
            desc = "Extract a compressed file";
            on = [leader "e"];
            run = ''
              shell --confirm --block '
                for file in $@; do
                foldername="$(basename "''${file%%.*}")"
                case $file in
                  *.tar.xz.gpg|*.txz.gpg)
                    [[ ! -d foldername ]] && mkdir $foldername
                    gpg -d "$file" | tar xJvC "$foldername"
                  ;;
                  *.tar.bz|*.tar.bz2|*.tbz|*.tbz2)
                    [[ ! -d foldername ]] && mkdir $foldername
                    tar xjvf "$file" -C "$foldername"
                  ;;
                  *.tar.gz|*.tgz)
                    [[ ! -d foldername ]] && mkdir $foldername
                    tar xzvf "$file" -C "$foldername"
                  ;;
                  *.tar.xz|*.txz)
                    [[ ! -d foldername ]] && mkdir $foldername
                    tar xJvf "$file" -C "$foldername"
                  ;;
                  *.zip)
                    unzip "$file"
                  ;;
                  *.rar)
                      unrar x "$file"
                  ;;
                  *.7z)
                    7z x "$file"
                  ;;
                esac
              done
              '
            '';
          }
          {
            desc = "Archive selected";
            on = [leader "a"];
            run = "plugin archive";
          }
          {
            desc = "Securely remove the selected file(s)";
            on = [leader "D"];
            run = "shell --confirm 'srm -rf $@'";
          }
          {
            on = [leader "s" "s"];
            run = "shell --confirm '${lib.getExe pkgs.sortpics}'";
            desc = "Sort the pictures in CWD to phone directory and desktop directory depending on its dimensions";
          }
          {
            on = [leader "t"];
            run = "tasks_show";
            desc = "Show the tasks manager";
          }
          {
            on = [leader "h"];
            run = "help";
            desc = "Show the help menu";
          }
          {
            on = [leader "?"];
            run = "help";
            desc = "Show the help menu";
          }
          {
            on = ["y"];
            run = [
              "yank"
              ''shell --confirm 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' ''
            ];
          }
        ];
      };

      tasks = {
        prepend_keymap = [
          {
            on = [leader "h"];
            run = "help";
            desc = "Show the help menu";
          }
          {
            on = [leader "?"];
            run = "help";
            desc = "Show the help menu";
          }
          {
            on = ["q"];
            run = "close";
            desc = "Hide the task manager";
          }
          {
            on = [leader "t"];
            run = "close";
            desc = "Hide the task manager";
          }
          {
            on = ["i"];
            run = "inspect";
            desc = "Inspect the task";
          }
          {
            on = [leader "c"];
            run = "cancel";
            desc = "Cancel the task";
          }
        ];
      };
    };
  };

  home.file.".config/yazi/init.lua".source = ./init.lua;
  home.file.".config/yazi/plugins" = {
    source = ./plugins;
    recursive = true;
  };
}
