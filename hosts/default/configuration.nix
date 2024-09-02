
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "icarus"; # Define your hostname.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Los_Angeles";

  users.users.ben = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
  };
 
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users."ben" = import ./home.nix;
    sharedModules = [ inputs.self.outputs.homeManagerModules.default ];
  };

  programs.hyprland.enable = true;

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    git
    alacritty
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}

