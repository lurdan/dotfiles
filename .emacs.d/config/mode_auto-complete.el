;;; auto-complete.el

(require 'auto-complete)

; (when (require 'auto-complete nil t)
;   (require 'auto-complete-yasnippet)
;   (require 'auto-complete-ruby)
;   (require 'auto-complete-css)
   
   (global-auto-complete-mode t)
;   (set-face-background 'ac-selection-face "steelblue")
;   (set-face-background 'ac-menu-face "skyblue")
;   (set-face-underline 'ac-menu-face "darkgray")
;   (define-key ac-complete-mode-map "\t" 'ac-expand)
;   (define-key ac-complete-mode-map "\r" 'ac-complete)
;   (define-key ac-complete-mode-map "\M-n" 'ac-next)
;   (define-key ac-complete-mode-map "\M-p" 'ac-previous)
;   (setq ac-auto-start 3
;         ac-dwim t ; Do What I Mean
;         ac-override-local-map nil
;         ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer)
;         ac-modes (append ac-modes '(eshell-mode
;                                     org-mode
;                                     howm-mode)))
;   (add-to-list 'ac-modes 'eshell-mode)

;   (set-default 'ac-sources '(ac-sources-yasnippet ac-sources-abbrev ac-sources-words-in-buffer))
 
;   (add-hook 'emacs-lisp-mode-hook
;             (lambda ()
;               (make-local-variable 'ac-sources)
;               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))
 
;   (add-hook 'eshell-mode-hook
;             (lambda ()
;               (make-local-variable 'ac-sources)
;               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer)))))

;   (add-hook 'haskell-mode-hook
;          #'(lambda () (auto-complete-mode 1)
;              (make-local-variable 'ac-sources)
;              (setq ac-sources '(ac-source-yasnippet
;                                 ac-source-abbrev
;                                 ac-source-words-in-buffer
;                                 my/ac-source-haskell)
;                    comment-padding " "
;                    comment-start "--")))

;   (add-hook 'haskell-mode-hook '(lambda ()
;                                   (add-to-list 'ac-sources 'ac-source-haskell)))

;   (add-hook 'ruby-mode-hook
;             (lambda ()
;               (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))))


