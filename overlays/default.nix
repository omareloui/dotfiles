{inputs, ...}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # Inside zellij on kitty, yazi probes the terminal, gets kitty's replies
    # forwarded by zellij and picks the kitty graphics protocol, which zellij
    # mangles. Make yazi use ueberzugpp (wayland layer) when running in zellij
    # under a compositor ueberzugpp supports.
    yazi-unwrapped = prev.yazi-unwrapped.overrideAttrs (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          substituteInPlace yazi-adapter/src/drivers/drivers.rs \
            --replace-fail \
              'let mut drivers: Self = emu.into();' \
              'if env_exists("ZELLIJ") && Ueberzug::supported_compositor() && env_exists("WAYLAND_DISPLAY") { return D::Wayland; }
          		let mut drivers: Self = emu.into();'
        '';
    });

    # The wrapper bundles `_7zz` without the RAR codecs, which shadows the
    # RAR-capable one, so extracting .rar fails with "Unsupported Method".
    yazi = prev.yazi.override {_7zz = final._7zz-rar;};

    # ueberzugpp never reads Hyprland's socket replies, so Hyprland drops its
    # commands. On top of that, with the lua IPC it positions the preview with a
    # `move` window rule added right after the first commit, usually before the
    # window is mapped, so it never applies and Hyprland centers the window.
    # Dispatch a real move (retried briefly until the window exists) instead.
    ueberzugpp = prev.ueberzugpp.overrideAttrs (old: {
      patches = (old.patches or []) ++ [./patches/ueberzugpp-hyprland-lua-move.patch];
    });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };
}
