{inputs, ...}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager

      ./zsh.nix
      ./locale.nix
      ./nix.nix
      ./ssh.nix
      ./console.nix
      ./virtualisation.nix
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
