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
        linemode = "size";
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
            run = "shell --confirm '${lib.getExe pkgs.wallpaper} $0'";
            desc = "Set the image as wallpaper";
          }
          {
            on = ["A"];
            run = ''
              shell --block --confirm '
                read -p "Write directory name: " dir
                mkdir -p $dir
                mv $@ $dir
              '
            '';
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
              shell --confirm '
                for file in $@; do
                  case $file in
                    *.tar.bz|*.tar.bz2|*.tbz|*.tbz2)
                      foldername="$(basename "''${file%%.*}")"
                      [[ ! -d foldername ]] && mkdir $foldername
                      tar xjvf "$file" -C "$foldername"
                    ;;
                    *.tar.gz|*.tgz)
                      foldername="$(basename "''${file%%.*}")"
                      [[ ! -d foldername ]] && mkdir $foldername
                      tar xzvf "$file" -C "$foldername"
                    ;;
                    *.tar.xz|*.txz)
                      foldername="$(basename "''${file%%.*}")"
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
                done'
            '';
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

  home.file.".config/yazi/plugins/smart-enter.yazi/init.lua".text =
    /*
    lua
    */
    ''
      return {
      	entry = function()
          local h = cx.active.current.hovered
          ya.manager_emit(h and h.cha.is_dir and "enter" or "open", {})
      	end,
      }
    '';

  home.file.".config/yazi/plugins/mpg123.yazi/init.lua".text =
    /*
    lua
    */
    ''
      local M = {}

      function M:peek()
        local child = Command("mpg123")
          :args({ tostring(self.area.w), tostring(self.file.url) })
          :stdout(Command.PIPED)
          :stderr(Command.PIPED)
          :spawn()

        local limit = self.area.h
        local i, lines = 0, ""

        repeat
          local next, event = child:read_line()
          if event == 1 then
            ya.err(tostring(event))
          elseif event ~= 0 then
            break
          end

          i = i + 1
          if i > self.skip then
            lines = lines .. next
          end
        until i >= self.skip + limit

      end

      return M
    '';
}
