(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ;Disable visible scrollbar
(tool-bar-mode -1)          ;Disable the toolbar
(tooltip-mode -1)           ;Disable tooltips
(set-fringe-mode 10)        ;Give som breathing room
(setq-default cursor-type 'hbar) ;; cursor alt cizgi
(menu-bar-mode -1)          ;Disable the menu bar
(setq visible-bell t)       ; Set up the visible bell



;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)



;; Pencere gecisleri
;; ----------------------------------------

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Turkce!!
;; -------------------------------------------
(require 'turkish)




;; Org-Mode Ayarlari
;; ------------------------------------------------------------------

;; org-bullets pakedi ile utf-8 semboller
(use-package org-bullets
  :ensure t
  :init
  (setq org-bullets-bullet-list
        '("◉" "◎" "⚫" "○" "►" "◇"))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )
(setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)")
(sequence "⚑ WAITING(w)" "|")
(sequence "|" "✘ CANCELED(c)")))





;; org ellipsis options, other than the default Go to Node...
;; not supported in common font, but supported in Symbola (my fall-back font) ⬎, ⤷, ⤵
(setq org-ellipsis "⤵");; ⤵ ≫ ⚡⚡⚡

;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 105)

;;(load-theme 'doom-tomorrow-day)
;;autopair uc tirnak ayari
;;--------------------------------
(require 'autopair)
(autopair-global-mode)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)



;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
term-mode-hook
eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;;Command Log
(use-package command-log-mode) ;;clm/toogle


(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


;;(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)
;; onemli
;;(define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)



;; You must run (all-the-icons-install-fonts) one time after
;; installing this package!


(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))


(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-tomorrow-day t))



(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

;;(use-package counsel
;;  :bind (("M-x" . counsel-M-x)
;;("C-x b" . counsel-ibuffer)
;;("C-x C-f" . counsel-find-file)
;;:map minibuffer-local-map
;;("C-r" . counsel-minibuffer-history)))





;; PYTHON KONFIGURASYONU
;; ------------------------------------------------------
(elpy-enable)
(setq elpy-rpc-python-command "/home/dei/anaconda3/bin/python")
(setq python-shell-interpreter "/home/dei/anaconda3/bin/ipython3"
      python-shell-interpreter-args "-i --simple-prompt")

;; elpy ile flymake yerine flycheck kullan
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; kayitta autopep8 duzenlemesi yap
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;;autopair uc tirnak ayari

(add-to-list 'load-path "/home/dei/.emacs.d/autopair")
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

(add-hook 'python-mode-hook
          #'(lambda ()
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))



 (setq prettify-symbols-unprettify-at-point 'right-edge)
  (global-prettify-symbols-mode 0)

  (add-hook
   'python-mode-hook
   (lambda ()
     (mapc (lambda (pair) (push pair prettify-symbols-alist))
           '(("def" . "𝒇")
             ("class" . "𝑪")
             ("and" . "∧")
             ("or" . "∨")
             ("not" . "￢")
             ("in" . "∈")
             ("not in" . "∉")
             ("return" . "⟼")
             ("yield" . "⟻")
             ("for" . "∀")
             ("!=" . "≠")
             ("==" . "＝")
             (">=" . "≥")
             ("<=" . "≤")
             ("[]" . "⃞")
             ("=" . "≝")))))



;;----------------------------------------------------------;;
;;       C                                                  ;;
;;----------------------------------------------------------;;


