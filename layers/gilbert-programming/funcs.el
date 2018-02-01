;;; funcs.el --- Better Emacs Defaults Layer configuration variables File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Gilbert Wong <gilbertwong96@outlook.com>
;; URL: https://github.com/Gilbert-Wong/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defun gilbert/run-current-file ()
  "Execute the current file.
For example, if the current buffer is the file x.py, then it'll call 「python x.py」 in a shell.
The file can be emacs lisp, php, perl, python, ruby, javascript, bash, ocaml, Visual Basic.
File suffix is used to determine what program to run.
If the file is modified, ask if you want to save first.
URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'
version 2015-08-21"
  (interactive)
  (let* (
         (ξsuffix-map
          ;; (extension . shell program name)
          `(
            ("php" . "php")
            ("pl" . "perl")
            ("py" . "python")
            ("py3" . ,(if (string-equal system-type "windows-nt") "c:/Python32/python.exe" "python3"))
            ("rb" . "ruby")
            ("js" . "node") ; node.js
            ("sh" . "bash")
            ;; ("clj" . "java -cp /home/xah/apps/clojure-1.6.0/clojure-1.6.0.jar clojure.main")
            ("ml" . "ocaml")
            ("vbs" . "cscript")
            ("tex" . "pdflatex")
            ("lua" . "lua")
            ;; ("pov" . "/usr/local/bin/povray +R2 +A0.1 +J1.2 +Am2 +Q9 +H480 +W640")
            ))
         (ξfname (buffer-file-name))
         (ξfSuffix (file-name-extension ξfname))
         (ξprog-name (cdr (assoc ξfSuffix ξsuffix-map)))
         (ξcmd-str (concat ξprog-name " \""   ξfname "\"")))

    (when (buffer-modified-p)
      (when (y-or-n-p "Buffer modified. Do you want to save first?")
        (save-buffer)))

    (if (string-equal ξfSuffix "el") ; special case for emacs lisp
        (load ξfname)
      (if ξprog-name
          (progn
            (message "Running…")
            (async-shell-command ξcmd-str "*gilbert/run-current-file output*"))
        (message "No recognized program file suffix for this file.")))))
