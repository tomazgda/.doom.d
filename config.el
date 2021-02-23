(setq user-full-name "Tomaz GdA"
      user-mail-address "tomazgda@icloud.com.com")
;;(setq writeroom-fullscreen-effect 'maximized)

(modus-themes-load-themes)
(setq doom-theme 'modus-operandi)
(global-set-key (kbd "<f4>") #'modus-themes-toggle)
(setq
modus-themes-org-blocks 'greyscale
modus-themes-mode-line 'borderless

modus-themes-variable-pitch-ui t
      modus-themes-variable-pitch-headings t
      modus-themes-scale-headings t
      modus-themes-scale-1 1.1
      modus-themes-scale-2 1.15
      modus-themes-scale-3 1.21
      modus-themes-scale-4 1.27
      modus-themes-scale-5 1.33)

(run-at-time "08:00" (* 60 60 24) (lambda () (enable-theme 'modus-operandi)))
(run-at-time "18:00" (* 60 60 24) (lambda () (enable-theme 'modus-vivendi)))

;(modus-themes-mode-line 'borderless)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")
(setq deft-directory "~/org"
      deft-extensions '("org" "txt")
      deft-recursive t)
(setq org-roam-directory "~/org/roam")
(setq org-journal-dir "~/org/journal")

 (use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(when (org-roam--org-roam-file-p)
  (org-roam))

(setq elfeed-feeds '(
        ;; proper news
        ("http://feeds.bbci.co.uk/news/world/rss.xml" news)
        ("https://www.theguardian.com/world/rss" news)
        ;; youtube
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-lHJZR3Gqxm24_Vd_AJ5Yw" youtube pewds)
        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCGwu0nbY2wSkW8N-cghnLpA" youtube jaiden)
        ;; reddit
        ("https://www.reddit.com/r/linux.rss" reddit linux)
))

(setq org-agenda-files '("~/org/todo"))

(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)

(after! mu4e
  (setq
   mu4e-headers-skip-duplicates  t
   mu4e-view-show-images t
   mu4e-view-show-addresses t
   mu4e-compose-format-flowed nil
   mu4e-date-format "%y/%m/%d"
   mu4e-headers-date-format "%Y/%m/%d"
   mu4e-change-filenames-when-moving t
   mu4e-attachments-dir "~/Downloads"
   mu4e-refile-folder "/icloud/Archive"
   mu4e-sent-folder   "/icloud/Sent"
   mu4e-drafts-folder "/icloud/Drafts"
   mu4e-trash-folder  "/icloud/Trash"
   mu4e-get-mail-command  "mbsync -a"))

(after! mu4e
  (setq sendmail-program "/opt/homebrew/bin/msmtp"
  send-mail-function #'smtpmail-send-it
  message-sendmail-f-is-evil t
  message-sendmail-extra-arguments '("--read-envelope-from"); , "--read-recipients")
  message-send-mail-function #'message-send-mail-with-sendmail))

(setq org-ditaa-jar-path "~/Downloads/ditaa0_9/ditaa0_9.jar")

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ditaa . t)
   )
)

(fringe-mode 15)

(setq
   split-width-threshold 0
   split-height-threshold nil)

(global-visual-line-mode 1)
(global-visual-fill-column-mode 1)
(set-fill-column 200)

;; When using this directly, you will need to have use-package installed:
;; M-x package-install, select use-package. But if you start via
;; `standalone.el', this is being taken care of automatically.


;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; rustic = basic rust-mode + additions

(setq rust-rustfmt-bin "/Users/tomaz/.cargo/bin/rustfmt")

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status)
              ("C-c C-c e" . lsp-rust-analyzer-expand-macro)
              ("C-c C-c d" . dap-hydra))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  ;;(setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm
  (setq-local buffer-save-without-query t))

;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; for rust-analyzer integration

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))


;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; inline errors

(use-package flycheck :ensure)


;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; auto-completion and code snippets

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package company
  :ensure
  :bind
  (:map company-active-map
              ("C-n". company-select-next)
              ("C-p". company-select-previous)
              ("M-<". company-select-first)
              ("M->". company-select-last))
  (:map company-mode-map
        ("<tab>". tab-indent-or-complete)
        ("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))


;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; for Cargo.toml and other config files

(use-package toml-mode :ensure)


;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; setting up debugging support with dap-mode

(use-package exec-path-from-shell
  :ensure
  :init (exec-path-from-shell-initialize))

(when (executable-find "lldb-mi")
  (use-package dap-mode
    :ensure
    :config
    (dap-ui-mode)
    (dap-ui-controls-mode 1)

    (require 'dap-lldb)
    (require 'dap-gdb-lldb)
    ;; installs .extension/vscode
    (dap-gdb-lldb-setup)
    (dap-register-debug-template
     "Rust::LLDB Run Configuration"
     (list :type "lldb"
           :request "launch"
           :name "LLDB::Run"
	   :gdbpath "rust-lldb"
           ;; uncomment if lldb-mi is not in PATH
           ;; :lldbmipath "path/to/lldb-mi"
           ))))
