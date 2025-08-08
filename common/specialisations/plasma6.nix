{
  config,
  pkgs, 
  ...
}: {

  services = {
    xserver = {
      enable = true;
    };
    displayManager = {
      sddm.enable = true;
    };
    desktopManager = {
      plasma6.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    
    (kdePackages.fcitx5-configtool.override {
      qtbase = kdePackages.qtbase;
    })
  ];
}