{ pkgs, ... }:
{
  networking.networkmanager.enable = true;

  networking = {
    nameservers = [
      "1.1.1.1"
      "223.5.5.5"
      "223.6.6.6"
      "2400:3200::1"
      "2400:3200:baba::1"
    ];
    wireguard.enable = true;
    nftables.enable = true;
  };
  services.firewalld = {
    enable = true;
    zones = {
      trusted = {
        masquerade = true;
        interfaces = [
          "Meta"
          "Mihomo"
          "FlClash"
        ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    firewalld-gui
  ];
}
