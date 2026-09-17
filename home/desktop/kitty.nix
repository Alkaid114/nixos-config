{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
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
      # Standard Unicode uses kitty/fontconfig fallback by actual glyph coverage.
      # Only Nerd Font private-use codepoints need an explicit mapping.
      symbol_map U+E000-U+E00A,U+E0A0-U+E0A2,U+E0A3,U+E0B0-U+E0B3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D7,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6B7,U+E700-U+E8EF,U+EA60-U+EC1E,U+ED00-U+EFCE,U+F000-U+F2FF,U+F300-U+F381,U+F400-U+F533,U+F0001-U+F1AF0 Symbols Nerd Font Mono
    '';
  };
}
