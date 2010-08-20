;;;;;;;;;;;;;;;
;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/"
      auto-install-save-confirm nil)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

