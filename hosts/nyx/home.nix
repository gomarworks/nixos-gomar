{ config, pkgs, inputs,... }:

{
  ##########################################################################
  # Basic Home Manager Configuration
  ##########################################################################
  home.username = "gomar";
  home.homeDirectory = "/home/gomar";

  # Define the Home Manager release compatibility
  home.stateVersion = "24.05"; # Please read the comment before changing. # Do not TOUCH
  
  # Allow installation of unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  ##########################################################################
  # Home Manager Packages
  ##########################################################################
  home.packages = with pkgs; [
    lazygit
    syncthing
  ];

  ##########################################################################
  # Import External Configurations
  ##########################################################################
  imports = [ 
    ../../homeManagerModules/nixvim.nix # Nixvim configuration
    ../../homeManagerModules/kitty.nix # Kitty configuration
    ../../homeManagerModules/emacs # Emacs configuration
    inputs.nixvim.homeManagerModules.default # Nixvim module import
  ]; 

  ##########################################################################
  # Chromium (Brave) Configuration
  ##########################################################################

  programs.chromium = {
    enable = true;
    package = pkgs.brave;

    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } #1Password
      { id = "fjcldmjmjhkklehbacihaiopjklihlgg"; } #News Feed Eradicator
      { id = "bhghoamapcdpbohphigoooaddinpkbai"; } #Authenticator
      { id = "laookkfknpbbblfpciffpaejjkokdgca"; } #Momentum
    
      { id = "neaebjphlfplgdhedjdhcnpjkndddbpd"; } #Vue Telescope
      { id = "iaajmlceplecbljialhhkmedjlpdblhp"; } #Vue.js devtools
    ];
   commandLineArgs = [
      "--disable-features=PasswordManagerOnboarding"
      "--disable-features=AutofillEnableAccountWalletStorage"
    ];
  };

  ##########################################################################
  # Environment Variables
  ##########################################################################
  #home.sessionVariables = {
  # EDITOR = "emacs"; # Example, set EDITOR environment variable
  #};

  ##########################################################################
  # Home Manager Self-Management
  ##########################################################################
  programs.home-manager.enable = true;

}
