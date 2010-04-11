;;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(autoload 'cperl-mode
  "cperl-mode" "alternate mode for editing Perl programs" t)

(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|f?cgi\\|t\\|al\\)$" . cperl-mode))

;;; Perl debugger
(autoload 'perl-debug "perl-debug" nil t)
(autoload 'perl-debug-lint "perl-debug" nil t)

(setq cperl-indent-level 2
;      cperl-auto-newline t
      cperl-indent-parens-as-block t
      cperl-close-paren-offset -4
      cperl-label-offset -4
      cperl-continued-statement-offset 4
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-hairy t
      cperl-font-lock t)

;; perldoc -m を開く
;; モジュールソースバッファの場合はその場で、
;; その他のバッファの場合は別ウィンドウに開く。
(put 'perl-module-thing 'end-op
     (lambda ()
       (re-search-forward "\\=[a-zA-Z][a-zA-Z0-9_:]*" nil t)))
(put 'perl-module-thing 'beginning-op
     (lambda ()
       (if (re-search-backward "[^a-zA-Z0-9_:]" nil t)
           (forward-char)
         (goto-char (point-min)))))

(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1)
            )
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))

(defun perl-eval (beg end)
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "perl")))

;(define-key cperl-mode-map "\C-cp" 'perl-eval)
