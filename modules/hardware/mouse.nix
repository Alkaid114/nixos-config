{ config, lib, ... }:
let
  cfg = config.my.hardware.mouse;
in
{
  options.my.hardware.mouse.enable = lib.mkEnableOption "鼠标外设配置 (ratbagd)";

  config = lib.mkIf cfg.enable {
    services.ratbagd.enable = true;
  };
}
