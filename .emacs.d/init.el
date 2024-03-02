(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes nil)
 '(git-gutter:added-sign "█|")
 '(git-gutter:deleted-sign "█▁")
 '(git-gutter:modified-sign "█⫶")
 '(ispell-dictionary "american")
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(meson-mode rust-mode git-gutter xcscope eglot markdown-mode expand-region ace-window company))
 '(scroll-bar-mode nil)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))
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

; Lock files
(setq create-lockfiles nil)

; Clangd + eglot
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

; Window resize
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

; Override major modes' keymaps
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    ; Comment or uncomment (toggle comment) region
    (define-key map (kbd "C-c C-c") 'comment-or-uncomment-region)
    map)
  "my-keys-minor-mode keymap")

(define-minor-mode my-keys-minor-mode
  "Minor mode to override major modes' keymaps"
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

;; org mode
(defun my/org-link-copy (&optional arg)
  "Extract URL from org-mode link and add it to kill ring."
  (interactive "P")
  (let* ((link (org-element-lineage (org-element-context) '(link) t))
          (type (org-element-property :type link))
          (url (org-element-property :path link))
          (url (concat type ":" url)))
    (kill-new url)
    (message (concat "Copied URL: " url))))

(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key org-mode-map (kbd "C-x y") 'my/org-link-copy)))
;; cscope
(require 'xcscope)
(cscope-setup)

;; Configure LSP.
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))

;; Configure git gutter.
(defun my:see-all-whitespace () (interactive)
       (setq whitespace-style (default-value 'whitespace-style))
       (setq whitespace-display-mappings (default-value 'whitespace-display-mappings))
       (whitespace-mode 'toggle))
