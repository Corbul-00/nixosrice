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

(setq +dashboard-banner-vertical-padding '(2 . 2)
      +dashboard-anchor '(center . center))

;; Random footer messages
(setq my/dashboard-footer-messages
      '(("The one true editor, Emacs!" . nil) 
        ("Who the hell uses VIM anyway? Go Evil!" . (nerd-icons-mdicon . "nf-md-emoticon_devil"))
        ("Free as free speech, free as free Beer" . (nerd-icons-mdicon . "nf-md-beer"))
        ("Happy coding!" . (nerd-icons-mdicon . "nf-md-emoticon_happy"))
        ("A day without coding for Monika is a wasted day..."
         . (nerd-icons-faicon . "nf-fa-hands_praying"))
        ("Everyday I imagine a future where I Linux larp with you..."
         . (nerd-icons-mdicon . "nf-md-heart"))
        ("Ever thought of configuring Monika with Emacs?" . (nerd-icons-mdicon . "nf-md-head_question"))
        ("Vi Vi Vi, the editor of the beast" . (nerd-icons-mdicon . "nf-md-emoticon_devil"))
        ("Welcome to the church of Emacs"
         . (nerd-icons-faicon . "nf-fa-place_of_worship"))
        ("While any text editor can save your files, only Emacs can save your soul"
         . (nerd-icons-faicon . "nf-fa-place_of_worship"))
        ("I showed you my source code, pls respond" . nil)))


(defun my/dashboard-widget-footer ()
  (let* ((entry (nth (random (length my/dashboard-footer-messages))
                     my/dashboard-footer-messages))
         (msg   (car entry))          ; the message text
         (extra (cdr entry))          ; nil, or (FUNCTION . ICON-NAME)
         ;; Always-present Emacs icon, from the "custom" nerd-icon set
         (emacs-icon (nerd-icons-sucicon "nf-custom-emacs"
                                         :height 1.1 :v-adjust -0.05
                                         :face 'doom-dashboard-menu-title))
         ;; Optional second icon, built by calling whatever function
         ;; was paired with this message (or nil if none)
         (extra-icon (when extra
                       (funcall (car extra) (cdr extra)
                                :height 1.1 :v-adjust -0.05
                                :face 'doom-dashboard-menu-title))))
    (insert "\n\n\n\n\n")
    (+dashboard-insert
     (concat emacs-icon " "
             msg
             (if extra-icon (concat " " extra-icon) "")))))

;; substitui o footer padrão do Doom
(remove-hook '+dashboard-functions #'+dashboard-widget-footer)
(add-hook! '+dashboard-functions :append
           #'my/dashboard-widget-footer)

;; Blank lines padding the banner above/below, and where the whole
;; dashboard (banner + menu + footer) sits in the window.
(setq +dashboard-banner-vertical-padding '(2 . 2)
      +dashboard-anchor '(center . center))

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
(after! org
  ;; Main notes directory
  (setq org-directory (expand-file-name "~/Zettelkasten/"))

  ;; Agenda files
  (setq org-agenda-files
        (list org-directory))

  ;; Appearance
  (setq org-hide-emphasis-markers t
        org-startup-indented t
        org-startup-with-inline-images t
        org-image-actual-width nil
        org-ellipsis " ▾"
        org-return-follows-link t)

  ;; Source blocks
  (setq org-edit-src-content-indentation 0
        org-src-preserve-indentation t)

  ;; Open file links in current window
  (setq org-link-frame-setup
        '((file . find-file)))

  ;; Evil-friendly navigation
  (evil-define-key 'normal org-mode-map
    (kbd "TAB") #'org-cycle
    (kbd "RET") #'org-open-at-point))

;;; Org-roam ------------------------------------------------------------------
(after! org-roam
  (setq org-roam-directory
        (file-truename "~/Zettelkasten"))

  (org-roam-db-autosync-mode))

;;; Nix -------------------------------------------------------------------------
(after! nix-mode
  (setq nix-nixfmt-bin "nixfmt"))

;;; Spell checking 
(setq ispell-program-name "hunspell"
      ispell-dictionary "en_US")

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
