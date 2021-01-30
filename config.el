(setq user-full-name "Tomaz GdA"
      user-mail-address "tomazgda@icloud.com.com")

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

(setq display-line-numbers-type nil)

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

(setq org-super-agenda-groups '((:name "Today"
                                  :time-grid t
                                  :scheduled today)
                           (:name "Due today"
                                  :deadline today)
                           (:name "Important"
                                  :priority "A")
                           (:name "Overdue"
                                  :deadline past)
                           (:name "Due soon"
                                  :deadline future)
                           (:name "Big Outcomes"
                                  :tag "bo")))

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

(fringe-mode 15)

(setq
   split-width-threshold 0
   split-height-threshold nil)

(global-visual-line-mode 1)
(global-visual-fill-column-mode 1)
(set-fill-column 100)


