;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Yang Tang"
      user-mail-address (concat '(116 97 110 103 121 97 110 103 46 99 110 64 103 109 97 105 108 46 99 111 109)))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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
(setq doom-font (font-spec :family "Comic Code Ligatures" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-one-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;; Restore the old behavior of the s and S keys.
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; Set frame size.
(when window-system (set-frame-size (selected-frame) 160 48))

;; Don't ask for confirmation when leaving Emacs.
(setq confirm-kill-emacs nil)

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
