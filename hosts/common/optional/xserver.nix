{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
