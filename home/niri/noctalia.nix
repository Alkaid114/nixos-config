{ pkgs, inputs, ... }:
{
  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ../dotfiles/noctalia/settings.json);
  };
}
