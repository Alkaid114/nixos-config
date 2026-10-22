{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.hardware.printing;
in
{
  options.my.hardware.printing.enable = lib.mkEnableOption "打印服务";

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };
  };
}
