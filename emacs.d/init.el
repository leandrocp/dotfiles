;;--------------;;
;; Emacs config ;;
;;--------------;;

;; Install
; https://emacsformacosx.com/
; https://emacsformacosx.com/tips

;; References:
; https://github.com/jwiegley/use-package
; https://github.com/caisah/emacs.dz
; https://github.com/syl20bnr/spacemacs
; https://github.com/bbatsov/prelude
; https://github.com/dougbeney/Emacs-Config/
; https://github.com/seagle0128/.emacs.d/
; https://www.sandeepnambiar.com/my-minimal-emacs-setup/
; https://gist.github.com/doitian/5425328
; https://gist.github.com/huytd/6b785bdaeb595401d69adc7797e5c22c
; https://github.com/rranelli/emacs-dotfiles
; https://github.com/zamansky/dot-emacs
; https://github.com/andreyorst/dotfiles/tree/master/.config/emacs
; https://github.com/ianpan870102/.personal-emacs.d
; https://github.com/annapawlicka/org-emacs/blob/master/org/config.org
; https://github.com/ianpan870102/.personal-emacs.d/blob/master/init.el
; https://github.com/hlissner/doom-emacs/issues/2217

;; ----------
;; package.el
;; ----------
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; --------------
;; use-package.el
;; --------------
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; -------
;; General
;; -------
(setq load-prefer-newer t)                        ; Don't load outdated byte code
(defvar comp-deferred-compilation)                ; Compile Emacs lisp into native code
(setq comp-deferred-compilation t)

; GC
(setq-default gc-cons-threshold 402653184
	      gc-cons-percentage 0.6
	      inhibit-compacting-font-caches t
	      message-log-max 16384
	      file-name-handler-alist nil)

(global-auto-revert-mode t)                       ; Auto load file when changed externally
(add-hook 'before-save-hook 'whitespace-cleanup)  ; Cleanup whitespace
(setq                                             ; Backups
  backup-directory-alist
    `((".*" . ,temporary-file-directory))
  auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t))
  backup-by-copying t
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq                                             ; unto-tree history
  undo-tree-history-directory-alist
    `((".*" . ,temporary-file-directory))
  undo-tree-auto-save-history t
  create-lockfiles nil)
(savehist-mode 1)                                 ; Save history

