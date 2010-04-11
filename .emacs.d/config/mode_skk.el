;;; skk
; aptitude install ddskk
;(setq skk-sticky-key [convert])

;(autoload 'skk-mode "skk" nil t)
(require 'skk)
(global-set-key "\C-x\C-j" 'skk-mode) 
(global-set-key "\C-xj" 'skk-auto-fill-mode) 
;(global-set-key "\C-xt" 'skk-tutorial)
(autoload 'skk-auto-fill-mode "skk" nil t)
;(autoload 'skk-tutorial "skk-tut" nil t)
(autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
(autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)
(add-hook 'isearch-mode-hook
	  (function (lambda ()
		      (and (boundp 'skk-mode) skk-mode
			   (skk-isearch-mode-setup) ))))
(add-hook 'isearch-mode-end-hook 
	  (function (lambda () 
		      (and (boundp 'skk-mode) skk-mode 
			   (skk-isearch-mode-cleanup) 
			   (skk-set-cursor-color-properly) )))) 

(setq skk-server-host "127.0.0.1")
(setq skk-server-portnum 1178)
;(setq skk-large-jisyo "~/.skkdic/SKK-JISYO.L")
;(setq skk-server-prog "/usr/sbin/skkserv.rb")
;(setq skk-aux-large-jisyo "~/.skkdic/SKK-JISYO.L.unannotated")
(setq skk-tut-file "")

;;; 各種モードで自動的に SKK が起動するようにする
;;(setq default-major-mode 'text-mode)
;(add-hook 'c-mode-hook '(lambda () (skk-mode t)))
(add-hook 'text-mode-hook '(lambda () (skk-mode t)))
(add-hook 'po-subedit-mode-hook '(lambda () (skk-mode t)))
(add-hook 'sgml-mode-hook '(lambda () (skk-mode t)))
(add-hook 'yatex-mode-hook '(lambda () (skk-mode t)))

;; ミニバッファ上でも skk-mode にする
;; skk-latin-mode でアルファベット入力にしておく
(add-hook 'minibuffer-setup-hook
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               (skk-latin-mode (point))
               ;; ミニバッファ上に「nil」と表示させないために, 空文字をミニバッファに表示
               (minibuffer-message "")
               )))

;;; server completion を有効にする
(add-to-list 'skk-search-prog-list
             '(skk-server-completion-search) t)
(add-to-list 'skk-completion-prog-list
             '(skk-comp-by-server-completion) t)

;; 個人辞書への学習をしない
;(add-hook 'skk-search-excluding-word-pattern-function
;          #'(lambda (kakutei-word)
;              (eq (aref skk-henkan-key (1- (length skk-henkan-key)))
;                  skk-server-completion-search-char)))

;(setq skk-jisyo-code 'utf-8)
;(setq skk-share-private-jisyo t)

(setq skk-dcomp-activate t)
(setq skk-show-inline 'vertical)
(setq skk-delete-implies-kakutei t)
;(setq skk-date-ad t)
(setq skk-show-tooltip t)

(setq skk-rom-kana-rule-list
      (cons '("-" nil skk-hyphen)
            skk-rom-kana-rule-list))
(defun skk-hyphen (arg)
  (let ((c (char-before (point))))
    (cond ((null c) "ー")
          ((and (<= ?0 c) (>= ?9 c)) "-")
          ((and (<= ?０ c) (>= ?９ c)) "−")
          (t "ー"))))

