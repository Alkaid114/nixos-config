{pkgs,config, ...}:
{
  imports = [
    # ../../common/secureBoot.nix
  ];
  

  specialisation = {
    plasma6.configuration = import ../../common/specialisations/plasma6.nix;
    hyprland.configuration = import ../../common/specialisations/hyprland;
  };


  environment.systemPackages = with pkgs; [
    google-chrome
    btrfs-progs       # Btrfs 命令行工具，如 btrfs subvolume/snapshot
    snapper           # 快照管理工具
    btrfs-assistant   # 图形化快照管理工具（如可用）
    vscode
    zsh
    bash
    distrobox
  ] ++(with kdePackages; [
    kate
    konsole
  ]);


  environment.shells = with pkgs; [
    bash
    zsh
  ];

  programs.zsh.enable = true;


  virtualisation.docker.enable = true;
}