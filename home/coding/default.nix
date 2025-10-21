{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./vscode.nix
    ./haskell.nix
    ./helix.nix
  ];

  home.packages = with pkgs; [
    gdbgui
  ];
}
