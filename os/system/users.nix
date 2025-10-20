{ pkgs, username, ... }:
{
  users.users.${username} = {
    name = username;
    isNormalUser = true;
    shell = pkgs.fish;
    description = username;
    initialPassword = "114514";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "power"
      "storage"
    ];
  };

  nix.settings.trusted-users = [ username ];
}
