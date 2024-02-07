{ pkgs, ... }: {

  users.users.omareloui = {
    initialPassword = "correcthorsebatterystaple";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
    packages = [ ];
  };

}
