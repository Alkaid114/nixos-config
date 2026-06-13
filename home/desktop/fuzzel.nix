{ lib, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        dpi-aware = "auto";
        prompt = ">";
        icons-enabled = "yes";
        lines = 20;
        width = 40;
        horizontal-pad = 40;
        vertical-pad = 12;
        inner-pad = 2;
        image-size-ratio = 0.3;
      };
      colors = lib.mkDefault {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "bac2deff";
        placeholder = "7f849cff";
        input = "cdd6f4ff";
        match = "b4befeff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "b4befeff";
        counter = "7f849cff";
        border = "b4befeff";
      };
      border = {
        width = 3;
        radius = 12;
      };
    };
  };
}
