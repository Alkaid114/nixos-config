{ config, lib, ... }:
let
  cfg = config.my.hardware.bluetooth;
in
{
  options.my.hardware.bluetooth.enable = lib.mkEnableOption "蓝牙";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };
}
