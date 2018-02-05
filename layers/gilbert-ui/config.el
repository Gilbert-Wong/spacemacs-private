;;; config.el --- Better Emacs Defaults Layer configuration variables File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: gilbert <gilbertwong96@outlook.com>
;; URL: https://github.com/Gilbert-Wong/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'vue-mode-hook 'linum-mode)

;; http://stackoverflow.com/questions/3875213/turning-on-linum-mode-when-in-python-c-mode
(setq linum-mode-inhibit-modes-list '(eshell-mode
                                      shell-mode
                                      profiler-report-mode
                                      help-mode
                                      text-mode
                                      fundamental-mode
                                      inferior-js-mode
                                      inferior-scheme-mode
                                      compilation-mode
                                      org-mode
                                      org-agenda-mode
                                      vc-git-log-edit-mode
                                      spacemacs-buffer-mode
                                      speedbar-mode))
(defadvice linum-on (around linum-on-inhibit-for-modes)
           "Stop the load of linum-mode for some major modes."
           (unless (member major-mode linum-mode-inhibit-modes-list)
             ad-do-it))
(ad-activate 'linum-on)
