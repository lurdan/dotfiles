;;; twittering-mode
(autoload 'twittering-mode "twittering-mode" "" t)
(autoload 'twittering-update-status-from-minibuffer "twittering-mode" "" t)

(setq twittering-username "lurdan")
;(setq twittering-password "")
;(setq twittering-proxy-server "")
;(setq twittering-proxy-port "8080")

;; private functions
(defun twit ()
  (interactive)
  (twittering-update-status-from-minibuffer))

(defun update-elisp-twittering-mode ()
  (interactive)
  (auto-install-from-url "http://github.com/hayamiz/twittering-mode/raw/master/twittering-mode.el"))

(add-hook 'twittering-new-tweets-hook (lambda ()
  (let ((n twittering-new-tweets-count))
    (if (> n 20)
      (todochiku-message
        (apply 'concat (mapcar (lambda(x) (format "%s " x)) twittering-new-tweets-spec))
        (format "You have %d new tweet%s"
          n (if (> n 1) "s" ""))
        (todochiku-icon 'social))
       (dolist (el new-statuses)
         (todochiku-message
            (cdr (assoc 'user-screen-name el))
;           (apply 'concat (mapcar (lambda(x) (format "%s " x)) twittering-new-tweets-spec))
;           (concat (cdr (assoc 'user-screen-name el))
;             " said: "
             (cdr (assoc 'text el))
;             )
;           (todochiku-icon 'social)
             (twittering-make-icon-string nil nil (cdr (assoc 'user-profile-image-url el)))
           ))))))
