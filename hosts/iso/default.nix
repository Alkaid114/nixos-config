{ inputs, pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];

  nixpkgs = {
    hostPlatform = inputs.nixpkgs.lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  services = {
    qemuGuest.enable = true;
    openssh.settings.PermitRootLogin = inputs.nixpkgs.lib.mkForce "yes";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = inputs.nixpkgs.lib.mkForce ["btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
  };

  networking = {
    hostName = "iso";
  };

  systemd = {
    services.sshd.wantedBy = inputs.nixpkgs.lib.mkForce ["multi-user.target"];
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  system.stateVersion = "25.11";
}