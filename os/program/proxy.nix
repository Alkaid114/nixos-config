{ pkgs, ... }:
{
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    tunMode = true;
    serviceMode = true;
  };
  # services.mihomo = {
  #   enable = true;
  #   webui = pkgs.metacubexd;
  #   tunMode = true;
  #   configFile = ../../home/dotfiles/mihomo/config2.yaml;
  # };

  # environment.systemPackages = with pkgs; [
  #   clash-meta
  # ];
}
