
; C/C++ customizations
(provide 'cpp-setup)

(defun complete-initialization-list-item ()
  (interactive)
  (backward-kill-word 1)
  (yank)
  (insert "(")
  (yank)
  (backward-delete-char 1)
  (insert ")"))

(setq-default c-basic-offset 4)
(defun my-c-mode-hook ()
  (c-set-offset 'access-label '/)
  (c-set-offset 'case-label '*)
  (c-set-offset 'statement-case-intro '*)
  (c-set-offset 'member-init-intro nil)
  (local-set-key "\C-cf" 'complete-initialization-list-item))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
