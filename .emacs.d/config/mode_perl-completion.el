;;; perl-completion
;http://svn.coderepos.org/share/lang/elisp/perl-completion/trunk/perl-completion.el
(add-hook 'cperl-mode-hook
          (lambda ()
;            (setq plcmp-use-keymap nil)
            (require 'perl-completion)
            (perl-completion-mode t)
;            (define-key plcmp-mode-map (kbd "C-M-i") 'plcmp-cmd-smart-complete)
            (add-to-list 'ac-sources 'ac-sources-perl-completion)))
