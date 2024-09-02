{ pkgs, config, lib, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git.enable = true;
    programs.git.userName = "grepgrok";
    programs.git.userEmail = "ben.k.olson@gmail.com";
  };
}
