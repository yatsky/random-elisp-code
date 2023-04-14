;; -*- lexical-binding: t; -*-
(require 's)
(require 'counsel)

(defun yaoni/get-current-dir ()
  "Get the current directory in absolute path."
  (let ((cur-dir
         (condition-case nil
             (string-join
              (butlast (split-string (buffer-file-name) "/")) "/")
           ;; remove the trailing / from (dired-current-directory)
           ;; so the result matches result from above code
           (error (substring (dired-current-directory)
                             0
                             (-
                              (length (dired-current-directory)) 1))))))
    cur-dir))

(defun yaoni/search-current-folder ()
  "Search for string in the current folder."
  (interactive)
  (let ((cur-dir (yaoni/get-current-dir)))
    (message "cur-dir=%s" cur-dir)
    (counsel-git-grep nil cur-dir nil "git grep cur dir: ")))


(defun filter-pred (prefix str)
  (s-starts-with? prefix str))

(defun yaoni/get-cands ()
  "Get the candidates for yaoni/search-current-folder-file."
  (interactive)
  (-filter (apply-partially 'filter-pred (yaoni/get-current-dir))
           (mapcar (lambda (str) (concat (counsel-locate-git-root) str))
                   (split-string
                    (shell-command-to-string counsel-git-cmd)
                    "\0"
                    t))))

(defun yaoni/search-current-folder-file ()
  (interactive)
  (ivy-read "Find file: " (yaoni/get-cands)
            :action #'counsel-git-action
            :history 'counsel-git-history
            :caller 'counsel-git))
(provide 'yaoni-search)
