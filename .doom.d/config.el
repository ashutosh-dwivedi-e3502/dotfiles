;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;;(load `local_config.el)
;; (load-file "~/.doom.d/local_config.el")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ashutosh Dwivedi"
      user-mail-address "ashutosh.dwivedi@outlook.in")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/todo/"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(after! org (setq org-export-backends '(pdf ascii html latex odt md pandoc)))

;; self: add projects dir for projectile
;; (apply `projectile-discover-project-in-directory project-dirs)
;; (projectile-discover-projects-in-directory "~/self/code")

(use-package pipenv
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))


(yas-global-mode 1)
(add-hook 'yas-minor-mode-hook (lambda ()
                                 (yas-activate-extra-mode 'fundamental-mode)))


(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            scala-mode
            tex-mode         ; latexindent is broken
            latex-mode))
;;(setq-hook! 'scala-mode-hook +format-with 'scalafmt)
;; (add-hook 'scala-mode-hook #'format-all-mode)
;; (setq-hook! 'scala-mode-hook +format-with-lsp t)
;;
;; (setq py-isort-options '("--quiet --color"))

(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))
(setq python-shell-completion-native-enable nil)

(add-hook 'python-mode-hook (lambda ()
                              (sphinx-doc-mode t)
                              (elpy-enable)
                              (python-black-on-save-mode)))
                              ;; (py-isort-before-save)))
                              ;; (pyimpsort-buffer)
                              ;; (pyimport-remove-unused)))


(setq comint-process-echoes t)


(when (executable-find "ipython")
  (setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
  (setq python-shell-interpreter "ipython"))

(setenv "WORKON_HOME" "/usr/local/Caskroom/miniconda/base/envs/")

(custom-set-variables
 '(conda-anaconda-home "/usr/local/Caskroom/miniconda/base/"))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(require 'vlf-setup)
(require 'org-download)

(add-hook 'dired-mode-hook 'org-download-enable)

(after! chatgpt-shell
  (setq chatgpt-shell-openai-key "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"))
