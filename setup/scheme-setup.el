
; Scheme customizations
(provide 'scheme-setup)

(setq auto-mode-alist (cons '("\\.ss$" . scheme-mode)
                            auto-mode-alist))
(put 'deleting-let  'scheme-indent-function 1)
(put 'deleting-let* 'scheme-indent-function 1)
(put 'let-at-once   'scheme-indent-function 1)
(put 'for-each-case 'scheme-indent-function 1)
(put 'for-each-combination 'scheme-indent-function 1)
(put 'repeat 'scheme-indent-function 1)

