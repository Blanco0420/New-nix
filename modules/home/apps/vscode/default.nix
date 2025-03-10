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
let
  cfg = config.apps.vscode;
in
{
  options.apps.vscode = {
    enable = mkEnableOption "enable vscode";
  };

  config = mkIf cfg.enable {
    stylix.targets.vscode.profileNames = [
      "default"
      "java"
      "nix"
      "react"
    ];
    programs.vscode = {

      enable = true;
      package = pkgs.vscode;
      profiles =
        let

          # The `name` and `publisher` fields here can be found as the `Unique Identifier`
          # in the Visual Studio Code Marketplace. For example:
          # antfu.unocss => name = "unocss" and publisher = "antfu"

          defaultProfile = {
            extensions =
              with pkgs.vscode-extensions;
              [
                catppuccin.catppuccin-vsc-icons
                usernamehw.errorlens
                esbenp.prettier-vscode
                gruntfuggly.todo-tree
                mkhl.direnv
                bbenoist.nix
              ]
              ++ (with pkgs.open-vsx; [
                hediet.vscode-drawio
                streetsidesoftware.code-spell-checker-british-english
                christian-kohler.path-intellisense
                albert.tabout
              ])
              ++ (with pkgs.vscode-marketplace; [
                coddx.coddx-alpha
                streetsidesoftware.code-spell-checker
              ]);
            userSettings = {
              editor = {
                formatOnSave = true;
                formatOnPaste = true;
              };
              git = {
                autofetch = true;
                enableSmartCommit = true;
                confirmSync = false;
              };
              workbench = {
                startupEditor = "none";
                workbench.iconTheme = "catppuccin-latte";
                workbench.colorTheme = "Stylix";
              };

              terminal.integrated.defaultProfile.linux = "zsh";
              hediet.vscode-drawio.theme = "dark";
            };
            keybindings = [
              {
                key = "ctrl+shift+'";
                command = "workbench.action.terminal.new";
                when = "terminalProcessSupported || terminalWebExtensionContributedProfile";
              }
              {
                key = "shift+alt+down";
                command = "notebook.cell.copyDown";
                when = "notebookEditorFocused";
              }
              {
                key = "shift+alt+down";
                command = "-notebook.cell.copyDown";
                when = "notebookEditorFocused && !inputFocus";
              }
              # FIXME: Fix this wallad
              {
                key = "shift+alt+up";
                command = "notebook.cell.copyUp";
                when = "notebookEditorFocused";
              }
              {
                key = "shift+alt+up";
                command = "-notebook.cell.copyUp";
                when = "notebookEditorFocused && !inputFocus";
              }
              {
                key = "ctrl+shift+down";
                command = "editor.action.insertCursorBelow";
                when = "";
              }
              {
                key = "ctrl+shift+up";
                command = "editor.action.insertCursorAbove";
                when = "";
              }
              {
                key = "shift+alt+down";
                command = "-editor.action.insertCursorBelow";
                when = "editorTextFocus";
              }
              {
                key = "shift+alt+up";
                command = "-editor.action.insertCursorAbove";
                when = "editorTextFocus";
              }
            ];
          };

        in
        {

          "default" = defaultProfile;

          java = lib.recursiveUpdate defaultProfile {
            extensions =
              defaultProfile.extensions
              ++ (with pkgs.open-vsx; [
                vmware.vscode-spring-boot
                lalithk90.thymeleaf-html5-snippets
                vscjava.vscode-spring-boot-dashboard
                vscjava.vscode-spring-initializr
                redhat.fabric8-analytics
                vscjava.vscode-java-debug
                vscjava.vscode-java-test
                vscjava.vscode-maven
                # vscjava.vscode-gradle
                vscjava.vscode-java-dependency
              ])
              ++ (with pkgs.vscode-marketplace; [
                visualstudioexptteam.vscodeintellicode
                vscjava.vscode-java-pack
                vmware.vscode-boot-dev-pack

              ])
              ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                  name = "java";
                  version = "1.41.2025030508";
                  sha256 = "sha256-u9p1RTxCX47aOwQAGmDjHE3VXxT0DfOMTN9AWWaHbUo=";
                  publisher = "redhat";

                }
              ];

            keybindings = defaultProfile.keybindings;
            userSettings = defaultProfile.userSettings // {
              #   "terminal.integrated.profiles.linux" = {
              #     "Devenv" = {
              #       "path" = "zsh";
              #       "args" = [
              #         "-c"
              #         "devenv"
              #         "shell"
              #       ];
              #     };
              #   };
              #   "terminal.integrated.defaultProfile.linux" = "Devenv";
              # TODO ADD BACK
            };
          };

          "react" = lib.recursiveUpdate defaultProfile {
            extensions =
              with pkgs.open-vsx;
              [
                dsznajder.es7-react-js-snippets
                oven.bun-vscode
              ]
              ++ (with pkgs.vscode-marketplace; [
                dbaeumer.vscode-eslint
                dsznajder.es7-react-js-snippets
                visualstudioexptteam.vscodeintellicode
                bradlc.vscode-tailwindcss
              ])
              ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                # {
                #   name = "JavaScriptSnippets";
                #   version = "1.8.0";
                #   sha256 = "sha256-u9p1RTxCX47aOwQAGmDjHE3VXxT0DfOMTN9AWWaHbUo=";
                #   publisher = "xabikos";

                # }
                {
                  name = "simple-react-snippets";
                  publisher = "burkeholland";
                  version = "1.2.8";
                  sha256 = "sha256-zrRxJZHRqBMGVkd56Q+wDbCSFfl4X3Kta4sX8ecZmu8=";
                }
              ]
              ++ defaultProfile.extensions;
            userSettings = defaultProfile.userSettings // {
              editor.defaultFormatter = "esbenp.prettier-vscode";
              javascript.updateImportsOnFileMove.enabled = "always";
            };
            keybindings = defaultProfile.keybindings;
          };
          nix = lib.recursiveUpdate defaultProfile {
            extensions =
              with pkgs.vscode-extensions;
              [
                jnoortheen.nix-ide
              ]
              ++ defaultProfile.extensions;
            keybindings = defaultProfile.keybindings;
            userSettings = defaultProfile.userSettings;
          };
        };

      # enableUpdateCheck = false;

      # enableExtensionUpdateCheck = false;
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
