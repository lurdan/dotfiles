;;; autolookup.el --- On-the-fly lookup/sdic
;; Copyright (C) 2000 Lookup Development Team <lookup@ring.gr.jp>

;; Author: Masatake YAMATO <jet@gyve.org>

;; This file will be part of Lookup.

;; Lookup is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; Lookup is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Lookup; if not, write to the Free Software Foundation,
;; Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;; $B@bL@(B:
;;
;; * autolookup.el$B$H$O(B
;; $B$3$N%W%m%0%i%`$O!$FCJL$JA`:n$rI,MW$H$9$k$3$H$J$/(B(Emacs$B$N(B)$B%]%$%s%H2<$K$"$kC18l$NLu$r(B
;; $B%(%3!<%(%j%"$KI=<($9$k%W%m%0%i%`$G$9!%%f!<%6$,(B1$BIC4V2?$b%(%G%#%?A`:n$r$7$J$1$lC18l$NLu$,(B
;; $BI=<($5$l$^$9!%%(%3!<%(%j%"$KLu$rI=<($9$k$N$G!$Lu$NI=<($K$h$C$F%&%#%s%I%&$N%l%$%"%&%H$J$I$r(B
;; $BJQ99$7$F$7$^$&62$l$O$"$j$^$;$s!%(B
;; 
;; * $BMxMQ$KI,MW$J$b$N(B
;; $BC18l$NLu$N<hF@$9$k$?$a$K!$(Blookup(http://openlab.ring.gr.jp/lookup)$B$+(B
;; sdic(http://www-nagao.kuee.kyoto-u.ac.jp/member/tsuchiya/sdic/)$B$,(B
;; $BI,MW$G$9!%(B
;; 
;; $B3+H/$K$O!$(B
;; emacs$B$K$O!%(BXEmacs21.1$B$r(B
;; lookup$B$O(B1.3$B$r!$(Bsdic$B$O(B2.1.2$B$r(B
;; $B<-=q$O!$(Bgene95$B$N$_$rMQ$$$^$7$?!%$=$l0J30$N<-=q$rMQ$$$?>l9g$d!$(Bgene95$B$HJ;MQ$7$?>l9g!$(B
;; $B$K$D$$$FD4$Y$F$$$^$;$s!%(B
;;
;; * $B;H$$J}(B
;; $B$^$:%m!<%I%Q%9$NDL$C$?%G%#%l%/%H%j$K$3$N%U%!%$%k$r(B"autolookup.el"$B$NL>A0$GJ]B8$7$^$9!%(B
;; lookup$B$r;H$&>l9g$K$O!$(B
;;
;; (setq auto-lookup-backend 'lookup)
;;
;; sdic$B$r;H$&>l9g$K$O!$(B
;;
;; (setq auto-lookup-backend 'sdic)
;;
;; $B$r(B.emacs$B$KDI2C$7$^$9!%$5$i$K(B.emacs$B$K<!$N(B4$B9T$rDI2C$7$F!$I>2A$7$^$9!%(B
;;
;; (autoload 'auto-lookup-mode "autolookup" 
;;           "$B%]%$%s%H2<$NC18l$NLu$r<+F0E*$KI=<($9$k%^%$%J!<%b!<%I(B" t)
;; (autoload 'global-auto-lookup-mode "autolookup" 
;;           "$B%]%$%s%H2<$NC18l$NLu$r<+F0E*$KI=<($9$k%^%$%J!<%b!<%I$r$9$Y$F$N%P%C%U%!$G5/F0$9$k!%(B" t)
;;
;; $B<!$N$I$A$i$+$N%3%^%s%I$r<B9T$7$F5/F0$7$^$9!%(B
;; M-x auto-lookup-mode
;; $B$K$h$C$FC18l$NLu$r<+F0E*$KI=<($9$k%^%$%J!<%b!<%I$r(Bon/off$B$9$k$3$H$,$G$-$^$9!%(B
;; $B%^%$%J!<%b!<%I$J$N$G%3%^%s%I$r<B9T$7$?%P%C%U%!$G$N$_C18l$NLu$r<+F0E*$KI=<($7$^$9!%(B
;;
;; M-x global-auto-lookup-mode
;; $B$9$Y$F$N%P%C%U%!$GF1;~$K(Bauto-lookup-mode$B$r(Bon/off$B$9$k$3$H$,$G$-$^$9!%(B
;;
;; * $B%+%9%?%^%$%:(B
;; sdic$B$r;H$&$+(B,lookup$B$r;H$&$+$O!$(B`auto-lookup-backend'$B$H$$$&(B
;; $BJQ?t$G@)8f$7$^$9!%(B
;; $BC18l$NLu$rI=<($9$k$^$G$N(B
;; $B;~4V$O(B`auto-lookup-interval'$B$H$$$&JQ?t$K$h$jD4@0$9$k$3$H$,$G$-$^$9!%(B
;; sdic$B$r%P%C%/%(%s%I$K;H$&>l9g!$MxMQ2DG=$J(B($BJ#?t$N(B)$BA4$F$N<-=q$rMQ$$$k$H8!:w(B
;; $B$K;~4V$,$+$+$k>l9g$,$"$j$^$9!%(BAuto lookup$B$G;HMQ$7$?$$<-=q$r(B
;; `auto-lookup-backend:sdic-eiwa-dictionary-list'
;; $B$d(B`auto-lookup-backend:sdic-waei-dictionary-list'
;; $B$K;XDj$7$F!$8!:w;~4V$rC;=L$G$-$^$9!%(B
;;
;; $BJQ99MzNr(B:
;;
;; Release 9
;; * Hideyuki SHIRAI ($BGr0f=(9T(B)$B$5$s(B<shirai at rdmg.mgcs.mei.co.jp>$B$N(B
;;   patch$B$r$"$F$?!%(B
;;   - $B8!:wC18lCf$+$i=u;l$r@Z<N$F$k(B.
;;   - $BF|K\8l$NC18l$O#2J8;z0J>e$r8!:w$9$k(B.
;;   - $B8!:wC18l$r(Bdownward$B$9$k(B.
;;
;; Release 8
;; * $BJQ?tL>$rJQ99$7$?!%(B
;;   auto-lookup-mode-backend->auto-lookup-backend.
;; * $B0lJ8;z$NC18l$O8!:w$7$J$$(B(sdic)$B!%(B
;; * sdic backend$B$G(Bsyntax table$B$rJQ99$9$k$N$r$d$a$?!%(B
;; * $B%7%s%\%kL>Cf$N(Bbackend-lookup$B!$(Bbackend-sdic
;;   $B$=$l$>$l(Bbackend:lookup, backend:sdic$B$KJQ99$7$?!%(B
;; * sdic$B$GJ#?t9TJ,$N7k2L$rI=<($9$k$h$&$K$7$?!%(B
;; * okada at opaopa.org ($B2,ED(B $B7r0l(B /Kenichi OKADA)$B$5$s$NOB1Q<-=q$r0z$/(B
;;   $B$?$a$N%Q%C%A$rEv$F$?!%(B
;; * Hideyuki SHIRAI ($BGr0f=(9T(B)$B$5$s(B<shirai at rdmg.mgcs.mei.co.jp>$B$N(B
;;   sdic backend$B$KBP$9$k%Q%C%A$r$"$F$?!%(B
;;   - auto-lookup-backend:sdic-word-input$B$G<h$j=P$7$?C18l$KF|K\8lJ8;z$,(B
;;     $B$^$8$C$F$$$J$$$+%A%'%C%/$9$k!%(B
;;   - $B8!:w@h$N1QOB<-=q(B/$B1QOB<-=q$r8BDj$9$k5!G=$rDI2C$7$?!%(B
;; * Added etags backend (experimental).
;;
;; Release 7
;; * sdic$B$H(Blookup$B$NN>J}$r;H$($k$h$&$K$7$?!%(B
;; * GNU Emacs$B$G$bF0:n$r3NG'$7$?!%(B
;;
;; Release 6
;; * Author$B$N%U%#!<%k%I$rJQ99$7$?!%(B
;;
;; Release 5
;; * global-auto-lookup-mode$B$KF~$C$F$$$l$P!$?7$7$$%U%!%$%k$r3+$$$?$H$-$K!$(B
;;   $B<+F0E*$K(Bglobal-auto-lookup-mode$B$KF~$k$h$&$K$7$?!%(B
;;
;; Release 4
;; * global mode$B$KF~$k$H$9$Y$F$N%P%C%U%!$K(BAutoLookup$B$HI=<($9$k$h$&$K$7$?!%(B
;; * lookup$B$N7k2L$r<hF@$9$k4X?t$HI=<($9$k4X?t$rJ,N%$7$?!%(B
;; * customize$B$G$-$k$h$&$K$7$?!%(B
;; * $B%I%-%e%a%s%H$r=q$$$?!%(B
;;
;; Release 3
;; * Added some documents.
;; * Avoid lookup if the cursor is in minibuffer.
;; * Avoid lookup if isearch is active.
;;
;; Release 2
;; * Added global-auto-lookup-mode

;; $B<U<-(B:
;; autolookup.el$B$O2<5-$K7G:\$5$l$?!$(BKeisuke Nishida<kxn30@po.cwru.edu> $B$5$s(B
;; $B$N%3!<%I$+$iGI@8$7$?$b$N$G$9!%(B
;; http://news.ring.gr.jp/news/openlab.lookup-ja/1012

;; TODO:
;; * 1$B9TI=<(0J30$b%5%]!<%H$9$k!%(B
;; * $BB>$N<-=q$G$b%F%9%H$9$k(B.
;; * $BJ#?t$N%(%s%H%j$N7k2L$r$+$-$"$D$a$k!%(B
;; * fset$B$NE1GQ$9$k!%(B
;; * defcustom

;;; Code:
(require 'timer)

;;
;; Customizable variables
;; 
(defgroup auto-lookup nil
  "Lookup$B<+F08F$S=P$7(B"
  :group 'lookup)

(defcustom auto-lookup-interval 1 
  "*$B<+F0E*$K(Blookup$B$r8F$S=P$9;~4V4V3V(B($BIC(B)"
  :type  'number
  :group 'auto-lookup)

(defcustom auto-lookup-mode-string " AutoLookup"
  "Auto lookup$B%b!<%I$N%b!<%IJ8;zNs(B"
  :type 'string
  :group 'auto-lookup)

(defcustom auto-lookup-backend 'lookup
  "Auto lookup$B%b!<%I$G;H$&8!:w%$%s%?!<%U%'!<%9$N<oN`(B. lookup$B$+(Bsdic"
  :type '(choice (const lookup)
                 (const sdic)
                 (const etags))
  :group 'auto-lookup)

;;
;; Backend own custumize
;;
(defvar auto-lookup-backend:sdic-eiwa-dictionary-list 
  nil
  "Auto lookup$B$N%P%C%/%(%s%I$H$7$F(Bsdic$B$r;H$&>l9g!$$I$N1QOB<-=q$r;H$&$+;XDj$9$k!%(B
$B;XDj$NJ}K!$O!$(B`sdic-eiwa-dictionary-list'$B$HF1$87A<0$G$"$k!%(Bnil$B$N>l9g(B
`sdic-eiwa-dictionary-list'$B$NCM$r$=$N$^$^;H$&!%(B
$BNc(B:
(setq auto-lookup-backend:sdic-eiwa-dictionary-list
      '((sdicf-client \"/usr/local/dict/gene.sdic\")))")

(defvar auto-lookup-backend:sdic-waei-dictionary-list 
  nil
  "Auto lookup$B$N%P%C%/%(%s%I$H$7$F(Bsdic$B$r;H$&>l9g!$$I$NOB1Q<-=q$r;H$&$+;XDj$9$k!%(B
$B;XDj$NJ}K!$O!$(B`sdic-waei-dictionary-list'$B$HF1$87A<0$G$"$k!%(Bnil$B$N>l9g(B
`sdic-waei-dictionary-list'$B$NCM$r$=$N$^$^;H$&!%(B
$BNc(B:
(setq auto-lookup-backend:sdic-waei-dictionary-list
      '((sdicf-client \"/usr/local/dict/edict.sdic\" 
        (add-keys-to-headword t))))")

;;
;; Core
;;
(defvar auto-lookup-history nil 
"$B:G8e$K(Bautolookup$B7PM3$G8!:w$5$l$?C18l(B
$BF1$8C18l$r7+$jJV$78!:w$9$k$3$H$rHr$1$k!%(B")
(defvar auto-lookup-function (lambda () (auto-lookup)))

(defun auto-lookup ()
  "$B%?%$%^!<$+$i8F$S=P$5$l$F(Blookup$B$r<B9T$9$k4X?t(B"
  (let (word)
  (if (and 
       ;; $B0J2<$N>r7o$r8+$?$5$J$$8B$j8!:w$r9T$J$o$J$$!%(B
       ;; $B%5!<%ACf$G$J$$$3$H(B
       (not isearch-mode)
       ;; $B%^%/%m<B9TCf$G$J$$$3$H(B
       (not executing-kbd-macro)
       ;; autolookup$B%b!<%I$KF~$C$F$$$k$3$H(B
       auto-lookup-mode
       ;; $B8=:_$N%P%C%U%!$,(Bmini buffer$B$G$J$$$3$H(B
       ;; Stolen from skk-in-minibuffer-p in skk-foreword of skk-10.59.
       (not (window-minibuffer-p (selected-window)))
       ;; $B8=:_$N%P%C%U%!$,(Blookup$B$N4FFD$9$k%P%C%U%!$J$$$3$H(B
       (auto-lookup-do-backend 'check-buffer (current-buffer))
       ;; $B:#$+$i8!:w$7$h$&$H$9$kC18l$,$"$k$3$H(B
       (progn 
         (setq word (auto-lookup-do-backend 'input))
         (and
          word
          (stringp word)
          (< 0 (length word))           ; $BC18l$ND9$5$rD4$Y$k!%(B
          (or (not auto-lookup-history)
              (not (string= word auto-lookup-history)))
          (progn (setq auto-lookup-history word) t))))
      ;; $B8!:w(B
      (let ((result
             (if (auto-lookup-describe-word word)
                 (auto-lookup-do-backend 'get-result))))
        ;; $B7k2LI=<((B
        (if result
            (auto-lookup-show-result (car result) (cdr result))
        )))))

(defun auto-lookup-describe-word (word)
  "lookup$B$"$k$$$O!$(Bsdic$B$rMQ$$$F(BWORD$B$r8!:w$9$k!%(B"
  ;; message$B$NDj5A$r0l;~E*$KCV$-49$($F8!:wCf$N=PNO$rM^@)$9$k!%(B
  (let ((message-backup (symbol-function 'message)))
    (unwind-protect
        (progn
          (defun message (fmt &rest args))
          (auto-lookup-do-backend 'describe word))
      (fset 'message message-backup))))


(defun auto-lookup-do-backend (task &optional arg)
  "lookup$B$"$k$$$O(Bsdic$B$N4X?t$r8F$S=P$9(B
TASK
  describe: $B8!:w(B. $B8!:w$K@.8y$7$?>l9g(Bnil$B0J30$NCM$rJV$9!%(B
  get-result: $B8!:w7k2L$N<hF@(B. ($BC18l(B . $B0UL#(B)$B$N%Z%"$rJV$9!%(B
  input: $B%]%$%s%H0LCV$+$iC18l$N<hF@(B, 
         $BC18l$rJ8;zNs$GJV$9!%8!:wBP>]$,8+$D$+$i$J$$>l9g(Bnil$B$rJV$7$F$bNI$$!%(B
  check-buffer: $B%P%C%/%(%s%I$G4IM}$7$F$$$k%P%C%U%!$KBP$7$F(Bnil$B$rJV$9!%(B"
  (cond 
   ((eq auto-lookup-backend 'lookup)
    (require 'lookup)
    (cond 
     ((eq task 'describe)
      (auto-lookup-backend:lookup-describe-word arg))
     ((eq task 'get-result)
      (auto-lookup-backend:lookup-get-result))
     ((eq task 'input)
      (auto-lookup-backend:lookup-word-input))
     ((eq task 'check-buffer)
      (auto-lookup-backend:lookup-check-buffer arg))))
   ((eq auto-lookup-backend 'sdic)
    (require 'sdic)
    (cond
     ((eq task 'describe)
      (auto-lookup-backend:sdic-describe-word arg))
     ((eq task 'get-result)
      (auto-lookup-backend:sdic-get-result))
     ((eq task 'input)
      (auto-lookup-backend:sdic-word-input))
     ((eq task 'check-buffer)
      (auto-lookup-backend:sdic-check-buffer arg))
     ))
   ((eq auto-lookup-backend 'etags)
    (require 'etags)
    (cond
     ((eq task 'describe)
      (auto-lookup-backend:etags-describe-word arg))
     ((eq task 'get-result)
      (auto-lookup-backend:etags-get-result))
     ((eq task 'input)
      (auto-lookup-backend:etags-word-input))
     ((eq task 'check-buffer)
      (auto-lookup-backend:etags-check-buffer arg))
     )) 
   (t
    nil)))

(defun auto-lookup-show-result (word line)
  "lookup$B$N7k2L$r%(%3!<%(%j%"$KI=<($9$k!%(B"
  (message "[%s] %s: %s" auto-lookup-backend word line))

;;
;; Sdic backend
;;
(defvar auto-lookup-backend:sdic-buffer-name " *Autolookup-sdic")
(defvar auto-lookup-backend:sdic-eiwa-symbol-list nil)
(defvar auto-lookup-backend:sdic-waei-symbol-list nil)

(defun auto-lookup-backend:sdic-word-input ()
  "sdic$B$G8!:w$9$kC18l$r<h$j=P$9!%(B"
  ;; $BC;$+$$C18l$r8!:w$7$h$&$H$9$k$H!$8!:w$K;~4V$,$+$+$k$N$G(B
  ;; $BC;$+$$C18l$O8!:w$7$J$$$h$&$K$9$k!%(B
  (let ((word (sdic-word-at-point)))
    ;; word$B$,(Bnil$B$G$J$$$3$H(B
    (if word
        ;; $B%"%k%U%!%Y%C%H$N$_$+$i$J$kC18l$+F|K\8lJ8;z$r4^$`C18l$+(B
        (if (not (string-match "\\cj" word))
            ;; $B%"%k%U%!%Y%C%H$N$_(B
 	    ;; 3$BJ8;z0J>e$N>l9g$N$_(Bword$B$r>.J8;z$K$7$FJV5Q$9$k(B
	    (if (< 2 (length word)) (downcase word) nil)
          ;; $BF|K\8lJ8;z$r4^$`C18l(B
          ;; $B4A;z$r4^$`$+4^$^$J$$$+(B
          (if (string-match "\\cC+" word)
              ;; $B4A;z$r4^$`>l9g4A;zItJ,$rCj=P$7$FJV5Q(B
              (save-match-data (match-string 0 word))
	    ;; $B%+%?%+%J$r4^$`>l9g%+%?%+%JItJ,$rCj=P(B
	    (if (string-match "\\cK+" word)
		(setq word (match-string 0 word)))
	    ;; $B$R$i$,$J(B/$B%+%?%+%J0lJ8;z$O8!:w$7$J$$(B
	    (if (> (length word) 1) word nil)))
      nil)))

(defun auto-lookup-backend:sdic-describe-word (word)
  "sdic$B$G(BWORD$B$r0z$/(B"
  (save-excursion
    (save-match-data
      (set-buffer (get-buffer-create auto-lookup-backend:sdic-buffer-name))
      ;; $B<-=q$N?t$r9J$k!%(B
      (let (;;; $B1QOB7O(B
            (sdic-eiwa-dictionary-list 
             ;; auto-lookup$B$N@_Dj$,$"$l$P;H$&!%(B
             (or auto-lookup-backend:sdic-eiwa-dictionary-list
                 ;; $B$J$1$l$P!$CV$-49$($OD|$a$k!%(B
                 sdic-eiwa-dictionary-list))
            ;; sdic$B$NFbItJQ?t$bCV$-49$($k!%(B
            (sdic-eiwa-symbol-list auto-lookup-backend:sdic-eiwa-symbol-list)
            ;;; $BOB1Q7O(B
            (sdic-waei-dictionary-list 
             (or auto-lookup-backend:sdic-waei-dictionary-list
                 sdic-waei-dictionary-list))
            (sdic-waei-symbol-list auto-lookup-backend:sdic-waei-symbol-list)
            ;;; 
            (case-fold-search t))
        ;; mode-name$B$rD4$Y$F7+$jJV$7(Bsdic-mode$B$KF~$k$N$rKI$0!%(B
        ;; $B$?$@$7!$(B(sdic-mode)$B$,8F$S=P$5$l$?$H$-$@$1(B
        ;; sdic-eiwa-dictionary-list$B$d(B
        ;; sdic-eiwa-symbol-list$B$NCV$-49$($,:nMQ$9$k(B.
        (or (string= mode-name sdic-mode-name) (sdic-mode))
        (setq buffer-read-only nil)
        (erase-buffer)
        (prog1
            (if (string-match "\\cj" word)
                (funcall 'sdic-search-waei-dictionary word)
              (funcall 'sdic-search-eiwa-dictionary word))
          ;; $BCV$-49$o$C$?FbItJQ?t$r%-%c%C%7%e$7$F<!2s$N(B(auto-lookup$B$K$h$k(B)
          ;; $B8!:w;~$K;H$&!%(B
          (setq auto-lookup-backend:sdic-eiwa-symbol-list sdic-eiwa-symbol-list
                auto-lookup-backend:sdic-waei-symbol-list sdic-waei-symbol-list))))))

(defun auto-lookup-backend:sdic-get-result ()
  "sdic$B$N8!:w7k2L$r<h$j=P$9!%(B
$B7k2L$O!$(B($BC18l(B . $BLu(B)$B$H$$$&%Z%"$G$"$k!%(B"
  (with-current-buffer  (get-buffer-create auto-lookup-backend:sdic-buffer-name)
    (goto-char sdic-buffer-start-point)
    (let (b e b0 word (line "") (flag t))
      ;;
      (setq b (point))
      (end-of-line)
      (setq e (point))
      (setq word (buffer-substring b e))
      (beginning-of-line)
      ;;
      (while flag
        (forward-line 1)
        (setq b0 (point))
        (back-to-indentation)
        (setq b (point))
        (end-of-line)
        (setq e (point))
        (if (not (eq b b0))
            (setq line (concat line (buffer-substring b e)))
          (setq flag nil)))
      (cons word line))))

(defun auto-lookup-backend:sdic-check-buffer (buffer)
"BUFFER$B$,(Bsdic$B$K$h$C$F4IM}$5$l$F$$$k%P%C%U%!$+$I$&$+D4$Y$k!%(B
NIL$B$N>l9g4IM}$5$l$F$$$k!%(B"
  (not (eq buffer
           (get-buffer auto-lookup-backend:sdic-buffer-name))))

;;
;; Lookup backend
;;
;; current-prefix-arg$B$,(Bnil$B0J30$NCM$r;}$D$H$-!$(B
;; lookup-word-input$B$,(Bmodule$BL>$r?R$M$F$/$k$N$G(B
;; $B$o$:$i$o$7$$!%(Bcurrent-prefix-arg$B$r0l;~E*$K(Bnil$B$H$9$k!%(B
(defun auto-lookup-backend:lookup-word-input ()
  "lookup$B$G8!:w$9$kC18l$r<h$j=P$9!%(B"
  (let* ((current-prefix-arg nil)
         (input (lookup-word-input)))
    (if (and input (car input) (stringp (car input)))
        (car input)
      nil)))

(defun auto-lookup-backend:lookup-describe-word (word)
  "lookup$B$GC18l$r0z$/!%(B"
  ;; lookup-word$B$NFbIt$G8F$S=P$7$FM_$7$/$J$$4X?t$rCV$-49$($kA0$K(B
  ;; $B%P%C%/%"%C%W%"%C%W$r:n@.$9$k!%(B
  (let ((current-prefix-arg nil)
        (lookup-display-buffer-backup 
         (symbol-function 'lookup-display-buffer))
        (lookup-pop-to-buffer-backup
         (symbol-function 'lookup-pop-to-buffer))
        (result nil))
    (unwind-protect
        (condition-case nil
            (progn
              ;;
              ;; $B4X?t$rCV$-49$($k!%(B
              ;;
              (defun lookup-display-buffer (buffer))
              (defun lookup-pop-to-buffer (buffer))
              ;;
              ;; lookup$B$N8F$S=P$7!%(B
              ;;
              (call-interactively 'lookup-word)
              ;; $B@.8y(B
              (setq result t))
          (error nil))
      ;;
      ;; $BCV$-49$($?4X?t$rI|85$9$k!%(B
      ;;
      (fset 'lookup-display-buffer lookup-display-buffer-backup)
      (fset 'lookup-pop-to-buffer lookup-pop-to-buffer-backup))
    result))

;; $B$3$N4X?t$rJQ99$9$l$PG$0U$N<-=q$KBP1~$G$-$k$O$:!%(B
(defun auto-lookup-backend:lookup-get-result ()
  "lookup$B$N$N8!:w7k2L$r<h$j=P$9!%(B
$B7k2L$O!$(B($BC18l(B . $BLu(B)$B$H$$$&%Z%"$G$"$k!%(B"
  (let (b e word (line ""))
    (with-current-buffer  (lookup-content-buffer)
      (goto-char (point-min))
      ;; $BC18l$r<h$j=P$9!%(B
      (setq b (point-min))
      (end-of-line)
      (setq e (point))
      (setq word (buffer-substring b e))
      (beginning-of-line)

      ;; $BLu$r<h$j=P$9!%(B
      (while (not (eobp))
        (forward-line 1)
        (back-to-indentation)
        (setq b (point))
        (end-of-line)
        (setq e (point))
        (setq line (concat line (buffer-substring b e)))))
    (cons word line)))

(defun auto-lookup-backend:lookup-check-buffer (buffer)
  "BUFFER$B$,(Blookup$B$K$h$C$F4IM}$5$l$F$$$k%P%C%U%!$+$I$&$+D4$Y$k!%(B
NIL$B$N>l9g4IM}$5$l$F$$$k!%(B"
  (not (memq buffer lookup-buffer-list)))

;;
;; Etags backend
;;
;;
;;; eltags.el --- electric tag search
;;
;; Copyright (C) 1999  Masatake YAMATO, Takaaki MORIYAMA
;;
;; Author: Masatake YAMATO<masata-y@is.aist-nara.ac.jp>
;;         Takaaki MORIYAMA<taka@airlab.cs.ritsumei.ac.jp>
;; Keywords: etags
;; Version: v0
;; Revision: 0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

(defvar auto-lookup-backend:etags-data-cache nil)
(defvar auto-lookup-backend:etags-type-cache nil)
(defun auto-lookup-backend:etags-describe-word (symbol)
  (let (result b e)
    (setq result (condition-case ()
                     (find-tag-internal symbol)
                   (error nil)))
    (setq tags-loop-scan '(display-tag-info nil)
          tags-loop-operate nil)
    (if result
        (save-excursion
          (set-buffer (car result))
          (goto-char (cdr result))
          (beginning-of-line)
          ;;
          (setq auto-lookup-backend:etags-type-cache
                (cond
                 ((equal ?# (char-after))
                  ;;
                  ;; Macro
                  ;;
                  (setq b (point)
                        e (progn (next-line 1) (end-of-line) (point)))
                  "M")
                 ((save-match-data
                    (let ((colon -1)
                          (paren -1))
                      (save-excursion 
                        (if (re-search-forward ";\\|{" nil t)
                            (setq colon (point))))
                      (save-excursion 
                        (if (re-search-forward "(" nil t)
                            (setq paren (point))))
                      (if (or (eq -1 colon) (eq -1 paren))
                          nil
                        (if (< paren colon)
                            t
                          nil))))
                  ;;
                  ;; Function
                  ;;
                  (setq b (save-excursion (previous-line 1) (beginning-of-line) (point))
                        e (if (re-search-forward ")" nil t)
                              (point)
                            (next-line 1) (end-of-line) (point)))
                  "F")
                 (t
                  ;;
                  ;; typedef, struct, enum, variable...
                  ;;
                  (setq b (point)
                        e (progn (end-of-line) (point)))
                  "E"
                  )))
          (setq auto-lookup-backend:etags-data-cache
                (replace-in-string 
                 (replace-in-string (buffer-substring b e) "\n\\|\t" " ")
                 "  +" " "))
          t)
      nil)))

(defun auto-lookup-backend:etags-get-result ()
  (cons auto-lookup-backend:etags-type-cache
        auto-lookup-backend:etags-data-cache))

(defun auto-lookup-backend:etags-word-input ()
  (find-tag-default))

(defun auto-lookup-backend:etags-check-buffer (buffer)
  (not (string= "TAGS" (buffer-name buffer))))

;;
;; Minor mode
;;
(defvar auto-lookup-mode nil)
(make-variable-buffer-local 'auto-lookup-mode)

(defun auto-lookup-mode (&optional arg)
  "$B8=:_$N%P%C%U%!$G(BAuto lookup$B$r<B9T$9$k(B. "
  (interactive "P")
  (setq auto-lookup-history nil)
  (setq auto-lookup-mode (if arg
                             (> (prefix-numeric-value arg) 0)
                           (not auto-lookup-mode)))
  (if auto-lookup-mode
      (auto-lookup-try-timer-start)
    (auto-lookup-try-timer-end)))

(if (fboundp 'add-minor-mode)
    (add-minor-mode 'auto-lookup-mode auto-lookup-mode-string)
  ;; Put this minor mode on the global minor-mode-alist.
  (or (assq 'auto-lookup-mode (default-value 'minor-mode-alist))
      (setq-default minor-mode-alist
                    (append (default-value 'minor-mode-alist)
                            '((auto-lookup-mode auto-lookup-mode-string))))))

;;
;; Global mode
;;
(defvar global-auto-lookup-mode nil)
(defun global-auto-lookup-mode (&optional arg)
  "$B$9$Y$F$N%P%C%U%!$G(BAuto lookup$B$r<B9T$9$k(B. "
  (interactive "P")
  (setq auto-lookup-history nil)
  (let ((on-p (if arg
                  (> (prefix-numeric-value arg) 0)
                (not global-auto-lookup-mode))))
    (setq global-auto-lookup-mode on-p)
    ;; From flyspell.el
    ;; $B>-Mh:n$i$l$k%P%C%U%!$G(Bauto-lookup-mode$B$r5/F0(B, $BDd;_$9$k!%(B
    (cond
     (on-p
      (add-hook 'find-file-hooks 'turn-on-auto-lookup-if-enabled)
      (add-hook 'first-change-hook 'turn-on-auto-lookup-if-enabled))
     (t
      (remove-hook 'find-file-hooks 'turn-on-auto-lookup-if-enabled)
      (remove-hook 'first-change-hook 'turn-on-auto-lookup-if-enabled)))
    ;; $B8=:_B8:_$9$k!$$9$Y$F$N%P%C%U%!$G(Bauto-lookup-mode$B$r5/F0(B, $BDd;_$9$k!%(B
    (mapcar
     (function 
      (lambda (buffer)
        (if (auto-lookup-do-backend 'check-buffer buffer)
            (with-current-buffer buffer
              (auto-lookup-mode (if on-p 1 -1))))))
     (buffer-list))))

(defun turn-on-auto-lookup-if-enabled ()
  (and global-auto-lookup-mode
       (not auto-lookup-mode)
       (auto-lookup-do-backend 'check-buffer (current-buffer))
       (auto-lookup-mode 1)))

;;
;; Timer
;;
(defvar auto-lookup-timer nil "Auto lookup$B$N%?%$%^$rJ];}$9$kJQ?t(B")
(defun auto-lookup-try-timer-start ()
  "Auto lookup$B$N%?%$%^$r%9%?!<%H$9$k!%(B
$BJ#?t$N(BAuto lookup$B$N%?%$%^$,@_Dj$7$J$$$h$&$K(B`auto-lookup-timer'$B$NCM$r;2>H$9$k!%(B"
  (when (not auto-lookup-timer)
    (setq auto-lookup-timer (run-with-idle-timer 
                             auto-lookup-interval
                             t 
                             auto-lookup-function))))

(defun auto-lookup-try-timer-end ()
  "Auto lookup$B$N%?%$%^$rDd;_$9$k!%(B
$B$?$@$7!$$9$Y$F$N%P%C%U%!$,(BAuto lookup$B$+$iH4$1$?$H$-$N$_Dd;_$9$k!$(B"
  (if auto-lookup-timer
      (let ((autolookuped-buffer nil))
        ;; Auto lookup mode$B$KF~$C$F$$$k%P%C%U%!$,(B
        ;; 1$B$D$b$J$$$+D4$Y$k!%(B
        (mapcar
         (function 
          (lambda (buffer)
            (with-current-buffer buffer
              (if auto-lookup-mode
                  (setq autolookuped-buffer t)))))
         (buffer-list))
        ;; Auto lookup mode$B$KF~$C$F$$$k%P%C%U%!$,(B1$B$D$b$J$1(B
        ;; $B$l$P%?%$%^$rDd;_$9$k!%(B
        (when (and autolookuped-buffer)
          (cancel-timer auto-lookup-timer)
          (setq auto-lookup-timer nil)))))

(provide 'autolookup)
;;; autolookup.el ends here

