{ pkgs, nix-doom-emacs, ... }:

let
  doomPrivateDir = pkgs.linkFarm "monidoom-private" [
    {
      name = "init.el";
      path = pkgs.writeText "init.el" ''
        (doom!
         :completion
         vertico

         :ui
         doom
         doom-dashboard
         modeline
         ophints
         indent-guides

         :editor
         (evil +everywhere)
         snippets

         :emacs
         dired
         undo
         vc

         :tools
         magit
         lsp

         :lang
         nix +lsp
         python +lsp
         rust +lsp
         javascript +lsp)
      '';
    }

    {
      name = "packages.el";
      path = pkgs.writeText "packages.el" ''
        ;; MoniDoom uses Doom's built-in modules.
      '';
    }

    {
      name = "config.el";
      path = pkgs.writeText "config.el" ''
        ;;; MoniDoom configuration

        ;; ─────────────────────────────────────────────
        ;; Appearance
        ;; ─────────────────────────────────────────────

        (setq doom-theme 'doom-one)

        (setq doom-font
              (font-spec
               :family "JetBrainsMono Nerd Font"
               :size 12))

        (setq display-line-numbers-type 'relative)

        ;; ─────────────────────────────────────────────
        ;; MoniDoom dashboard
        ;; ─────────────────────────────────────────────

        ;; Image supplied by the Hyprmoni theme.
        (setq +doom-dashboard-banner-file
              "/etc/nixos/home/modules/hyprmoni/assets/emacsbg.png")

        (setq +doom-dashboard-banner-padding '(0 . 2))

        ;; Keep the dashboard compact like LazyVim.
        (setq +doom-dashboard-functions
              '(doom-dashboard-widget-banner
                doom-dashboard-widget-shortmenu
                doom-dashboard-widget-loaded))

        ;; LazyVim-inspired menu, but using Doom/Emacs actions.
        (setq +doom-dashboard-menu-sections
              '(("Find File"
                 :icon ""
                 :key "f"
                 :action find-file)

                ("New File"
                 :icon ""
                 :key "n"
                 :action find-file)

                ("Projects"
                 :icon ""
                 :key "p"
                 :action projectile-switch-project)

                ("Find Text"
                 :icon "󰱼"
                 :key "g"
                 :action projectile-ripgrep)

                ("Recent Files"
                 :icon ""
                 :key "r"
                 :action recentf-open-files)

                ("Config"
                 :icon ""
                 :key "c"
                 :action doom/open-private-config)

                ("Quit"
                 :icon "󰅗"
                 :key "q"
                 :action save-buffers-kill-emacs)))

        ;; ─────────────────────────────────────────────
        ;; Hyprmoni palette
        ;; ─────────────────────────────────────────────

        (custom-set-faces!
          ;; Editor
          '(default
             :background "#0D0D0D"
             :foreground "#FFD9E8")

          '(cursor
             :background "#FD5BA2")

          '(fringe
             :background "#0D0D0D")

          ;; Line numbers
          '(line-number
             :foreground "#67253F"
             :background "#0D0D0D")

          '(line-number-current-line
             :foreground "#FD5BA2"
             :background "#1B1B1B"
             :weight bold)

          '(hl-line
             :background "#1B1B1B")

          ;; Selection
          '(region
             :background "#401929"
             :foreground "#FFD9E8")

          ;; Search
          '(isearch
             :background "#FD5BA2"
             :foreground "#0D0D0D"
             :weight bold)

          '(lazy-highlight
             :background "#67253F"
             :foreground "#FFD9E8")

          ;; Syntax
          '(font-lock-comment-face
             :foreground "#BFBFBF"
             :slant italic)

          '(font-lock-string-face
             :foreground "#FFAA99")

          '(font-lock-keyword-face
             :foreground "#CE4A7E"
             :weight bold)

          '(font-lock-function-name-face
             :foreground "#FD5BA2"
             :weight bold)

          '(font-lock-type-face
             :foreground "#FFD9E8")

          '(font-lock-constant-face
             :foreground "#FFAA99")

          '(font-lock-variable-name-face
             :foreground "#FFD9E8")

          '(font-lock-builtin-face
             :foreground "#FD5BA2")

          ;; Modeline
          '(mode-line
             :background "#1B1B1B"
             :foreground "#FFD9E8"
             :box nil)

          '(mode-line-inactive
             :background "#0D0D0D"
             :foreground "#BFBFBF"
             :box nil)

          ;; Minibuffer
          '(minibuffer-prompt
             :foreground "#FD5BA2"
             :weight bold)

          ;; Completion
          '(vertico-current
             :background "#401929"
             :foreground "#FFD9E8"
             :weight bold)

          ;; Which-key
          '(which-key-key-face
             :foreground "#FD5BA2"
             :weight bold)

          '(which-key-group-description-face
             :foreground "#CE4A7E")

          '(which-key-command-description-face
             :foreground "#FFD9E8")

          ;; Diagnostics
          '(flycheck-error
             :foreground "#FD5BA2"
             :underline t)

          '(flycheck-warning
             :foreground "#FFAA99"
             :underline t)

          '(flycheck-info
             :foreground "#CE4A7E"
             :underline t)

          ;; Git
          '(diff-added
             :foreground "#CE4A7E")

          '(diff-removed
             :foreground "#FD5BA2")

          '(diff-changed
             :foreground "#FFAA99")

          ;; Dashboard
          '(doom-dashboard-banner
             :foreground "#FD5BA2")

          '(doom-dashboard-menu-title
             :foreground "#FFD9E8")

          '(doom-dashboard-menu-desc
             :foreground "#FFAA99")

          '(doom-dashboard-menu-key
             :foreground "#FD5BA2"
             :weight bold)

          '(doom-dashboard-footer
             :foreground "#BFBFBF")

          ;; Borders
          '(vertical-border
             :foreground "#67253F")

          '(window-divider
             :foreground "#67253F"))

        ;; ─────────────────────────────────────────────
        ;; Evil
        ;; ─────────────────────────────────────────────

        (after! evil
          (setq evil-normal-state-cursor
                '(box "#FD5BA2")

                evil-insert-state-cursor
                '(bar "#FD5BA2")

                evil-visual-state-cursor
                '(hollow "#FD5BA2")

                evil-replace-state-cursor
                '(hbar "#FD5BA2")))

        ;; ─────────────────────────────────────────────
        ;; Clean startup
        ;; ─────────────────────────────────────────────

        (setq inhibit-startup-screen t
              confirm-kill-emacs nil)
      '';
    }
  ];
in
{
  imports = [
    nix-doom-emacs.hmModule
  ];

  programs.doom-emacs = {
    enable = true;

    # Native Wayland/PGTK Emacs for Hyprland.
    emacsPackage = pkgs.emacs-pgtk;

    doomPrivateDir = doomPrivateDir;
  };

  home.packages = with pkgs; [
    git
    ripgrep
    fd

    nodejs
    python3
  ];
}
