{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (qmk.override {
        wb32-dfu-updater = pkgs.wb32-dfu-updater.overrideAttrs (oldAttrs: {
          postPatch = ''
            substituteInPlace CMakeLists.txt \
              --replace-fail "cmake_minimum_required(VERSION 3.0)" "cmake_minimum_required(VERSION 3.5)"
          '';
        });
      })
      wally-cli
    ];

    file.".config/qmk/qmk.ini".text = let
      kb = "zsa/voyager";
      km = "omareloui";
    in ''
      [compile]

      [flash]

      [user]
      keyboard = ${kb}
      keymap = ${km}

      [config]

      [console]

      [c2json]

      [docs]

      [find]
      keymap = default

      [format_c]

      [format_python]

      [format_text]

      [generate_autocorrect_data]

      [generate_compilation_database]

      [generate_develop_pr_list]

      [generate_dfu_header]

      [generate_info_json]

      [generate_make_dependencies]

      [git_submodule]

      [hello]

      [info]

      [license_check]

      [lint]

      [kle2json]

      [list_keymaps]

      [list_layouts]

      [mass_compile]
      keymap = default

      [new_keyboard]

      [new_keymap]

      [painter_convert_graphics]

      [painter_make_font_image]

      [painter_convert_font_image]

      [test_c]

      [userspace_add]

      [userspace_remove]

      [userspace_compile]

      [general]
    '';
  };
}
