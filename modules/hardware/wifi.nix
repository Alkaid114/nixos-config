{ config, lib, ... }:
let
  cfg = config.my.hardware.wifi;
in
{
  options.my.hardware.wifi.enable = lib.mkEnableOption "Wi-Fi 与 NetworkManager";

  config = lib.mkIf cfg.enable {
    networking = {
      wireless = {
        enable = true;
        iwd = {
          enable = false;
        };
      };
      networkmanager = {
        enable = true;
      };
    };
  };
}
