;;; elscreen
; aptitude install elscreen

(require 'elscreen-w3m)
(require 'elscreen-howm)
(require 'elscreen-server)

; タブの横幅を短くして close ボタンも消す
(setq elscreen-display-tab 8
      elscreen-tab-display-kill-screen nil)

; M-x して新しい screen を開く
(defun elscreen-create-execute (prefix-arg)
  (interactive "P")
  (message "%s" (this-command-keys))
  (setq this-command
        (read-command
         (concat (key-description (this-command-keys)) " ")))
  (elscreen-create)
  (call-interactively this-command t))

