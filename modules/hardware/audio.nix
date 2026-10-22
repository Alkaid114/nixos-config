{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.hardware.audio;
in
{
  options.my.hardware.audio.enable = lib.mkEnableOption "PipeWire 音频";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        audio = {
          enable = true;
        };
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };
    environment.systemPackages = with pkgs; [
      alsa-utils
      # pavucontrol
    ];
  };
}
