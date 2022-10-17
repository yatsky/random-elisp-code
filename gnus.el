;; -*- lexical-binding: t; -*-
(defun cleanup-article ()
  "Wrapper around `article-strip-trailing-space'."
  (message "Running cleanup.")
  (gnus-article-strip-leading-space)
  (gnus-article-strip-trailing-space)
  (message "Finished cleanup."))

;; Because a single article buffer is used for displaying
;; all articles (`gnus-single-article-buffer' is set to `t'),
;; `gnus-article-mode-hook' is used for modifying the
;; article buffer once, not on a per article basis.
;; So we can't use `gnus-article-mode-hook'.
;; Instead we use `gnus-article-prepare-hook'.
(add-hook 'gnus-article-prepare-hook 'cleanup-article)


(provide 'gnus)
