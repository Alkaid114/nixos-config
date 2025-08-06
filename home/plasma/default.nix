{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [ 
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./konsole.nix
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select"; # If you liked the click-to-open default from plasma 5
      wallpaper = ../../wallpapers.png;
      globalTheme = "BreezeDark";
      iconTheme = "BreezeDark";
      cursorType = {
        theme = "BreezeLight";
      };
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    panels = [
      {
        location = "bottom";
        widgets = [ 
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
              };
            } 
            {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
              # And explicitly hide networkmanagement and volume
              hidden = [
                "org.kde.plasma.bluetooth"
              ];
            };
          }
          ];
      }
    ];
  };

  xresources.properties = {
    "Xcursor.size" = 18;
    "Xft.dpi" = 132;
  };

}