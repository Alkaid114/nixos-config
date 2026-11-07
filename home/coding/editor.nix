{ pkgs, ... }:
{
  imports = [
    ./emacs
  ];

  home.packages = with pkgs; [
    vscode
  ];
}
