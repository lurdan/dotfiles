;;; pod-mode
; aptitude install emacs-goodies-el

(require 'pod-mode)
(add-to-list 'auto-mode-alist
             '("\\.pod$" . pod-mode))

(add-hook 'pod-mode-hook
          '(lambda () (progn
                        (font-lock-mode)
                        (auto-fill-mode 1)
                        (flyspell-mode 1)
                        )))

