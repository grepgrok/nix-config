{ pkgs, lib, config, ... }:

{
  options = {
    alacritty.enable = lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
	  padding = { x = 16; y = 16; };
	  opacity = 0.9;
	  blur = true;
	};

	colors = {
	  # TODO: color scheme
	  transparent_background_colors = true;
	};
      };
    };
  };
}
