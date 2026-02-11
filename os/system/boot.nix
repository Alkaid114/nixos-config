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
        efiSysMountPoint = "/boot/efi";
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
}
