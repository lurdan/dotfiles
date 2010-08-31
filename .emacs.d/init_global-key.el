;;; keybind settings
;; auto indent
;(global-set-key "\C-m" 'newline-and-indent)
;(global-set-key "\C-j" 'newline)

;(global-set-key [?\C-:] 'anything)

;(global-set-key "\C-x\M-t" 'text-translator)
;(global-set-key "\C-x\M-T" 'text-translator-translate-last-string)

(global-set-key (kbd "C-h") 'delete-backward-char)


;; キーバインドを定義するマイナーモード
;(setq my-keyjack-mode-map (make-sparse-keymap))
;(mapcar (lambda (x)
;          (define-key my-keyjack-mode-map (car x) (cdr x))
;          (global-set-key (car x) (cdr x)))
;        '(
;          ("\t". hippie-expand)
;;	  ("\C-c\t" . indent-relative)
;	  ))

;(easy-mmode-define-minor-mode my-keyjack-mode
;			      "Grab keys" ; ドキュメント
;			      nil ; 初期値 t にすると、全てでオンになる
;			      " Keyjack" ; on の時のモード行への表示
;			      my-keyjack-mode-map ; マイナモード用キーマップの初期値
;			      )
