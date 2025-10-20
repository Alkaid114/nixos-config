{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./vscode.nix
    ./haskell.nix
  ];

  home.packages = with pkgs; [
    gdbgui
  ];
}
