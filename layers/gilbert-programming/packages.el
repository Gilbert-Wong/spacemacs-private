;; packages.el --- Better Emacs Defaults Layer configuration variables File
;;
;; Copyright (c) 2017-2018 Gilbert Wong
;;
;; Author: Gilbert Wong <gilbertwong96@outlook.com>
;; URL: https://github.com/Gilbert-Wong/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq gilbert-programming-packages
      '(
        paredit
        ivy-erlang-complete
        company-erlang
        vue-mode
        ))

;; vue-mode
(defun gilbert-programming/init-vue-mode()
  "Setup for VueJs"
  (use-package vue-mode
    :defer t
    :ensure t
    :config
    (progn
      (add-hook 'vue-mode-hook 'spacemacs/run-prog-mode-hooks)

      ;; set vue mode keys
      (spacemacs/set-leader-keys-for-major-mode 'vue-mode
        "v" 'vue-mode-edit-indirect-at-point)
      )
    )
  )

;; enhance erlang-mode
(defun gilbert-programming/init-ivy-erlang-complete()
  "Setup for erlang."
  (use-package ivy-erlang-complete
    :defer t
    :ensure t
    :config
    (progn
      (add-hook 'erlang-mode-hook #'company-erlang-init)
      (add-hook 'erlang-mode-hook #'ivy-erlang-complete-init)
      ;; automatic update completion data after save
      (add-hook 'after-save-hook #'ivy-erlang-complete-reparse)
      (add-to-list 'auto-mode-alist '("rebar\\.config$" . erlang-mode))
      (add-to-list 'auto-mode-alist '("relx\\.config$" . erlang-mode))
      (add-to-list 'auto-mode-alist '("system\\.config$" . erlang-mode))
      (add-to-list 'auto-mode-alist '("\\.app\\.src$" . erlang-mode))
      ;; (dolist (prefix '(
      ;;                   ("e" . "erlang-ide")
      ;;                   ))
      ;; (spacemacs/declare-prefix-for-mode
      ;;   'erlang-mode (car prefix) (cdr prefix)))

      (spacemacs/set-leader-keys-for-major-mode 'erlang-mode
        "d" 'ivy-erlang-complete-find-definition
        "s" 'ivy-erlang-complete-find-spec
        "r" 'ivy-erlang-complete-find-references
        "f" 'ivy-erlang-complete-find-file
        "h" 'ivy-erlang-complete-show-doc-at-point
        "p" 'ivy-erlang-complete-set-project-root
        "a" 'ivy-erlang-complete-autosetup-project-root
        ))

    :custom
    (ivy-erlang-complete-erlang-root "/usr/local/Cellar/erlang/")
    )
  )

(defun gilbert-programming/init-company-erlang()
  (add-hook 'erlang-mode-hook #'company-erlang-init)
  )


(defun gilbert-programming/post-init-js-doc ()
  (setq js-doc-mail-address "gilbertwong96@outlook.com"
        js-doc-author (format "Gilbert Wong <%s>" js-doc-mail-address)
        js-doc-url "http://blog.gilbertwong.co"
        js-doc-license "MIT")
  )

(defun gilbert-programming/init-ctags-update ()
  (use-package ctags-update
    :init
    :defer t
    :config
    (spacemacs|hide-lighter ctags-auto-update-mode)))

(defun gilbert-programming/post-init-web-mode ()
  (with-eval-after-load "web-mode"
    (web-mode-toggle-current-element-highlight)
    (web-mode-dom-errors-show))
  (setq company-backends-web-mode '((company-dabbrev-code
                                     company-keywords)
                                    company-files company-dabbrev)))

(defun gilbert-programming/post-init-yasnippet ()
  (progn
    (set-face-background 'secondary-selection "gray")
    (setq-default yas-prompt-functions '(yas-ido-prompt yas-dropdown-prompt))
    (mapc #'(lambda (hook) (remove-hook hook 'spacemacs/load-yasnippet)) '(prog-mode-hook
                                                                           markdown-mode-hook))

    (spacemacs/add-to-hooks 'gilbert/load-yasnippet '(prog-mode-hook
                                                      markdown-mode-hook
                                                      org-mode-hook))
    ))

(defun gilbert-programming/post-init-js2-refactor ()
  (progn
    (spacemacs/set-leader-keys-for-major-mode 'js2-mode
      "r>" 'js2r-forward-slurp
      "r<" 'js2r-forward-barf)))


(defun gilbert-programming/post-init-css-mode ()
  (progn
    (dolist (hook '(css-mode-hook sass-mode-hook less-mode-hook))
      (add-hook hook 'rainbow-mode))

    (defun css-imenu-make-index ()
      (save-excursion
        (imenu--generic-function '((nil "^ *\\([^ ]+\\) *{ *$" 1)))))

    (add-hook 'css-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'css-imenu-make-index)))))



(defun gilbert-programming/init-paredit ()
  (use-package paredit
    :commands (paredit-wrap-round
               paredit-wrap-square
               paredit-wrap-curly
               paredit-splice-sexp-killing-backward)
    :init
    (progn

      (bind-key* "s-(" #'paredit-wrap-round)
      (bind-key* "s-[" #'paredit-wrap-square)
      (bind-key* "s-{" #'paredit-wrap-curly)
      )))

(defun gilbert-programming/post-init-company ()
  (progn
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.08)

    (when (configuration-layer/package-usedp 'company)
      (spacemacs|add-company-backends :modes shell-script-mode makefile-bsdmake-mode sh-mode lua-mode nxml-mode conf-unix-mode json-mode graphviz-dot-mode))
    ))

(defun gilbert-programming/post-init-company-c-headers ()
  (progn
    (setq company-c-headers-path-system
          (quote
           ("/usr/include/" "/usr/local/include/" "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1")))
    ;;    (setq company-c-headers-path-user
    ;;          (quote
    ;;           ("/Users/gilbertwong/cocos2d-x/cocos/platform" "/Users/gilbertwong/cocos2d-x/cocos" "." "/Users/gilbertwong/cocos2d-x/cocos/audio/include/")))
    ))
