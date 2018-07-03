
; git customizations
(provide 'git-setup)

(require 'git-gutter)
(global-git-gutter-mode t)

(global-set-key "\C-cgs" 'git-gutter:set-start-revision)
(global-set-key "\C-cgn" 'git-gutter:next-hunk)
(global-set-key "\C-cgp" 'git-gutter:previous-hunk)

; from http://emacs.stackexchange.com/questions/16469/how-to-merge-git-conflicts-in-emacs
(defun enable-smerge ()
  (when (and buffer-file-name (vc-backend buffer-file-name))
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^<<<<<<< " nil t)
        (smerge-mode +1)))))
(add-hook 'find-file-hook #'enable-smerge)

(setq smerge-command-prefix "\C-cm")

