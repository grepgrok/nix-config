{ pkgs, lib, config, ... }:

{
  options = {
    ags.enable = lib.mkEnableOption "enables AGS (Aylur's Gtk Shell)";
  };

  config = lib.mkIf config.ags.enable {
    # TODO: can I include the flake.nix and home.nix import here?
    # TODO: can I source a whole director except this default.nix?
    #home.file.".config/ags/config.js".source = ./config.js;

    programs.ags = {
      enable = true;
      configDir = ./.;
      extraPackages = with pkgs; [
        gtksourceview
	webkitgtk
	accountsservice
      ];
    };
  };
}
