{
  ...
}:
# let
#   nvidia-cfg = pkgs.callPackage ../../hardware/nvidia-laptop-power-cfg.nix {};
# in
{
  imports = [
    ./hardware-configuration.nix
    ../../hardware/bluetooth.nix
    ../../hardware/amdgpu.nix
    ../../hardware/nvidia.nix
    ../../hardware/wifi.nix
    ../../hardware/common.nix
  ];

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
