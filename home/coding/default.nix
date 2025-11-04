{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./vscode.nix
    # ./haskell.nix
    # ./helix.nix
    ./neovim.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    gdbgui
    uv
    nomachine-client
    filezilla
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
