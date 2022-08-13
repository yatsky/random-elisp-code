(defun yaoni/get-html-text (buffer-name)
  (interactive)
  (let* ((text (progn
                 (with-current-buffer buffer-name
                   (dom-texts (libxml-parse-html-region (point-min) (point-max)) "\n")))
               ))
    (with-current-buffer
        (get-buffer-create "*output*")
      (erase-buffer)
      (insert text))))

(defun yaoni/get-html-headings (buffer-name)
  (let* ((text (progn
                 (with-current-buffer buffer-name
                   (mapconcat 'dom-texts (dom-by-tag (libxml-parse-html-region (point-min) (point-max)) 'code) "\n")))
               ))
    (with-current-buffer
        (get-buffer-create "*output-headings*")
      (erase-buffer)
      (insert text))))

(defun yaoni/get-html-subheadings (buffer-name)
  (let* ((text (progn
                 (with-current-buffer buffer-name
                   (mapconcat 'dom-texts (dom-by-tag (libxml-parse-html-region (point-min) (point-max)) 'strong) "\n")))
               ))
    (with-current-buffer
        (get-buffer-create "*output-headings*")
      (erase-buffer)
      (insert text))))
