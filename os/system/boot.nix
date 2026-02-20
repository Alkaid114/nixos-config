{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      #   useOSProber = true;
      #   theme = lib.mkForce inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
      # };
      limine = {
        enable = false;
        efiSupport = true;
      };
      systemd-boot.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_6_19;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };
  };
}
