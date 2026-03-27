{
  pkgs,
  outputs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./locale.nix
    ./nix.nix
    ./ssh.nix
    ./virtualisation.nix
    ./shell.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  documentation = {
    enable = true;
    dev.enable = true;
    man.enable = true;
  };
}
