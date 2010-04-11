;;;;;;;;;;
;; flymake
(require 'flymake)
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s" "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))

;; エラー、警告時のフェイス
(set-face-background 'flymake-errline "red4")
(set-face-foreground 'flymake-errline "black")
(set-face-background 'flymake-warnline "yellow")
(set-face-foreground 'flymake-warnline "black")

;; エラーをミニバッファに表示
(defun flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

(global-set-key "\M-gn" '(lambda ()
                           (interactive)
                           (let (line (line-number-at-pos))
                             (flymake-goto-next-error)
                             (when (equal line (line-number-at-pos))
                               (next-error)))))
(global-set-key "\M-gp" '(lambda ()
                           (interactive)
                           (let (line (line-number-at-pos))
                             (flymake-goto-prev-error)
                             (when (equal line (line-number-at-pos))
                               (previous-error)))))
(global-set-key "\C-cd" 'flymake-display-err-minibuf)

;;;;;;;;;;;;;;;;;;;;
;; flymake for shell
(defcustom flymake-shell-of-choice
  "/bin/bash"
  "Path of shell.")

(defcustom flymake-shell-arguments
  (list "-n")
  "Shell arguments to invoke syntax checking.")

(defconst flymake-allowed-shell-file-name-masks
  '(("\\.sh$" flymake-shell-init))
  "Filename extensions that switch on flymake-shell mode syntax checks.")

(defcustom flymake-shell-err-line-patterns-re
  '(("^\\(.+\\): line \\([0-9]+\\): \\(.+\\)$" 1 2 nil 3))
  "Regexp matching JavaScript error messages.")

(defun flymake-shell-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list flymake-shell-of-choice (append flymake-shell-arguments (list local-file)))))

(defun flymake-shell-load ()
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-shell-file-name-masks))
  (setq flymake-err-line-patterns (append flymake-err-line-patterns flymake-shell-err-line-patterns-re))
  (flymake-mode t))

(add-hook 'sh-mode-hook 'flymake-shell-load)

;;;;;;;;;;;;;;;;;;;
;; flymake for ruby
(defun flymake-ruby-init ()
  (let* ((temp-file	(flymake-init-create-temp-buffer-copy
			  'flymake-create-temp-inplace))
	 (local-file	(file-relative-name
			  temp-file
			  (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
  '(lambda ()
     ;; Don't want flymake mode for ruby regions in rhtml files
     (if (not (null buffer-file-name)) (flymake-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake for Javascript
(defconst flymake-allowed-js-file-name-masks '(("\\.json$" flymake-js-init)
                                               ("\\.js$" flymake-js-init)))
(defcustom flymake-js-detect-trailing-comma t nil :type 'boolean)
(defvar flymake-js-err-line-patterns '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(SyntaxError\:.+\\)\:$" 1 2 nil 3)))
(when flymake-js-detect-trailing-comma
  (setq flymake-js-err-line-patterns (append flymake-js-err-line-patterns
                                             '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(strict warning: trailing comma.+\\)\:$" 1 2 nil 3)))))

(defun flymake-js-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
			  'flymake-create-temp-inplace))
         (local-file	(file-relative-name
			  temp-file
			  (file-name-directory buffer-file-name))))
    (list "js" (list "-s" local-file))))
(defun flymake-js-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-js-file-name-masks))
  (setq flymake-err-line-patterns flymake-js-err-line-patterns)
  (flymake-mode t))

(add-hook 'javascript-mode-hook '(lambda () (flymake-js-load)))

;;;;;;;;;;;;;;;;;;;
;; flymake for Java
(setcdr (assoc "\\.java\\'" flymake-allowed-file-name-masks)
	'(flymake-simple-ant-java-init flymake-simple-java-cleanup))

(defun flymake-get-ant-cmdline (source base-dir)
  (list "ant"
	(list "-buildfile"
	      (concat base-dir "/" "build.xml"))))

(add-hook 'java-mode-hook
	  '(lambda ()
	     (flymake-mode)))

;;;;;;;;;;;;;;;;;;;;;;
;; flymake for Haskell

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "ghc"
        (list "--make" "-fbyte-code"
              (concat "-i"base-dir)
              source)))
(defvar multiline-flymake-mode nil)
(defvar flymake-split-output-multiline nil)

(defadvice flymake-split-output
  (around flymake-split-output-multiline activate protect)
  (if multiline-flymake-mode
      (let ((flymake-split-output-multiline t))
        ad-do-it)
    ad-do-it))

(defadvice flymake-split-string
  (before flymake-split-string-multiline activate)
  (when flymake-split-output-multiline
    (ad-set-arg 1 "^\\s *$")))


(push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)

(push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)

(push
 '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

;; optional setting
;; if you want to use flymake always, then add the following hook.
(add-hook
 'haskell-mode-hook
 '(lambda ()
    (add-to-list 'flymake-allowed-file-name-masks
                 '("\\.l?hs$" flymake-Haskell-init flymake-simple-java-cleanup))
    (add-to-list 'flymake-err-line-patterns
                 '("^\\(.+\\.l?hs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\\(?:.\\|\\W\\)+\\)"
                   1 2 3 4))
    (set (make-local-variable 'multiline-flymake-mode) t)))

;;;;;;;;;;;;;;;;;;;
;; flymake for perl

;; set-perl5lib: 開いたスクリプトのパスに応じて、@INCにlibを追加
; http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el
(require 'set-perl5lib)

;; Perl用設定
;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 'flymake-perl-load)
