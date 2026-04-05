{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    package = pkgs.stable.pipewire;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    wireplumber.package = pkgs.stable.wireplumber;
  };
}
