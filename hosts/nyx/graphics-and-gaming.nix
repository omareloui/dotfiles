{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # required for va-api video acceleration
      vpl-gpu-rt # important for newer meteor lake quicksync features
      intel-compute-runtime # OpenCL and Level Zero for Arc compute optimization
    ];
  };

  services.xserver.videoDrivers = ["modesetting"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Forces apps to prioritize the modern Arc driver backend
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = ["i915.force_probe=!7d55" "xe.force_probe=7d55"];
}
