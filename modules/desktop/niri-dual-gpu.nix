{
  pkgs,
  lib,
  igpuPciAddress,
  dgpuPciAddress,
}:
{
  config,
  ...
}:
let
  niriPackage = pkgs.niri.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ../../patches/niri-shm-2604.patch
    ];
    postInstall = (oldAttrs.postInstall or "") + ''
      mv $out/bin/niri-session $out/bin/niri-session-real
      cat > $out/bin/niri-session <<'EOF'
      #!${pkgs.runtimeShell}
      set -eu

      config_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/niri"
      render_config="$config_dir/render-device.kdl"
      render_config_tmp="$render_config.tmp.$$"
      dgpu_card_path="/dev/dri/by-path/pci-${dgpuPciAddress}-card"
      dgpu_render_path="/dev/dri/by-path/pci-${dgpuPciAddress}-render"
      igpu_render_path="/dev/dri/by-path/pci-${igpuPciAddress}-render"

      external_connected=false
      if [ -e "$dgpu_card_path" ]; then
        dgpu_card="$("${pkgs.coreutils}/bin/readlink" -f "$dgpu_card_path")"
        dgpu_card="''${dgpu_card##*/}"
        for status in /sys/class/drm/"$dgpu_card"-*/status; do
          [ -e "$status" ] || continue
          if [ "$(<"$status")" = connected ]; then
            external_connected=true
            break
          fi
        done
      fi

      ${pkgs.coreutils}/bin/mkdir -p "$config_dir"
      if [ "$external_connected" = true ]; then
        render_device="$dgpu_render_path"
      else
        render_device="$igpu_render_path"
      fi

      {
        ${pkgs.coreutils}/bin/printf '%s\n' 'debug {'
        ${pkgs.coreutils}/bin/printf '    render-drm-device "%s"\n' "$render_device"
        ${pkgs.coreutils}/bin/printf '%s\n' '}'
      } > "$render_config_tmp"
      ${pkgs.coreutils}/bin/mv -f "$render_config_tmp" "$render_config"

      real_session="$("${pkgs.coreutils}/bin/dirname" "$("${pkgs.coreutils}/bin/readlink" -f "$0")")/niri-session-real"
      exec "$real_session" "$@"
      EOF
      chmod +x $out/bin/niri-session
    '';
  });
in
{
  config = lib.mkIf config.programs.niri.enable {
    programs.niri.package = lib.mkForce niriPackage;
  };
}
