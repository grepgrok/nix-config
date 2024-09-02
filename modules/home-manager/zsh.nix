{ pkgs, lib, config, ... }:

{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        # TODO: make this use current host
        rebuild = "sudo nixos-rebuild switch --flake $HOME/nixos#default";
      };
    };
  };
}
