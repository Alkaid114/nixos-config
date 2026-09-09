{ lib, pkgs, ... }:
{
  fileSystems."/boot".options = lib.mkForce [ "umask=0077" ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      limine = {
        enable = true;
        efiSupport = true;
        extraInstallCommands = ''
          declare -A seen=()
          ${pkgs.efibootmgr}/bin/efibootmgr -v | while IFS= read -r line; do
            case "$line" in
              Boot[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]\**HD\(*)
                entry="''${line#Boot????\* }"
                entry="''${entry%%$'\t'*}"
                [ "$entry" = "Limine" ] && continue
                [ -n "''${seen[$entry]:-}" ] && continue
                seen["$entry"]=1
                printf '\n/%s\n  protocol: efi_boot_entry\n  entry: %s\n' \
                  "$entry" "$entry" >> /boot/limine/limine.conf
                ;;
            esac
          done
        '';
        style.interface.resolution = "2560x1600";
        resolution = "2560x1600x32";
      };
      systemd-boot.enable = false;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {
      "kernel.sysrq" = 1;
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
    };
  };
}
