;(auto-install-from-url "http://github.com/kiwanami/emacs-cacoo/raw/master/cacoo.el")

(require 'cacoo)
(global-set-key (kbd "M--") 'toggle-cacoo-minor-mode) ; Alt+「-」で切り替え
(setq cacoo:img-dir-ok t) ; 画像フォルダは確認無しで作る
(setq cacoo:max-size 450) ; 画像の長辺は450px
(setq cacoo:external-viewer "eog") ; eogというアプリを標準画像ビューアーにする
(setq cacoo:img-regexp 
     '("\\[img:\\(.*\\)\\][^]\n\r]*$" ; imgのデフォルト記法
       "\\[f:\\(.*\\)\\][^]\n\t]*$"   ; はてなフォトライフ記法
       "<img src=[\"']\\(.*\\)[\"'][ ]*\\/>[^\n\t]*$" ; HTMLのimgタグ
       ))
(setq cacoo:img-pattern "<img src=\"%s\" />") ; 貼り付けはimgタグで
