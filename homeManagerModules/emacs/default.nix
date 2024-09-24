{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      # Voeg hier je Emacs-pakketten toe, bijvoorbeeld:
      epkgs.spacious-padding
      epkgs.evil
      epkgs.org
      epkgs.org-present
    ];
  };

  home.file.".emacs.d/init.el".source = ./init.el;

  # Maak een alias voor het starten van Emacs in vanilla mode met alleen jouw init.el
  programs.bash.shellAliases = {
    emacs = "emacs -Q -l ~/.emacs.d/init.el";
  };# epkgs.magit
      # epkgs.org
}
