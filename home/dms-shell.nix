{ inputs, pkgs, ... }:
{
  imports = [
    inputs.dms-plugin-registry.homeModules.default
    inputs.dms.homeModules.dank-material-shell
  ];
  programs.dank-material-shell = {
    enable = true;
    # package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    dgop.package = pkgs.dgop;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableClipboardPaste = true;
    plugins = {
      dockerManager = {
        enable = true;
      };
    };
  };
}
