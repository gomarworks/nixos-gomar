{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    butableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        github.copilot
        ms-vscode.cpptools-extension-pack
        vue.volar
    ];
  };
}