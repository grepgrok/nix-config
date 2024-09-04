{ pkgs, config, lib, ... }:

{
  imports = 
    [
      # TODO: auto-search the directory
      ./hypr/default.nix
      ./clipse/default.nix
      ./git.nix
      ./alacritty.nix
      ./zsh.nix
    ];
}
