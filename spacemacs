;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
    ;; Base distribution to use. This is a layer contained in the directory
    ;; `+distribution'. For now available distributions are `spacemacs-base'
    ;; or `spacemacs'. (default 'spacemacs)
    dotspacemacs-distribution 'spacemacs
    ;; List of additional paths where to look for configuration layers.
    ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
    dotspacemacs-configuration-layer-path '()
    ;; List of configuration layers to load. If it is the symbol `all' instead
    ;; of a list then all discovered layers will be installed.
    dotspacemacs-configuration-layers
    '(
       elixir
       ;; php
       ;; csv
       osx
       ;; (shell :variables
         ;; shell-default-shell 'multi-term
         ;; shell-default-height 30
         ;; shell-default-term-shell "/bin/zsh"
         ;; shell-default-position 'bottom)
       git
       ;; dash
       (auto-completion :variables
         auto-completion-return-key-behavior 'complete
         auto-completion-tab-key-behavior 'cycle
         auto-completion-enable-help-tooltip t
         auto-completion-enable-sort-by-usage t
         auto-completion-complete-with-key-sequence-delay 0.1)
       ;; (syntax-checking
         ;; (setq flycheck-checkers '(javascript-eslint ruby-rubocop))
         ;; (setq flycheck-highlighting-mode 'lines)
         ;; (setq flycheck-check-syntax-automatically '(mode-enabled save)))
       ;; colors
       markdown
       emacs-lisp
       shell-scripts
       html
       yaml
       javascript
       sql
       ruby
       ;; (ruby :variables
         ;; ruby-version-manager 'asdf)
       ruby-on-rails
       scala
       ;; ansible
       )
    ;; List of additional packages that will be installed without being
    ;; wrapped in a layer. If you need some configuration for these
    ;; packages, then consider creating a layer. You can also put the
    ;; configuration in `dotspacemacs/user-config'.
    dotspacemacs-additional-packages
    '(
       editorconfig
       ;; dumb-jump
       graphql-mode
       dracula-theme
       )
    ;; A list of packages and/or extensions that will not be install and loaded.
    dotspacemacs-excluded-packages
    '(
       orgit
       )
    ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
    ;; are declared in a layer which is not a member of
    ;; the list `dotspacemacs-configuration-layers'. (default t)
    dotspacemacs-delete-orphan-packages t))

;; https://gist.github.com/tonini/0d3f9433b214044a870e
;; Display alchemist buffers always at the right side
;; Just change (side . right) with the position you would like 'bottom, 'top, 'right or 'left
;; Source: http://www.lunaryorn.com/2015/04/29/the-power-of-display-buffer-alist.html
;; (add-to-list 'display-buffer-alist
             ;; `(,(rx bos (or "*alchemist test report*"
                            ;; "*alchemist mix*"
                            ;; "*alchemist help*"
                            ;; "*alchemist iex*"
                            ;; "*Alchemist-IEx*"))
                    ;; (display-buffer-reuse-window
                     ;; display-buffer-in-side-window)
               ;; (reusable-frames . visible)
               ;; (side            . bottom)
;; (window-width . 0.3)))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
    ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
    ;; possible. Set it to nil if you have no way to use HTTPS in your
    ;; environment, otherwise it is strongly recommended to let it set to t.
    ;; This variable has no effect if Emacs is launched with the parameter
    ;; `--insecure' which forces the value of this variable to nil.
    ;; (default t)
    dotspacemacs-elpa-https t
    ;; Maximum allowed time in seconds to contact an ELPA repository.
    dotspacemacs-elpa-timeout 5
    ;; If non nil then spacemacs will check for updates at startup
    ;; when the current branch is not `develop'. (default t)
    dotspacemacs-check-for-update t
    ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
    ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
    ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
    ;; unchanged. (default 'vim)
    dotspacemacs-editing-style 'vim
    ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
    dotspacemacs-verbose-loading nil
    ;; Specify the startup banner. Default value is `official', it displays
    ;; the official spacemacs logo. An integer value is the index of text
    ;; banner, `random' chooses a random text banner in `core/banners'
    ;; directory. A string value must be a path to an image format supported
    ;; by your Emacs build.
    ;; If the value is nil then no banner is displayed. (default 'official)
    dotspacemacs-startup-banner 'official
    ;; List of items to show in the startup buffer. If nil it is disabled.
    ;; Possible values are: `recents' `bookmarks' `projects'.
    ;; (default '(recents projects))
    dotspacemacs-startup-lists '(projects recents)
    ;; Number of recent files to show in the startup buffer. Ignored if
    ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
    dotspacemacs-startup-recent-list-size 5
    ;; Default major mode of the scratch buffer (default `text-mode')
    dotspacemacs-scratch-mode 'text-mode
    ;; List of themes, the first of the list is loaded when spacemacs starts.
    ;; Press <SPC> T n to cycle to the next theme in the list (works great
    ;; with 2 themes variants, one dark and one light)
    dotspacemacs-themes '(dracula
                           spacemacs-dark
                           spacemacs-light
                           solarized-light
                           solarized-dark
                           leuven
                           monokai
                           zenburn)
    ;; If non nil the cursor color matches the state color in GUI Emacs.
    dotspacemacs-colorize-cursor-according-to-state t
    ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
    ;; size to make separators look not too crappy.
    dotspacemacs-default-font '("Hack"
                                 :size 13
                                 :weight normal
                                 :width normal
                                 :powerline-scale 1)
    ;; The leader key
    dotspacemacs-leader-key "SPC"
    ;; The leader key accessible in `emacs state' and `insert state'
    ;; (default "M-m")
    dotspacemacs-emacs-leader-key "M-m"
    ;; Major mode leader key is a shortcut key which is the equivalent of
    ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
    dotspacemacs-major-mode-leader-key ","
    ;; Major mode leader key accessible in `emacs state' and `insert state'.
    ;; (default "C-M-m)
    dotspacemacs-major-mode-emacs-leader-key "C-M-m"
    ;; These variables control whether separate commands are bound in the GUI to
    ;; the key pairs C-i, TAB and C-m, RET.
    ;; Setting it to a non-nil value, allows for separate commands under <C-i>
    ;; and TAB or <C-m> and RET.
    ;; In the terminal, these pairs are generally indistinguishable, so this only
    ;; works in the GUI. (default nil)
    dotspacemacs-distinguish-gui-tab nil
    ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
    ;; The command key used for Evil commands (ex-commands) and
    ;; Emacs commands (M-x).
    ;; By default the command key is `:' so ex-commands are executed like in Vim
    ;; with `:' and Emacs commands are executed with `<leader> :'.
    dotspacemacs-command-key ":"
    ;; If non nil `Y' is remapped to `y$'. (default t)
    dotspacemacs-remap-Y-to-y$ t
    ;; Name of the default layout (default "Default")
    dotspacemacs-default-layout-name "Default"
    ;; If non nil the default layout name is displayed in the mode-line.
    ;; (default nil)
    dotspacemacs-display-default-layout nil
    ;; If non nil then the last auto saved layouts are resume automatically upon
    ;; start. (default nil)
    dotspacemacs-auto-resume-layouts nil
    ;; Location where to auto-save files. Possible values are `original' to
    ;; auto-save the file in-place, `cache' to auto-save the file to another
    ;; file stored in the cache directory and `nil' to disable auto-saving.
    ;; (default 'cache)
    dotspacemacs-auto-save-file-location 'cache
    ;; Maximum number of rollback slots to keep in the cache. (default 5)
    dotspacemacs-max-rollback-slots 5
    ;; If non nil then `ido' replaces `helm' for some commands. For now only
    ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
    ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
    dotspacemacs-use-ido nil
    ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
    dotspacemacs-helm-resize nil
    ;; if non nil, the helm header is hidden when there is only one source.
    ;; (default nil)
    dotspacemacs-helm-no-header nil
    ;; define the position to display `helm', options are `bottom', `top',
    ;; `left', or `right'. (default 'bottom)
    dotspacemacs-helm-position 'bottom
    ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
    ;; several times cycle between the kill ring content. (default nil)
    dotspacemacs-enable-paste-micro-state nil
    ;; Which-key delay in seconds. The which-key buffer is the popup listing
    ;; the commands bound to the current keystroke sequence. (default 0.4)
    dotspacemacs-which-key-delay 0.4
    ;; Which-key frame position. Possible values are `right', `bottom' and
    ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
    ;; right; if there is insufficient space it displays it at the bottom.
    ;; (default 'bottom)
    dotspacemacs-which-key-position 'bottom
    ;; If non nil a progress bar is displayed when spacemacs is loading. This
    ;; may increase the boot time on some systems and emacs builds, set it to
    ;; nil to boost the loading time. (default t)
    dotspacemacs-loading-progress-bar t
    ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
    ;; (Emacs 24.4+ only)
    dotspacemacs-fullscreen-at-startup nil
    ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
    ;; Use to disable fullscreen animations in OSX. (default nil)
    dotspacemacs-fullscreen-use-non-native nil
    ;; If non nil the frame is maximized when Emacs starts up.
    ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
    ;; (default nil) (Emacs 24.4+ only)
    dotspacemacs-maximized-at-startup t
    ;; A value from the range (0..100), in increasing opacity, which describes
    ;; the transparency level of a frame when it's active or selected.
    ;; Transparency can be toggled through `toggle-transparency'. (default 90)
    dotspacemacs-active-transparency 90
    ;; A value from the range (0..100), in increasing opacity, which describes
    ;; the transparency level of a frame when it's inactive or deselected.
    ;; Transparency can be toggled through `toggle-transparency'. (default 90)
    dotspacemacs-inactive-transparency 90
    ;; If non nil unicode symbols are displayed in the mode line. (default t)
    dotspacemacs-mode-line-unicode-symbols t
    ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
    ;; scrolling overrides the default behavior of Emacs which recenters the
    ;; point when it reaches the top or bottom of the screen. (default t)
    dotspacemacs-smooth-scrolling t
    ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
    ;; derivatives. If set to `relative', also turns on relative line numbers.
    ;; (default nil)
    dotspacemacs-line-numbers nil
    ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
    ;; (default nil)
    dotspacemacs-smartparens-strict-mode nil
    ;; Select a scope to highlight delimiters. Possible values are `any',
    ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
    ;; emphasis the current one). (default 'all)
    dotspacemacs-highlight-delimiters 'all
    ;; If non nil advises quit functions to keep server open when quitting.
    ;; (default nil)
    dotspacemacs-persistent-server nil
    ;; List of search tool executable names. Spacemacs uses the first installed
    ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
    ;; (default '("ag" "pt" "ack" "grep"))
    dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
    ;; The default package repository used if no explicit repository has been
    ;; specified with an installed package.
    ;; Not used for now. (default nil)
    dotspacemacs-default-package-repository nil
    ;; Delete whitespace while saving buffer. Possible values are `all'
    ;; to aggressively delete empty line and long sequences of whitespace,
    ;; `trailing' to delete only the whitespace at end of lines, `changed'to
    ;; delete only whitespace for changed lines or `nil' to disable cleanup.
    ;; (default nil)
    dotspacemacs-whitespace-cleanup nil
    ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq-default git-magit-status-fullscreen t)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (editorconfig-mode 1)

  (global-git-commit-mode t)

  ;; (add-hook 'prog-mode-hook 'dumb-jump-mode)

  (global-company-mode)

  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action)

  (setq powerline-default-separator 'nil)
  (spaceline-compile)

  (setq backup-directory-alist `((".*" . ,temporary-file-directory)))
  (setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
  (setq create-lockfiles nil)

  (setq flycheck-check-syntax-automatically '(mode-enabled save))

  (setq neo-window-position 'right)
  (setq neo-window-width 50)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ghub epl jinja2-mode company-ansible ansible-doc ansible graphql-mode slack emojify circe oauth2 websocket ht alert log4e gntp zonokai-theme zenburn-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme company-quickhelp packed phpunit phpcbf php-extras php-auto-yasnippets drupal-mode php-mode winum fuzzy flycheck-credo csv-mode graphviz-dot-mode yaml-mode xterm-color ws-butler which-key web-mode web-beautify use-package tagedit spaceline powerline smeargle shell-pop sass-mode ruby-test-mode rubocop rspec-mode robe restart-emacs pug-mode projectile-rails rake inflections persp-mode pcre2el paradox spinner osx-dictionary org-plus-contrib open-junk-file neotree move-text markdown-toc markdown-mode macrostep link-hint less-css-mode js2-refactor multiple-cursors info+ indent-guide hydra hungry-delete hl-todo highlight-indentation help-fns+ helm-themes helm-projectile helm-make projectile helm-descbinds helm-dash helm-company helm-c-yasnippet helm-ag google-translate git-timemachine git-messenger git-link flycheck-pos-tip fish-mode feature-mode eyebrowse expand-region evil-surround evil-search-highlight-persist evil-nerd-commenter evil-mc evil-matchit evil-magit evil-iedit-state iedit evil-exchange eshell-z eshell-prompt-extras ensime sbt-mode scala-mode emmet-mode ember-mode editorconfig dumb-jump company-tern tern company-statistics column-enforce-mode color-identifiers-mode coffee-mode chruby bundler inf-ruby bind-key auto-yasnippet alchemist aggressive-indent ace-window ace-link ace-jump-helm-line avy auto-complete company yasnippet highlight anzu smartparens bind-map f evil undo-tree elixir-mode flycheck request helm helm-core s skewer-mode js2-mode magit magit-popup git-commit with-editor async dash spacemacs-theme window-numbering volatile-highlights vi-tilde-fringe uuidgen toc-org sql-indent slim-mode simple-httpd scss-mode rvm ruby-tools reveal-in-osx-finder rbenv rainbow-mode rainbow-identifiers rainbow-delimiters quelpa pos-tip popwin popup pkg-info pbcopy osx-trash org-bullets ob-elixir noflet multi-term mmm-mode minitest magit-gitflow lorem-ipsum livid-mode linum-relative let-alist launchctl json-mode js-doc insert-shebang ido-vertical-mode highlight-parentheses highlight-numbers hide-comnt helm-swoop helm-mode-manager helm-gitignore helm-flx helm-css-scss haml-mode goto-chg golden-ratio gitconfig-mode gitattributes-mode gh-md flycheck-mix flx-ido fill-column-indicator fancy-battery exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-numbers evil-lisp-state evil-indent-plus evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu esh-help ember-yasnippets elisp-slime-nav diminish dash-functional dash-at-point company-web company-shell clean-aindent-mode auto-highlight-symbol auto-compile adaptive-wrap ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((type nil)) (:background "#000000" :foreground "#f8f8f2")) (((class color) (min-colors 89)) (:background "#282a36" :foreground "#f8f8f2")))))
