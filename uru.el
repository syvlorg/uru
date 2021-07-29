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



;;;###autoload
(defalias 'use-package-normalize/:uru 'use-package-normalize-forms)

;;;###autoload
(defun use-package-handler/:uru (name keyword args rest state)
  "Generate uru with NAME for `:uru' KEYWORD.
ARGS, REST, and STATE are prepared by `use-package-normalize/:uru'."
  (use-package-concat
   (mapcar #'(lambda (def) `(uru ,@def)) args)
   (use-package-process-keywords name rest state)))

(add-to-list 'use-package-keywords :uru t)

(provide 'uru)
;;; uru.el ends here
