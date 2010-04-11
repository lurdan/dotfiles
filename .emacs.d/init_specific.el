;;; load version/environment specific settings
;; Emacs 環境の判別
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (equal system-type 'usg-unix-v)))
(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-emacs20
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar run-emacs21
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar run-emacs22
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar run-emacs23
  (and (equal emacs-major-version 23)
       (null (featurep 'xemacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs20))
(defvar run-meadow2 (and run-meadow run-emacs21))
(defvar run-meadow3 (and run-meadow run-emacs22))
(defvar run-xemacs (featurep 'xemacs))
(defvar run-xemacs-no-mule
  (and run-xemacs (not (featurep 'mule))))

;; 判別した環境用に設定を読みこむ
(cond
 (run-w32
  (load-safe "subst-win.el")
  ))
 
(cond
 (run-emacs23
  (global-font-lock-mode t)
  )
 (run-meadow ;; Meadow 用設定
  (load-safe "cus_meadow.el")
  )
 (run-emacs22 ;; Emacs22用設定
  (global-font-lock-mode t)
;  (load-safe 'color-theme)

  (require 'color-theme)
;  (color-theme-initialize)
  (color-theme-wheat)

; UNICODE-RANGE
  (utf-translate-cjk-set-unicode-range
   '((#x00a2 . #x00a3) ; ¢, £
     (#x00a7 . #x00a8) ; §, ¨
     (#x00ac . #x00ac) ; ¬
     (#x00b0 . #x00b1) ; °, ±
     (#x00b4 . #x00b4) ; ´
     (#x00b6 . #x00b6) ; ¶
     (#x00d7 . #x00d7) ; ×
     (#X00f7 . #x00f7) ; ÷
     (#x0370 . #x03ff) ; Greek and Coptic
     (#x0400 . #x04FF) ; Cyrillic
     (#x2000 . #x206F) ; General Punctuation
     (#x2100 . #x214F) ; Letterlike Symbols
     (#x2190 . #x21FF) ; Arrows
     (#x2200 . #x22FF) ; Mathematical Operators
     (#x2300 . #x23FF) ; Miscellaneous Technical
     (#x2500 . #x257F) ; Box Drawing
     (#x25A0 . #x25FF) ; Geometric Shapes
     (#x2600 . #x26FF) ; Miscellaneous Symbols
     (#x2e80 . #xd7a3) (#xff00 . #xffef)))

  )
 (run-emacs21 ;; Emacs21用設定

  ;;; Mule-UCS の設定 (emacs21 以前)
  ;; (set-language-environment) の前に設定します
  (require 'un-define)
  (setq bitmap-alterable-charset 'tibetan-1-column)
  (require 'jisx0213)
  )
 (run-xemacs
  ;; settings for XEmacs
  (setq test nil)
  )
 )
