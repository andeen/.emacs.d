
; SWIG customizations
(provide 'swig-setup)

; use C++ mode for lack of a better one
(setq auto-mode-alist (cons '("\\.i$" . c++-mode)
                            auto-mode-alist))

