{ config, pkgs, ... };

{
    home.username = "walrus";
    home.homeDirectory = "/home/walrus";
    programs.git.enable = true;
    home.stateVersion = "25.05";
    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo I use nixos, btw";
        };
    };
}
