{ ... }:

let
  void = "#0D0D0D";
  panel = "#1B1B1B";
  wine = "#67253F";
  wineDark = "#401929";
  pink = "#CE4A7E";
  hotPink = "#FD5BA2";
  blush = "#FFD9E8";
  peach = "#FFAA99";

  icon = name: text: fg: {
    inherit name text fg;
  };
in
{
  # Yazi itself remains enabled by modules/yazi/default.nix. Only its palette
  # changes while Hyprmoni is the selected profile.
  programs.yazi.theme = {
    mgr = {
      cwd = { fg = hotPink; };
      hovered = {
        fg = void;
        bg = pink;
        bold = true;
      };
      preview_hovered = { underline = true; };
      find_keyword = {
        fg = hotPink;
        bold = true;
        italic = true;
        underline = true;
      };
      find_position = {
        fg = peach;
        bg = "reset";
        bold = true;
      };
      symlink_target = {
        fg = peach;
        italic = true;
      };
      marker_copied = {
        fg = pink;
        bg = pink;
      };
      marker_cut = {
        fg = wine;
        bg = wine;
      };
      marker_marked = {
        fg = blush;
        bg = blush;
      };
      marker_selected = {
        fg = hotPink;
        bg = hotPink;
      };
      count_copied = {
        fg = void;
        bg = pink;
      };
      count_cut = {
        fg = blush;
        bg = wine;
      };
      count_selected = {
        fg = void;
        bg = hotPink;
      };
      border_symbol = "│";
      border_style = { fg = wine; };
      syntect_theme = "";
    };

    tabs = {
      active = {
        fg = void;
        bg = pink;
        bold = true;
      };
      inactive = {
        fg = blush;
        bg = wineDark;
      };
      sep_inner = {
        open = "";
        close = "";
      };
      sep_outer = {
        open = "";
        close = "";
      };
    };

    mode = {
      normal_main = {
        fg = void;
        bg = pink;
        bold = true;
      };
      normal_alt = {
        fg = pink;
        bg = wineDark;
      };
      select_main = {
        fg = void;
        bg = hotPink;
        bold = true;
      };
      select_alt = {
        fg = hotPink;
        bg = wineDark;
      };
      unset_main = {
        fg = blush;
        bg = wine;
        bold = true;
      };
      unset_alt = {
        fg = wine;
        bg = panel;
      };
    };

    status = {
      overall = {
        fg = blush;
        bg = void;
      };
      sep_left = {
        open = "";
        close = "";
      };
      sep_right = {
        open = "";
        close = "";
      };
      perm_sep = { fg = wine; };
      perm_type = { fg = pink; };
      perm_read = { fg = blush; };
      perm_write = { fg = hotPink; };
      perm_exec = { fg = peach; };
      progress_label = {
        fg = blush;
        bold = true;
      };
      progress_normal = {
        fg = hotPink;
        bg = wineDark;
      };
      progress_error = {
        fg = void;
        bg = hotPink;
      };
    };

    which = {
      cols = 3;
      mask = { bg = void; };
      cand = { fg = hotPink; };
      rest = { fg = wine; };
      desc = { fg = blush; };
      separator = "  ";
      separator_style = { fg = wineDark; };
    };

    confirm = {
      border = { fg = hotPink; };
      title = { fg = blush; };
      content = { fg = blush; };
      list = { fg = pink; };
      btn_yes = {
        fg = void;
        bg = pink;
        bold = true;
      };
      btn_no = {
        fg = blush;
        bg = wineDark;
      };
      btn_labels = [ "  [Y]es  " "  (N)o  " ];
    };

    spot = {
      border = { fg = hotPink; };
      title = { fg = blush; };
      tbl_col = { fg = pink; };
      tbl_cell = {
        fg = blush;
        bg = wineDark;
      };
    };

    notify = {
      title_info = { fg = pink; };
      title_warn = { fg = peach; };
      title_error = { fg = hotPink; };
      icon_info = "";
      icon_warn = "";
      icon_error = "";
    };

    pick = {
      border = { fg = hotPink; };
      active = {
        fg = void;
        bg = pink;
        bold = true;
      };
      inactive = { fg = blush; };
    };

    input = {
      border = { fg = hotPink; };
      title = { fg = blush; };
      value = { fg = blush; };
      selected = {
        fg = void;
        bg = pink;
      };
    };

    cmp = {
      border = { fg = hotPink; };
      active = {
        fg = void;
        bg = pink;
        bold = true;
      };
      inactive = { fg = blush; };
      icon_file = "";
      icon_folder = "";
      icon_command = "";
    };

    tasks = {
      border = { fg = hotPink; };
      title = { fg = blush; };
      hovered = {
        fg = hotPink;
        underline = true;
      };
    };

    help = {
      on = { fg = hotPink; };
      run = { fg = pink; };
      desc = { fg = blush; };
      hovered = {
        fg = void;
        bg = pink;
        bold = true;
      };
      footer = {
        fg = void;
        bg = hotPink;
      };
    };

    filetype.rules = [
      {
        mime = "inode/directory";
        fg = pink;
      }
      {
        mime = "image/*";
        fg = peach;
      }
      {
        mime = "{audio,video}/*";
        fg = wine;
      }
      {
        mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
        fg = wine;
      }
      {
        mime = "application/{pdf,doc,rtf}";
        fg = hotPink;
      }
      {
        mime = "text/*";
        fg = blush;
      }
      {
        name = "*";
        is = "orphan";
        fg = void;
        bg = hotPink;
      }
      {
        name = "*";
        is = "exec";
        fg = hotPink;
        bold = true;
      }
      {
        name = "*";
        fg = blush;
      }
      {
        name = "*/";
        fg = pink;
      }
    ];

    icon.prepend_exts = [
      (icon "nix" "" hotPink)
      (icon "json" "" pink)
      (icon "json5" "" pink)
      (icon "jsonc" "" pink)
      (icon "html" "" hotPink)
      (icon "htm" "" hotPink)
      (icon "css" "" pink)
      (icon "scss" "" pink)
      (icon "xml" "󰗀" wine)
      (icon "toml" "" pink)
      (icon "yaml" "" pink)
      (icon "yml" "" pink)
      (icon "md" "" peach)
      (icon "txt" "󰈙" blush)
      (icon "conf" "" wine)
      (icon "ini" "" wine)
      (icon "sh" "" hotPink)
      (icon "fish" "" hotPink)
      (icon "py" "" pink)
      (icon "lua" "" pink)
      (icon "js" "" peach)
      (icon "ts" "" pink)
      (icon "rs" "" hotPink)
      (icon "go" "" pink)
      (icon "c" "" wine)
      (icon "cpp" "" wine)
      (icon "lock" "" wine)
    ];

    icon.prepend_files = [
      (icon "flake.nix" "" hotPink)
      (icon "flake.lock" "" wine)
      (icon "package.json" "" pink)
      (icon "package-lock.json" "" wine)
      (icon ".gitignore" "" wine)
      (icon ".env" "" peach)
    ];
  };
}
