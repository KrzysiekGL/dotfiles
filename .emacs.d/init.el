(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(display-fill-column-indicator-column 100)
 '(highlight-indent-guides-method 'column)
 '(package-selected-packages '(dockerfile-mode company expand-region eglot ace-window))
 '(scroll-bar-mode nil)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(package-selected-packages '(expand-region ace-window company eglot)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Eglot (for clangd)
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Font/Face size
(set-face-attribute 'default nil :height 110)

;; Vertical line
(setq fci-rule-column 100)
(global-display-fill-column-indicator-mode 1)
(global-display-line-numbers-mode 1)

;; Copying; copy-region-as-kill keybinding
(global-set-key (kbd "C-x C-y") 'copy-region-as-kill)

;; Overwrite a selected region
(delete-selection-mode 1)

;; Expand region
(global-set-key (kbd "C-;") 'er/expand-region)
(put 'upcase-region 'disabled nil)

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

; ace-window key binding
(global-set-key (kbd "M-o") 'ace-window)

; Backup dir for '.*~' files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

; Autosave dir for '#.*#' files
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosave/" t)))
