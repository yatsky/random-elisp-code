;; -*- lexical-binding: t; -*-

(defun yaoni/get-buffer-name ()
  (interactive)
  (kill-new (buffer-name)))

(defun yaoni/get-code-location ()
  "Gets the current file name (via buffer name) and the line number."
  (interactive)
  (kill-new (concat (buffer-name) (string-replace "Line" ":" (what-line)))))

(provide 'yaoni-get-buffer-name)
