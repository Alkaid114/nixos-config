{ pkgs, ... }:
{
  stylix.enable = true;
  stylix.autoEnable = true;


  # 可选：设置壁纸和主题
  stylix.image = ./niri/wallpaper.png;
  stylix.polarity = "dark";

  stylix.fonts = {
    serif = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK SC";
    };

    sansSerif = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK SC";
    };

    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrains Mono Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

}
