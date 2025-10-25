{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./vscode.nix
    ./haskell.nix
    ./helix.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    gdbgui
    uv
  ];
}
