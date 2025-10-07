{pkgs}:
{
  environment.systemPackages = with pkgs; [
    google-chrome
    btrfs-progs       # Btrfs 命令行工具，如 btrfs subvolume/snapshot
    snapper           # 快照管理工具
    btrfs-assistant   # 图形化快照管理工具（如可用）
    vscode
    vim
    wget
    curl
    git
    lm_sensors # for `sensors` command
    fastfetch
    mesa-demos
    # archives
    zip
    xz
    unzip

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop  # replacement of htop/nmon
    # iotop # io monitoring
    # iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # audio
    alsa-utils
    pavucontrol
    pamixer
  ];
}