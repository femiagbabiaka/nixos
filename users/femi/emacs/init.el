;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                     ;;
;;                emacs config is a hell of a drug                     ;;
;;                Femi Agbabiaka <femi@femiagbabiaka.xyz>              ;;
;;                                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; whoami
(setq user-full-name "Femi Agbabiaka"
      user-mail-address "femi@femiagbabiaka.xyz")

;; Remove default GUI
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Set font
(set-frame-font "Go Mono for Powerline-12" nil t)

;; Change backup location
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))

;; Update file backup settings
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)

;; Change custom variable file location
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;   package list   ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;

;; MELPA
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

;; Download use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Reduce load time
(eval-when-compile (require 'use-package))

;; config use-package
(require 'use-package-ensure)
(setq use-package-always-ensure t)


;; Set theme
(use-package apropospriate-theme
  :ensure t
  :config 
  (load-theme 'apropospriate-dark t))

(use-package evil
  :config
  (evil-mode 1))

(use-package disable-mouse
  :init
  (global-disable-mouse-mode)
  (mapc #'disable-mouse-in-keymap
	(list evil-motion-state-map
	      evil-normal-state-map
	      evil-visual-state-map
	      evil-insert-state-map)))

(use-package magit)

(use-package csv-mode)

(use-package slime
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf))
  (setq inferior-lisp-program "/usr/bin/sbcl"))

(use-package nix-mode
  :mode "\\.nix\\'")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(org-agenda-files '("~/repos/orgfiles/todo.org"))
 '(package-selected-packages
   '(nix-mode apropospriate-theme slime csv-mode evil vterm counsel magit xah-fly-keys use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
