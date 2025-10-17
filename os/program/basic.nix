{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    # archives
    zip
    xz
    unzip
    lm_sensors # for `sensors` command
    fastfetch
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

    btop # replacement of htop/nmon
    # iotop # io monitoring
    # iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    lsof # list open files

  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
}
