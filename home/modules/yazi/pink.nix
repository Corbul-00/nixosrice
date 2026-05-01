{ config, pkgs, lib, ... }:
{
  programs.yazi = {
    enable = true;

    theme = {
      manager = {
        cwd = { fg = "#ff2d78"; };                   # current dir — hot pink

        hovered         = { fg = "#0d0010"; bg = "#ff2d78"; };
        preview_hovered = { underline = true; };

        find_keyword  = { fg = "#ff2d78"; bold = true; };
        find_position = { fg = "#cc00ff"; italic = true; };

        marker_copied  = { fg = "#ff2d78"; bg = "#ff2d78"; };
        marker_cut     = { fg = "#e0003c"; bg = "#e0003c"; };
        marker_marked  = { fg = "#cc00ff"; bg = "#cc00ff"; };
        marker_selected = { fg = "#ff2d78"; bg = "#ff2d78"; };

        tab_active   = { fg = "#0d0010"; bg = "#ff2d78"; };
        tab_inactive = { fg = "#cc00ff"; bg = "#3d0050"; };
        tab_width    = 1;

        border_symbol = "│";
        border_style  = { fg = "#ff2d78"; };

        syntect_theme = "";
      };

      status = {
        overall = { fg = "#ff2d78"; bg = "#0d0010"; };

        separator_open  = "";
        separator_close = "";
        separator_style = { fg = "#3d0050"; bg = "#0d0010"; };

        mode_normal  = { fg = "#0d0010"; bg = "#ff2d78"; bold = true; };
        mode_select  = { fg = "#0d0010"; bg = "#cc00ff"; bold = true; };
        mode_unset   = { fg = "#0d0010"; bg = "#e0003c"; bold = true; };

        progress_label  = { fg = "#ff2d78"; bold = true; };
        progress_normal = { fg = "#ff2d78"; bg = "#0d0010"; };
        progress_error  = { fg = "#e0003c"; bg = "#0d0010"; };

        permissions_t = { fg = "#cc00ff"; };
        permissions_r = { fg = "#ff2d78"; };
        permissions_w = { fg = "#e0003c"; };
        permissions_x = { fg = "#ff69b4"; };
        permissions_s = { fg = "#3d0050"; };
      };

      input = {
        border   = { fg = "#ff2d78"; };
        title    = { fg = "#cc00ff"; };
        value    = { fg = "#ff2d78"; };
        selected = { reversed = true; };
      };

      completion = {
        border   = { fg = "#ff2d78"; };
        active   = { bg = "#3d0050"; };
        inactive = { bg = "#0d0010"; };

        icon_file    = { fg = "#ff69b4"; };
        icon_folder  = { fg = "#ff2d78"; };
        icon_command = { fg = "#cc00ff"; };
      };

      tasks = {
        border  = { fg = "#ff2d78"; };
        title   = {};
        hovered = { underline = true; };
      };

      which = {
        mask            = { bg = "#0d0010"; };
        cand            = { fg = "#ff2d78"; };
        rest            = { fg = "#cc00ff"; };
        desc            = { fg = "#ff69b4"; };
        separator       = "  ";
        separator_style = { fg = "#3d0050"; };
      };

      help = {
        on      = { fg = "#ff2d78"; };
        run     = { fg = "#cc00ff"; };
        desc    = { fg = "#ff69b4"; };
        hovered = { bg = "#3d0050"; bold = true; };
        footer  = { fg = "#0d0010"; bg = "#ff2d78"; };
      };

      filetype = {
        rules = [
          # folders
          { mime = "inode/directory";  fg = "#ff2d78"; }

          # images
          { mime = "image/*";          fg = "#ff69b4"; }

          # video / audio
          { mime = "video/*";          fg = "#cc00ff"; }
          { mime = "audio/*";          fg = "#cc00ff"; }

          # archives
          { mime = "application/zip";              fg = "#e0003c"; }
          { mime = "application/gzip";             fg = "#e0003c"; }
          { mime = "application/x-tar";            fg = "#e0003c"; }
          { mime = "application/x-bzip2";          fg = "#e0003c"; }
          { mime = "application/x-7z-compressed";  fg = "#e0003c"; }
          { mime = "application/x-rar-compressed"; fg = "#e0003c"; }
          { mime = "application/zstd";             fg = "#e0003c"; }

          # documents
          { mime = "application/pdf";  fg = "#cc00ff"; }
          { mime = "text/*";           fg = "#ff69b4"; }

          # executables
          { mime = "application/x-executable"; fg = "#ff2d78"; bold = true; }

          # fallback
          { name = "*";  fg = "#ff69b4"; }
          { name = "*/"; fg = "#ff2d78"; }
        ];
      };
    };
  };
}
