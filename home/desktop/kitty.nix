{ pkgs, ... }:
{
  home.packages = [ pkgs.noto-fonts-cjk-sans ];
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
    shellIntegration = {
      mode = null;
    };
    mouseBindings = {
      "ctrl+left release" = "ungrabbed mouse_handle_click link";
      "left click" = "ungrabbed no_op";
    };
    settings = {
      window_padding_width = "3 10";
      text_composition_strategy = "platform";
      cursor_shape = "block";
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;
      enable_audio_bell = false;
      window_alert_on_bell = true;
      narrow_symbols_precomposed = true;
      shell_integration = "enabled no-cursor";
      shell = "${pkgs.fish}/bin/fish";
    };
    extraConfig = ''
      # 基础汉字
      symbol_map U+4E00-U+9FFF Noto Sans Mono CJK SC

      # CJK标点符号
      symbol_map U+3000-U+303F Noto Sans Mono CJK SC

      # 全角ASCII及闭合字母数字
      symbol_map U+FF00-U+FFEF Noto Sans Mono CJK SC

      # 额外扩展区
      symbol_map U+20000-U+2A6DF Noto Sans Mono CJK SC

      # emoji
      symbol_map U+1F300-U+1FAD6 Noto Color Emoji
    '';
  };
}
