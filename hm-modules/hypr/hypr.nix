{ pkgs, lib, config, inputs, ... }:

{
  options = {
    hypr.enable = lib.mkEnableOption "enables hypr" 
  };

  config = lib.mkIf config.hypr.enable {
    home.file.".config/hypr".source = .;
  };
}
