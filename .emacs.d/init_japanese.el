;;; Japanese Environment

(set-language-environment "Japanese")

;; UTF-8
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;(set-buffer-file-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(set-default-coding-system 'utf-8)
;(prefer-coding-system 'utf-8-unix)

;; calendar + japanese holidays
(require 'calendar)
(defun-add-hook 'calendar-load-hook
  (progn
    (require 'japanese-holidays)
    (setq number-of-diary-entries 31
          mark-holidays-in-calendar t
          calendar-holidays (append japanese-holidays local-holidays other-holidays)
          calendar-weekend-marker 'diary)))

(defun-add-hook 'today-visible-calendar-hook
  (progn
    (calendar-mark-weekend)
    (calendar-mark-today)))

(defun-add-hook 'today-invisible-calendar-hook
  (calendar-mark-weekend))

; local keybind
(define-key calendar-mode-map "f" 'calendar-forward-day)
(define-key calendar-mode-map "n" 'calendar-forward-day)
(define-key calendar-mode-map "b" 'calendar-backward-day)
