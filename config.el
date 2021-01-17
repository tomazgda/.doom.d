;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tomaz Geddes de Almeida"
      user-mail-address "tomazgda@icloud.com")

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
(setq doom-theme 'doom-solarized-dark)

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

;; smooth scrolling

; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
; (setq mouse-wheel-progressive-speed nil)
; (setq mouse-wheel-follow-mouse 't)
; (setq scroll-step 1)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((racket . t)))

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq org-agenda-files '("~/Notes/TODO"))

(setq org-journal-date-prefix "#+TITLE:"
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-dir "~/Notes/Journal")

(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)


(setq
mu4e-headers-skip-duplicates  t
mu4e-view-show-images t
mu4e-view-show-addresses t
mu4e-compose-format-flowed nil
mu4e-date-format "%y/%m/%d"
mu4e-headers-date-format "%Y/%m/%d"
mu4e-change-filenames-when-moving t
mu4e-attachments-dir "~/Downloads"

;; mu4e-maildir       "~/Maildir"   ;; top-level Maildir
 ;; note that these folders below must start with /
 ;; the paths are relative to maildir root
mu4e-refile-folder "/icloud/Archive"
mu4e-sent-folder   "/icloud/Sent"
mu4e-drafts-folder "/icloud/Drafts"
mu4e-trash-folder  "/icloud/Trash"

;; this setting allows to re-sync and re-index mail
;; by pressing U
mu4e-get-mail-command  "mbsync -a")

(setq message-send-mail-function    'smtpmail-send-it
      smtpmail-smtp-server  "smtp.mail.me.com"
      smtpmail-stream-type  'ssl
      smtpmail-smtp-service 587)