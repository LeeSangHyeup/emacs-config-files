(setq package-archives
  '(("melpa-stable" . "http://stable.melpa.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (neotree elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 150 :width normal)))))

;;remove scratch message
(setq initial-scratch-message nil)

;;to solving copy&paste ploblem.
(delete-selection-mode)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq elpy-rpc-python-command "python3")
(package-initialize)
(elpy-enable)

(add-hook 'elpy-mode-hook (lambda ()
                            (add-hook 'before-save-hook
                                      'elpy-black-fix-code nil t)))

;; set hideshow for programming
(load-library "hideshow")
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;(add-hook 'java-mode-hook 'hs-minor-mode)
;(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)

(defun mouse-set-point-hs-toggle-hiding ()
  (interactive)
  (call-interactively 'mouse-set-point)
  (call-interactively 'hs-toggle-hiding))

;; set global key for hideshow
(global-unset-key [double-mouse-3])
(global-set-key [mouse-3]  'mouse-set-point-hs-toggle-hiding)
