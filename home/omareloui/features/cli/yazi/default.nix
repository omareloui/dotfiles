{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.yazi = {
    enable = true;
    extraPackages = with pkgs; [ueberzugpp];
    shellWrapperName = "ya";
    settings = {
      mgr = {
        ratio = [1 3 4];
        linemode = "custom";
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
      };

      preview = {
        image_delay = 100;
        image_filter = "catmull-rom";
        image_quality = 85;
        sixel_fraction = 10;
        max_width = 1000;
        max_height = 1000;

        # From the docs:
        # ```
        # If your monitor has a 2.0 scale factor, and is running on Wayland under
        # Hyprland, you may need to set ueberzug_scale: 0.5, and adjust the value of
        # ueberzug_offset according to your case, to offset this issue
        # ```
        # formela 1/current_scale
        ueberzug_scale = 0.6666;
        ueberzug_offset = [60 3 10 5];
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
            run = ''zathura "$@"'';
            desc = "open pdf files";
          }
        ];

        image = [
          {
            run = ''loupe "$@"'';
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
        prepend_preloaders = [
          {
            mime = "image/*";
            run = "noop";
          }
        ];
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
      mgr = {
        prepend_keymap = [
          {
            on = "k";
            run = "plugin augment-command -- arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "j";
            run = "plugin augment-command -- arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "K";
            run = "plugin augment-command -- parent_arrow -1";
            desc = "Move cursor up in the parent directory";
          }
          {
            on = "J";
            run = "plugin augment-command -- parent_arrow 1";
            desc = "Move cursor down in the parent directory";
          }

          {
            on = "<C-k>";
            run = "seek -5";
            desc = "Seek up 5 units in the preview pane";
          }
          {
            on = "<C-j>";
            run = "seek 5";
            desc = "Seek down 5 units in the preview pane";
          }
          {
            on = "l";
            run = "plugin augment-command -- enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = "<Enter>";
            run = "plugin augment-command -- enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = "<S-Enter>";
            run = "plugin augment-command -- enter --interactive";
            desc = "Enter the child directory, or open the file interactively";
          }
          {
            on = "<Right>";
            run = "plugin augment-command -- enter --no-skip";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = ["h"];
            run = "plugin augment-command -- leave";
            desc = "Go back to the parent directory";
          }
          {
            on = ["<Left>"];
            run = "plugin augment-command -- leave --no-skip";
            desc = "Go back to the parent directory";
          }
          {
            on = "t";
            run = "plugin augment-command -- tab_create --current";
            desc = "Create a new tab with CWD";
          }
          {
            on = "O";
            run = "plugin augment-command -- open --interactive";
            desc = "Open selected files interactively";
          }
          {
            on = "<Space>";
            run = ["toggle" "plugin augment-command -- arrow 1 --no-wrap"];
            desc = "Toggle the current selection state";
          }
          {
            on = "u";
            run = ["escape --select" "unyank"];
            desc = "Unselect all files and also unyank cut files";
          }
          {
            on = "d";
            run = "yank --cut";
            desc = "Cut the selected files";
          }
          {
            on = "p";
            run = "plugin augment-command -- paste";
            desc = "Paste the files";
          }
          {
            on = "P";
            run = "plugin augment-command -- paste --force";
            desc = "Paste the files (overwrite if the destination exists)";
          }
          {
            on = "_";
            run = "plugin augment-command -- create";
            desc = "Create a file or directory";
          }
          {
            on = "+";
            run = "plugin augment-command -- create";
            desc = "Create a file or directory";
          }
          {
            on = "=";
            run = "hardlink";
            desc = "Hardlink yanked files";
          }
          {
            on = "x";
            run = "plugin augment-command -- remove";
            desc = "Move the files to the trash";
          }
          {
            on = "X";
            run = "plugin augment-command -- remove --permanently";
            desc = "Permanently delete the files";
          }
          {
            on = "a";
            run = "plugin augment-command -- archive";
            desc = "Add files to an archive";
          }
          {
            on = "!";
            run = ''shell "$SHELL" --block'';
            desc = "Open shell here";
          }
          {
            on = "z";
            run = "plugin fzf";
            desc = "Jump to a directory, or reveal a file using fzf";
          }
          {
            on = "Z";
            run = "plugin fzf";
            desc = "Jump to a directory, or reveal a file using fzf";
          }
          {
            on = "o";
            run = "plugin augment-command -- editor";
            desc = "Open files with the default editor";
          }
          {
            on = "i";
            run = "plugin augment-command -- pager";
            desc = "Open files with the default pager";
          }
          {
            on = "r";
            run = "plugin augment-command -- rename --cursor=before_ext";
            desc = "Rename a file or directory";
          }
          {
            on = "R";
            run = "plugin augment-command -- rename --empty=all";
            desc = "Rename file and remove the whole file name";
          }
          {
            on = "I";
            run = "plugin augment-command -- rename --cursor=start";
            desc = "Rename file at the start of the file name";
          }
          # {
          #   on = "A";
          #   run = "plugin augment-command -- rename --cursor=end";
          #   desc = "Rename file with the cursor at the end of the file name";
          # }
          {
            on = "C";
            run = "plugin augment-command -- rename --empty=all";
            desc = "Rename file and remove the whole file name";
          }
          {
            on = ["c" "c"];
            run = "plugin augment-command -- copy path";
            desc = "Copy the file path";
          }
          {
            on = ["c" "d"];
            run = "plugin augment-command -- copy dirname";
            desc = "Copy the directory path";
          }
          {
            on = ["c" "f"];
            run = "plugin augment-command -- copy filename";
            desc = "Copy the filename";
          }
          {
            on = ["c" "n"];
            run = "plugin augment-command -- copy name_without_ext";
            desc = "Copy the filename without extension";
          }
          {
            on = ["c" "m"];
            run = "plugin augment-command -- rename --empty=stem --cursor=start";
            desc = "Rename file and remove the file name";
          }
          {
            on = ["c" "r"];
            run = "create";
            desc = "Create a file (ends with / for directories)";
          }
          {
            on = ["e" "m"];
            run = "plugin augment-command -- emit";
            desc = "Emit a Yazi command";
          }
          {
            on = ["g" "c"];
            run = "cd ~/.config";
            desc = "Go to the config directory";
          }
          {
            on = ["g" "d"];
            run = "cd ${config.home.sessionVariables.DOWNLOADS_DIR}";
            desc = "Go to the downloads directory";
          }
          {
            on = ["g" "v"];
            run = "cd ${config.home.sessionVariables.FLAKE}";
            desc = "Go to the dotfiles directory";
          }
          {
            on = ["g" "r"];
            run = "cd ${config.home.sessionVariables.REPOS_DIR}";
            desc = "Go to the repos directory";
          }
          {
            on = ["g" "l"];
            run = "follow";
            desc = "Follow hovered symlink";
          }
          {
            on = ["g" "f"];
            run = "plugin augment-command -- first_file";
            desc = "Jump to the first file";
          }

          {
            on = "1";
            run = "plugin relative-motions -- 1";
            desc = "Move in relative steps";
          }
          {
            on = "2";
            run = "plugin relative-motions -- 2";
            desc = "Move in relative steps";
          }
          {
            on = "3";
            run = "plugin relative-motions -- 3";
            desc = "Move in relative steps";
          }
          {
            on = "4";
            run = "plugin relative-motions -- 4";
            desc = "Move in relative steps";
          }
          {
            on = "5";
            run = "plugin relative-motions -- 5";
            desc = "Move in relative steps";
          }
          {
            on = "6";
            run = "plugin relative-motions -- 6";
            desc = "Move in relative steps";
          }
          {
            on = "7";
            run = "plugin relative-motions -- 7";
            desc = "Move in relative steps";
          }
          {
            on = "8";
            run = "plugin relative-motions -- 8";
            desc = "Move in relative steps";
          }
          {
            on = "9";
            run = "plugin relative-motions -- 9";
            desc = "Move in relative steps";
          }

          {
            on = ["g" "i"];
            run = "plugin lazygit";
            desc = "run lazygit";
          }
          {
            on = ["w"];
            run = ''shell --confirm '${lib.getExe pkgs.wallpaper} "$0"' '';
            desc = "set the image as wallpaper";
          }
          {
            on = "A";
            run = "plugin fold";
            desc = "add selected to a new directory";
          }
          {
            on = [leader "f"];
            run = ''plugin unfold'';
            desc = "flatten the selected directories";
          }
          {
            desc = "protect with gpg";
            on = [leader "p" "e"];
            orphan = true;
            run = ''
              shell --confirm '
                for file in $@; do
                  [[ -f $file ]] && gpg -r contact@omareloui.com -e "$file"
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
          # {
          #   desc = "edit gpg files";
          #   on = [leader "p" "o"];
          #   run = ''
          #     shell --confirm --block '
          #       file=$0
          #       if [[ $file == *.gpg ]]; then
          #         # TODO: decrepit as a temp
          #         # TODO: update $file to be that temp
          #       else
          #         # TODO: copy the file to /tmp
          #         # TODO: update $file to be that temp
          #       fi
          #
          #       # TODO: edit the file
          #
          #       # TODO: know how to track if exited after saving or not
          #
          #       # TODO: on success (file updated/changed) encrypt and move to current dir
          #       # TODO: remove the temp files
          #
          #       # TODO: on failure (file updated/changed) move back the files
          #     '
          #   '';
          # }
          {
            on = [leader "a"];
            orphan = true;
            run = "plugin archive-and-protect";
            desc = "archive";
          }
          {
            on = [leader "D"];
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
            on = [leader "g" "p"];
            run = "plugin genpdf";
            desc = "generate a pdf from selected files";
          }
          {
            on = [leader "g" "g"];
            run = "plugin gengif";
            desc = "generate a gif preview from a video";
          }
          {
            on = "y";
            run = [
              "yank"
              ''shell --confirm 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list' ''
            ];
          }
          {
            on = "T";
            run = "plugin toggle-pane min-preview";
            desc = "Show or hide the preview pane";
          }
        ];
      };

      tasks = {
        suppress_preload = true;

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

  home.file = {
    ".config/yazi/init.lua".source = ./init.lua;
    ".config/yazi/plugins" = {
      source = ./plugins;
      recursive = true;
    };

    ".config/starship-yazi.toml".text = lib.mkIf config.programs.yazi.enable ''
      add_newline = false
      format = "$directory$git_branch$cmd_duration$jobs$battery$python
      palette = "catppuccin_mocha"

      [aws]
      disabled = true

      [python]
      format = "[(($virtualenv) )]($style)"
    '';
  };
}
