;; require
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives  '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

;; dracula
(load-theme 'dracula t)
;; utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-coding-systems 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; 現在位置表示
(column-number-mode t)

;; 行番号
(global-linum-mode t)

;; 括弧
(show-paren-mode t)
(electric-pair-mode t)

;; 時間の表示
; (display-time t)

;; yes -> y, no -> n
(defalias 'yes-or-no-p 'y-or-n-p)

;; 初期メッセージの非表示
(setq inhibit-startup-message t)

;; バックアップファイルの保存先
(setq backup-directory-alist '((".*" . "~/.ehistory")))

;; backspace
; (keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-\\" 'help)

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode 0.5)

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; tabサイズ
(setq default-tab-width 2)

;; バッファ操作
(global-set-key (kbd "M-[") 'switch-to-prev-buffer)
(global-set-key (kbd "M-]") 'switch-to-next-buffer)

;; タブ操作
(global-set-key (kbd "C-t") nil)
(global-set-key (kbd "C-t s") 'find-file-other-tab)
(global-set-key (kbd "C-t 0") 'tab-close)
(global-set-key (kbd "C-t 1") 'tab-close-other)
(global-set-key (kbd "C-t 2") 'tab-new)
(global-set-key (kbd "C-t d") 'dired-other-tab)
(global-set-key (kbd "C-t m") 'tab-move)
(global-set-key (kbd "C-t RET") 'tab-bar-select-tab-by-name)
(global-set-key (kbd "C-t o") 'tab-next)
(global-set-key (kbd "C-t r") 'tab-rename)

;; ウィンドウ操作
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x C-1") 'delete-other-windos)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-o") 'other-window)

(global-set-key (kbd "C-x C-k") 'kill-buffer)

;; bufferの最後でカーソルを動かそうとしても音がならないようにする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

(setq ring-bell-function 'ignore)

;; 選択範囲をコメントアウト
(global-set-key (kbd "M-;") 'comment-region)

;; 一行コメントアウト
(defun one-line-comment ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (end-of-line)
    (comment-or-uncomment-region (region-beginning) (region-end))))
(global-set-key (kbd "C-;") 'one-line-comment)

;; git
;(require 'git-gutter)
;(global-git-gutter-mode 1)

;(global-set-key (kbd "C-x C-g") 'magit-diff-working-tree)

;(global-auto-revert-mode t)

;; magit
(defalias 'magit 'magit-status)
(global-set-key (kbd "C-x C-g") 'magit-status)

(setenv "GIT_EDITOR" "emacsclient")
(add-hook 'shell-mode-hook 'with-editor-export-git-editor)

;; neo-tree
(require 'neotree)
(global-set-key (kbd "C-o") 'neotree-toggle)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
  '(package-selected-packages
     '(cmake-ide dracula-theme flycheck-golangci-lint flycheck company-go go-mode magit editorconfig vue-mode undo-tree neotree leaf-keywords hydra git-gutter el-get auto-complete all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; vue-mode

;; editorconfig
(editorconfig-mode 1)

;; golang
(add-to-list 'exec-path (expand-file-name "/home/linuxbrew/.linuxbrew/bin/go/bin"))

(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
                          (add-hook 'before-save-hook' 'gofmt-before-save)
                          (local-set-key (kbd "M-.") 'godef-jump)
                          (set (make-local-variable 'company-backends) '(company-go))
                          (setq indent-tabs-mode nil)
                          (setq c-basic-offset 2)
                          (setq tab-width 2)))

(require 'company-go)
(add-hook 'go-mode-hook (lambda()
                          (company-mode)
                          (setq company-transformers '(company-sort-by-backend-importance))
                          (setq company-idle-delay 0)
                          (setq company-minimum-prefix-length 3)
                          (setq company-selection-wrap-around t)
                          (setq completion-ignore-case t)
                          (setq company-dabbrev-doqncase nil)
                          (global-set-key (kbd "C-M-i") 'company-complete)
                          (define-key company-active-map (kbd "C-n") 'company-select-next)
                          (define-key company-active-map (kbd "C-p") 'company-select-previous)
                          (define-key company-active-map (kbd "C-s") 'company-filter-candidates)
                          (define-key company-active-map [tab] 'company-complete-selection)
                          (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
                          ))
