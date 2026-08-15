;;; config.el -*- lexical-binding: t; -*-

;;; Identity ------------------------------------------------------------
(setq user-full-name "Ayanolord")

;;; Fonts (match kitty.nix) -----------------------------------------------
(setq doom-font (font-spec :family "AdwaitaMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Nunito" :size 15)
      doom-big-font (font-spec :family "AdwaitaMono Nerd Font" :size 20))

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
;; GUI: doombg.png, deployed by assets.nix to ~/.config/hyprmoni/assets/.
(setq fancy-splash-image "~/.config/hyprmoni/assets/doombg.png")

;; TTY fallback (fancy-splash-image only applies when (display-graphic-p)).
(defun +hyprmoni/dashboard-ascii-banner ()
  (let* ((banner '(" ███╗   ███╗ ██████╗ ███╗   ██╗██╗███╗   ██╗"
                   " ████╗ ████║██╔═══██╗████╗  ██║██║████╗  ██║"
                   " ██╔████╔██║██║   ██║██╔██╗ ██║██║██╔██╗ ██║"
                   " ██║╚██╔╝██║██║   ██║██║╚██╗██║██║██║╚██╗██║"
                   " ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║██║ ╚████║"
                   " ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝"
                   ""
                   "                   DoomMonika"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) ?\s)))
               "\n"))
     'face 'doom-dashboard-banner)))
(setq +doom-dashboard-ascii-banner-fn #'+hyprmoni/dashboard-ascii-banner)

;;; UI / editing basics -------------------------------------------------------
(setq display-line-numbers-type 'relative)

;;; Org-mode ------------------------------------------------------------------
;; `org` is already turned on in init.el (:lang (org +dragndrop +pandoc)),
;; deliberately left unconfigured for now. Drop things in here later, e.g.:
;;
;; (after! org
;;   (setq org-directory "~/org/"
;;         org-agenda-files (list org-directory)
;;         org-ellipsis " ▾"))

;;; Nix -------------------------------------------------------------------------
(after! nix-mode
  (setq nix-nixfmt-bin "nixfmt"))

;;; Other languages -------------------------------------------------------------
;; Add `after!` blocks here as you enable more :lang modules in init.el
;; (rustic, python, markdown, etc).

;;; Keybindings -------------------------------------------------------------------
;; `map!` bindings go here as you add them.
