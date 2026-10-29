{ pkgs, inputs, ... }:
let
  cursorShader = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "cursor-shaders";
    rev = "9ad9158a93c0de0c045e1c6b27df37da698bc8af";
    sha256 = "sha256-TnoQvptwjs6P5/JfJO1CR3yhCfCcaw5wvPr5oEhn4Ho=";
  };
in
{
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      theme = "Catppuccin Mocha";
      font-family = [
        "JetBrains Mono"
        "Noto Sans Mono CJK SC"
        "Noto Sans Symbols 2"
        "Noto Color Emoji"
      ];
      font-style = "Medium";
      font-size = 13;
      cursor-style = "block";
      shell-integration-features = "no-cursor";
      auto-update = "off";
      window-padding-x = 10;
      window-padding-y = 3;
      window-padding-balance = true;
      # language = "en";
      command = "${pkgs.fish}/bin/fish";
      custom-shader = "${cursorShader}/ghostty/cursor_tail.glsl";
      # custom-shader-animation = "always";
      gtk-single-instance = true;
      window-inherit-working-directory = false;
      working-directory = "home";
    };
  };
}
