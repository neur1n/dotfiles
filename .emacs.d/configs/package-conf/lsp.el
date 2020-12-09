;************************************************* company-mode/company-mode{{{
(add-hook 'after-init-hook #'global-company-mode)
(with-eval-after-load 'company
   (define-key company-active-map (kbd "<tab>") #'company-select-next)
   (define-key company-active-map (kbd "<backtab>") #'company-select-previous)
   (define-key company-active-map (kbd "M-n") nil)
   (define-key company-active-map (kbd "M-p") nil))
;}}}

;******************************************************** emacs-lsp/lsp-mode{{{
(add-hook 'prog-mode-hook #'lsp)
;}}}
