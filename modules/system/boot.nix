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
          tmp_conf=$(${pkgs.coreutils}/bin/mktemp)
          marker_begin='# BEGIN external EFI entries'
          marker_end='# END external EFI entries'
          ${pkgs.gawk}/bin/awk -v begin="$marker_begin" -v end="$marker_end" '
            $0 == begin { skip=1; next }
            $0 == end { skip=0; next }
            !skip { print }
          ' /boot/limine/limine.conf > "$tmp_conf"
          printf '\n%s\n' "$marker_begin" >> "$tmp_conf"

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
                  "$entry" "$entry" >> "$tmp_conf"
                ;;
            esac
          done
          printf '%s\n' "$marker_end" >> "$tmp_conf"
          ${pkgs.coreutils}/bin/install -m 0600 "$tmp_conf" /boot/limine/limine.conf
          ${pkgs.coreutils}/bin/rm -f "$tmp_conf"
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
