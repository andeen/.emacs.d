
; TeX customizations
(provide 'latex-setup)

(setq auto-mode-alist (cons '("\\.lg$" . latex-mode)
                            auto-mode-alist))
(require 'tex-site)
(setq TeX-newline-function 'newline-and-indent)

(setq tex-dvi-view-command "xdvi")
(setq LaTeX-indent-level 4)
(setq tex-indent-basic 4)

(setq TeX-electric-escape t)
(setq TeX-parse-self t)
(setq TeX-auto-save t)
(setq TeX-auto-local ".auto/")

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook (function (lambda () (setq ispell-parser 'tex))))

