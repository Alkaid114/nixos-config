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
    htop
    strace
    lsof
    lsd
    ffmpeg-full
    tealdeer
    ripgrep
    nvtopPackages.amd
    nvtopPackages.nvidia
    nvtopPackages.intel
  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };

  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
