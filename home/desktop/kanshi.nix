{ ... }:
{
  # 外接显示器时禁用笔记本屏幕
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "laptop-only";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "with-dp5";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-5";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "with-hdmi";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "HDMI-1";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "with-both";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-5";
              status = "enable";
            }
            {
              criteria = "HDMI-1";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
