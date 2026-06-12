{
  pkgs,
  lib,
  ...
}:
let
  gpuSelectfuzzel = pkgs.writeShellScript "fuzzel-gpu-select" ''
    exec env PATH=${lib.makeBinPath [ pkgs.niri pkgs.gnugrep pkgs.coreutils ]}:$PATH "$@"

    export PATH="$PATH:/run/current-system/sw/bin:$HOME/.nix-profile/bin"

    EXTERNAL_DP_COUNT=$(niri msg outputs | grep "DP" | grep -v "eDP" | wc -l)

    if [ "$EXTERNAL_DP_COUNT" -gt 0 ]; then
        export __NV_PRIME_RENDER_OFFLOAD=1 
        export __VK_LAYER_NV_optimus=NVIDIA_only 
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
    fi

    if [[ "$*" =~ (obs|gpu-screen-recorder|com.tencent.wemeet) ]]; then
        unset __NV_PRIME_RENDER_OFFLOAD __VK_LAYER_NV_optimus __GLX_VENDOR_LIBRARY_NAME
    fi

    exec "$@"
  '';
in
{
  imports = [
    ./wallpaper.nix
  ];
  # services.polkit-gnome.enable = true;
  services.hyprpolkitagent.enable = true;
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    matugen
  ];
  programs.cava.enable = true;
  xdg.configFile."niri/base.kdl".source = ./niri-base.kdl;
  xdg.configFile."niri/config.kdl".text = ''
    include "base.kdl"
    binds {
        Mod+D { spawn-sh "fuzzel --launch-prefix=${gpuSelectfuzzel}"; }
    }
    //spawn-sh-at-startup "sleep 2 && QT_QPA_PLATFORMTHEME=gtk3 ${pkgs.dms-shell}/bin/dms restart"
  '';

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3";
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
}
