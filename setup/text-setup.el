
(provide 'text-setup)

(require 'gnus-art)
(defun rs-emphasize ()
  "Emphasize text according to `gnus-emphasis-alist'."
  ;; Code from `article-emphasize' in `gnus-art.el'
  (interactive)
  (save-excursion
    (let ((alist gnus-emphasis-alist)
          (inhibit-read-only t)
          (props (append '(article-type emphasis)
                         gnus-hidden-properties))
          regexp elem beg invisible visible face)
      (setq beg (point-min))
      (while (setq elem (pop alist))
        (goto-char beg)
        (setq regexp (car elem)
              invisible (nth 1 elem)
              visible (nth 2 elem)
              face (nth 3 elem))
        (while (re-search-forward regexp nil t)
          (when (and (match-beginning visible) (match-beginning invisible))
            (push 'emphasis gnus-article-wash-types)
            (gnus-article-hide-text
             (match-beginning invisible) (match-end invisible) props)
            (gnus-article-unhide-text-type
             (match-beginning visible) (match-end visible) 'emphasis)
            (gnus-put-text-property-excluding-newlines
             (match-beginning visible) (match-end visible) 'face face)
            (goto-char (match-end invisible))))))))
;(add-hook 'text-mode-hook 'rs-emphasize)


(require 'flymake)
(defun flymake-proselint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "proselint" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks '("\\.txt\\'" flymake-proselint-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.md\\'" flymake-proselint-init))
(add-hook 'text-mode-hook '(lambda () (flymake-mode t)))

