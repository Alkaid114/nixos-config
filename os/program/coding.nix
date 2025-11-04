{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-rfc-style

    vscode
    git

    cmake
    # gcc
    gnumake
    clang
    clang-tools
    clang
    libclang
    glibc
    gdb
    gcc_multi
    libgcc
    binutils
    ninja
    openssl
    pkg-config

    wireguard-tools
  ];

  environment.variables = {
    LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    LD_LIBRARY_PATH = [
      "${config.hardware.nvidia.package}/lib"
      "$LD_LIBRARY_PATH" # 保留原有值
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      eigen
    ];
  };

  networking.wireguard.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
