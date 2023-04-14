;; -*- lexical-binding: t; -*-
(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(provide 'yaoni-date)

