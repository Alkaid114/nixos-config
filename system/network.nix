{ ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ 
    "Meta"
  ];
    allowedTCPPorts = [ 7897 ]; # Clash 
    allowedUDPPorts = [ 7897 ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # networking.networkmanager.connectionProfiles = [
  #   {
  #     connection.id = "static-wlp4s0";
  #     connection.type = "ethernet";
  #     connection.interface-name = "wlp4s0";
  #     ipv4.addresses = [
  #       {
  #         address = "192.168.1.16";
  #         prefixLength = 24;
  #       }
  #     ];
  #     ipv4.gateway = "192.168.124.2";
  #     ipv4.dns = ["223.5.5.5"];
  #     ipv4.method = "manual";
  #   }
  # ];
}
