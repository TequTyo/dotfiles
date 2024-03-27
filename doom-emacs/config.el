;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "TequTyo"
      user-mail-address "Tyhjakuori@proton.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
(add-hook 'ielm-mode-hook 'eldoc-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'prog-mode-hook 'evil-vimish-fold-mode)
(add-hook 'text-mode-hook 'evil-vimish-fold-mode)

;; Folding
(use-package vimish-fold
  :ensure
  :after evil)

(use-package evil-vimish-fold
  :ensure
  :after vimish-fold
  :init
  (setq evil-vimish-fold-mode-lighter " ⮒")
  (setq evil-vimish-fold-target-modes '(prog-mode conf-mode text-mode))
  :config
  (global-evil-vimish-fold-mode))

;;;###autoload
(defun myfold/close-all-plus-comments ()
  (interactive)
  (+fold/close-all)
  (hide/show-comments 'hide)
  )

;;;###autoload
(defun myfold/open-all-plus-comments ()
  (interactive)
  (+fold/open-all)
  (hide/show-comments 'show)
  )

;;;###autoload
(defun myfold/open-plus-comments ()
  (interactive)
  (+fold/open)
  (hide/show-comments 'show)
  )

;;;###autoload
(defun myfold/toggle-plus-comments ()
  (interactive)
  (+fold/toggle)
  (hide/show-comments 'show)
  )

(when (modulep! :editor evil)
  ;; Add vimish-fold, outline-mode & hideshow support to folding commands
  (define-key! 'global
    [remap evil-toggle-fold]   #'myfold/toggle-plus-comments
    ;; [remap evil-close-fold]    #'+fold/close
    [remap evil-open-fold]     #'myfold/open-plus-comments
    [remap evil-open-fold-rec] #'myfold/open-plus-comments
    [remap evil-close-folds]   #'myfold/close-all-plus-comments
    [remap evil-open-folds]    #'myfold/open-all-plus-comments
    )
  )

;; Javascript ect.
(require 'prettier-js)
(setq prettier-js-args '(
  "--trailing-comma" "all"
  "--bracket-spacing" "false"
))

(setq js-doc-mail-address "your email address"
       js-doc-author (format "your name <%s>" js-doc-mail-address)
       js-doc-url "url of your website"
       js-doc-license "license name")

(add-hook 'js2-mode-hook
           #'(lambda ()
               (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
               (define-key js2-mode-map "@" 'js-doc-insert-tag)))
(after! js2-mode
  (set-company-backend! 'js2-mode 'company-tide 'company-yasnippet)
  (set-lookup-handlers! 'js2-mode :xref-backend #'xref-js2-xref-backend)
  (set-docsets! 'js2-mode "JavaScript" "JQuery")
  (set-docsets! 'rjsx-mode :add "React")
  (set-docsets! 'nodejs-mode :remove "JQuery"))

;; flyspell and tooltips
(after! flyspell
  (setq flyspell-lazy-idle-seconds 1))

(after! tooltip-mode
  (setq help-at-pt-display-when-idle 't)
  (setq help-at-pt-set-timer '1))

(use-package mediawiki)

(setq browse-url-browser-function 'browse-url-firefox
          browse-url-new-window-flag  t
          browse-url-firefox-new-window-is-tab t)
