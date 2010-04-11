;;; ack
; aptitude install ack-grep
(defun ack ()
  (interactive)
  (let ((grep-find-command "ack-grep --nocolor --nogroup "))
    (call-interactively 'grep-find)))

