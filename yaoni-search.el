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
	(if (vc-backend (buffer-file-name))
		(counsel-git-grep nil cur-dir nil "git grep cur dir: ")
	  (counsel-rg nil cur-dir nil "grep cur dir:"))))


(defun filter-pred (prefix str)
  (s-starts-with? prefix str))

(defun yaoni/get-cands ()
  "Get the candidates for yaoni/search-current-folder-file."
  (interactive)
  ;; we remove the (counsel-locate-git-root) from the string
  ;; to make it shorter as some projects will have deeply
  ;; nested folder structure
  (mapcar (lambda (str) (string-join (split-string str (counsel-locate-git-root))))
          (-filter (apply-partially 'filter-pred (yaoni/get-current-dir))
                   (mapcar (lambda (str) (concat (counsel-locate-git-root) str))
                           (split-string
                            (shell-command-to-string counsel-git-cmd)
                            "\0"
                            t)))))

(defun yaoni/get-current-buffer-folder ()
  "Return the folder name of the current buffer."
  (let ((dir (or (if (eq major-mode 'dired-mode)
                     (dired-current-directory)
                   (if (vc-backend (buffer-file-name))
					   (counsel-locate-git-root)
					 (or buffer-file-name default-directory)))
                 default-directory)))
    (message dir)
    dir))

(defun yaoni/search-current-folder-file ()
  (interactive)
  (ivy-read "Find file cur dir: " (yaoni/get-cands)
            :action (lambda (file) (find-file (concat (yaoni/get-current-buffer-folder) file)))
            :history 'counsel-git-history
            :caller 'counsel-git))
(provide 'yaoni-search)
