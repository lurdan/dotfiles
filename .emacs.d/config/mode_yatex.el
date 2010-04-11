;;; YaTeX
; aptitude install yatex

(autoload-if-found 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;; YaTeX-mode
;;(YaTeX-help-file "/usr/local/lib/xemacs/site-lisp/YATEXHLP.jp")
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(setq dvi2-command "xdvi"
      tex-command "platex"
      dviprint-command-format "dvips %s | lpr"
      YaTeX-kanji-code 2)

;; YaHtml-mode
(setq auto-mode-alist
      (cons (cons "\\.html?$" 'yahtml-mode) auto-mode-alist))
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
(setq yahtml-www-browser "w3m"
      yahtml-kanji-code 2)
(if (boundp 'auto-insert-alist)
    (setq auto-insert-alist
	  (cons '((yahtml-mode . "YaHTML mode") . "page.template")
		auto-insert-alist)))

(add-hook 'yahtml-mode-hook
    '(lambda ()
      (setq indent-line-function 'yahtml-indent-line)
      (define-key yahtml-mode-map "\C-m" 'reindent-then-newline-and-indent)
      (make-local-variable 'outline-minor-mode-prefix)
      (setq outline-minor-mode-prefix "\C-c")
      (make-local-variable 'outline-regexp)
      (setq outline-regexp "<[hH][1-6]*>")
      (require 'sb-html)
      (auto-fill-mode -1)
      (outline-minor-mode t)))
