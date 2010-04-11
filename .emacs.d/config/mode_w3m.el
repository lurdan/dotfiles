;;;;;;;;;;;
;; w3m-mode
(require 'w3m)
;(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;(autoload 'w3m-find-file "w3m" "*w3m interface function for local file." t)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;(autoload 'w3m-search "w3m-search" "*Search QUERY using SEARCH-ENGINE." t)
;(autoload 'w3m-weather "w3m-weather" "*Display weather report." t)
;(autoload 'w3m-antenna "w3m-antenna" "*Report chenge of WEB sites." t)

; 外部ブラウザとして firefox の新規タブを開く 
(setq w3m-content-type-alist
      (cons
       '("text/html" "\\.s?html?$"
         (lambda (url) (browse-url-firefox browse-url-new-window-flag)))
       w3m-content-type-alist))

;;; browse-url のデフォルトは w3m で、とにかく新規タブを使う
(setq browse-url-browser-function #'w3m-browse-url
      browse-url-new-window-flag t
      browse-url-firefox-new-window-is-tab t)

;(global-set-key "\C-xm" 'browse-url-at-point)

;;; w3m for dired
;(add-hook 'dired-mode-hook
;          (lambda ()
;              (define-key dired-mode-map "\C-xm" 'dired-w3m-find-file)))
;(defun dired-w3m-find-file ()

