;; -*- lexical-binding: t; -*-
(defun yaoni/replace-buffer-content ()
  "Erase buffer and paste the last content in kill-ring."
  (interactive)
  (erase-buffer)
  (call-interactively 'evil-paste-before))

(defun yaoni/copy-buffer ()
  "Copy the buffer content."
  (interactive)
  (let ((s (buffer-string)))
    (if (length> s 10000)
        (message "Buffer content too long")
      (kill-new s))))
(provide 'yaoni-edit)
;;; yaoni-edit.el ends here
