{ config, lib, pkgs, ... }:

let
  stashDir = "${config.home.homeDirectory}/Stash";

  purpleDark   = "#1a0b2e";
  purpleMid    = "#2d1b4e";
  purpleAccent = "#7b2cbf";
  pink         = "#ff6bcb";
  pinkSoft     = "#ff9ee3";
  textLight    = "#f0e6ff";
in
{
  # Directory structure
  home.file."Stash/.keep".text = "";
  home.file."Stash/background/.keep".text = "";

  # Optional: manage the background image
  # home.file."Stash/background/background.png".source = ./background.png;

  # 1. The CSS file (this is the important part)
  home.file."Stash/custom.css".text = ''
    /* Dark purple + pink theme */
    body {
      background-color: ${purpleDark} !important;
      background-image: url("/custom/background.png");
      background-size: cover;
      background-attachment: fixed;
      background-position: center;
      background-repeat: no-repeat;
      color: ${textLight} !important;
    }

    #root {
      background-color: rgba(26, 11, 46, 0.75) !important;
    }

    .bg-dark, .navbar, .navbar-dark {
      background-color: ${purpleMid} !important;
      border-color: ${purpleAccent} !important;
    }

    .card, .job-table.card, .bg-secondary {
      background-color: rgba(45, 27, 78, 0.85) !important;
      border-color: ${purpleAccent} !important;
      color: ${textLight} !important;
    }

    a, .text-primary {
      color: ${pink} !important;
    }
    a:hover {
      color: ${pinkSoft} !important;
    }

    .btn-primary, .btn-secondary, .btn.active {
      background-color: ${purpleAccent} !important;
      border-color: ${pink} !important;
      color: ${textLight} !important;
    }
    .btn-primary:hover, .btn-secondary:hover {
      background-color: ${pink} !important;
      border-color: ${pinkSoft} !important;
      color: ${purpleDark} !important;
    }

    * {
      scrollbar-color: ${pink} ${purpleMid};
    }

    .form-control, input, select, textarea {
      background-color: rgba(26, 11, 46, 0.6) !important;
      color: ${textLight} !important;
      border-color: ${purpleAccent} !important;
    }
  '';

  # 2. Minimal config.yml – only the keys we need to manage
  home.file."Stash/config.yml".text = ''
    # Managed by Home Manager
    cssenabled: true

    custom_served_folders:
      "/": ${stashDir}/background

    theme_color: "${purpleDark}"

    # -------------------------------------------------
    # Paste the REST of your original config.yml below
    # (database, stash paths, etc.)
    # -------------------------------------------------
  '';
}
