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
        ];
      };
    };
    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = ["l"];
            exec = "plugin --sync smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          {
            on = ["w"];
            exec = "shell --confirm '${lib.getExe pkgs.wallpaper} $1'";
            desc = "Set the image as wallpaper";
          }
          {
            on = ["A"];
            exec = ''
              shell --block --confirm '
                read -p "Write directory name: " dir
                mkdir -p $dir
                mv $@ $dir
              '
            '';
            desc = "Add selected to a new directory";
          }
          {
            on = ["F"];
            exec = ''
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
            on = ["e"];
            exec = ''
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
}
