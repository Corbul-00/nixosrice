{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-doom-emacs-unstraightened.homeModule
  ];

  programs.doom-emacs = {
    enable = true;

    emacs = pkgs.emacs-pgtk;

    doomDir = pkgs.linkFarm "monidoom" [
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
          ;;; MoniDoom

          ;; ─────────────────────────────────────
          ;; Basic appearance
          ;; ─────────────────────────────────────

          (setq doom-theme 'doom-one)

          (setq doom-font
                (font-spec
                 :family "JetBrainsMono Nerd Font"
                 :size 12))

          (setq display-line-numbers-type 'relative)

          ;; ─────────────────────────────────────
          ;; MoniDoom dashboard
          ;; ─────────────────────────────────────

          (setq +doom-dashboard-banner-file
                "/etc/nixos/home/modules/hyprmoni/assets/emacsbg.png")

          (setq +doom-dashboard-banner-padding '(0 . 2))

          (setq +doom-dashboard-functions
                '(doom-dashboard-widget-banner
                  doom-dashboard-widget-shortmenu
                  doom-dashboard-widget-loaded))

          (setq +doom-dashboard-menu-sections
                '(("Find File"
                   :icon ""
                   :key "f"
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

          ;; ─────────────────────────────────────
          ;; Hyprmoni palette
          ;; ─────────────────────────────────────

          (custom-set-faces!
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

            '(hl-line
               :background "#1B1B1B")

            '(region
               :background "#401929"
               :foreground "#FFD9E8")

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

            '(mode-line
               :background "#1B1B1B"
               :foreground "#FFD9E8"
               :box nil)

            '(mode-line-inactive
               :background "#0D0D0D"
               :foreground "#BFBFBF"
               :box nil)

            '(minibuffer-prompt
               :foreground "#FD5BA2"
               :weight bold)

            '(vertico-current
               :background "#401929"
               :foreground "#FFD9E8"
               :weight bold)

            '(which-key-key-face
               :foreground "#FD5BA2"
               :weight bold)

            '(which-key-group-description-face
               :foreground "#CE4A7E")

            '(which-key-command-description-face
               :foreground "#FFD9E8")

            '(doom-dashboard-menu-key
               :foreground "#FD5BA2"
               :weight bold)

            '(doom-dashboard-menu-title
               :foreground "#FFD9E8")

            '(doom-dashboard-menu-desc
               :foreground "#FFAA99")

            '(doom-dashboard-footer
               :foreground "#BFBFBF")

            '(vertical-border
               :foreground "#67253F"))

          ;; ─────────────────────────────────────
          ;; Evil cursor
          ;; ─────────────────────────────────────

          (after! evil
            (setq evil-normal-state-cursor
                  '(box "#FD5BA2")

                  evil-insert-state-cursor
                  '(bar "#FD5BA2")

                  evil-visual-state-cursor
                  '(hollow "#FD5BA2")

                  evil-replace-state-cursor
                  '(hbar "#FD5BA2")))

          ;; Clean startup
          (setq inhibit-startup-screen t
                confirm-kill-emacs nil)
        '';
      }
    ];
  };

  home.packages = with pkgs; [
    git
    ripgrep
    fd
    nodejs
    python3
  ];
}
