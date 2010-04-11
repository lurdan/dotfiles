;;; browser-kill-ring
; aptitude install emacs-goodies-el
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;(global-set-key "\C-y" 'browse-kill-ring)
(setq browse-kill-ring-display-style 'one-line)
(setq browse-kill-ring-quit-action 'kill-and-delete-window)
(setq browse-kill-ring-highlight-current-entry t)
(setq browse-kill-ring-highlight-inserted-item t)
