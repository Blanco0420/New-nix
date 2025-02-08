{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.dev;
in {
  options.roles.dev = with types; {
    enable = mkBoolOpt false "enable dev role";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nixfmt nil ];
    programs = {
      vscode = {
        enable = true;
        package = pkgs.vscode;
        userSettings = {
          "editor.formatOnSave" = true;
          "editor.formatOnPaste" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
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
      git = {
        userEmail = "sachajamesterry@gmail.com";
        userName = "Blanco0420";
      };
      gh = { enable = true; };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      helix = {
        enable = true;
        defaultEditor = true;
        languages.language = [{
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }];
        settings = {
          editor = {
            bufferline = "multiple";
            shell = [ "zsh" "c-" ];
          };
          keys.normal = { space.space = "file_picker"; };
          keys.insert = {
            A.x = "normal_mode";
            # esc = "no_op";
          };
        };
      };
    };
  };
}
