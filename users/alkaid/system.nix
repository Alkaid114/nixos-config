{pkgs,config, ...}:
{
  imports = [
    ../../common/plasma.nix
  ];
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = with pkgs; [
    google-chrome
    kate
    konsole
    btrfs-progs       # Btrfs 命令行工具，如 btrfs subvolume/snapshot
    snapper           # 快照管理工具
    btrfs-assistant   # 图形化快照管理工具（如可用）
    vscode
    zsh
    bash
    distrobox
  ];

  environment.shells = with pkgs; [
    bash
    zsh
  ];

  virtualisation.docker.enable = true;
}