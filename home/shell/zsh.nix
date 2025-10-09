{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-autosuggestions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    # initContent = ''
    # # Powerlevel10k configuration
    # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    # source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    # '';
    plugins = [
      # {
      #   name = "powerlevel10k-config";
      #   src = ../dotfiles/.p10k.zsh;
      #   file = "p10k.zsh";
      # }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };
}
