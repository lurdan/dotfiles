;;;; -*- mode: lisp-interaction; syntax: elisp; coding: utf-8 -*-
(defvar *emacs-load-start* (current-time))

;; .emacs 用の macro
; via. http://www.sodan.org/~knagano/emacs/dotemacs.html
(defmacro exec-if-bound (sexplist)
  ""
  `(if (fboundp (car ',sexplist))
       ,sexplist))

(defmacro defun-add-hook (hookname &rest sexplist)
  ""
  `(add-hook ,hookname
             (function (lambda () ,@sexplist))))

(defmacro eval-safe (&rest body)
  ""
  `(condition-case error
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(defun load-safe (loadlib)
  ""
  (let ((load-status (load loadlib t)))
    (or load-status
        (message (format "[load-safe] faild %s" loadlib)))
    load-status))

(defun autoload-if-found (function file &optional docstring interactive type)
  ""
  (and (locate-library file)
       (autoload function file docstring interactive type)))

;; load-path にサブディレクトリごと追加
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
           (default-directory my-lisp-dir))
      (add-to-list 'load-path my-lisp-dir)
      (normal-top-level-add-subdirs-to-load-path)))

;; basic settings
(exec-if-bound (menu-bar-mode -1)) ; メニューバーを消す
(exec-if-bound (tool-bar-mode 0)) ; ツールバーを消す
(exec-if-bound (scroll-bar-mode -1)) ; スクロールバーを消す
(auto-compression-mode t) ; edit gz files
(setq
 inhibit-startup-message t ; 起動メッセージを表示しない
 gc-cons-threshold (* 10 gc-cons-threshold) ; GCの間隔(を大きくして反応を良さげに)
 frame-title-format "%b" ; タイトルバーにファイル名を表示
 kill-read-only-ok t ; surpress errors when killing read only buffers
 message-log-max 10000 ; ログの記録行数
 history-length 1000 ; 履歴をたくさん保存する
 echo-keystrokes 0.8 ; エコーエリアにキーストロークを表示するまでの時間 (default 0 なら表示しない)
 enable-recursive-miniburffers t ; ミニバファを再帰的に呼び出せるようにする
 large-file-warning-threshold (* 25 1024 1024) ; 大きいファイルを開こうとした場合に警告。サイズ閾値 25MB。
 )

(setq-default indent-tabs-mode nil) ; avoid using tab to aligning
(setq-default save-place t) ; ファイル内のカーソル位置を記憶する
(require 'saveplace)

(windmove-default-keybindings) ; shift + cursor to move to other window
(savehist-mode 1) ; 履歴を保存する

;(global-hl-line-mode 1) ;現在行に色をつける
;(set-face-background 'hl-line "darkolivegreen") ;現在行につける色

(transient-mark-mode 1) ; リージョンに色をつける

(show-paren-mode 1)

(setq use-dialog-box nil) ; ダイアログボックスを使わないようにする
(defalias 'message-box 'message)

(defalias 'yes-or-no-p 'y-or-n-p) ; yes と入力するのは面倒なので y で十分にする

(ffap-bindings) ; 現在位置のファイル・URL を開く
(setq diff-switches "-u")

;; ファイル名がかぶった場合にバッファ名をわかりやすくする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; カーソル位置の表示
(line-number-mode t)
(column-number-mode t)

;; surpress newline at last of buffer
(setq next-line-add-newlines nil)
(setq require-final-newline t)

;;; iswitchb
(require 'iswitchb)
(iswitchb-mode 1)
(iswitchb-default-keybindings)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil) ; 部分文字列のかわりに正規表現を使う場合は t
(setq iswitchb-prompt-newbuffer nil)

(ido-mode 1)
(exec-if-bound (ido-everywhere 1))

; shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
; for zsh
; [[ $EMACS = t ]] && unsetopt zle

(cua-mode t)
(setq cua-enable-cua-keys nil)

; bookmark. C-x r m to set, C-x r l to jump
(setq bookmark-save-flag 1)
(progn
  (setq bookmark-sort-flag nil)
  (defun bookmark-arrange-latest-top ()
    (let ((latest (bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (cons latest (delq latest bookmark-alist))))
    (bookmark-save))
  (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))


;; chmod +x for shebang
(add-hook
  'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;; バックアップファイルの保存場所を指定
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.backup"))
            backup-directory-alist))

;; http://namazu.org/~satoru/diary/?200203c&to=200203272#200203272
;; 編集中のファイルを開き直す
;; - yes/no の確認が不要;;   - revert-buffer は yes/no の確認がうるさい
;; - 「しまった! 」というときにアンドゥで元のバッファの状態に戻れる
;;   - find-alternate-file は開き直したら元のバッファの状態に戻れない
;;
(defun reopen-file ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat
              old-supersession-threat)))))

;(define-key ctl-x-map "\C-r"  'reopen-file)

;; info path
(setq Info-directory-list
      `( ,(expand-file-name "../info" data-directory)
         "~/.emacs.d/info"))

(load-safe "private.el")

(load-safe "init_specific.el") ; load elisp packages
(load-safe "init_japanese.el") ; Japanese Environment
(load-safe "init_common.el") ; load elisp packages

(load-safe "init_global-key.el")

; load custom settings
(setq custom-file "~/.emacs-custom")
(load-safe custom-file)

;; revert all settings when something go wrong
(put 'eval-expression 'disabled nil)
(setq minibuffer-max-depth nil)

;(howm-menu)

;; 時間計測
(message "My .emacs loaded in %ds" (destructuring-bind (hi lo ms) (current-time)
                                     (- (+ hi lo) (+ (first *emacs-load-start*) (second *emacs-load-start*)))))

;;;;;;;;;;;;;
;;; graveyard

;; ステータスラインに時間を表示 (screen にまかせる)
;(setq display-time-24hr-format t
;      display-time-day-and-date t)
;(display-time)

;;; 一行が 80 字以上になった時には自動改行する
;(setq fill-column 180)
;(setq text-mode-hook 'turn-on-auto-fill)
;(setq default-major-mode 'text-mode)

