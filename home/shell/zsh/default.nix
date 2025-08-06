{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      # gs = "git status";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
        file = "powerlevel10k.zsh-theme";
      }
    ];


  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh
  ];

  # 添加 p10k 配置文件（你可以用 p10k configure 生成）
  home.file.".p10k.zsh".text = builtins.readFile ./.p10k.zsh;
}
