{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.roles.dev;
in
{
  options.roles.dev = with types; {
    enable = mkBoolOpt false "enable dev role";
  };

  config = mkIf cfg.enable {
    cli.terminals.ghostty.enable = true;
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nil
      jdk
      # bun
      # maven
      docker-client
      # mysql-workbench
      devenv
      # postman
    ];
    apps.vscode.enable = true;
    programs = {

      eclipse.enable = true;

      direnv = {
        enable = true;
        enableZshIntegration = true;
        # nix-direnv.enable = true;
        # silent = true;
      };

      git = {
        userEmail = "sachajamesterry@gmail.com";
        userName = "Blanco0420";
      };
      gh = {
        enable = true;
      };

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
        languages.language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          }
        ];
        settings = {
          editor = {
            bufferline = "multiple";
            shell = [
              "zsh"
              "c-"
            ];
          };
          keys.normal = {
            space.space = "file_picker";
          };
          keys.insert = {
            A.x = "normal_mode";
            # esc = "no_op";
          };
        };
      };
    };
  };
}
