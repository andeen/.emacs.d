
; utility functions
(provide 'utils)

(defun char-whitespace-p ()
  (char-equal (char-syntax (char-after)) 32))
(defun pull-to-right-margin ()
  "deletes chars from the beginning of the line until it fits into 78 columns"
  (interactive)
  (let* ((line (buffer-substring (save-excursion (beginning-of-line) (point))
                                 (save-excursion (end-of-line) (point))))
         (length (length line)))
    (if (> length 78)
        (progn
          (beginning-of-line)
          (while (and (> length 78) (char-whitespace-p))
            (progn
              (delete-char 1)
              (setq length (- length 1))))))))
(global-set-key "\C-ce" 'pull-to-right-margin)

(defun push-to-right-margin ()
  "insert spaces at the beginning of the line until it fills 78 columns"
  (interactive)
  (let* ((line (buffer-substring (save-excursion (beginning-of-line) (point))
                                 (save-excursion (end-of-line) (point))))         (length (length line)))
    (if (< length 78)
        (progn
          (beginning-of-line)
          (insert-char 32 (- 78 length))))))
(global-set-key "\C-cr" 'push-to-right-margin)

(defun duplicate-line ()
  "duplicates the current line"
  (interactive)
  (progn
    (kill-whole-line)
    (yank) (yank)
    (forward-line -1)))
(global-set-key "\C-cl" 'duplicate-line)

(require 'tabify)
(defun untabify-buffer ()
  "Untabify the entire current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun transpose-buffers ()
  "Transpose the buffers shown in two windows."
  (interactive)
  (let ((this-win (window-buffer))
        (next-win (window-buffer (next-window))))
    (set-window-buffer (selected-window) next-win)
    (set-window-buffer (next-window) this-win)))
(global-set-key "\C-xt" 'transpose-buffers)

(defun copy-to-next-window ()
  "Transpose the buffers shown in two windows."
  (interactive)
  (let ((this-win (window-buffer)))
    (set-window-buffer (next-window) this-win))
  (switch-to-buffer nil))
(global-set-key "\C-xn" 'copy-to-next-window)

(defun kill-other-buffers ()
  "Kill all buffers but the current one.
   Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))
(global-set-key "\C-cko" 'kill-other-buffers)

(defun kill-all-buffers ()
  "Kill all buffers.
   Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (not (buffer-file-name buffer))
      (kill-buffer buffer))))
(global-set-key "\C-cka" 'kill-all-buffers)

(defun smart-open-line ()
  "Insert an empty line after the current line.
   Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
(global-set-key [(shift return)] 'smart-open-line)

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))
(global-set-key [(control shift return)] 'smart-open-line-above)

(defun tail-file (FILENAME)
  "Open a file in auto-revert tail mode."
  (interactive "fTail file: ")
  (find-file FILENAME)
  (auto-revert-tail-mode)
  (end-of-buffer))
(global-set-key "\C-x\C-t" 'tail-file)

(defun switch-and-compile ()
  "Start compilation, switch to buffer and follow point"
  (interactive)
  (compile compile-command)
  (switch-to-buffer (get-buffer "*compilation*"))
  (delete-other-windows))
(setq compilation-scroll-output 'next-error)
;(setq compilation-skip-threshold 2)
(global-set-key "\C-xc" 'switch-and-compile)

;; http://www.emacswiki.org/emacs/SwitchingBuffers#toc5
(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and
   forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; set key binding
(global-set-key (kbd "C-`") 'switch-to-previous-buffer)
