{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim.url = "github:nix-community/nixvim";

    eva.url = "github:nerdypepper/eva";

    nix-colors.url = "github:misterio77/nix-colors";

    templ.url = "github:a-h/templ";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    system = "x86_64-linux";
    systems = ["x86_64-linux" "aarch64-linux"];

    systemConfig = {
      colorScheme = inputs.nix-colors.lib.schemeFromYAML "folke-tokyo-night-dark" (builtins.readFile ./assets/themes/folke-tokyo-night-dark.yaml);
      # colorScheme = inputs.nix-colors.colorSchemes.paraiso;
    };

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs systemConfig;};
        modules = [./nixos/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "omareloui@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs outputs systemConfig;};
        modules = [./home-manager/home.nix];
      };
    };
  };
}
