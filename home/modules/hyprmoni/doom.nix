{ pkgs, nix-doom-emacs, ... }:

let
  doomPrivateDir = pkgs.linkFarm "monidoom-private" [
    {
      name = "init.el";
      path = pkgs.writeText "monidoom-init.el" ''
        (doom!
         :input
         ;; bzzzt

         :completion
         (corfu +orderless)
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
         format

         :emacs
         dired
         undo
         vc

         :term
         eshell

         :checkers
         syntax

         :tools
         magit
         lsp

         :lang
         nix +lsp
         python +lsp
         rust +lsp
         javascript +lsp))
      '';
    }

    {
      name = "packages.el";
      path = pkgs.writeText "monidoom-packages.el" ''
        ;; Keep this empty.
        ;; Doom modules provide the functionality we want.
      '';
    }

    {
      name = "config.el";
      path = pkgs.writeText "monidoom-config.el" ''
        ;; ─────────────────────────────────────────────
        ;; MoniDoom
        ;; ─────────────────────────────────────────────

        ;; Theme
        (setq doom-theme 'doom-one)

        ;; Font
        (setq doom-font
              (font-spec
               :family "JetBrainsMono Nerd Font"
               :size 12))

        ;; Vim-style relative line numbers
        (setq display-line-numbers-type 'relative)

        ;; Leader keys remain Doom/Evil defaults:
        ;; SPC       = leader
        ;; SPC m     = local leader

        ;; ─────────────────────────────────────────────
        ;; Transparency
        ;; ─────────────────────────────────────────────

        (when (display-graphic-p)
          (add-to-list 'default-frame-alist '(alpha-background . 92)))

        ;; ─────────────────────────────────────────────
        ;; LazyVim-style dashboard
        ;; ─────────────────────────────────────────────

        (setq +doom-dashboard-banner-file
              "${doomPrivateDir}/emacsbg.png")

        (setq +doom-dashboard-banner-padding '(0 . 2))

        (setq +doom-dashboard-name "*monivim*")

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
                 :action consult-ripgrep)

                ("Recent Files"
                 :icon ""
                 :key "r"
                 :action recentf-open-files)

                ("Config"
                 :icon ""
                 :key "c"
                 :action doom/open-private-config)

                ("Restore Session"
                 :icon "󰁯"
                 :key "s"
                 :when (fboundp 'doom/quickload-session)
                 :action doom/quickload-session)

                ("Lazy Extras"
                 :icon "󰏗"
                 :key "x"
                 :action doom/describe-modules)

                ("Lazy"
                 :icon "󰒲"
                 :key "l"
                 :action doom/sync)

                ("Quit"
                 :icon "󰅗"
                 :key "q"
                 :action save-buffers-kill-emacs)))

        ;; ─────────────────────────────────────────────
        ;; Hyprmoni palette
        ;; ─────────────────────────────────────────────

        (custom-set-faces!
          ;; Main editor
          '(default
             :background "#0D0D0D"
             :foreground "#FFD9E8")

          '(cursor
             :background "#FD5BA2")

          '(fringe
             :background "#0D0D0D")

          '(line-number
             :foreground "#67253F"
             :background "#0D0D0D")

          '(line-number-current-line
             :foreground "#FD5BA2"
             :background "#1B1B1B"
             :weight bold)

          ;; Current line
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

          ;; Comments
          '(font-lock-comment-face
             :foreground "#BFBFBF"
             :slant italic)

          ;; Strings
          '(font-lock-string-face
             :foreground "#FFAA99")

          ;; Keywords
          '(font-lock-keyword-face
             :foreground "#CE4A7E"
             :weight bold)

          ;; Functions
          '(font-lock-function-name-face
             :foreground "#FD5BA2"
             :weight bold)

          ;; Types
          '(font-lock-type-face
             :foreground "#FFD9E8")

          ;; Constants
          '(font-lock-constant-face
             :foreground "#FFAA99")

          ;; Variables
          '(font-lock-variable-name-face
             :foreground "#FFD9E8")

          ;; Builtins
          '(font-lock-builtin-face
             :foreground "#FD5BA2")

          ;; Operators / punctuation
          '(font-lock-negation-char-face
             :foreground "#FFAA99")

          ;; Mode line
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
          '(corfu-default
             :background "#1B1B1B"
             :foreground "#FFD9E8")

          '(corfu-current
             :background "#401929"
             :foreground "#FFD9E8"
             :weight bold)

          ;; Vertico
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

          ;; LSP
          '(lsp-face-highlight-textual
             :background "#401929")

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
             :background "#23312A"
             :foreground "#CE4A7E")

          '(diff-removed
             :background "#401929"
             :foreground "#FD5BA2")

          '(diff-changed
             :background "#401929"
             :foreground "#FFAA99")

          ;; Dashboard
          '(doom-dashboard-banner
             :foreground "#FD5BA2")

          '(doom-dashboard-menu-title
             :foreground "#FFD9E8"
             :weight normal)

          '(doom-dashboard-menu-desc
             :foreground "#FFAA99")

          '(doom-dashboard-menu-key
             :foreground "#FD5BA2"
             :weight bold)

          '(doom-dashboard-footer
             :foreground "#BFBFBF")

          ;; Popup / borders
          '(window-divider
             :foreground "#67253F")

          '(vertical-border
             :foreground "#67253F"))

        ;; ─────────────────────────────────────────────
        ;; Hyprmoni dashboard spacing
        ;; ─────────────────────────────────────────────

        (after! doom-dashboard
          (setq +doom-dashboard-banner-padding '(0 . 2)))

        ;; Keep the dashboard clean
        (setq +doom-dashboard-functions
              '(doom-dashboard-widget-banner
                doom-dashboard-widget-shortmenu
                doom-dashboard-widget-loaded))

        ;; ─────────────────────────────────────────────
        ;; Better Evil cursor colors
        ;; ─────────────────────────────────────────────

        (after! evil
          (setq evil-normal-state-cursor '(box "#FD5BA2")
                evil-insert-state-cursor '(bar "#FD5BA2")
                evil-visual-state-cursor '(hollow "#FD5BA2")
                evil-replace-state-cursor '(hbar "#FD5BA2")))

        ;; ─────────────────────────────────────────────
        ;; Disable unnecessary startup clutter
        ;; ─────────────────────────────────────────────

        (setq inhibit-startup-screen t
              confirm-kill-emacs nil)
      '';
    }

    {
      name = "emacsbg.png";
      path = ./assets/emacsbg.png;
    }
  ];
in
{
  imports = [
    nix-doom-emacs.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    emacsPackage = pkgs.emacs;
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
