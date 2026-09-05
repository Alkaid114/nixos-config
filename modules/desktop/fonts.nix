{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      inter
      material-icons
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      corefonts

      material-design-icons
      material-symbols
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono

      (pkgs.callPackage ../../packages/ttf-ms-win11-auto.nix { })
      (pkgs.callPackage ../../packages/ttf-ms-win11-auto-zh_cn.nix { })
      (pkgs.callPackage ../../packages/ttf-ms-win11-fod-auto-hans.nix { })
    ];
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif CJK SC"
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Inter"
        "Noto Sans CJK SC"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Sans Mono CJK SC"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
