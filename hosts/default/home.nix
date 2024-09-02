{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.self.outputs.homeManagerModules.default ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  
  git.enable = true;
  hypr.enable = true;
}
