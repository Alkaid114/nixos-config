{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-rfc-style

    vscode
    git
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
