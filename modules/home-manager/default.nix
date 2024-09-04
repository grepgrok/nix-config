{ pkgs, config, lib, ... }:

{
  imports = 
    [
      # TODO: auto-search the directory
      ./ags/default.nix
      ./clipse/default.nix
      ./hypr/default.nix
      ./alacritty.nix
      ./git.nix
      ./zsh.nix
    ];
}
