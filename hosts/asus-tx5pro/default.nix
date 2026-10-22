{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
    ../../modules/hardware
    ../../modules/desktop
    ../../modules/develop
    ../../modules/gaming
    ../../modules/virtual
  ];

  my = {
    hardware = {
      amdgpu.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      keyboard.enable = true;
      mouse.enable = true;
      printing.enable = true;
      wifi.enable = true;

      nvidia = {
        enable = true;
        prime = {
          enable = true;
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:6:0:0";
        };
      };
    };

    desktop.niri.renderDevice = {
      enable = true;
      igpuPciAddress = "0000:06:00.0";
      dgpuPciAddress = "0000:01:00.0";
    };
  };

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

  networking = {
    hostName = "asus-tx5pro";
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
