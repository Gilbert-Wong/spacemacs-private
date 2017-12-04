;;; packages.el --- gilbert layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Gilbert-PC <gilbert@Gilbert-PC>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `gilbert-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `gilbert/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `gilbert/pre-init-PACKAGE' and/or
;;   `gilbert/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst gilbert-packages
  '(youdao-dictionary
    company
    occur-mode
    )
  )

(defun gilbert/init-youdao-dictionary()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
    )
  )

(defun gilbert/post-init-company()
  (setq company-minimum-prefix-length 1))


(defun gilbert/init-occur-mode()
  (evilified-state-evilify-map occur-mode-map
    :mode occur-mode)
  )
;;; packages.el ends here
