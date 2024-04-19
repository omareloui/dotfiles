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
            desc = "open with default system application";
          }
        ];

        pdf = [
          {
            run = ''zathura $@'';
            desc = "open pdf files";
          }
        ];

        image = [
          {
            run = ''loupe $@'';
            desc = "open images";
          }
        ];

        video = [
          {
            run = ''vlc "$@"'';
            orphan = true;
            desc = "open videos";
          }
        ];

        text = [
          {
            run = ''nvim "$@"'';
            desc = "open with the text editor";
            block = true;
          }
        ];

        archive = [
          {
            run = ''ark "$0"'';
            desc = "open a gui to view/extract the archive";
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
            desc = "seek down half a page";
          }
          {
            on = ["<A-k"];
            run = "seek -10";
            desc = "seek up half a page";
          }
          {
            on = ["l"];
            run = "plugin --sync smart-enter";
            desc = "enter the child directory, or open the file";
          }
          {
            on = ["w"];
            run = ''shell --confirm '${lib.getExe pkgs.wallpaper} "$0"' '';
            desc = "set the image as wallpaper";
          }
          {
            on = ["A"];
            run = "plugin fold";
            desc = "add selected to a new directory";
          }
          {
            on = ["-"];
            run = "shell --confirm --block 'nvim -c \"norm -\" ..'";
            desc = "open oil file explorer";
          }
          {
            on = [leader "g"];
            run = "shell --confirm ${lib.getExe pkgs.group_likes}";
            desc = "group like-titled files into directories";
          }
          {
            on = [leader "f"];
            run = ''plugin unfold'';
            desc = "flatten the selected directories";
          }
          {
            desc = "extract a compressed file";
            on = [leader "e"];
            run = ''
              shell --confirm --block '
                for file in $@; do
                filename_with_ext="$(basename "$file")"
                foldername="''${filename_with_ext%.*}"

                case $filename_with_ext in
                  *.tar.xz.gpg)
                    foldername="''${filename_with_ext%.*.*.*}"
                  ;;
                  *.tar.bz|*.tar.bz2|*.tar.gz|*.tar.xz)
                    foldername="''${filename_with_ext%.*.*}"
                  ;;
                esac

                case $file in
                  *.tar.xz.gpg|*.txz.gpg)
                    [[ ! -d foldername ]] && mkdir "$foldername"
                    gpg -d "$file" | tar xJvC "$foldername"
                  ;;
                  *.tar.bz|*.tar.bz2|*.tbz|*.tbz2)
                    [[ ! -d foldername ]] && mkdir "$foldername"
                    tar xjvf "$file" -C "$foldername"
                  ;;
                  *.tar.gz|*.tgz)
                    [[ ! -d foldername ]] && mkdir "$foldername"
                    tar xzvf "$file" -C "$foldername"
                  ;;
                  *.tar.xz|*.txz)
                    [[ ! -d foldername ]] && mkdir "$foldername"
                    tar xJvf "$file" -C "$foldername"
                  ;;
                  *.zip)
                    [[ ! -d foldername ]] && mkdir "$foldername"
                    unzip -d "$foldername" "$file"
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
            desc = "protect with gpg";
            on = [leader "p" "e"];
            orphan = true;
            # TODO: make sure the selected are files not folders (or archive if it contains folders)
            run = ''
              shell --confirm '
                for file in $@; do
                  gpg -r contact@omareloui.com -e "$file"
                done
              '
            '';
          }
          {
            desc = "decrepit gpg files";
            on = [leader "p" "d"];
            orphan = true;
            run = ''
              shell --confirm --block '
                for file in $@; do
                  name="$(basename "$file")"
                  gpg -d "$file" 1>''${name%.*} 2>/dev/null
                done
              '
            '';
          }
          {
            on = [leader "a"];
            orphan = true;
            run = "plugin archive-and-protect";
            desc = "archive";
          }
          {
            on = [leader "D"];
            orphan = true;
            run = "plugin srm";
            desc = "securely remove the selected file(s)";
          }
          {
            on = [leader "s" "s"];
            run = "shell --confirm '${lib.getExe pkgs.sortpics}'";
            desc = "sort the pictures in CWD to phone directory and desktop directory depending on its dimensions";
          }
          {
            on = [leader "t"];
            run = "tasks_show";
            desc = "show the tasks manager";
          }
          {
            on = [leader "h"];
            run = "help";
            desc = "show the help menu";
          }
          {
            on = [leader "?"];
            run = "help";
            desc = "show the help menu";
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
            desc = "show the help menu";
          }
          {
            on = [leader "?"];
            run = "help";
            desc = "show the help menu";
          }
          {
            on = ["q"];
            run = "close";
            desc = "hide the task manager";
          }
          {
            on = [leader "t"];
            run = "close";
            desc = "hide the task manager";
          }
          {
            on = ["i"];
            run = "inspect";
            desc = "inspect the task";
          }
          {
            on = [leader "c"];
            run = "cancel";
            desc = "cancel the task";
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
