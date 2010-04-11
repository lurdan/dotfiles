;;; puppet-mode
; aptitude install puppet-el
; http://projects.puppetlabs.com/projects/puppet/repository/revisions/master/raw/ext/emacs/puppet-mode.el

(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(defun ai-elisp-puppet-mode ()
  (interactive)
  (auto-install-from-url "http://projects.puppetlabs.com/projects/puppet/repository/revisions/master/raw/ext/emacs/puppet-mode.el")

