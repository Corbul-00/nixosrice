;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +orderless)
       (vertico +icons)

       :ui
       doom
       doom-dashboard
       hl-todo
       modeline
       nav-flash
       ophints
       (popup +defaults)
       treemacs
       vc-gutter        ; git signs, like lazyvim's gitsigns
       workspaces        ; per-project tabs, like lazyvim's tab/bufferline

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       multiple-cursors
       snippets

       :emacs
       dired
       electric
       undo
       vc

       :checkers
       syntax
       (spell +flyspell)

       :tools
       (eval +overlay)
       lookup
       (lsp +peek)
       (magit +forge)
       direnv           ; you're already Nix-flake-everything, this matters

       :lang
       emacs-lisp
       json
       markdown
       nix
       (sh +fish)        ; you're on fish already
       yaml
       (org +dragndrop +pandoc)

       :config
       (default +bindings +smartparens))
