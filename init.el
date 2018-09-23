
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (lsp-haskell lsp-ui emacs-lsp highlight-indent-guides flycheck use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(setq scroll-margin 6)

(use-package dracula-theme
  :ensure t)
  
(use-package evil
  :ensure t
  :config (evil-mode)
  )

(use-package ivy
  :ensure t
  :init (ivy-mode))

(use-package counsel
  :ensure t
  :init (counsel-mode))

(use-package swiper
  :ensure t)

(use-package telephone-line
  :ensure t
  :init
  (telephone-line-mode 1)
  (setq telephone-line-lhs
    '((evil   . (telephone-line-evil-tag-segment))
      (accent . (telephone-line-vc-segment
                 telephone-line-erc-modified-channels-segment
                 telephone-line-process-segment))
      (nil    . (telephone-line-minor-mode-segment
                 telephone-line-buffer-segment))))
  (setq telephone-line-rhs
    '((nil    . (telephone-line-misc-info-segment))
      (accent . (telephone-line-major-mode-segment))
      (evil   . (telephone-line-airline-position-segment)))))


(use-package company
  :ensure t
  :init (add-hook 'after-init-hook 'global-company-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo))


(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-bottom)
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-side-window-max-width 0.33
        which-key-idle-delay 0.05)
  )

(use-package general
  :ensure t
  :config
  (general-evil-setup t)
  (general-def :states '(normal motion emacs) "SPC" nil)

  (general-define-key
   :states '(normal)
   :prefix "SPC"
   "SPC" '(counsel-M-x :which-key "run command")
   "s" '(swiper :which-key "swiper")
   )

  (general-define-key
   :states '(normal visual)
   :prefix "SPC b"
   "l" '(list-buffers :which-key "list buffers")
   "b" '(switch-to-buffer :which-key "switch to buffer")
   )

  (general-define-key
   :states '(normal visual)
   :prefix "SPC j"
   "l" '(avy-goto-line :which-key "goto line")
   "c" '(avy-goto-char :which-key "goto char")
   "w" '(avy-goto-subword-1 :which-key "goto word")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC f"
   "f" '(counsel-find-file :which-key "find file")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC h"
   "b" '(counsel-descbinds :which-key "describe binding")
   "f" '(counsel-describe-function :which-key "describe function")
   "v" '(counsel-describe-variable :which-key "describe variable")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC w"
   "v" '(split-window-below :which-key "split window vert")
   "s" '(split-window-right :which-key "split window hori")
   "w" '(ace-window :which-key "ace-window")
   "d" '(delete-other-windows :which-key "delete other windows")
   "k" '(windmove-up :which-key "move up")
   "j" '(windmove-down :which-key "move down")
   "h" '(windmove-left :which-key "move left")
   "l" '(windmove-right :which-key "move right")
   )

  (which-key-declare-prefixes
    "SPC j" "navigation"
    "SPC b" "buffers"
    "SPC m" "move"
    "SPC f" "files"
    "SPC w" "windows"
    "SPC h" "help")
)

(use-package python
  :defer
  :ensure elpy
  :config
  (elpy-enable)

  (setq python-shell-interpreter "python"
	python-shell-interpreter-args "-i")

  (general-define-key
   :states '(normal)
   :prefix "SPC j"
   "j" '(elpy-nav-forward-block :which-key "next block")
   "k" '(elpy-nav-backward-block :which-key "prev block")
   "d" '(elpy-goto-definition :which-key "goto definition")
   "o" '(elpy-doc :which-key "documentation")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC l s"
   "k" '(elpy-shell-kill :which-key "kill shell")
   "b" '(elpy-shell-send-buffer :which-key "send buffer")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC m"
   "h" '(elpy-nav-indent-shift-left :which-key "shift left")
   "l" '(elpy-nav-indent-shift-right :which-key "shift right")
   )

  (which-key-declare-prefixes
    "SPC l" "python"
    "SPC l s" "python-shell"))


(use-package projectile
  :ensure t
  :ensure ivy
  :config
  (setq projectile-completion-system 'ivy)

  (setq projectile-globally-ignored-file-suffixes
	(append '("pyc"
		  "~"
		  "#")
		projectile-globally-ignored-file-suffixes))

  (projectile-mode)

  (general-define-key
   :states '(normal)
   :prefix "SPC"
   "p" '(projectile-command-map :which-key "projectile")
   ))

(use-package ace-window
  :ensure t)

(use-package tex
  :ensure auctex
  :defer
  :config
  (load-theme 'adwaita)

  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-PDF-mode t)
  (TeX-fold-mode)

  ;; Turn on synctex
  ;; Shift + Left click to go to line from Okular
  (setq TeX-source-correlate-mode t
	TeX-source-correlate-start-server t)
  (setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular")

  ;; Larger previews
  (set-default 'preview-scale-function 1.2)
  
  (general-define-key
   :states '(normal)
   :prefix "SPC l i"
   "e" '(LaTeX-environment :which-key "environment")
   "s" '(LaTeX-section :which-key "section")
   "m" '(LaTeX-insert-macros :which-key "macros")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC l b"
   "m" '(TeX-command-master :which-key "master")
   "b" '(TeX-command-run-all :which-key "build then view")
   "v" '(TeX-view :which-key "view")
   "c" '(TeX-clean :which-key "clean")
   )
  
  (general-define-key
   :states '(normal)
   :prefix "SPC l p"
   "d" '(preview-document :which-key "document")
   "e" '(preview-environment :which-key "environment")
   "s" '(preview-section :which-key "section")
   "r" '(preview-region :which-key "region")
   "b" '(preview-buffer :which-key "buffer")
   )

  (general-define-key
   :states '(normal)
   :prefix "SPC l p c"
   "d" '(preview-clearout-document :which-key "document")
   "e" '(preview-clearout-environment :which-key "environment")
   "s" '(preview-clearout-section :which-key "section")
   "r" '(preview-clearout :which-key "region")
   "b" '(preview-clearout-buffer :which-key "buffer")
   )

  (which-key-declare-prefixes
    "SPC l" "latex"
    "SPC l i" "insert"
    "SPC l b" "build"
    "SPC l p" "preview"
    "SPC l p c" "clearout"))

(use-package flycheck
  :ensure t
  :config
  
  (general-define-key
   :states '(normal)
   :prefix "SPC c"
   "n" '(flycheck-next-error :which-key "next error")
   "p" '(flycheck-previous-error :which-key "previous error")
   "1" '(flycheck-first-error :which-key "first error")
   )

  (which-key-declare-prefixes
    "SPC c" "flycheck"))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'column))

(use-package haskell-mode
  :defer
  :ensure t
  :config
  (custom-set-variables
   '(haskell-stylish-on-save t))
   
  (general-define-key
   :states '(normal visual)
   :prefix "SPC l"
   "a" '(align-regexp :which-key "align")
   )

  (which-key-declare-prefixes
    "SPC l" "haskell"))
