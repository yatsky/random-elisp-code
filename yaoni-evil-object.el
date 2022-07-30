(evil-define-text-object yaoni/line-w/o-newline (count &optional beg end type)
  "Select a line without \n or \n\r."
  (let ((beg (line-beginning-position))
        (end (line-end-position)))
    (setq end (save-excursion
                ;; go to the end of line and move backwards
                ;; the cursor will be right before the line break.
                ;; (eq (char-after) 10)
                (goto-char end)
                (while
                    (and
                     (> (point) beg)
                     (memq (char-before) (list 32 9)))
                  (backward-char))
                (point)))
    (evil-range beg end)))

(define-key evil-inner-text-objects-map "y" 'yaoni/line-w/o-newline)

(provide 'yaoni-evil-object)
;;; yaoni-evil-object.el ends here
