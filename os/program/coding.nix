{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-tree
    git
    gdb
    vim
    nano
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      glibc
      zlib
      openssl

      icu
      libxml2
      libuuid
      libsecret
      glib
      atk
      at-spi2-atk
      cairo
      pango
      gdk-pixbuf
      gtk3
      gtk2

      wayland
      libxkbcommon
      libGL
      mesa

      alsa-lib
      libpulseaudio
    ];
  };
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
