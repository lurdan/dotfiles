;;; subst-win.el --- Unicode translation for Windows -*- coding: euc-jp;-*-

;; Copyright (C) 2004  ARISAWA Akihiro

;; Author: ARISAWA Akihiro <ari@mbf.sphere.ne.jp>
;; Keywords: i18n

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Code:

(mapc
 (lambda (pair)
   (let ((unicode (car pair))
	 (char (cadr pair)))
     (puthash unicode  char ucs-unicode-to-mule-cjk)
     (puthash char unicode ucs-mule-cjk-to-unicode)))
 '(
   ;; JIS X 0208 correspondings
   (#xFF5E ?°¡) ;; FULLWIDTH TILDE
   (#x2225 ?°¬) ;; PARALLEL TO
   (#xFF0D ?°›) ;; FULLWIDTH HYPHENMINUS
   (#xFFE0 ?°Ò) ;; FULLWIDTH CENT SIGN
   (#xFFE1 ?°Ú) ;; FULLWIDTH POUND SIGN
   (#xFFE2 ?¢Ã) ;; FULLWIDTH NOT SIGN
   ;; JIS X 0212 correspondings
   (#xFFE4 ?è¢√) ;; FULLWIDTH BROKEN BAR
   ))

(provide 'subst-win)
;;; subst-win.el ends here
