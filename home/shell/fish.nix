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
    "starship.toml".source = ./dotfiles/starship.toml;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
      set fish_greeting # Disable greeting
    '';
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
