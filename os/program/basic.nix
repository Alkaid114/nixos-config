{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    zip
    xz
    p7zip
    unzip
    lm_sensors
    fastfetch
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    nix-output-monitor
    htop
    strace
    lsof
    lsd
    ffmpeg-full
    tealdeer
  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
}
