;; -*- lexical-binding: t; -*-

(defun yaoni/get-buffer-name ()
  (interactive)
  (kill-new (buffer-name)))

(provide 'yaoni-get-buffer-name)
