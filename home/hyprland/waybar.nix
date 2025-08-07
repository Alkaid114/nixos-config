{
  config,
  pkgs,
  ...
}: {
  home.file.".config/waybar/config".text = ''
    {
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["clock"],
      "modules-right": ["network", "bluetooth", "battery", "tray"],

      "network": {
        // 不指定 interface，Waybar 会自动选择活跃设备
        "format-wifi": "📶 {essid} ({signalStrength}%)",
        "format-ethernet": "🖧 {ipaddr}",
        "format-disconnected": "🚫 Offline",
        "tooltip-format": "IP: {ipaddr}\nMAC: {hwaddr}\nType: {ifname}"
      }


      "bluetooth": {
        "format": " {status}",
        "format-connected": " {device_alias}"
      },

      "battery": {
        "format": "{capacity}% {icon}",
        "format-charging": "⚡ {capacity}%"
      },

      "clock": {
        "format": "🕒 {:%H:%M}"
      }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
      font-family: "JetBrainsMono Nerd Font", "Noto Sans CJK SC", sans-serif;
      font-size: 14px;
      color: #ffffff;
    }

    #battery {
      color: #00ff00;
    }

    #clock {
      padding: 0 10px;
      background-color: #333333;
      border-radius: 5px;
    }

    #network {
      padding: 0 10px;
      color: #00ffff;
      background-color: #222;
      border-radius: 5px;
    }
  '';

}