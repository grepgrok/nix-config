{ pkgs, config, lib, ... }:

{
  imports = 
    [
      ./hypr/default.nix
      ./git.nix
    ];
}
