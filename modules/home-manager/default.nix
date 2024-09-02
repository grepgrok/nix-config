{ pkgs, config, lib, ... }:

{
  imports = 
    [
      #./hypr
      ./git.nix
    ];
}
