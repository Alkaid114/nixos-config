{
  pkgs,
  config,
  lib,
  username,
  ...
}:
{
  home.packages = with pkgs; [
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fzf
    fishPlugins.grc
    jq
    fd
    grc
    starship
  ];

  xdg.configFile = {
    "starship.toml".source = ../dotfiles/.config/starship.toml;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = pkgs.lib.fileContents ../dotfiles/.config/fish/config.fish;
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc;
      }
    ];
  };
}
