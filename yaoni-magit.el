;; -*- lexical-binding: t; -*-
;; source: https://github.com/aborn/.spacemacs.d/blob/687750f41a67ef3e8829b36095074f05d75f5b0d/parts/aborn-swift.el#L71
(defun yaoni/simple-git-commit-push ()
  "Simple commit current git project and push to its upstream."
  (interactive)
  (when (and buffer-file-name
             (buffer-modified-p))
    (save-buffer))                   ;; save it first if modified.
  (magit-diff-unstaged)
  (when (yes-or-no-p "Do you really want to commit everything?")
    (magit-stage-modified)
    (magit-diff-staged)
    (setq msg (read-string "Commit Message: "))
    (when (= 0 (length msg))
      (setq msg (format-time-string "commit by magit in emacs@%Y-%m-%d %H:%M:%S"
                                    (current-time))))
    (message "commit message is %s" msg)
    (magit-call-git "commit" "-m" msg)
    (magit-push-current-to-upstream nil)
    (message "now do async push to %s" (magit-get "remote" "origin" "url")))
  (magit-mode-bury-buffer))

(provide 'yaoni-magit)
;;; yaoni-magit.el ends here
