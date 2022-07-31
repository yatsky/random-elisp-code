(defun yaoni/get-text-object (&optional entire-line)
  "Return an my own text object based on `ENTIRE-LINE'."
  (let* ((beg (if entire-line
                  (line-beginning-position)
                (point)))
         (end (save-excursion
                ;; go to the end of line and move backwards
                ;; the cursor will be right before the line break.
                ;; (eq (char-after) 10)
                (goto-char (line-end-position))
                (while
                    (and
                     (> (point) beg)
                     (memq (char-before) (list 32 9)))
                  (backward-char))
                (point))))
    (evil-range beg end)))

(evil-define-text-object yaoni/line-w/o-newline (count &optional beg end type)
  "Select a line without \n or \n\r."
  (yaoni/get-text-object t))

(evil-define-text-object yaoni/point-to-end-w/o-newline (count &optional beg end type)
  "Select characters from point to end of line without \n or \n\r."
  (yaoni/get-text-object))

(define-key evil-inner-text-objects-map "y" 'yaoni/point-to-end-w/o-newline)
(define-key evil-outer-text-objects-map "y" 'yaoni/line-w/o-newline)

(provide 'yaoni-evil-object)
;;; yaoni-evil-object.el ends here
