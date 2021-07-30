;;; uru.el --- a simple package                     -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Jeet Ray

;; Author: Jeet Ray <aiern@protonmail.com>
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Put a description of the package here

;;; Code:

(require 'dash)

(defvar meq/var/ua-major-mode-deinos nil)

;;;###autoload
(defmacro defuru* (ua major-mode name &rest args)
  (push `(,ua ,major-mode ,(intern (concat (symbol-name name) "/body"))) meq/var/ua-major-mode-deinos)
  `(defdeino ,name ,@args))

;;;###autoload
(defmacro defuru (major-mode name &rest args) `(defuru* nil ,major-mode ,name ,@args))

;;;###autoload
(defmacro defurua (ua major-mode name &rest args) `(defuru* ,ua ,major-mode ,name ,@args))

(defun uru* (uru-list) (when (derived-mode-p (cadr uru-list)) (funcall (caddr uru-list))))

;;;###autoload
(defun uru (&optional ua) (interactive "p")
  (mapc #'uru* (if current-prefix-arg
                  (--filter (= (car it) ua) (--remove (booleanp (car it)) meq/var/ua-major-mode-deinos))
                  (--filter (booleanp (car it)) meq/var/ua-major-mode-deinos))))

;; Adapted From: https://github.com/jwiegley/use-package/blob/master/use-package-core.el#L1153
;;;###autoload
(defalias 'use-package-normalize/:uru 'use-package-normalize-forms)

;; Adapted From: https://gitlab.com/to1ne/use-package-hydra/-/blob/master/use-package-hydra.el#L79
;;;###autoload
(defun use-package-handler/:uru (name keyword args rest state)
    (use-package-concat (mapcar #'(lambda (def) `(defuru ,@def)) args)
    (use-package-process-keywords name rest state)))

(add-to-list 'use-package-keywords :uru t)

;;;###autoload
(defalias 'use-package-normalize/:urua 'use-package-normalize-forms)

;;;###autoload
(defun use-package-handler/:urua (name keyword args rest state)
    (use-package-concat (mapcar #'(lambda (def) `(defurua ,@def)) args)
    (use-package-process-keywords name rest state)))

(add-to-list 'use-package-keywords :urua t)

(provide 'uru)
;;; uru.el ends here
