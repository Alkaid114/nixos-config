{ pkgs, ... }:
{
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    interactiveShellInit = ''

      alias ls='lsd'
    '';
  };
}
