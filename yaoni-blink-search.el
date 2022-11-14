;; -*- lexical-binding: t; -*-
(require 's)

(defun browse-url-macosx-edge-browser (url &optional _new-window)
  "Invoke Microsoft Edge browser in MacOS.
The optional NEW-WINDOW argument is not used."
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (do-applescript
   (s-lex-format "
tell application \"Microsoft Edge\"
    activate open location \"${url}\"
end tell")))

(function-put 'browse-url-macosx-edge-browser 'browse-url-browser-kind
              'external)

(provide 'yaoni-blink-search)
;;; yaoni-blink-search.el ends here
