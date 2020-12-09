(defvar bootstrap-version)
(let ((bootstrap-file
        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(set 'EMACSCONFIG (concat (getenv "HOME") "/.emacs.d/"))

(load (concat EMACSCONFIG "configs/ui.el"))
(load (concat EMACSCONFIG "configs/package-list.el"))
(load (concat EMACSCONFIG "configs/package-conf.el"))
