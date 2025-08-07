{pkgs,config, ...}:
{
  home.packages = with pkgs;[
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    # promptInit = ''
    #   source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    #   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    # '';
    # ohMyZsh = {
    #   enable = true;
    #   plugins = [ "git" "history" "z" ];
    # };
  };
}