{ pkgs, lib, config, ... }:

{
  options = {
    hypr.enable = lib.mkEnableOption "enables hypr"; 
  };

  config = lib.mkIf config.hypr.enable {
    home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./hyprland.conf;
    home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./start.sh;
  };
}
