{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "/home/omareloui/.dotfiles/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/omareloui/.config/sops/age/keys.txt";
    age.generateKey = false;

    # secrets.password-hash.neededForUsers = true;
  };

  # users.users.omareloui.hashedPasswordFile = config.sops.secrets.password-hash.path;
}
