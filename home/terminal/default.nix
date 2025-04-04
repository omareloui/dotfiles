{outputs, ...}: {
  imports =
    [
      ./zellij.nix
    ]
    ++ (
      if !outputs.isWsl
      then [
        ./kitty.nix
        ./wezterm.nix
      ]
      else []
    );
}
