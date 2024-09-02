{ pkgs, lib, config, ... }:

{
  options = {
    hm-manager.hypr.enable = lib.mkEnableOption "enables hypr"; 
  };

  config = lib.mkIf config.hypr.enable {
    home.file.".config/hypr/hyprland.conf".source = lib.mkDefault ./hyprland.conf;
    home.file.".config/hypr/start.sh".source = lib.mkDefault ./start.sh;
  };
}
