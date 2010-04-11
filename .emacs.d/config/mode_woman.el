;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; WoMan
(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)
(autoload 'woman-dired-find-file "woman"
  "In dired, run the WoMan man-page browser on this file." t)

;; default ("/usr/man" "/usr/local/man")
(setq woman-manpath '("/usr/share/man" "/usr/share/man/ja"))

;; 初回起動が遅いので cache 作成。
(setq woman-cache-filename (expand-file-name "~/.backup/woman_cache"))

;; 新しく frame は作らない。
(setq woman-use-own-frame nil)

; `r' で関連項目へジャンプ
(setq Man-see-also-regexp "SEE ALSO\\|関連項目")
; 各ヘッダ間を `n', `p' でジャンプ
(setq Man-first-heading-regexp
           "^[ \t]*NAME$\\|^[ \t]*名[前称]$\\|^[ \t]*No manual entry fo.*$")
(setq Man-heading-regexp "^\\([A-Zーぁ-んァ-ヶ亜-瑤][A-Zーぁ-んァ-ヶ亜-瑤 \t]+\\)$")
