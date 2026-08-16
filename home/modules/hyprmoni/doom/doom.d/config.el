;;; config.el -*- lexical-binding: t; -*-

;;; Identity ------------------------------------------------------------
(setq user-full-name "corbul")

;;; Fonts (match kitty.nix) -----------------------------------------------
;; Bump the :size numbers to make everything bigger — doom-font also drives
;; menus, which-key, and dashboard text. doom-big-font is only used by
;; `doom-big-font-mode' (SPC t b), not your everyday size.
(setq doom-font (font-spec :family "AdwaitaMono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Nunito" :size 19)
      doom-big-font (font-spec :family "AdwaitaMono Nerd Font" :size 28))

;;; Theme: hyprmoni palette -------------------------------------------------
;; Base: doom-tokyo-night mirrors the folke/tokyonight.nvim base your
;; lazyvim.nix profile builds on. Faces below are clobbered to hit
;; palette.nix's exact hex values - same move lazyvim.nix makes with
;; on_colors / on_highlights.
(setq doom-theme 'doom-tokyo-night)

(custom-set-faces!
 '(default                     :background "#0D0D0D" :foreground "#FFD9E8")
 '(cursor                      :background "#FD5BA2")
 '(region                      :background "#401929")
 '(hl-line                     :background "#1B1B1B")
 '(line-number                 :foreground "#67253F")
 '(line-number-current-line    :foreground "#FD5BA2" :bold t)
 '(vertical-border              :foreground "#67253F")
 '(font-lock-comment-face       :foreground "#BFBFBF" :italic t)
 '(font-lock-keyword-face       :foreground "#CE4A7E" :bold t)
 '(font-lock-function-name-face :foreground "#FD5BA2" :bold t)
 '(font-lock-string-face        :foreground "#FFAA99")
 '(font-lock-constant-face      :foreground "#FFAA99")
 '(font-lock-type-face          :foreground "#FFD9E8")
 '(doom-modeline-bar            :background "#FD5BA2")
 '(mode-line                    :background "#1B1B1B" :foreground "#FFD9E8")
 '(mode-line-inactive           :background "#1B1B1B" :foreground "#BFBFBF"))

;;; Dashboard ---------------------------------------------------------------
;; Points at the pre-resized copy doom.nix generates (see doomBannerWidth
;; there) - Doom inserts this image at native pixel size with no scaling
;; of its own, so resizing has to happen on the Nix side, not here.
(setq fancy-splash-image "~/.config/hyprmoni/assets/doom-banner.png")

;; Blank lines padding the banner above/below, and where the whole
;; dashboard (banner + menu + footer) sits in the window.
(setq +dashboard-banner-vertical-padding '(2 . 2)
      +dashboard-anchor '(center . center))

;; Footer
(setq dashboard-set-footer t)

;; TTY fallback (fancy-splash-image only applies when (display-graphic-p)).
;; Must RETURN a propertized string - Doom inserts it itself, this function
;; doesn't insert anything directly.
(defun +hyprmoni/dashboard-ascii-banner ()
  (propertize
   (string-join
    '(" ███╗   ███╗ ██████╗ ███╗   ██╗██╗███╗   ██╗"
      " ████╗ ████║██╔═══██╗████╗  ██║██║████╗  ██║"
      " ██╔████╔██║██║   ██║██╔██╗ ██║██║██╔██╗ ██║"
      " ██║╚██╔╝██║██║   ██║██║╚██╗██║██║██║╚██╗██║"
      " ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║██║ ╚████║"
      " ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝"
      ""
      "                   DoomMonika")
    "\n")
   'face '+dashboard-banner))
(setq +dashboard-ascii-banner-fn #'+hyprmoni/dashboard-ascii-banner)

;;; UI / editing basics -------------------------------------------------------
(setq display-line-numbers-type 'relative)

;;; Vim / Evil compatibility ---------------------------------------------------
;; Evil ships a subset of Vim's ex-commands - things like netrw's :Ex don't
;; exist unless added by hand. Add more the same way if you hit others.
(after! evil
  (evil-ex-define-cmd "Ex" #'dired-jump))

;;; Org-mode ------------------------------------------------------------------
;; `org` is already turned on in init.el (:lang (org +dragndrop +pandoc)),
;; deliberately left unconfigured for now. Drop things in here later, e.g.:
;;
 (after! org
   (setq org-directory "~/org/"
         org-agenda-files (list org-directory)
         org-ellipsis " ▾"))

;;; Nix -------------------------------------------------------------------------
(after! nix-mode
  (setq nix-nixfmt-bin "nixfmt"))

;;; Other languages -------------------------------------------------------------
;; Add `after!` blocks here as you enable more :lang modules in init.el
;; (rustic, python, markdown, etc).

;;; Keybindings -------------------------------------------------------------------
;; `map!` bindings go here as you add them.

;;; Treemacs ----------------------------------------------------------------------
(after! treemacs
  (require 'treemacs-evil)
  (require 'treemacs-nerd-icons)

  (treemacs-load-theme "nerd-icons")

  (setq treemacs-width 25
        treemacs-is-never-other-window nil
        treemacs-space-between-root-nodes nil)

  (set-face-attribute 'treemacs-file-face nil
                      :foreground "#70E1E8")
  (set-face-attribute 'treemacs-directory-face nil
                      :foreground "#5ec4ff")

  (add-hook 'treemacs-mode-hook
            (lambda ()
              (text-scale-set -1))))

(defun my/treemacs-toggle ()
  "Toggle Treemacs and ensure it takes over the frame if opened."
  (interactive)
  (require 'treemacs)
  (let ((treemacs-window (treemacs-get-local-window)))
    (if treemacs-window
        (delete-window treemacs-window)
      (progn
        (treemacs-display-current-project-exclusively)
        ;; Force it to take the whole frame
        (delete-other-windows)))))

;; Navigation
(after! evil
  (define-key evil-normal-state-map (kbd "C-n") #'my/treemacs-toggle))

;;; Elcord ----------------------------------------------------------------------
(after! elcord
  (setq elcord-editor-name "Doom Emacs"
        elcord-editor-icon "doom_icon"
        elcord-use-major-mode-as-main-icon nil
        elcord-display-buffer-details t
        elcord-display-line-numbers nil
        elcord-refresh-rate 15
        elcord-idle-timer 300
        elcord-idle-message "Taking a break"
        elcord-quiet t)

  (elcord-mode 1))
