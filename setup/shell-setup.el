
; Shell customizations
(provide 'shell-setup)

(defun activate-ansi-colors ()
  (require 'ansi-color)
  (ansi-color-for-comint-mode-on))
(add-hook 'comint-mode-hook 'activate-ansi-colors)
(add-hook 'shell-mode-hook 'activate-ansi-colors)
