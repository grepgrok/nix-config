{ pkgs, config, lib, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "grepgrok";
      userEmail = "ben.k.olson@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
