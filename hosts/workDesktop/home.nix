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
    blender # 3D graphics
    openscad # parametric CAD
    audacity # Audio editing 
    teams-for-linux # Microsoft Teams for linux
    signal-desktop # Signal desktop client
    gimp
    xclip
    lazygit
    vscode
  ];
  
  programs.vscode.mutableExtensionsDir = false;
  
  ##########################################################################
  # Import External Configurations
  ##########################################################################
  imports = [ 
    ../../homeManagerModules/nixvim.nix # Nixvim configuration
    ../../homeManagerModules/kitty.nix # Kitty configuration
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
    ];

   commandLineArgs = [
      "--disable-features=PasswordManagerOnboarding"
      "--disable-features=AutofillEnableAccountWalletStorage"
    ];
  };

  ##########################################################################
  # Environment Variables
  ##########################################################################
  home.sessionVariables = {
  # EDITOR = "emacs"; # Example, set EDITOR environment variable
  };

  ##########################################################################
  # Home Manager Self-Management
  ##########################################################################
  programs.home-manager.enable = true;

}
