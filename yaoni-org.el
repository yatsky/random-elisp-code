;; -*- lexical-binding: t; -*-

(defun yaoni/org-cycle ()
  (interactive)
  (org-babel-goto-src-block-head)
  (org-cycle))


(provide 'yaoni-org)
;;; yaoni-org.el ends here
