{pkgs,inputs, ...}: {
  imports = [
    ../../home/core.nix

    ../../home/fcitx5
    ../../home/hyprland
    ../../home/programs
    ../../home/shell
  ];

  programs.git = {
    enable = true;
    userName = "Alkaid";
    userEmail = "xinlai.gao2006@outlook.com";
  };

  home.packages = with pkgs;[

    # 如下是我常用的一些命令行工具，你可以根据自己的需要进行增删
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
    iotop # io monitoring
    iftop # network monitoring

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

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO 在这里添加你的自定义 bashrc 内容
    # bashrcExtra = ''
    #   export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    # '';

    # TODO 设置一些别名方便使用，你可以根据自己的需要进行增删
    # shellAliases = {
    #   k = "kubectl";
    #   urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    #   urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    # };
  };
}