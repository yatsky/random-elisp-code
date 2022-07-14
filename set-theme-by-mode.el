;; adapted from http://xahlee.info/emacs/emacs/emacs_set_theme_on_mode.html

(defun set-vterm-theme ()
  "Set background color or theme depending on major mode."
  (message "setting theme.")
  (if (eq major-mode 'vterm-mode)
      (progn 
        (set-background-color "black")
        (set-foreground-color "white"))))

(add-hook 'vterm-mode-hook 'set-vterm-theme)

(setq special-display-buffer-names '("*vterm*"))
