{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    google-chrome
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
}
