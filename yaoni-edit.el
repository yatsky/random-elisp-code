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

(defun yaoni/upcase-thing-at-point ()
  "Upcase thing at point"
  (interactive)
  (yaoni/mark-node)
  (upcase-region (region-beginning) (region-end)))

(defun yaoni/downcase-thing-at-point-region ()
  "Downcase thing at point."
  (interactive)
  (yaoni/mark-node)
  (downcase-region (region-beginning) (region-end)))

(provide 'yaoni-edit)
;;; yaoni-edit.el ends here
