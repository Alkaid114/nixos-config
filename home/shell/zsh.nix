{pkgs}:
{
  home.packages = with pkgs;[
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
    # Powerlevel10k configuration
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };
}