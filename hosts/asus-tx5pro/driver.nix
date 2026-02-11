{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = lib.mkForce inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    hostName = "asus-tx5pro";
    wireless = {
      enable = false;
      iwd = {
        enable = true;
      };
    };
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };

  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
          offloadCmdMainProgram = "prime-run";
        };
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:6:0:0";
      };
      videoAcceleration = true;
      dynamicBoost.enable = true;
    };
    nvidia-container-toolkit.enable = true;
    amdgpu = {
      initrd = {
        enable = true;
      };
      opencl.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  powerManagement = {
    enable = true;
    cpufreq.max = 4200000;
  };

  boot.kernelModules = [
    "amdgpu"
    "ntsync"
  ];
  boot.kernelParams = [ "modprobe.blacklist=nouveau" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
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

  environment.systemPackages = with pkgs; [
    acpi
    libva
    libva-utils
    mesa
    libva-vdpau-driver
    vdpauinfo
    blueman
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  system.stateVersion = "25.11";
}
