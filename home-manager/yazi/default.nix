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
          # {
          #   on = [leader "a" "z"];
          #   run = ''
          #     shell --confirm --block '
          #       read -p "Archive name? " archive_name
          #       mkdir -p "$archive_name"
          #       cp $@ "$archive_name"
          #       zip -r "$archive_name" $archive_name
          #       rm -rf $archive_name
          #     '
          #   '';
          #   desc = "Archive the selected file(s) into a .zip archive";
          # }
          # {
          #   on = [leader "a" "x"];
          #   run = ''
          #     shell --confirm --block '
          #       read -p "Archive name? " archive_name
          #       relpaths="$(for i in $@; do realpath -s --relative-to="$PWD" "$i"; done)"
          #       tar -Jcvf "$archive_name.tar.xz" ''${relpaths[@]}
          #     '
          #   '';
          #   desc = "Archive the selected file(s) into a .tar.xz archive";
          # }
          # {
          #   desc = "Archive and protect the selected file(s) into a .zip archive";
          #   on = [leader "a" "p"];
          #   run = ''
          #     shell --confirm --block '
          #       read -p "Archive name? " archive_name
          #       mkdir -p "$archive_name"
          #       cp $@ "$archive_name"
          #       zip -er "$archive_name" $archive_name
          #       rm -rf $archive_name
          #     '
          #   '';
          # }
          # {
          #   desc = "Archive the selected file(s) into a .tar.xz archive";
          #   on = [leader "a" "g"];
          #   run = ''
          #     shell --confirm '
          #       # read -p "Archive name? " archive_name
          #       archive_name="protected_archive"
          #       relpaths="$(for i in $@; do realpath -s --relative-to="$PWD" "$i"; done)"
          #       tar -Jcvf "$archive_name.tar.xz" ''${relpaths[@]}
          #       gpg -r contact@omareloui.com -e "$archive_name.tar.xz"
          #       srm -f "$archive_name.tar.xz"
          #     '
          #   '';
          # }
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

  home.file.".config/yazi/init.lua".text =
    /*
    lua
    */
    ''
      local old_linemode = Folder.linemode
      function Folder:linemode(area, _files)
        if cx.active.conf.linemode ~= "mylinemode" then
          return old_linemode(self, area)
        end

        local lines = {}

        local year = os.date("%Y")

        for _, f in ipairs(self:by_kind(self.CURRENT).window) do
          -- Modified time
          local time = f.cha.modified // 1
          if time and os.date("%Y", time) ~= year then
            time = os.date("%d/%m/%Y", time)
          else
            time = time and os.date("%d %b. %H:%M", time) or ""
          end

          -- Size
          local size = f:size()
          size = size and ya.readable_size(size):gsub(" ", "") or "-"

          lines[#lines + 1] = ui.Line({
            ui.Span(" "),
            ui.Span(size),
            ui.Span("   "),
            ui.Span(time),
            ui.Span(" "),
          })
        end

        return ui.Paragraph(area, lines):align(ui.Paragraph.RIGHT)
      end

      function Status:mime()
        local h = cx.active.current.hovered
        if h == nil or ya.target_family() ~= "unix" or h.cha.is_dir then
          return ui.Line({})
        end

        local mime = h:mime()

        if not mime then
          return ui.Line({})
        end

        return ui.Line({
          ui.Span(" "),
          ui.Span(mime):fg("gray"):dim(),
        })
      end

      function Status:owner()
        local h = cx.active.current.hovered
        if h == nil or ya.target_family() ~= "unix" then
          return ui.Line({})
        end

        return ui.Line({
          ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
          ui.Span(":"),
          ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
          ui.Span(" "),
        })
      end

      function Status:render(area)
        self.area = area

        local left = ui.Line({ self:mode(), self:size(), self:name(), self:mime() })
        local right = ui.Line({ self:owner(), self:permissions(), self:percentage(), self:position() })

        return {
          ui.Paragraph(area, { left }),
          ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
          table.unpack(Progress:render(area, right:width())),
        }
      end
    '';

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

  home.file.".config/yazi/plugins/archive.yazi/init.lua".text =
    /*
    lua
    */
    ''
      ---@param s string
      ---@return string
      local function trim(s)
        return s:match("^%s*(.-)%s*$")
      end

      local get_selected = ya.sync(function(state)
        local selected = cx.active.selected
        state.selected = {}
        for k, v in pairs(selected) do
          state.selected[k] = tostring(v)
        end
        return state.selected
      end)

      local get_cwd = ya.sync(function(state)
        local cwd = cx.active.current.cwd
        state.cwd = tostring(cwd)
        return state.cwd
      end)

      return {
        entry = function(_self, _args)
          local cand = ya.which({
            cands = {
              { on = "g", desc = "archive into gpg protected .tar.xz.gpg archive file" },
              { on = "p", desc = "TODO: archive into protected .zip file" },
            },
          })

          if not cand then
            return
          end

          if cand ~= 1 then
            return
          end

          local archive_name, event = ya.input({
            title = "Archive name:",
            position = { "top-center", w = 40 },
            realtime = false,
          })

          local confirmed = event == 1

          archive_name = trim(archive_name)

          if not confirmed or archive_name == "" then
            return
          end
          archive_name = archive_name .. ".tar.xz"

          local sel = get_selected()
          local cwd = get_cwd()
          local files = {}
          for _, file in ipairs(sel) do
            local out, err = Command("realpath"):args({ "-s", "--relative-to", cwd, file }):output()
            local f = out.stdout
            f = trim(f)
            if err then
              ya.err("error while getting the relative path: " .. err)
              return
            end
            table.insert(files, f)
          end

          local child, err = Command("tar"):args({ "-Jcvf", archive_name }):args(files):spawn()
          if err then
            ya.err("error while creating the tar child: ", err)
            return
          end

          local _, err = child:wait()
          if err then
            ya.err("error on running the tar child: ", err)
            return
          end

          local child, err = Command("gpg"):args({ "-r", "contact@omareloui.com", "-e", archive_name }):spawn()
          if err then
            ya.err("error while creating the gpg child: ", err)
            return
          end

          local _, err = child:wait()
          if err then
            ya.err("error on running the gpg child: ", err)
            return
          end

          local child, err = Command("srm"):args({ "-f", archive_name }):spawn()
          if err then
            ya.err("error while creating the srm child: ", err)
            return
          end

          local _, err = child:wait()
          if err then
            ya.err("error on running the srm child: ", err)
            return
          end
        end,
      }
    '';
}
