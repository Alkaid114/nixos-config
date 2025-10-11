{ pkgs, username, ... }:
{
  users.users.${username} = {
    name = username;
    isNormalUser = true;
    shell = pkgs.zsh;
    description = username;
    initialPassword = "114514";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "power"
    ];
  };

  nix.settings.trusted-users = [ username ];
}
