;;; settings for elisp packages
(server-start)

;;
(load-safe "mode_auto-install.el")
(load-safe "mode_auto-async-byte-compile.el")

;; settings for various completions
(load-safe "mode_anything.el")
(load-safe "mode_auto-complete.el")
;mode_dabbrev-expand-multiple.el
;mode_dabbrev-highlight.el
;mode_pabbrev.el
;mode_hippie-expand.el
;mode_yasnippet.el

;;
(load-safe "mode_flymake.el")
;(load "mode_parenthesis.el")

;;
(load-safe "mode_one-key.el")
(load-safe "mode_browse-kill-ring.el")
(load-safe "mode_elscreen.el")
;(load-safe "mode_dired.el")
;(load-safe "mode_muse.el")
;mode_html-helper.el
;mode_parenthesis.el

;;
(load-safe "mode_skk.el")
(load-safe "mode_lookup.el")
(load-safe "mode_w3m.el")
(load-safe "mode_org.el")
(load-safe "mode_woman.el")
(load-safe "mode_text-translator.el")
(load-safe "mode_todochiku.el")
(load-safe "mode_twittering.el")
;mode_simple-hatena.el
;mode_howm.el
;mode_wanderlust.el
;mode_dvc.el

;; settings for file types
(load-safe "mode_cperl.el")
(load-safe "mode_perl-completion")
(load-safe "mode_perltidy.el")
(load-safe "mode_pod.el")
(load-safe "mode_ack.el")

(load-safe "mode_yatex.el")
(load-safe "mode_po.el")
(load-safe "mode_puppet.el")
;(load-safe "mode_haskell.el")
;mode_rpm.el
;mode_ruby.el
(load-safe "mode_slime.el")

;(load "mode-EVAL.el")


;(load-safe "mode_sticky.el")
;(load-safe "mode_recentf-ext.el")
;(load-safe "mode_sense-region.el")






;;;;;;;;;;
;;; migemo
;;; (C/Migemo は cus_meadow.el に記述)
;; aptitude install migemo
(require 'migemo)
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)

;;;;;;;;;;;;;;
;;; 履歴マニア
(autoload 'kill-summary "kill-summary" nil t)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

(recentf-mode)
