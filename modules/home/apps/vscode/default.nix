{ inputs, lib, host, pkgs, config, namespace, ... }:
with lib;
let cfg = config.apps.vscode;
in {
  options.apps.vscode = { enable = mkEnableOption "enable vscode"; };

  config = mkIf cfg.enable {
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        usernamehw.errorlens
        # yzhang.markdown-all-in-one
      ];
      userSettings = {
        editor.formatOnSave = true;
        editor.formatOnPaste = true;

        workbench.iconTheme = "catppuccin-latte";
        terminal.integrated.defaultProfile.linux = "fish";
        # "workbench.iconTheme" = "catppuccin-latte";
      };

      mutableExtensionsDir = false;
      enableUpdateCheck = false;

      enableExtensionUpdateCheck = false;
      # extensions = with pkgs.open-vsx; [
      #   # "https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json"

      #   gruntfuggly.todo-tree
      #   catppuccin.catppuccin-vsc-icons
      #   catppuccin.catppuccin-vsc

      #   usernamehw.errorlens
      #   esbenp.prettier-vscode
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

