;; perltidy
;; aptitude install perltidy
(defun perltidy-region (beg end)
  (interactive "r")
  (shell-command-on-region beg end "perltidy -q" nil t))

