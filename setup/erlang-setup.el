
; Erlang
(provide 'erlang-setup)

(require 'flymake)
(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name temp-file
		(file-name-directory buffer-file-name))))
    (list "/home/lballabio/bin/check-erlang" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))
(add-hook 'erlang-mode-hook 'flymake-mode)

