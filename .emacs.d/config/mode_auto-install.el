;;;;;;;;;;;;;;;
;; auto-install
; (install-elisp-from-emacswiki "auto-install.el")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/"
      auto-install-save-confirm nil
      ediff-window-setup-function 'ediff-setup-windows-plain
      )
;(add-to-list 'load-path auto-install-directory)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

