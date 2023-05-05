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

(defun display-last-modified-files ()
  "Display the result of a shell command in a new buffer called *last modified files*."
  (interactive)
  ;; Replace "git ls-files -z | xargs -0 -n1 -I{} -- git log -1 --format="%ai {}" -- {}  | sort | tail -n 5" with your desired shell command
  (let ((shell-command "git diff --name-only HEAD~1 HEAD")
        (buffer-name "*last modified files*")
        (dd (vc-root-dir)))
    (with-current-buffer (get-buffer-create buffer-name)
      ;; need to set this for the buffer
      ;; so that shell command can use the correct dir
      (setq default-directory dd)
      (erase-buffer)
      (insert (shell-command-to-string shell-command))
      (display-buffer buffer-name))))

(provide 'yaoni-magit)
;;; yaoni-magit.el ends here
