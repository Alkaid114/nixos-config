{ ... }:
{
  programs.fuzzel.enable = true;
  xdg.configFile."fuzzel" = {
    source = ./dotfiles/.config/fuzzel;
    recursive = true;
  };
}
