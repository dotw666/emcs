;; inhibit splash screen
(setq inhibit-splash-screen t)

;; change the font
(set-face-attribute 'default nil :font "menlo-9" )

;; maximize screen on startup
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; disable menu on startup
(menu-bar-mode -1)

;; disable tools on startup
(tool-bar-mode -1)

;; disable scroll bar on startup
(scroll-bar-mode -1)

;; set "gnu" style indenting for c
(setq c-default-style "linux"
      c-basic-offset 4)

;; turn on electric pair mode
(electric-pair-mode 1)

;; add custom load path for themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; load custom theme
(load-theme 'dracula t)
