{
  pkgs,
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
  ];

  programs.fish = {
    enable = true;
    shellInit = pkgs.lib.fileContents ./config.fish + ''
      if status is-interactive
        ${pkgs.direnv}/bin/direnv hook fish | source
      end
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
