;;; text-translator
; auto-install-batch

(require 'text-translator)
(setq text-translator-auto-selection-func
  'text-translator-translate-by-auto-selection-enja)

;; プリフィックスキーを変更する場合.
;; (setq text-translator-prefix-key "\M-n")
