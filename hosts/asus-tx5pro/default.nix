{ pkgs, ... }:
# let
#   nvidia-cfg = pkgs.callPackage ../../packages/nvidia-laptop-power-cfg.nix {};
# in
{
  programs.niri.package = pkgs.niri.overrideAttrs (oldAttrs: {
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
      nvidia_card_path="/dev/dri/by-path/pci-0000:01:00.0-card"
      nvidia_render_path="/dev/dri/by-path/pci-0000:01:00.0-render"
      amdgpu_render_path="/dev/dri/by-path/pci-0000:06:00.0-render"

      external_connected=false
      if [ -e "$nvidia_card_path" ]; then
        nvidia_card="$(readlink -f "$nvidia_card_path")"
        nvidia_card="''${nvidia_card##*/}"
        for status in /sys/class/drm/"$nvidia_card"-*/status; do
          [ -e "$status" ] || continue
          if [ "$(<"$status")" = connected ]; then
            external_connected=true
            break
          fi
        done
      fi

      mkdir -p "$config_dir"
      if [ "$external_connected" = true ]; then
        render_device="$nvidia_render_path"
      else
        render_device="$amdgpu_render_path"
      fi

      {
        printf '%s\n' 'debug {'
        printf '    render-drm-device "%s"\n' "$render_device"
        printf '%s\n' '}'
      } > "$render_config_tmp"
      mv -f "$render_config_tmp" "$render_config"

      real_session="$(dirname "$(readlink -f "$0")")/niri-session-real"
      exec "$real_session" "$@"
      EOF
      chmod +x $out/bin/niri-session
    '';
  });

  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/amdgpu.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/wifi.nix
    ../../modules/hardware/keyboard.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/printing.nix
  ];

  fileSystems = {
    "/".options = [
      "compress=zstd:3"
      "noatime"
    ];
    "/home".options = [
      "compress=zstd:3"
      "noatime"
    ];
    "/root".options = [
      "compress=zstd:3"
      "noatime"
    ];
    "/var/log".options = [
      "compress=zstd:3"
      "noatime"
    ];
    "/var/cache".options = [
      "compress=zstd:3"
      "noatime"
    ];
    "/var/tmp".options = [
      "compress=zstd:3"
      "noatime"
    ];
    "/nix".options = [
      "compress=zstd:3"
      "noatime"
    ];
  };

  # services.udev.packages = [ nvidia-cfg ];
  # boot.extraModprobeConfig = builtins.readFile "${nvidia-cfg}/lib/modprobe.d/nvidia.conf";

  networking = {
    hostName = "asus-tx5pro";
  };

  hardware = {
    nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
          offloadCmdMainProgram = "prime-run";
        };
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:6:0:0";
      };
      powerManagement.finegrained = true;
    };
  };

  powerManagement = {
    enable = true;
    cpufreq.max = 4200000;
  };

  boot.kernelModules = [
    "ntsync"
  ];

  services = {
    asusd = {
      enable = true;
    };
    power-profiles-daemon.enable = true;
    upower.enable = true;
    acpid.enable = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  system.stateVersion = "26.05";
}
