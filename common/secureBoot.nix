{ config, pkgs, ... }:

let
  mokKey = "/etc/secureboot/MOK.key";
  mokCert = "/etc/secureboot/MOK.crt";
in {
  environment.systemPackages = with pkgs; [
    shim
    mokutil
    openssl
    sbsigntool
  ];

  systemd.services.generate-mok-key = {
    description = "Generate MOK key and certificate";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        mkdir -p /etc/secureboot
        if [ ! -f ${mokKey} ]; then
          openssl req -new -x509 -newkey rsa:2048 \
            -keyout ${mokKey} -out ${mokCert} -nodes \
            -days 36500 -subj "/CN=NixOS Secure Boot/"
        fi
      '';
    };
  };

  systemd.services.sign-efi = {
    description = "Sign GRUB and kernel with MOK key";
    wantedBy = [ "multi-user.target" ];
    after = [ "generate-mok-key.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''

        # 签名 GRUB
        grub_efi="/boot/EFI/NixOS-boot/grubx64.efi"
        if [ -f "$grub_efi" ]; then
          sbsign --key "${mokKey}" --cert "${mokCert}" --output "$grub_efi" "$grub_efi"
        fi

        # 签名所有内核和 initrd EFI 文件
        for efi_file in /boot/EFI/nixos/*.efi; do
          sbsign --key "${mokKey}" --cert "${mokCert}" --output "$efi_file" "$efi_file"
        done
      '';
    };
  };

  system.activationScripts.signEfiAndModules = {
    text = ''
      PATH=${pkgs.lib.makeBinPath [ pkgs.sbsigntool pkgs.kmod pkgs.openssl ]}
      key="/etc/secureboot/MOK.key"
      cert="/etc/secureboot/MOK.crt"

      # 签名 GRUB
      grub_efi="/boot/EFI/NixOS-boot/grubx64.efi"
      if [ -f "$grub_efi" ]; then
        sbsign --key "${mokKey}" --cert "${mokCert}" --output "$grub_efi" "$grub_efi"
      fi

      # 签名所有内核和 initrd EFI 文件
      for efi_file in /boot/EFI/nixos/*.efi; do
        sbsign --key "${mokKey}" --cert "${mokCert}" --output "$efi_file" "$efi_file"
      done
    '';
  };

}
