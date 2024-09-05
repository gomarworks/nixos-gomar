{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Color scheme configuration
    colorschemes.gruvbox.enable = true;

    # Plugin configuration
    plugins = {
      lualine.enable = true;        # Status line plugin
      transparent.enable = true;    # Transparent background
      telescope = {                 # Fuzzy finder plugin
        enable = true;
        keymaps."<C-p>" = "git_files";  # Ctrl-P for git files search
      };
      harpoon = {                   # Bookmarking plugin
        enable = true;
        keymaps.addFile = "<leader>a";         # Add file shortcut
        keymaps.toggleQuickMenu = "<leader>m"; # Toggle quick menu shortcut
      };
    };

    # Clipboard and other options
    clipboard = {
      register = "unnamedplus";           # Use system clipboard
      providers.wl-copy.enable = true;    # Enable clipboard on Wayland
    };
    opts = {
      relativenumber = true;  # Relative line numbers
      incsearch = true;       # Incremental search
    };
  };
}

