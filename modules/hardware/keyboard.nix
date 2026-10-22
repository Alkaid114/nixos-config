{ config, lib, ... }:
let
  cfg = config.my.hardware.keyboard;
in
{
  options.my.hardware.keyboard.enable = lib.mkEnableOption "外接键盘的 Apple 功能键模式 (F1-F12 优先)";

  config = lib.mkIf cfg.enable {
    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';
  };
}
