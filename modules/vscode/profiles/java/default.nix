{
  inputs,
  lib,
  host,
  pkgs,
  config,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.vscode.profiles.java;
in
{
  options.custom.vscode.profiles.java = {
    enable = mkEnableOption "enable vscode java profile";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      userSettings = {
        editor.formatOnSave = true;
        editor.formatOnPaste = true;
        git.autofetch = true;
        workbench.iconTheme = "catppuccin-latte";
        terminal.integrated.defaultProfile.linux = "zsh";
        # "workbench.iconTheme" = "catppuccin-latte";
      };
      keybindings = [
        {
          key = "ctrl+shift+'";
          command = "workbench.action.terminal.new";
          when = "terminalProcessSupported || terminalWebExtensionContributedProfile";
        }
      ];

      mutableExtensionsDir = false;
      enableUpdateCheck = false;

      enableExtensionUpdateCheck = false;
      # extensions = with pkgs.open-vsx; [
      #   # "https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json"

      #   catppuccin.catppuccin-vsc

      #   mikestead.dotenv

      # ];
      # ] ++ (with pkgs.vscode-marketplace; [
      #   # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
      #   dbaeumer.vscode-eslint
      #   # mtxr.sqltools-driver-sqlite
      #   ms-vscode-remote.vscode-remote-extensionpack
      #   ms-vscode.remote-explorer
      #   ms-vsliveshare.vsliveshare
      # codeforge.remix-forge
      # amodio.toggle-excluded-files
      # ]);
    };
  };
}
