{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    hplip
    hplipWithPlugin
  ];

  services.printing.enable = true;
  services.printing.browsed.enable = true; # Enable network printer discovery
  services.system-config-printer.enable = true; # GUI for printer management
  services.ipp-usb.enable = true; # Enable IPP-over-USB for modern printers
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Ensure printer configuration persists across reboots
  hardware.printers.ensurePrinters = [
    {
      name = "HP_DeskJet_5820_series_586252";
      deviceUri = "dnssd://HP%20DeskJet%205820%20series%20%5B586252%5D._ipp._tcp.local/?uuid=1c852a4d-b800-1f08-abcd-705a0f586252";
      model = "everywhere";
      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];

  # Set as default printer
  hardware.printers.ensureDefaultPrinter = "HP_DeskJet_5820_series_586252";
}