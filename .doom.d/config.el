;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Yang Tang"
      user-mail-address (concat '(116 97 110 103 121 97 110 103 46 99 110 64 103 109 97 105 108 46 99 111 109)))

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
(setq doom-font (font-spec :family "OperatorMonoSSmLig Nerd Font" :size 14 :weight 'semi-light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

;; Restore the old behavior of the s and S keys.
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; Set frame size.
(when window-system (set-frame-size (selected-frame) 160 48))

;; Don't ask for confirmation when leaving Emacs.
(setq confirm-kill-emacs nil)

;; Set theme.
(setq doom-theme 'doom-one-light)

;; New splits will be at the bottom or to the right side of the screen.
(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)

;; Italic comments.
(custom-set-faces! '(font-lock-comment-face :slant italic))

;; LLVM coding style guidelines in emacs.
(defun llvm-lineup-statement (langelem)
  (let ((in-assign (c-lineup-assignments langelem)))
    (if (not in-assign)
        '++
      (aset in-assign 0
            (+ (aref in-assign 0)
               (* 2 c-basic-offset)))
      in-assign)))
(c-add-style "llvm.org"
             '("gnu"
               (fill-column . 80)
               (c++-indent-level . 2)
               (c-basic-offset . 2)
               (indent-tabs-mode . nil)
               (c-offsets-alist . ((arglist-intro . ++)
                                   (innamespace . 0)
                                   (member-init-intro . ++)
                                   (statement-cont . llvm-lineup-statement)))))
(add-hook 'c-mode-common-hook (lambda () (c-set-style "llvm.org")))

;; Customize org export references.
(use-package ox
  :defer t
  :config
  (defun org-export-get-reference (datum info)
    (let ((cache (or (plist-get info :internal-references)
                     (let ((h (make-hash-table :test #'eq)))
                       (plist-put info :internal-references h)
                       h)))
          (reverse-cache (or (plist-get info :taken-internal-references)
                             (let ((h (make-hash-table :test 'equal)))
                               (plist-put info :taken-internal-references h)
                               h))))
      (or (gethash datum cache)
          (let* ((name (let ((raw-value (when (listp datum)
                                          (let ((property-list (cadr datum)))
                                            (when property-list (plist-get property-list :raw-value))))))
                         (if raw-value
                             (replace-regexp-in-string "[^[:alnum:]]" "" (s-downcase raw-value))
                           (let ((type (org-element-type datum)))
                             (format "org%s%d"
                                     (if type
                                         (replace-regexp-in-string "-" "" (symbol-name type))
                                       "secondarystring")
                                     (incf (gethash type cache 0)))))))
                 (number (+ 1 (gethash name reverse-cache -1)))
                 (new-name (format "%s%s" name (if (< 0 number) number ""))))
            (puthash name number reverse-cache)
            (puthash datum new-name cache)
            new-name)))))