;; UI
;; --
(add-to-list 'default-frame-alist              ; Start maximixed
	     '(fullscreen . maximized))
(tool-bar-mode -1)                             ; Hide tool bar
(menu-bar-mode -1)                             ; Hide menu
(scroll-bar-mode -1)                           ; Hide scroll
(blink-cursor-mode -1)                         ; Do not blink cursor
(setq-default cursor-type 'bar)                ; Line-style cursor similar to other text editors
(setq inhibit-startup-screen t)                ; Disable startup screen
(setq initial-scratch-message "")              ; Make *scratch* buffer blank
(setq-default frame-title-format '("%b"))      ; Display buffer name on title
(setq ring-bell-function 'ignore)              ; Disable bell sound
(fset 'yes-or-no-p 'y-or-n-p)                  ; y-or-n-p makes answering questions faster
(show-paren-mode 1)                            ; Show closing parens by default
(global-hl-line-mode +1)                       ; Highlight line
(setq jit-lock-defer-time 0.05                 ; Performance
      header-line-format nil
      fast-but-imprecise-scrolling t)
(add-to-list 'default-frame-alist
	     '(inhibit-double-buffering . t))
(setq scroll-margin 20                         ; Scroll
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position t
      auto-window-vscroll nil)
(add-to-list 'default-frame-alist              ; Fancy macOS titlebar
	     '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist
	     '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)

;; Packages
;; --------
(use-package auto-package-update
  :ensure t
  :init (setq auto-package-update-delete-old-versions t
	      auto-package-update-hide-results t)
  :config (auto-package-update-maybe))

(use-package ace-window
  :ensure t)

(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package autorevert
  :ensure nil
  :config
  (setq auto-revert-interval 2)
  (setq auto-revert-check-vc-info t)
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)
  (global-auto-revert-mode +1))

(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init (beacon-mode 1))

(use-package centaur-tabs
  :demand
  :config (centaur-tabs-mode t)
	  (centaur-tabs-group-by-projectile-project)
	  (centaur-tabs-headline-match)
	  (setq centaur-tabs-set-icons t
		centaur-tabs-gray-out-icons 'buffer
		centaur-tabs-cycle-scope 'tabs
		centaur-tabs-set-modified-marker t))

(use-package company
  :ensure t
  :diminish
  :commands company-cancel
  :hook (after-init . global-company-mode)
  :init (setq company-backends '((company-files
				  company-keywords
				  company-capf
				  company-files
				  company-yasnippet
				  company-dabbrev-code
				  company-dabbrev)))
  :config (setq company-idle-delay 0.1
		company-require-match nil
		company-tooltip-limit 10
		company-minimum-prefix-length 3
		company-selection-wrap-around t
		company-tooltip-align-annotations t
		company-tooltip-flip-when-above t)
  :bind (:map company-active-map
	 ("TAB" . company-complete-common-or-cycle)
	 ("<tab>" . company-complete-common-or-cycle)
	 ("<S-Tab>" . company-select-previous)
	 ("<backtab>" . company-select-previous)
	 ("C-j" . company-select-next)
	 ("C-k" . company-select-previous)))

(use-package company-box
  :ensure t
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package counsel
  :ensure t
  :hook (ivy-mode . counsel-mode)
  :commands (counsel-M-x
	     counsel-find-file
	     counsel-file-jump
	     counsel-recentf
	     counsel-rg
	     counsel-describe-function
	     counsel-describe-variable
	     counsel-find-library)
  :config (setq counsel-rg-base-command "rg --vimgrep %s"))

(use-package counsel-projectile
  :ensure t
  :after projectile)

(use-package dap-mode
  :ensure t)

(use-package deadgrep
  :ensure t)

(use-package diminish
  :ensure t)

(use-package display-line-numbers
  :ensure t
  :hook (prog-mode . display-line-numbers-mode)
  :config (setq-default display-line-numbers-width 3))

(use-package doc-view
  :ensure nil
  :custom (doc-view-resolution 192))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :ensure t
  :config (load-theme 'doom-one t)
	  (doom-themes-visual-bell-config)
	  (doom-themes-org-config)
	  (setq find-file-visit-truename t
		doom-modeline-buffer-file-name-style 'relative-to-project))

(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t
     evil-want-keybinding nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :custom (evil-collection-company-use-tng nil)
	  (evil-collection-setup-minibuffer t)
  :config (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :config (evil-commentary-mode))

(use-package evil-escape
  :ensure t
  :after evil
  :init (setq-default evil-escape-key-sequence "kj")
  :config (evil-escape-mode 1))

(use-package evil-magit
  :ensure t
  :after evil magit)

(use-package exec-path-from-shell
  :ensure t
  :config (exec-path-from-shell-initialize))

(use-package fast-scroll
  :ensure t
  :config (fast-scroll-config)
	  (fast-scroll-mode 1)
	  (add-hook 'fast-scroll-start-hook (lambda () (flycheck-mode -1)))
	  (add-hook 'fast-scroll-end-hook (lambda () (flycheck-mode 1))))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config (global-flycheck-mode))

(use-package flycheck-credo
  :ensure t
  :after flycheck elixir-mode
  :init (flycheck-credo-setup))

(use-package flycheck-mix
  :ensure t
  :after flycheck elixir-mode
  :init (flycheck-mix-setup))

(use-package flx
  :ensure t)

(use-package help
  :ensure nil
  :custom (help-window-select t))

(use-package ivy
  :ensure t
  :diminish
  :commands ivy-mode
  :config (ivy-mode 1)
	  (setq enable-recursive-minibuffers t
		ivy-use-virtual-buffers t
		ivy-ignore-buffers '("\\` " "\\`\\*")
		ivy-height 20
		ivy-count-format ""
		ivy-initial-inputs-alist nil))

(use-package ivy-posframe
  :ensure t
  :config (ivy-posframe-mode 1)
	  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1)
	  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package lsp-mode
  :ensure t
  :defer t
  :diminish lsp-mode
  :init (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable)
  :hook ((elixir-mode . lsp)
	(lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config (add-to-list 'exec-path "~/code/github/elixir-lsp/elixir-ls/release")
	  (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\.git$")
	  (add-to-list 'lsp-file-watch-ignored "[/\\\\]deps$")
	  (add-to-list 'lsp-file-watch-ignored "[/\\\\]_build$")
	  (add-to-list 'lsp-file-watch-ignored "[/\\\\]\\.elixir_ls$")
	  (defvar lsp-elixir--config-options (make-hash-table))
	  (add-hook 'lsp-after-initialize-hook
	    (lambda ()
	      (lsp--set-configuration `(:elixirLS, lsp-elixir--config-options))))
	  (puthash "dialyzerEnabled" :json-false lsp-elixir--config-options))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config (setq lsp-ui-doc-enable nil
		lsp-ui-doc-include-signature t
		lsp-ui-sideline-enable t
		lsp-ui-flycheck-enable t
		lsp-ui-peek-enable t
		lsp-ui-peek-list-width 60
		lsp-ui-peek-peek-height 25))

(use-package magit
  :ensure t)

(use-package popwin
  :ensure t
  :config (push '("*exunit-compilation*"
		  :dedicated t
		  :position bottom
		  :stick t
		  :height 0.4
		  :noselect t)
		popwin:special-display-config))

(use-package projectile
  :ensure t
  :config (projectile-mode +1)
	  (setq projectile-require-project-root nil
		projectile-sort-order 'recently-active
		projectile-completion-system 'ivy))

(use-package rg
  :ensure t
  :config (rg-enable-default-bindings))

(use-package saveplace
  :ensure t
  :config (save-place-mode 1))

(use-package shell
  :ensure t
  :config (setq comint-prompt-read-only t
		comint-process-echoes nil))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package smex
  :config (smex-initialize))

(use-package solaire-mode
  :ensure t
  :commands (solaire-global-mode
	     solaire-mode-swap-bg
	     turn-on-solaire-mode
	     solaire-mode-in-minibuffer
	     solaire-mode-reset)
  :hook ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
	(minibuffer-setup . solaire-mode-in-minibuffer)
  :config (solaire-global-mode +1)
	  (solaire-mode-swap-bg))

(use-package swiper
  :after ivy
  :config (setq swiper-action-recenter t
		swiper-include-line-number-in-search t))

(use-package treemacs
  :ensure t
  :defer t
  :config (treemacs-follow-mode t)
	  (treemacs-filewatch-mode t)
	  (setq treemacs-width 50
		treemacs-is-never-other-window t))

(use-package treemacs-evil
  :ensure t
  :after treemacs evil)

(use-package treemacs-icons-dired
  :ensure t
  :after treemacs dired
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :ensure t
  :after treemacs magit)

(use-package treemacs-persp
  :ensure t
  :after treemacs persp-mode
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-projectile
  :ensure t
  :after treemacs projectile)

(use-package uniquify
  :ensure nil
  :config (setq uniquify-buffer-name-style 'forward
		uniquify-separator "/"
		uniquify-after-kill-buffer-p t
		uniquify-ignore-buffers-re "^\\*"))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode t))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

;; Languages
;; ---------
(use-package erlang
  :mode "\\.erl$")

(use-package elixir-mode
  :mode ("\\.exs?" "mix.lock")
  :init (add-hook 'elixir-mode-hook
	    (lambda() (add-hook 'before-save-hook 'elixir-format nil t)))
  :hook (elixir-mode . lsp))

(use-package exunit
  :ensure t
  :after (elixir-mode))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package yaml-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
	  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(use-package web-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))
	  (add-to-list 'auto-mode-alist '("\\.leex\\'" . web-mode)))

;; Keybindings
;; -----------
(use-package general
  :ensure t
  :config (general-evil-setup t)

  (general-create-definer general-spc
    :states 'normal
    :keymaps 'override
    :prefix "SPC"
  )

  (general-spc
    ; global
    "SPC"   'counsel-M-x
    "qq"    '(kill-emacs :which-key "quit")
    ; project
    "pp"    '(counsel-projectile-switch-project :which-key "switch project")
    "pf"    '(counsel-projectile-find-file :which-key "find files")
    "pb"    '(counsel-projectile-switch-to-buffer :which-key "switch buffer")
    "ps"    '(counsel-projectile-rg :which-key "search in project")
    "bb"    '(counsel-switch-buffer :which-key "buffers list")
    "ta"    '(exunit-verify-all :which-key "test all")
    "tf"    '(exunit-verify :which-key "test file")
    "tn"    '(exunit-verify-single :which-key "test nearest")
    "tt"    '(exunit-rerun :which-key "rerun last test")
    ; buffer
    "fs"    '(save-buffer :which-key "save file")
    "<tab>" '(evil-switch-to-windows-last-buffer :which-key "cycle buffer")
    "/"     '(swiper :which-key "search in buffer")
    "*"     '(swiper-thing-at-point :which-key "search thing at point")
    "m"     '(counsel-imenu :which-key "imenu")
    ; filetree
    "ff"    'treemacs-select-window
    ; window
    "ww"    '(ace-window :which-key "goto window")
    "w/"    '(split-window-right :which-key "split right")
    "w-"    '(split-window-below :which-key "split bottom")
    "wq"    '(delete-window :which-key "delete window")
    "wl"    'evil-window-right
    "wh"    'evil-window-left
    "wj"    'evil-window-down
    "wk"    'evil-window-up
    ; tools
    "gs"    '(magit-status :which-key "git status")
    ; goto
    "gr"    '(lsp-ui-peek-find-references :which-key "goto references")
    "gd"    '(lsp-ui-peek-find-definitions :which-key "goto definition")
    "gt"    '(projectile-toggle-between-implementation-and-test :which-key "toggle test")
    "hh"    '(lsp-ui-doc-show :which-key "show doc")
    "hb"    '(counsel-descbinds :which-key "bindings")
  )

  (general-define-key
    :states '(normal visual emacs)
    :keymaps 'override
    "C-h" 'centaur-tabs-backward
    "C-l" 'centaur-tabs-forward
  )
)
