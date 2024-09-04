{ pkgs, lib, config, ... }:

{
  options = {
    clipse.enable = lib.mkEnableOption "enables clipse";
  };

  config = lib.mkIf config.clipse.enable {
    # TODO: this is a common pattern. Make it a lib function
    home.file.".config/clipse/config.json".source = 
      lib.mkDefault ./config.json;
    home.file.".config/clipse/catppuccin.json".source = 
      lib.mkDefault ./catppuccin.json;
  };
}
