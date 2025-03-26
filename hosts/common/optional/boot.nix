{
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
    };
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["iwlwifi"];
    extraModprobeConfig = ''
      options iwlwifi bt_coex_active=0
    '';
  };
}
