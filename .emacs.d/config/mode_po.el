;;; po-mode
; aptitude install gettext-el

(autoload 'po-mode "po-mode")
(setq auto-mode-alist (cons '("\\.po[tx]?\\'\\|\\.po\\." . po-mode)
						auto-mode-alist))

