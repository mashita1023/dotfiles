;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.

;;; Code:
;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (setq org-directory "~/ghq/github.com/mashimo/org-files")
    (setq org-default-notes-file "notes.org")
    (setq org-capture-templates
      '(("n" "Note" entry (file+headline
                            "~/ghq/github.com/mashimo/org-files/notes.org" "Notes")
          "* %?\nEntered on %U\n %i\n %a")
         ))
    (setq kill-whole-line t)
    (setq initial-scratch-message "")
    (setq electric-indent-mode -1)

    (leaf-keywords-init)))

;; ここにいっぱい設定を書く

(leaf-keys (("C-h"  . backward-delete-char)
            ("C-/"  . undo)
            ("M-\\" . help-command)
            ("M-["  . switch-to-prev-buffer)
            ("M-]"  . switch-to-next-buffer)
            ("C-c c" . org-capture)
            ))

(define-key global-map (kbd "C-/") 'undo)

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom((imenu-list-size . 30)
            (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf custom-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

;; define custom properties of buliltin
(leaf custom-start
  :doc "define customization properties of buildins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))
  :bind (("M-ESC ESC" . c/redraw-frame))
  :custom '((user-full-name . "Toshichika Mashimo")
            (user-mail-address . "mashita1023@gmail.com")
            (user-login-name . "mashita1023")
            (create-lockfiles . nil)
            (debug-on-error . t)
            (init-file-debug . t)
            (truncate-lines . t)
            (scroll-bar-mode . nil)
            (indent-tabs-mode . nil)
            (electric-pair-mode . t)
            (auto-save-default . nil)
            (make-backup-files . nil)
            (display-time-mode . t)
            (x-select-enable-clipboard . t))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (global-unset-key "C-s")
  (if window-system (progn
                      (set-frame-parameter nil 'alpha 80)))
  (setq backup-directory-alist
    (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
      backup-directory-alist))
  (setq auto-save-file-name-transforms
    `((".*", (expand-file-name "~/.emacs.d/backup/") t)))
  (defvar prev-yanked-text nil)
  (setq interprogram-cut-function
    (lambda (text)
      (let ((process-connection-type nil))
        (let ((proc (start-process "pbcopy" nil "*pbcopy")))
          (process-send-string proc text)
          (process-send-eof proc)))))
  (setq interprogram-paste-function
    (lambda ()
      (let ((text (shell-command-to-string "pbpaste")))
        (if (string= prev-yanked-text text)
          nil
          (setq prev-yanked-text text))))))

;;linum
(leaf display-line-numbers
  :ensure t
  :config
  (global-display-line-numbers-mode 1)
  (setq indicate-empty-lines t)
  (setq indicate-buffer-boundaries 'left))
;; delete selection if you insert
(leaf delselect
  :doc "delete selection if you insert"
  :tag "builtin"
  :global-minor-mode delete-selection-mode)

;; highlight maching paren
(leaf paren
  :doc "highlight matching paren"
  :tag "builtin"
  :custom ((show-paren-delay . 0.1))
  :global-minor-mode show-paren-mode)

; read variables in shell
(leaf exec-path-from-shell
  :doc "get environment variables such as $PATH from the shell"
  :req "emacs-27.2"
  :tag "environment" "unix" "emacs>=24.1"
  :added "2021-06-21"
  :url "https://github.com/purcell/exec-path-from-shell"
  :emacs>= 24.1
  :ensure t)

;; freee-keys is searching unused key prefix
(leaf free-keys
  :ensure t)

;; use git in emacs
(leaf magit
  :ensure t
  :bind ("C-x g" . magit-status))

;;
(leaf selectrum
  :ensure t
  :global-minor-mode t)

;;
(leaf which-key
  :ensure t
  :global-minor-mode t)

;;undo and redo
(leaf undo-tree
  :ensure t
  :bind (("M-/" . undo-tree-redo)
         ("C-M-/" . undo-tree-visualize))
  :global-minor-mode global-undo-tree-mode
  :custom(
  (undo-tree-visualizer-diff . t)
  (undo-tree-history-directory-alist . '(("." . "~/.emacs.d/backup/")))))

;;
(leaf expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

;; emphasize cursor when move buffer
(leaf beacon
  :ensure t
  :require t
  :global-minor-mode beacon-mode
  :config
  (beacon-mode 1))

;; emphasize changes to yank
(leaf volatile-highlights
  :ensure t
  :require t
  :global-minor-mode volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

;; display indent
(leaf highlight-indent-guides
  :ensure t
  :require t
  :global-minor-mode highlight-indent-guides-mode
  :custom
  (highlight-indent-guides-method . 'character)
  (highlight-indent-guides-auto-character-face-perc . 20)
  (highlight-indent-guides-character . ?\|)
  :hook
  (prog-mode-hook . highlight-indent-guides-mode))

;; icon
(leaf all-the-icons
  :ensure t)
(leaf all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode)
)

(leaf highlight-defined
  :ensure t)

(leaf path-headerline-mode
  :ensure t
  :config (path-headerline-mode 1))

;; watch and select dir and file
(leaf neotree
  :ensure t
  :bind ("C-o" . neotree-toggle)
  :defvar (neo-show-hidden-files
           neo-keymap-style
           neo-smart-open
           neo-window-width
           neo-window-fixed-size
           neo-theme)
  :config
  (setq neo-show-hidden-files t
        neo-keymap-style 'concise
        neo-smart-open t
        neo-window-width 30
        neo-window-fixed-size nil
        neo-theme 'icons))

;; dired
(leaf dired
  :config
  ;; 先にディレクトリを表示
  (setq dired-listing-switches "-al")
  ;; ファイルサイズをいい感じに
  (setq dired-ls-F-marks-symlinks t)
  ;; ディレクトリの再帰系
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  ;; デフォルトをバッファで開くようにする
  (setq dired-kill-when-opening-new-dired-buffer t))

(leaf dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t)

  ;; font
  (set-face-attribute 'default nil
                      :family "Hack Nerd Font Mono"
                      :height 120)
  ;; Jpn-font
  (set-fontset-font t 'japanese-jisx0208
                    (font-spec :family "Hiragino Sans")))


;; cursor can be multiple
(leaf multiple-cursors
  :ensure t
  :bind (("C-M-c"   . mc/edit-lines)
         ("C-M-n"   . mc/mark-next-like-this)
         ("C-M-p"   . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; snippet
(leaf yasnippet
  :ensure t
  :global-minor-mode yas-global-mode)

;; code jump (gtags)
;(leaf ggtags
;  :ensure t)

;; tagjump
(leaf dumb-jump
  :ensure t
  :hook ('xref-backend-functions . dumb-jump-xref-activate)
  :config
  (leaf dumb-jump-mode
    :ensure t))

;; syntax checking
(leaf flycheck
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error)
         ("M-l" . flycheck-list-errors))
  :global-minor-mode global-flycheck-mode)

;; auto-completion
(leaf company
  :ensure t
  :custom ((company-minimum-prefix-length . 1)
           (company-idle-delay . 0)
           (company-dabbrev-downcase . nil)
           (company-require-match . 'never)
           (company-selection-wrap-around . t)
           (company-tooltip-align-annotations . t)
            (company-tng-mode . t))
  :hook (prog-mode . company-mode)
  :global-minor-mode global-company-mode
  :config
  (leaf company-box
             :emacs>= 27
             :ensure t
    :hook (company-mode-hook . company-box-mode))
  (leaf company-statistics
    :ensure t
    :defun (company-statics-mode)))

;; copilot
;; (leaf copilot
;;   :el-get (copilot :type github :pkgname "copilot-emacs/copilot.el")
;;   :hook (prog-mode . copilot-mode)
;;   :config
;;   (leaf jsonrpc :ensure t)
;;   (leaf dash :ensure t)
;;   (leaf s :ensure t)
;;   (leaf editorconfig :ensure t)
;;   (defvar copilot-mode-map)
;;   (defvar copilot-node-executable "~/.asdf/shims/node")
;;   (defun my/copilot-tab ()
;;     (interactive)
;;     (or (copilot-accept-completion)
;;         (indent-for-tab-command)))
;;   (with-eval-after-load 'copilot
;;     (define-key copilot-mode-map (kbd "<tab>") #'my/copilot-tab)))

;; llm
(leaf ellama
  :ensure t
  :require (llm llm-openai)
  :custom (llm-warn-on-nonfree . nil)
  :defvar (ellama-major-mode
           ellama-naming-scheme
           ellama-provider
           ellama-openai-key
           ellama-language
           ellama-openai-model
           ellama-keymap-prefix)
  :defun make-llm-openai
  :config
  (setq ellama-major-mode 'markdown-mode
        ellama-naming-scheme 'ellama-generate-name-by-time
        ellama-provider (make-llm-openai :key (getenv "OPENAI_API_KEY"))
        ellama-language "Japanese"
        ellama-openai-model "gpt-4o")
        ellama-keymap-prefix "C-c l")

;; enhance completion and search
(leaf ivy
  :ensure t
  :global-minor-mode ivy-mode
  :custom ((ivy-re-builders-alist . '((t      . ivy--regex-fuzzy)
                                      (swiper . ivy--regex-plus)))
           (ivy-use-selectable-prompt . t)
           (ivy-mode . t)
           (counsel-mode . t))
  :init
  (leaf *ivy-requirements
    :config
    ;; search
    ;; swiper-include-line-number-in-search only works with setq
    (leaf swiper
      :ensure t
      :bind ("C-s" . swiper)
      :defvar swiper-include-line-number-in-search
      :config
      (setq swiper-include-line-number-in-search t))
    ;; find-file
    (leaf counsel
      :ensure t
      :global-minor-mode counsel-mode
      :bind (("C-c C-s" . counsel-imenu)
              ("C-c C-r" . counsel-recentf)))
    (leaf ghq
      :ensure t
      :config
      (defvar ivy-ghq-short-list t))))

;; string manipulation
(leaf s
  :ensure t)

;; modern list API for emacs
(leaf dash
  :ensure t)

;; root project and toggle
(leaf projectile
  :ensure t
  :global-minor-mode projectile-mode
  :bind ("C-c p" . projectile-command-map))

;; terminal
(leaf vterm
  :ensure t)

;; ripgrep
(leaf rg
  :ensure t
  :config
  (rg-enable-default-bindings))

;; color display
(leaf rainbow-mode
  :ensure t
  :leaf-defer t
  :hook
  (tsx-ts-mode . rainbow-mode))

;; editorconifg
(leaf editorconfig
  :ensure t)
;  :custom
;  (editorconfig-mode . 1))

;; golang
(leaf go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode)))

;; web
(leaf web-mode
  :ensure t
  :after flycheck
  :defun flycheck-add-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.scss\\'"  . web-mode)
         ("\\.css\\'"   . web-mode)
         ("\\.vue\\'"   . web-mode)
         ("\\.js[x]?\\'" . web-mode)
;         ("\\.tsx\\'" . web-mode)
         ("\\.jst.eco\\'" . web-mode))
  :init (defvar web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (defvar web-mode-markup-indent-offset 2)
  (defvar web-mode-enable-auto-closing t)
  (defvar web-mode-enable-auto-pairing t)
  (defvar web-mode-auto-close-style 2)
  (defvar web-mode-tag-auto-close-style 2)
  (defvar web-mode-css-indent-offset 2)
  (defvar web-mode-code-indent-offset 2)
  (defvar web-mode-comment-style 2)
  (defvar web-mode-style-padding 1)
  (defvar web-mode-script-padding 1))

;; lsp
;;;; sorbetとruby-lspが共存できないためruby-lspのみ使う
;(leaf eglot
;  :ensure t
;  :defvar eglot-server-programs
;  :hook
;;  (typescript-mode . eglot-ensure)
;;  (tsx-ts-mode . eglot-ensure)
;  (ruby-mode-hook . eglot-ensure)
;  :config
;  (with-eval-after-load 'eglot
;    (add-to-list 'eglot-server-programs
;                 `(ruby-mode .,(eglot-alternatives
;                                '(("bundle" "exec" "srb" "tc" "--lsp")
;                                  ("ruby-lsp"))))))
                                        ;  )
(leaf eglot
  :ensure t
  :defvar ((eglot-server-programs)
           (eglot-stay-out-of))
  :hook
  ((ruby-ts-mode-hook . eglot-ensure)
   (go-mode-hook . eglot-ensure)
   (eglot-managed-mode . company-mode))
  :config
  (setq eglot-stay-out-of '(yasnippet))
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 `(ruby-ts-mode "bundle" "exec" "ruby-lsp")))
  )

;; typescript
;;; https://jppot.info/posts/c05e989a-e642-4c84-a5b8-a0e0c3178941
;(leaf typescript-ts-mode
;  :mode (("\\\\.tsx\\\\'" . tsx-ts-mode)
;         ("\\\\.ts\\\\'" . tsx-ts-mode))
;  :config
;  (setq typescript-ts-mode-indent-offset 2))

(leaf typescript-mode
  :ensure t
  :require (flycheck treesit)
  :config
  (flycheck-add-mode 'javascript-eslint 'typescript-mode)
  (flycheck-add-mode 'javascript-eslint 'tsx-ts-mode)
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . tsx-ts-mode)))

(leaf treesit
  :defvar treesit-language-source-alist
  :config
  (add-to-list 'treesit-language-source-alist
               '(ruby "https://github.com/tree-sitter/tree-sitter-ruby"))
  (defvar treesit-font-lock-level 4))

(leaf treesit-auto
  :ensure t
  :require t
  :defun global-treesit-auto-mode
  :custom
  (treesit-auto-install . t)
  :config
  (global-treesit-auto-mode))

(leaf tree-sitter
  :ensure t
  :hook ((typescript-ts-mode . tree-sitter-hl-mode)
         (tsx-ts-mode . tree-sitter-hl-mode)
         (ruby-ts-mode . tree-sitter-hl-mode))
  :defvar tree-sitter-major-mode-language-alist
  :config
  (global-tree-sitter-mode))

(leaf tree-sitter-langs
  :ensure t
  :after tree-sitter
  :config
  (tree-sitter-require 'tsx)
  (tree-sitter-require 'ruby)
  (add-to-list 'tree-sitter-major-mode-language-alist '(tsx-ts-mode . tsx))
  (add-to-list 'tree-sitter-major-mode-language-alist '(ruby-ts-mode . ruby)))

(leaf tide
  :ensure t
  :hook (tsx-ts-mode . setup-tide-mode)
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (defvar flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  (defvar company-tooltip-align-annotations t))

;; python
;(leaf python-mode
;  :ensure t
;  :leaf-defer t
;  :mode (("\\.py\\'" . python-mode)))

;; ruby
(leaf ruby-mode
  :ensure t
  :custom (ruby-insert-encoding-magic-comment . nil)
  :mode (("\\.rb\\'" . ruby-ts-mode)))

;(leaf rspec-mode
;  :ensure t
;  :mode (("\\_spec.rb\\'" . rspec-mode)))

;; yaml
(leaf yaml-mode
  :ensure t
  )

; markdown
(leaf markdown
  :config
  (leaf markdown-mode
    :ensure t
    :leaf-defer t
    :mode ("\\.md\\'" . gfm-mode)
    :custom
    (markdown-command . "github-markup")
    (markdown-command-needs-filename . t))
  (leaf markdown-preview-mode
  :ensure t)
 )

;; dockerfile
(leaf dockerfile-mode
  :ensure t
  :mode ("\\Dockerfile\\'" . dockerfile-mode))

;; dart
;(leaf dart-mode
;  :ensure t
;  :leaf-defer t
;  :mode ("\\.dart\\'" . dart-mode)
;  )


(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package blackout el-get hydra leaf-keywords leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; init.el ends here
