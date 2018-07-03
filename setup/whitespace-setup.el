
(provide 'whitespace-setup)

(require 'whitespace)
(setq-default whitespace-check-buffer-leading nil)
(setq-default whitespace-check-buffer-trailing nil)
(global-set-key "\C-cwc" 'whitespace-cleanup)
(global-set-key "\C-cub" 'untabify-buffer)
