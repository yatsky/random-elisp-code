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
        (if (y-or-n-p "Buffer content too long. Proceed? (y/n)")
            (kill-new s)
          (message "Operation canclled."))
      (kill-new s))))

(defun yaoni/upcase-thing-at-point ()
  "Upcase thing at point"
  (interactive)
  (yaoni/mark-node)
  (upcase-region (region-beginning) (region-end)))

(defun yaoni/downcase-thing-at-point ()
  "Downcase thing at point."
  (interactive)
  (yaoni/mark-node)
  (downcase-region (region-beginning) (region-end)))


(evil-define-operator yaoni/evil-replace-with-kill-ring (beg end type register yank-handler)
  "Replace current content from BEG to END with content in kill-ring."
  (interactive "<R><x><y>")
  ;; somehow no need to call 'evil-delete interactively?
  (evil-delete beg end type register yank-handler)
  (insert (cadr kill-ring)))

(define-key evil-normal-state-map "r" 'yaoni/evil-replace-with-kill-ring)

(provide 'yaoni-edit)
;;; yaoni-edit.el ends here
