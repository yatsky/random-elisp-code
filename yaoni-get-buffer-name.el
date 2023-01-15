;; -*- lexical-binding: t; -*-

(defun yaoni/get-buffer-name ()
  (interactive)
  (kill-new (buffer-name)))

(defun yaoni/get-code-location ()
  "Gets the repo name, file name (via buffer name) and the line number."
  (interactive)
  (let ((root-dir
         ;; second (2) to last
         (car (last (split-string (vc-root-dir) "/") 2))))
    (kill-new  (concat (replace-regexp-in-string
                        (concat ".*" root-dir)
                        root-dir
                        (buffer-file-name))
                       (string-replace "Line" ":" (what-line))))))

(provide 'yaoni-get-buffer-name)
