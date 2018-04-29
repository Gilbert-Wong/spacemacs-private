;;; keybindings.el --- Better Emacs Defaults Layer configuration variables File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: gilbert <gilbertwong96@outlook.com>
;; URL: https://github.com/Gilbert-Wong/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(global-set-key (kbd "M-s o") 'occur-dwim)

(define-key global-map (kbd "C-c y") 'youdao-dictionary-search-at-point+)

(define-key global-map (kbd "<f8>") 'gilbert/show-current-buffer-major-mode)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)


(global-set-key (kbd "<f5>") 'gilbert/run-current-file)
