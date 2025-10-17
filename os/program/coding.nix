{ pkgs, ... }:
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
    glibc
    gdb
    gcc_multi
    libgcc
    binutils
    ninja

    wireguard-tools
  ];

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
