
(provide 'leanpub)

(defun replace-from-beginning (regexp to-string)
  (goto-char (point-min))
  (query-replace-regexp regexp to-string))

(defun remove-hyphenation ()
  "removes \-"
  (replace-from-beginning "\\\\-" ""))

(defun remove-versal ()
  "removes versal formatting"
  (replace-from-beginning "\\\\versal{\\(.*?\\)}{\\(.*?\\)}" "\\1\\2"))

(defun remove-precis ()
  "removes precis"
  (replace-from-beginning "\\\\precis{\\(.*?\\)}" ""))

(defun replace-quotes ()
  "replaces `` and '' with double quotes"
  (replace-from-beginning "``" "\"")
  (replace-from-beginning "''" "\""))

(defun remove-escapes ()
  "replaces \_ with _ etc."
  (replace-from-beginning "\\\\_" "_")
  (replace-from-beginning "\\\\%" "%")
  (replace-from-beginning "\\\\&" "&"))

(defun replace-inline-code ()
  "replaces \code{foo} and \texttt{foo} with `foo`"
  (replace-from-beginning "\\\\code{\\(.*?\\)}" "`\\1`")
  (replace-from-beginning "\\\\texttt{\\(.*?\\)}" "`\\1`"))

(defun replace-italics ()
  "replaces \emph{foo} and similar with *foo*"
  (replace-from-beginning "\\\\emph{\\(.*?\\)}" "*\\1*")
  (replace-from-beginning "\\\\work{\\(.*?\\)}" "*\\1*")
  (replace-from-beginning "\\\\latin{\\(.*?\\)}" "*\\1*")
  (replace-from-beginning "\\\\foreign{\\(.*?\\)}" "*\\1*")
  (replace-from-beginning "\\\\definition{\\(.*?\\)}" "*\\1*"))

(defun remove-acronyms ()
  (replace-from-beginning "\\\\acronym{\\(.*?\\)}" "\\1"))

(defun replace-macros ()
  (replace-from-beginning "\\\\vect{\\(.*?\\)}" "\\\\mathbf{\\1}")
  (replace-from-beginning "\\\\cpp{}" "C++")
  (replace-from-beginning "\\\\csharp{}" "C#"))

(defun remove-pagination ()
  (replace-from-beginning ".*\\\\shortpage.*\n" "")
  (replace-from-beginning ".*\\\\longpage.*\n" "")
  (replace-from-beginning ".*\\\\clearpage.*\n" ""))

(defun remove-non-breaking-spaces ()
  (replace-from-beginning "\\([a-zA-Z]\\)~\\([a-zA-Z]\\)" "\\1 \\2"))

(defun remove-comments ()
  (replace-from-beginning "%.*\n" ""))

(defun replace-titles ()
  "replaces \chapter[...]{foo} with # foo etc."
  (replace-from-beginning "\\\\chapter{\\(.*?\\)}" "# \\1\n")
  (replace-from-beginning "\\\\section{\\(.*?\\)}" "## \\1\n")
  (replace-from-beginning "\\\\subsection{\\(.*?\\)}" "### \\1\n"))

(defun replace-code-blocks ()
  (replace-from-beginning "\\\\begin{C\\+\\+}\\[\\(.*\\(?:\n.*\\)\\{0,6\\}\\)\\]"
                          "\n{\n\\1\n}\n~~~~~~~~")
  (replace-from-beginning "\\\\begin{C\\+\\+}" "\n~~~~~~~~")
  (replace-from-beginning "\\\\end{C\\+\\+}" "~~~~~~~~\n"))

(defun replace-image-labels ()
  (replace-from-beginning "\\\\label{fig:\\(.*?\\)}" "{id=\"\\1\"}"))

(defun replace-other-labels ()
  (replace-from-beginning "\\\\label{\\(.*?\\):\\(.*?\\)}" "{#\\1-\\2}"))

(defun replace-graphics ()
  (replace-from-beginning
   ".*\\\\includegraphics\\[.*?\\]{\\(.*?\\)}.*\n.*\\\\caption{\\([[:ascii:]]*?\\)}"
   "![\\2](\\1)")
  (replace-from-beginning "\\\\begin{figure}.*\n" "")
  (replace-from-beginning ".*\\\\centering.*\n" "")
  (replace-from-beginning "\\\\end{figure}.*\n" "")
  (replace-from-beginning ".*caption=\\([[:ascii:]]*?\\)," "title=\"\\1\"")
  (replace-from-beginning ".*float=.*\n" "")
  (replace-from-beginning ".*frame=.*\n" "")
  (replace-from-beginning ".*showlines.*\n" "")
  (replace-from-beginning ".*gobble.*\n" "")
  )

(defun replace-footnotes ()
  (let ((stem (read-from-minibuffer "Footnote label? ")))
    (replace-from-beginning "\\\\footnote{\\([[:ascii:]]*?\\)}"
                            (apply 'string
                                   (append "[^" stem "]\n"
                                           "[^" stem "]: \\1\n\n" ())))))

(defun replace-pause ()
  (replace-from-beginning "\\\\breath{}" "***"))

(defun leanpub/cleanup ()
  "performs all the needed transformations"
  (interactive)
  (remove-versal)
  (remove-precis)
  (remove-hyphenation)
  (remove-escapes)
  (remove-pagination)
  (remove-non-breaking-spaces)
  (remove-comments)
  (replace-quotes)
  (replace-italics)
  (remove-acronyms)
  (replace-inline-code)
  (replace-code-blocks)
  (replace-titles)
  (replace-macros)
  (replace-image-labels)
  (replace-other-labels)
  (replace-graphics)
  (replace-footnotes)
  (replace-pause))

