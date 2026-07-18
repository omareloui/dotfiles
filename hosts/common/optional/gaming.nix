{pkgs, ...}: {
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;

      # Ensures older games and wrappers map the 32-bit layers correctly
      extraPackages32 = with pkgs.pkgsi686Linux; [intel-media-driver];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Optimizes process priorities and scheduling when launching games
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud # system overlay tracking real-time FPS, frame timings, and VRAM utilization.
    protonup-qt # graphical interface used to install community-managed compatibility runtimes like Proton-GE inside Steam
    heroic # manager for running games outside the Steam ecosystem (e.g., Epic Games, GOG, or direct executable binaries)
  ];
}
