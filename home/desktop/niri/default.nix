{
  pkgs,
  lib,
  ...
}:
let
  gpuSelectfuzzel = pkgs.writeShellScript "fuzzel-gpu-select" ''
    #export PATH="$PATH:/run/current-system/sw/bin:$HOME/.nix-profile/bin"

    EXTERNAL_DP_COUNT=$(
      ${pkgs.niri}/bin/niri msg outputs |
      ${pkgs.gnugrep}/bin/grep "DP" |
      ${pkgs.gnugrep}/bin/grep -v "eDP" |
      ${pkgs.coreutils}/bin/wc -l
    )

    if [ "$EXTERNAL_DP_COUNT" -gt 0 ]; then
        export __NV_PRIME_RENDER_OFFLOAD=1 
        export __VK_LAYER_NV_optimus=NVIDIA_only 
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
    fi

    case "$1" in
      *obs*|*gpu-screen-recorder*|*com.tencent.wemeet*)
        unset __NV_PRIME_RENDER_OFFLOAD
        unset __VK_LAYER_NV_optimus
        unset __GLX_VENDOR_LIBRARY_NAME
        ;;
    esac

    exec "$@"
  '';
in
{
  # services.polkit-gnome.enable = true;
  services.hyprpolkitagent.enable = true;
  services.gnome-keyring.enable = true;
  home.packages = with pkgs; [
    matugen
  ];
  programs.cava.enable = true;
  xdg.configFile."niri/config.kdl".text =
    builtins.readFile ./config.kdl + "\n" + "include optional=true \"fuzzel.kdl\"\n";
  xdg.configFile."niri/fuzzel.kdl".text = ''
    binds {
        Mod+D { spawn-sh "fuzzel --launch-prefix=${gpuSelectfuzzel}"; }
    }
  '';

  dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
}
