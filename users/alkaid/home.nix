{pkgs,inputs,username, ...}: {
  imports = [
    ./fcitx5.nix
    ./shell
  ];

  programs.git = {
    enable = true;
    userName = "Alkaid";
    userEmail = "xinlai.gao2006@outlook.com";
  };

  home.packages = with pkgs;[

    fastfetch

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
  ];
}