{
  programs.plasma.konsole = {
    enable = true;

    profiles = {
      "Alkaid" = {
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 13;
        };
        colorScheme = "Breeze";
        # transparency = 0.3;
        command = "/usr/bin/zsh"

      };
    };

    defaultProfile = "Alkaid";
  };
}
