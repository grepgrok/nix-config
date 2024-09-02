{ config, pkgs, inputs, ... }:

{
  # imports = [ ../../modules/home-manager/hypr ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  
  hypr.enable = true;
}
