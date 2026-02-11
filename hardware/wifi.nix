{ ... }:
{
  networking = {
    wireless = {
      enable = false;
      iwd = {
        enable = true;
      };
    };
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };
}
