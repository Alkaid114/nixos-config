{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-tree
    git
    gdb
    gnumake
    man-pages
    man-pages-posix
  ];
  services.envfs.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries =
      with pkgs;
      [
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
        libX11
        libXcursor
        libXcomposite
        libXdamage
        libXext
        libXfixes
        libXi
        libXrender
        libXtst
        libXrandr
        vulkan-loader

        alsa-lib
        libpulseaudio

        nspr
        nss

        # bundled Qt5 需要这些
        fontconfig
        freetype
        dbus
        libdrm
        krb5
        libxcb
        libxcb-image
        libxcb-keysyms
        libxcb-render-util
        libxcb-wm
        libice
        libsm
      ]
      ++ lib.optionals config.my.hardware.nvidia.enable [
        pkgs.cudaPackages.cuda_cudart
        config.hardware.nvidia.package
      ];
  };
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
