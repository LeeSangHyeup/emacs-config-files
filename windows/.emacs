
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;set default font size
(set-face-attribute 'default nil :height 160)

;;turnoff annoying beep sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;set utf-8 for using korean
;(setq-default buffer-file-coding-system 'utf-8-unix)
;(prefer-coding-system 'utf-8-unix)
;(setq slime-net-coding-system 'utf-8-unix)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages (quote (ag dumb-jump find-file-in-project slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;set up developement enviorment
(slime-setup '(slime-asdf
	       slime-company
	       slime-fancy
	       slime-indentation
	       slime-sbcl-exts
	       slime-scratch
	       slime-tramp))


;;to solving copy&paste ploblem.
(delete-selection-mode)

;;setup "jump to code definition tool"
(dumb-jump-mode)


;; set hideshow for programming
(load-library "hideshow")
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)


;;set python interpreter
(setq python-shell-interpreter "C:/Users/lsh/AppData/Local/Programs/Python/Python38-32/python")



;;set python autocomplete
(defun jedi-python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'jedi-python-mode-hook)




(defun mouse-set-point-hs-toggle-hiding ()
  (interactive)
  (call-interactively 'mouse-set-point)
  (call-interactively 'hs-toggle-hiding))

;; set global key for hideshow
(global-unset-key [double-mouse-3])
(global-set-key [mouse-3]  'mouse-set-point-hs-toggle-hiding)


;;for set up sbcl
(setq inferior-lisp-program "c:/sbcl/2.0.0/sbcl.exe")

;;for set up slime
(add-to-list 'load-path "c:/emacs/share/emacs/site-lisp/slime-master/")
(require 'slime)
(slime-setup '(slime-fancy))

;;neotree
(add-to-list 'load-path "c:/emacs/share/emacs/site-lisp/neotree/")
(require 'neotree)
(neotree-toggle)
(setq neo-smart-open t)

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
	(progn
            (neotree-dir project-dir)
            (neotree-find file-name))
        (message "Could not find git project root."))))

;;(define-key map (kbd "C-c C-p") 'neotree-project-dir)

;;kill start page
(setq inhibit-startup-screen t)

;;remove scratch message
(setq initial-scratch-message nil)

;; configure neotree shortcut 
(global-set-key [f8] 'neotree-toggle)


;;install lisp auto-complete plug-in
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'slime
  (slime-setup '(slime-fancy slime-company)))
(with-eval-after-load 'company
  (define-key company-active-map (kbd "\C-n") 'company-select-next)
  (define-key company-active-map (kbd "\C-p") 'company-select-previous)
  (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-.") 'company-show-location))

;;set full screen when starts-up
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;;set elpy(python IDE)
(use-package elpy
	     :ensure t
	     :init
	     :config
	     (package-initialize)
	     (elpy-enable)
	     ;; (add-hook 'python-mode-hook (lambda ()
	     ;; 				   (setq indent-tabs-mode nil)))
	     )

;(use-package ein
;  :ensure t)
