
; global customizations
(provide 'global-setup)

(global-font-lock-mode 1)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(global-set-key "\C-ct" 'toggle-truncate-lines)
(global-set-key "\C-xr" 'revert-buffer)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

(global-set-key "\C-c\C-g" 'keyboard-quit)
(global-set-key "\C-x\C-g" 'keyboard-quit)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq dabbrev-case-replace nil)

(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode)

(require 'flymake)
(require 'flymake-cursor)
(global-set-key "\C-cne" 'flymake-goto-next-error)
(global-set-key "\C-cpe" 'flymake-goto-prev-error)

(require 'expand-region)
(global-set-key (kbd "C-(") 'er/expand-region)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-~") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(require 'dimmer)
(dimmer-activate)
(setq dimmer-percent 0.40)

(setq scroll-margin 3)
(setq x-stretch-cursor t)

(windmove-default-keybindings 'super)
