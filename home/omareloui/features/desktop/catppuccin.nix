{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  qt = {
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
}
