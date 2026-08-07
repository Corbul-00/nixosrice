{ config, lib, pkgs, ... }:

let
  stashDir = "${config.home.homeDirectory}/Stash";

  # Dark purple + pink palette – tweak freely
  purpleDark   = "#1a0b2e";
  purpleMid    = "#2d1b4e";
  purpleAccent = "#7b2cbf";
  pink         = "#ff6bcb";
  pinkSoft     = "#ff9ee3";
  textLight    = "#f0e6ff";

  customCss = ''
    /* Dark purple + pink theme for Stash */
    body {
      background-color: ${purpleDark} !important;
      background-image: url("/custom/background.png");
      background-size: cover;
      background-attachment: fixed;
      background-position: center;
      background-repeat: no-repeat;
      color: ${textLight} !important;
    }

    /* Make content readable over the image */
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
in
{
  # Make sure the directory structure exists
  home.file."Stash/.keep".text = "";
  home.file."Stash/background/.keep".text = "";

  # Optionally manage the background image itself (put background.png next to this .nix)
  # home.file."Stash/background/background.png".source = ./background.png;

  # Declaratively write / update the relevant parts of config.yml
  # (you can keep the rest of your existing config.yml intact)
  home.file."Stash/config.yml".text = lib.mkDefault (''
    # --- managed by Home Manager (stash-ui.nix) ---
    cssenabled: true
    css: |
${lib.concatMapStrings (l: "  " + l + "\n") (lib.splitString "\n" customCss)}

    custom_served_folders:
      /: ${stashDir}/background

    theme_color: "${purpleDark}"
    # --- end managed section ---

    # Keep any other settings you already have below this line
    # (or move everything into this file if you prefer full declarative control)
  '');
}
