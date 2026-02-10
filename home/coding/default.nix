{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    uv
    filezilla
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
