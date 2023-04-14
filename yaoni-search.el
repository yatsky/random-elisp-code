;; -*- lexical-binding: t; -*-

(defun yaoni/search-current-folder ()
  "Search for string in the current folder."
  (interactive)
  (let* ((cur-dir
          (condition-case nil
              (string-join
               (butlast (split-string (buffer-file-name) "/")) "/")
            ;; remove the trailing / from (dired-current-directory)
            ;; so the result matches result from above code
            (error (substring (dired-current-directory)
                              0
                              (-
                               (length (dired-current-directory)) 1))))))
    (message "cur-dir=%s" cur-dir)
    (counsel-git-grep nil cur-dir nil "git grep cur dir: ")))
(provide 'yaoni-search)
