{ ... }:
{
  networking = {
    wireless = {
      enable = true;
      iwd = {
        enable = false;
      };
    };
    networkmanager = {
      enable = true;
    };
  };
}
