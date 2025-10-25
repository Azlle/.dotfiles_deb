# helix.nix
{ pkgs, config, lib, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        auto-save = true;
        bufferline = "multiple";
        cursorline = true;
        cursorcolumn = true;
        line-number = "relative";
        gutters = [
          "diagnostics"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "file-modification-indicator"
          ];
          center = [ ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
        };

        whitespace = {
          render = {
            space = "none";
            tab = "all";
            newline = "none";
          };
        };

        indent-guides = {
          render = true;
        };

        file-picker = {
          hidden = false;
        };

        search = {
          smart-case = true;
          wrap-around = true;
        };

        lsp = {
          display-messages = true;
        };
      };

      keys = {
        normal = {
          C-j = ":buffer-next";
          C-k = ":buffer-previous";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];

          space = {
            space = "file_picker";
            w = ":w";
            q = ":q";
          };
        };

        insert = {
          j.j = "normal_mode";
        };
      };

      theme = "autumn_night_transparent";
    };

    languages.language = [
      {
        name = "nix";
        auto-format = false;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
    ];

    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}
