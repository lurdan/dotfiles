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

(defmacro eval-safe (&rest body)
  ""
  `(condition-case error
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

;; load-path にサブディレクトリごと追加
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; basic settings
(setq inhibit-startup-message t) ; 起動メッセージを表示しない
(exec-if-bound (menu-bar-mode -1)) ; メニューバーを消す
(exec-if-bound (tool-bar-mode 0)) ; ツールバーを消す
(setq gc-cons-threshold 524880) ; GCの間隔(を大きくして反応を良さげに)
(setq frame-title-format "%b") ; タイトルバーにファイル名を表示
(auto-compression-mode t) ; edit gz files
(setq kill-read-only-ok t) ; surpress errors when killing read only buffers
(setq-default indent-tabs-mode nil) ; avoid using tab to aligning
(windmove-default-keybindings) ; shift + cursor to move to other window

;; カーソル位置の表示
(line-number-mode t)
(column-number-mode t)

;; surpress newline at last of buffer
(setq next-line-add-newlines nil)
(setq require-final-newline t)

;;; iswitchb
(require 'iswitchb)
(iswitchb-default-keybindings)

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

