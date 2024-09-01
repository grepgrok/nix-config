{ pkgs, lib, config, inputs, ... }:

{
  options = {
    hypr.enable = lib.mkEnableOption "enables hypr"; 
  };

  config = lib.mkIf config.hypr.enable {
    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.file.".config/hypr/start.sh".source = ./start.sh;
  };
}
