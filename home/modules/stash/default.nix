{ config, lib, pkgs, ... }:

let
  stashDir = "${config.home.homeDirectory}/Stash";

  purpleDark   = "#1a0b2e";
  purpleMid    = "#2d1b4e";
  purpleAccent = "#7b2cbf";
  pink         = "#ff6bcb";
  pinkSoft     = "#ff9ee3";
  textLight    = "#f0e6ff";

  # Keep the CSS clean – no leading spaces that break YAML
  customCss = ''
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
in
{
  home.file."Stash/.keep".text = "";
  home.file."Stash/background/.keep".text = "";

  # Optional: manage the image itself
  # home.file."Stash/background/background.png".source = ./background.png;

  home.file."Stash/config.yml".text = ''
# Managed by Home Manager – stash UI theme
cssenabled: true
css: |
${customCss}

custom_served_folders:
  "/": ${stashDir}/background

theme_color: "${purpleDark}"

# -------------------------------------------------
# Put the rest of your original config.yml below this line
# (or copy the whole existing file here and keep only the
#  three keys above managed by Home Manager)
# -------------------------------------------------
'';
}
