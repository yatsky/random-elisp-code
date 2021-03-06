;; use regex because sometimes we need more than one vterm frame/window!
(setq special-display-regexps '("\\*vterm\\**"))

;; adapted from http://xahlee.info/emacs/emacs/emacs_set_theme_on_mode.html
(defun set-vterm-theme ()
  "Set background color or theme depending on major mode."
  (if (and
       ;; interestingly eq is enough to test equality here
       (eq major-mode 'vterm-mode) 
       ;; I'm happy with dracula theme so don't run this
       ;; if dracula's enabled
       (not (equal custom-enabled-themes '(dracula))))
      (progn 
        (message "setting basic theme for vterm.")
        (set-background-color "#282a36")
        (set-foreground-color "#f8f8f2"))))

(add-hook 'vterm-mode-hook 'set-vterm-theme)

