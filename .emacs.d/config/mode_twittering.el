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
