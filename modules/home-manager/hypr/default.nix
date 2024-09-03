{ pkgs, lib, config, ... }:

{
  options = {
    hypr.enable = lib.mkEnableOption "enables hypr"; 
  };

  config = lib.mkIf config.hypr.enable {
    # TODO: This links into the store, not under $HOME. :(
    #home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./hyprland.conf;
    #home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./start.sh;
    home.file.".config/hypr/hyprland.conf".source = lib.mkDefault ./hyprland.conf;
    home.file.".config/hypr/start.sh".source = lib.mkDefault ./start.sh;
  };
}
