{
  outputs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./ssh.nix
    ./virtualisation.nix
    ./zsh.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
