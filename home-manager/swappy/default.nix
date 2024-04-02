{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swappy
  ];

  home.file.".config/swappy/config".text =
    /*
    toml
    */
    ''
      [Default]
      save_dir=${config.home.sessionVariables.PICS_DIR}/swappy
      save_file_format=swappy_%Y-%m-%d-%I-%M-%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=Poppins
      paint_mode=brush
      early_exit=false
      fill_shape=false
    '';
}
