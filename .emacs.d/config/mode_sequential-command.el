;(auto-install-from-emacswiki "sequential-command.el")
(require 'sequential-command)

(define-sequential-command seq-home
  back-to-indentation  beginning-of-line beginning-of-buffer seq-return)
(global-set-key "\C-a" 'seq-home)

(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)
(global-set-key "\C-e" 'seq-end)

(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))

