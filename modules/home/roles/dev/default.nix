{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.custom;
let cfg = config.roles.dev;
in {
  options.roles.dev = with types; {
    enable = mkBoolOpt false "enable dev role";
  };

  config = mkIf cfg.enable {
    cli.terminals.ghostty.enable = true;
    home.packages = with pkgs; [ nixfmt nil ];
    apps.vscode.enable = true;
    programs = {

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
