{
  plugins.telescope = {
    enable = true;

    lazyLoad.settings.cmd = [ "Telescope" ];

    extensions = {
      fzf-native.enable = true;
    };
  };
}
