{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    
    # Oh My Zsh configuration
    ohMyZsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";  # Powerlevel10k theme for a "riced out" prompt
      plugins = [ "git" "z" "sudo" "vi-mode" "docker" ];  # Add plugins as needed
    };

    # Custom aliases and functions
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -lah";
      gs = "git status";
    };

    # Custom Zsh configuration
    shellInit = ''
      # Custom prompt settings (if not using Powerlevel10k, or additional settings)
      export ZSH_THEME="powerlevel10k/powerlevel10k"
      
      # Example: Add a fancy prompt
      if [[ ! -f ~/.p10k.zsh ]]; then
        source ${(q-)ZDOTDIR:-$HOME}/.zshrc
      fi

      # Other custom configurations
      bindkey -v  # Enable Vi key bindings
      export EDITOR=nvim  # Set Neovim as default editor
    '';

    # Additional customizations or Zsh plugins (e.g., fzf, autosuggestions)
    fzf.enable = true;  # Enable FZF for fuzzy finding
    zsh-autosuggestions.enable = true;  # Autosuggestions for command completion
    zsh-syntax-highlighting.enable = true;  # Syntax highlighting in Zsh
  };
}

