{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    # settings = {
    #   fade-in = 0.2;
    #   screenshots = true;

    #   ignore-empty-password = false;

    #   clock = false;

    #   indicator = false;
    #   indicator-caps-lock = false;
    #   indicator-radius = 60;
    #   indicator-thickness = 5;

    #   effect-blur = "12x12";
    #   effect-vignette = "0.5:0.5";

    #   line-color = "00000000";
    #   line-clear-color = "00000000";
    #   line-caps-lock-color = "00000000";
    #   line-ver-color = "00000000";
    #   line-wrong-color = "00000000";

    #   ring-color = "00000033";
    #   ring-caps-lock-color = "5500A3FF";
    #   ring-wrong-color = "FF0000FF";

    #   separator-color = "00000000";

    #   text-color = "FFFFFFFF";
    #   text-clear-color = "00000000";
    #   text-wrong-color = "00000000";
    #   text-ver-color = "00000000";
    #   text-caps-lock-color = "00000000";

    #   inside-color = "00000066";
    #   inside-clear-color = "00000066";
    #   inside-caps-lock-color = "00000066";
    #   inside-ver-color = "00000066";
    #   inside-wrong-color = "00000066";

    #   grace = 5;
    # };
  };
}
