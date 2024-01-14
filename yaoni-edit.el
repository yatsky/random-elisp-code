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

(defun yaoni/copy-minibuffer ()
  "Copy the minibuffer content with live candidates."
  (interactive)
  (mark-whole-buffer)
  (kill-ring-save))

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

(defun yaoni/indent-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))

(provide 'yaoni-edit)
;;; yaoni-edit.el ends here
