{ config, pkgs, lib, ... }:
{
  programs.yazi = {
    enable = true;

    theme = {
      manager = {
        cwd = { fg = "#ff4d94"; };                   # current dir — vibrant pink

        hovered         = { fg = "#1a0010"; bg = "#ff4d94"; };   # selected item
        preview_hovered = { underline = true; };

        find_keyword  = { fg = "#ff85c2"; bold = true; };
        find_position = { fg = "#c94090"; italic = true; };

        marker_copied  = { fg = "#ff4d94"; bg = "#ff4d94"; };
        marker_cut     = { fg = "#c0004e"; bg = "#c0004e"; };
        marker_marked  = { fg = "#9b30ff"; bg = "#9b30ff"; };
        marker_selected = { fg = "#ff4d94"; bg = "#ff4d94"; };

        tab_active   = { fg = "#1a0010"; bg = "#ff4d94"; };
        tab_inactive = { fg = "#ff85c2"; bg = "#4a0030"; };
        tab_width    = 1;

        border_symbol = "│";
        border_style  = { fg = "#ff4d94"; };         # panel borders — vibrant pink

        syntect_theme = "";
      };

      status = {
        overall = { fg = "#ff4d94"; bg = "#1a0010"; };   # bottom bar

        separator_open  = "";
        separator_close = "";
        separator_style = { fg = "#4a0030"; bg = "#1a0010"; };

        mode_normal  = { fg = "#1a0010"; bg = "#ff4d94"; bold = true; };
        mode_select  = { fg = "#1a0010"; bg = "#9b30ff"; bold = true; };
        mode_unset   = { fg = "#1a0010"; bg = "#c0004e"; bold = true; };

        progress_label  = { fg = "#ffffff"; bold = true; };
        progress_normal = { fg = "#ff4d94"; bg = "#1a0010"; };
        progress_error  = { fg = "#c0004e"; bg = "#1a0010"; };

        permissions_t = { fg = "#9b30ff"; };
        permissions_r = { fg = "#ff4d94"; };
        permissions_w = { fg = "#c0004e"; };
        permissions_x = { fg = "#ff85c2"; };
        permissions_s = { fg = "#4a0030"; };
      };

      input = {
        border   = { fg = "#ff4d94"; };
        title    = { fg = "#ff85c2"; };
        value    = { fg = "#ff4d94"; };
        selected = { reversed = true; };
      };

      completion = {
        border   = { fg = "#ff4d94"; };
        active   = { bg = "#4a0030"; };
        inactive = { bg = "#1a0010"; };

        icon_file    = { fg = "#ff85c2"; };
        icon_folder  = { fg = "#ff4d94"; };
        icon_command = { fg = "#9b30ff"; };
      };

      tasks = {
        border  = { fg = "#ff4d94"; };
        title   = {};
        hovered = { underline = true; };
      };

      which = {
        mask            = { bg = "#1a0010"; };
        cand            = { fg = "#ff85c2"; };
        rest            = { fg = "#4a0030"; };
        desc            = { fg = "#ff4d94"; };
        separator       = "  ";
        separator_style = { fg = "#4a0030"; };
      };

      help = {
        on      = { fg = "#ff4d94"; };
        run     = { fg = "#ff85c2"; };
        desc    = { fg = "#c0004e"; };
        hovered = { bg = "#4a0030"; bold = true; };
        footer  = { fg = "#1a0010"; bg = "#ff4d94"; };
      };

      filetype = {
        rules = [
          # folders
          { mime = "inode/directory";  fg = "#ff4d94"; }

          # images
          { mime = "image/*";          fg = "#ff85c2"; }

          # video / audio
          { mime = "video/*";          fg = "#9b30ff"; }
          { mime = "audio/*";          fg = "#9b30ff"; }

          # archives
          { mime = "application/zip";                    fg = "#c0004e"; }
          { mime = "application/gzip";                   fg = "#c0004e"; }
          { mime = "application/x-tar";                  fg = "#c0004e"; }
          { mime = "application/x-bzip2";                fg = "#c0004e"; }
          { mime = "application/x-7z-compressed";        fg = "#c0004e"; }
          { mime = "application/x-rar-compressed";       fg = "#c0004e"; }
          { mime = "application/zstd";                   fg = "#c0004e"; }

          # documents
          { mime = "application/pdf";  fg = "#ff85c2"; }
          { mime = "text/*";           fg = "#ffb6d9"; }

          # executables
          { mime = "application/x-executable"; fg = "#ff4d94"; bold = true; }

          # fallback
          { name = "*";  fg = "#ffb6d9"; }
          { name = "*/"; fg = "#ff4d94"; }
        ];
      };
    };
  };
}
