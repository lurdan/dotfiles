;;;;;;;;;;;
;; 自動保存
;(install-elisp "http://coderepos.org/share/export/15652/lang/elisp/auto-save-buffers-enhanced/trunk/auto-save-buffers-enhanced.el")
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 2)
(auto-save-buffers-enhanced t)
