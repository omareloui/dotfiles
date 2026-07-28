{ pkgs, ... }: {
  home.packages = with pkgs; [ scrcpy ];
  home.shellAliases = {
    use_phone_camera = "scrcpy --v4l2-sink=/dev/video0 --video-source=camera --no-video-playback --no-audio-playback --camera-id=0 --no-window";
  };
}
