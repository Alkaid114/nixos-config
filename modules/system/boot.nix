{
  pkgs,
  lib,
  ...
}:
{
  fileSystems."/boot".options = lib.mkForce [ "umask=0077" ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      limine = {
        enable = false;
        efiSupport = true;
      };
      systemd-boot = {
        enable = true;
        extraInstallCommands = ''
          ${pkgs.systemd}/bin/bootctl install --esp-path=/boot --efi-boot-option-description=NixOS
        '';
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };
  };
}
