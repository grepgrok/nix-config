
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "icarus"; # Define your hostname.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Desktop portals (screen sharing, link opening, file opening, etc.)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # TODO: many other options  

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
    users.modules = [ inputs.self.outputs.homeManagerModules.default ];
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; [
    git
    kitty

    waybar
    dunst # notification daemon
      libnotify
    swww # wallpaper daemon (TODO: check other options)
    rofi-wayland # TODO: app launcher
    networkmanagerapplet
    grim         # screenshot util --+
    slurp        # select util       |
    wl-clipboard # xclip alt       --+
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}

