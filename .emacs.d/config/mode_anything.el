;;; anything.el
(require 'anything-config)

;(setq anything-sources (list ;;anything-source-buffers
;                             anything-source-bookmarks
;                             ;;anything-source-recentf
;                             anything-source-file-name-history
;                             anything-source-locate-r
;                             anything-source-complex-command-history))
;(setq anything-type-actions (list anything-actions-buffer
;                                  anything-actions-file
;                                  anything-actions-sexp))

;(define-key anything-map (kbd "C-M-n") 'anything-next-source)
;(define-key anything-map (kbd "C-M-p") 'anything-previous-source)
;(define-key anything-map "\C-p" 'anything-previous-line)
;(define-key anything-map "\C-n" 'anything-next-line)
;(define-key anything-map "\C-v" 'anything-next-page)
;(define-key anything-map "\M-v" 'anything-previous-page)

;(anything-iswitchb-setup)

;(defadvice anything-check-minibuffer-input (around sit-for activate)
;  (if (sit-for anything-idle-delay t)
;      ad-do-it))

;(defvar anything-c-source-occur
;  '((name . "Occur")
;    (init . (lambda ()
;              (setq anything-c-source-occur-current-buffer
;                    (current-buffer))))
;    (candidates . (lambda ()
;                    (setq anything-occur-buf (get-buffer-create "*Anything Occur*"))
;                    (with-current-buffer anything-occur-buf
;                      (erase-buffer)
;                      (let ((count (occur-engine anything-pattern
;                                                 (list anything-c-source-occur-current-buffer) anything-occur-buf
;                                                 list-matching-lines-default-context-lines nil
;                                                 list-matching-lines-buffer-name-face
;                                                 nil list-matching-lines-face
;                                                 (not (eq occur-excluded-properties t)))))
;                        (when (> count 0)
;                          (let ((lines (split-string (buffer-string) "\n" t)))
;                            (cdr lines)))))))
;    (action . (("Goto line" . (lambda (candidate)
;                                (goto-line (string-to-number candidate) anything-c-source-occur-current-buffer)))))
;    (requires-pattern . 3)
;    (volatile)))

;(defun anything-c-source-semantic-construct-candidates (tags depth)
;  (apply 'append (mapcar '(lambda (tag)
;                            (when (and (listp tag)
;                                       (or (equal (semantic-tag-type tag) "class")
;                                           (eq (semantic-tag-class tag) 'function)))
;                              (cons (cons (concat (make-string (* depth 2) ?\s)
;                                                  (semantic-format-tag-summarize tag nil t)) tag)
;                                    (anything-c-source-semantic-construct-candidates (semantic-tag-components tag) (1+ depth)))))
;                         tags)))

;(defvar anything-c-source-semantic
;  '((name . "Semantic Tags")
;    (init . (lambda ()
;              (setq anything-c-source-semantic-candidates
;                    (anything-c-source-semantic-construct-candidates (semantic-fetch-tags) 0))))
;    (candidates . (lambda ()
;                    (mapcar 'car anything-c-source-semantic-candidates)))
;    (action . (("Goto tag" . (lambda (candidate)
;                               (let ((tag (cdr (assoc candidate anything-c-source-semantic-candidates))))
;                                 (semantic-go-to-tag tag))))))))


;; anything-complete
;(require 'anything-complete)
;(anything-lisp-complete-symbol-set-timer 150)

;; anything-kyr
;(require 'anything-kyr-config)
;(when (require 'anything-complete nil t)
;  (anything-read-string-mode 1))

;; ac-anything
;(require 'ac-anything)
;(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)

