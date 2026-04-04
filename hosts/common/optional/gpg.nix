{config, ...}: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = config.services.openssh.enable;
  };
}
