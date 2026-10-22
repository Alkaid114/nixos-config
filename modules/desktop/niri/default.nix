{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.desktop.niri.renderDevice;

  niriPackage = pkgs.niri.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ../../../patches/niri-shm-2604.patch
    ];
    postInstall =
      (oldAttrs.postInstall or "")
      + lib.optionalString cfg.enable ''
        mv $out/bin/niri-session $out/bin/niri-session-real
        cat > $out/bin/niri-session <<'EOF'
        #!${pkgs.runtimeShell}
        set -eu

        config_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/niri"
        render_config="$config_dir/render-device.kdl"
        render_config_tmp="$render_config.tmp.$$"
        dgpu_card_path="/dev/dri/by-path/pci-${cfg.dgpuPciAddress}-card"
        dgpu_render_path="/dev/dri/by-path/pci-${cfg.dgpuPciAddress}-render"
        igpu_render_path="/dev/dri/by-path/pci-${cfg.igpuPciAddress}-render"

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
  options.my.desktop.niri.renderDevice = {
    enable = lib.mkEnableOption "按外接屏切换 DRM render node";
    igpuPciAddress = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = "核显的 PCI 地址，例如 0000:06:00.0";
    };
    dgpuPciAddress = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = "独显的 PCI 地址，例如 0000:01:00.0";
    };
  };

  config = {
    assertions = [
      {
        assertion = !cfg.enable || (cfg.igpuPciAddress != null && cfg.dgpuPciAddress != null);
        message = "开启 niri renderDevice 时必须设置 igpuPciAddress 和 dgpuPciAddress";
      }
    ];

    services.xserver.xkb.layout = "us";

    programs.niri = {
      enable = true;
      useNautilus = true;
      package = lib.mkDefault niriPackage;
    };

    environment.systemPackages = with pkgs; [
      kitty
      fuzzel
      xwayland-satellite
      nautilus
      adwaita-icon-theme
      gnome-themes-extra
      file-roller
    ];

    services = {
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      gnome.localsearch.enable = true;
    };

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };
      mime.enable = true;
    };
  };
}
