;; -*- lexical-binding: t; -*-

(defun yaoni/get-buffer-name ()
  (interactive)
  (kill-new (buffer-name)))

(defun yaoni/get-code-location ()
  "Gets the repo name, file name (via buffer name), the line number, and the commit hash."
  (interactive)
  (let* ((root-dir
          ;; second (2) to last
          (car (last (split-string (vc-root-dir) "/") 2)))
         (file-name (replace-regexp-in-string
                     (concat ".*" root-dir)
                     root-dir
                     (buffer-file-name)))
         (file-name-split (split-string file-name "/"))
         (first-part (car file-name-split))
         (rest-part (mapconcat 'identity (cdr file-name-split) "/"))
         (line-number (string-replace "Line " "#L" (what-line)))
         (commit-hash (vc-git-working-revision (buffer-file-name))))
    (kill-new (concat "https://github.com/domain-group/" first-part "/blob/" commit-hash "/" rest-part line-number ))))

(provide 'yaoni-get-buffer-name)
