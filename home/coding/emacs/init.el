;;; init.el -*- lexical-binding: t; -*-

;; 基础设置
(setq inhibit-startup-screen t)   ; 关闭默认启动画面
(global-display-line-numbers-mode 1) ; 显示行号
(tool-bar-mode -1)                ; 隐藏工具栏
(menu-bar-mode -1)                ; 隐藏菜单栏
(scroll-bar-mode -1)              ; 隐藏滚动条
(setq display-line-numbers-width 4)
(setopt elisp-fontify-semantically t)
(global-auto-revert-mode 1)
(set-frame-font "Jetbrains Maple Mono-14" nil t)
(set-face-attribute 'default nil
		    :family "Jetbrains Maple Mono"
		    :height 140)
(setq catppuccin-flavor 'mocha)
(load-theme 'catppuccin t)

;; 设置一个专门存放垃圾文件的目录
(defvar my-backup-dir (expand-file-name "var/backups" user-emacs-directory))
(unless (file-exists-p my-backup-dir)
  (make-directory my-backup-dir t))

;; 备份文件 (`~`) 
(setq backup-directory-alist `(("." . ,my-backup-dir)))
;; 设置备份文件不随保存次数叠加
(setq delete-old-versions t)

;; 自动保存文件 (`#`)
(setq auto-save-file-name-transforms
      `((".*" ,my-backup-dir t)))

;; 关闭锁文件
(setq create-lockfiles nil)

;; which-key按键提示
(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :config
  (setq which-key-show-operator-state-maps t)
  (setq which-key-show-major-mode t)
  (setq which-key-idle-delay 0.5)) ; 半秒后弹出

;; undo-tree撤销历史
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode 1))

;; 确保目录存在
(make-directory (expand-file-name "var/undo-tree" user-emacs-directory) t)

;; 历史文件存指定文件夹
(setq undo-tree-history-directory-alist
      `(("." . ,(expand-file-name "var/undo-tree" user-emacs-directory))))

;; recentf
(setq recentf-save-file (expand-file-name "var/recentf.eld" user-emacs-directory))
;; 开启记录最近文件的功能
(recentf-mode 1)
;; 最多记录50个
(setq recentf-max-saved-items 50)

;; 忽略一些文件类型
(add-to-list 'recentf-exclude "\\.emacs\\.d/var/")
(add-to-list 'recentf-exclude "^/tmp/")

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("k" . meow-next)
   '("i" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("j" . meow-left)
   '("J" . meow-left-expand)
   '("h" . meow-insert)
   '("H" . meow-open-above)
   '("k" . meow-next)
   '("K" . meow-next-expand)
   '("i" . meow-prev)
   '("I" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(use-package meow
  :ensure t
  :demand t
  :init
  (meow-global-mode 1)
  :config
  (meow-setup)
  ;; 相对行号
  (meow-setup-line-number)
  ;; 设置模式指示器
  (meow-setup-indicator))

;; doom-modeline状态栏
(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-height 32)
  (setq doom-modeline-support-imenu t)
  (setq doom-modeline-buffer-file-name-style 'auto)
  (setq doom-modeline-icon t)
  (setq doom-modeline-buffer-name t)
  (doom-modeline-mode 1))

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-banner-logo-title "Welcome to Emacs")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 5)
                          (projects . 5))))

;; magit：Git界面
(use-package magit
  :ensure t)

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :custom
  (setq markdown-enable-math t)
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package company-math
  :ensure t
  :config
  (add-to-list 'company-backends 'company-math-symbols-latex))

(add-hook 'markdown-mode-hook
          (lambda ()
            (setq-local company-backends
                        (append '((company-math-symbols-latex company-math-symbols-unicode))
                                company-backends))))

(use-package avy
  :ensure t
  :defer t
  :config
  ;; 设置跳转时使用的引导键
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  ;; 设置跳转样式（'at 表示在字符所在位置显示引导键）
  (setq avy-style 'at)
  ;; 限制avy只在当前窗口生效
  (setq avy-all-windows nil))

(use-package consult
  :ensure t
  :bind (;; 覆盖原生C-x b，使用consult
         ("C-x b" . consult-buffer)
	 ("C-s" . consult-line)
	 ("C-x g" . magit-status)))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  ;; 允许在搜索时用空格分开多个关键词
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((file (styles basic partial-completion)))))

;; (use-package general
;;   :ensure t
;;   :config
;;   (general-override-mode 1)
;;   (general-auto-unbind-keys)

;;   ;; 让general的Leader键作用于Meow的NORMAL和MOTION状态
;;   (general-create-definer my-leader-def
;;     :keymaps '(meow-motion-state-keymap meow-normal-state-keymap)
;;     :prefix "SPC")

;;   ;; 定义菜单树
;;   (my-leader-def
;;     ;; Buffer 相关
;;     "b"  '(:ignore t :which-key "buffers")
;;     "bb" '(consult-buffer :which-key "switch buffer")
;;     "bd" '(kill-current-buffer :which-key "kill buffer")
;;     "bi" '(ibuffer :which-key "ibuffer list")

;;     ;; 文件/目录 相关
;;     "f"  '(:ignore t :which-key "files")
;;     "ff" '(find-file :which-key "find file")
;;     "fd" '(dired :which-key "open dired")

;;     ;; 搜索 相关
;;     "s"  '(:ignore t :which-key "search")
;;     "sl" '(consult-line :which-key "search in buffer")
;;     "sg" '(consult-ripgrep :which-key "search in project")

;;     ;; 窗口 相关
;;     "w"  '(:ignore t :which-key "windows")
;;     "wh" '(evil-window-left :which-key "window left")
;;     "wj" '(evil-window-down :which-key "window down")
;;     "wk" '(evil-window-up :which-key "window up")
;;     "wl" '(evil-window-right :which-key "window right")
;;     "wd" '(evil-window-delete :which-key "close window")
;;     "wo" '(delete-other-windows :which-key "close other windows")

;;     ;; 跳转 (Avy) 相关
;;     "j"  '(:ignore t :which-key "jump (avy)")
;;     "jc" '(avy-goto-char :which-key "goto char")
;;     "jw" '(avy-goto-word-0 :which-key "goto word")
;;     "jl" '(avy-goto-line :which-key "goto line")

;;     ;; Git (Magit) 相关
;;     "g"  '(:ignore t :which-key "git")
;;     "gg" '(magit-status :which-key "magit status")
;;     "gl" '(magit-log-current :which-key "magit log")))

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-<tab>" . copilot-accept-completion-by-word)
              ("C-TAB" . copilot-accept-completion-by-word)
              ("C-n" . copilot-next-completion)
              ("C-p" . copilot-previous-completion))
  :config
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

;; 内置eglot LSP配置
(use-package eglot
  :ensure nil ; 内置包
  :hook (prog-mode . eglot-ensure) ; 编程模式下自动启动
  :config
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("ty" "server")))
  )
;; tree-sitter语法高亮
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt) ; 打开文件时提示安装缺失的语法
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) ; 自动将-ts-mode加入auto-mode-alist
  (global-treesit-auto-mode)) ; 全局启用

;; apheleia代码格式化
(use-package apheleia
  :ensure t
  :hook (prog-mode . apheleia-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1) ; 开启垂直补全模式
  :config
  ;; 支持循环滚动
  (setq vertico-cycle t))

(use-package nerd-icons
  :ensure t)

(provide 'init)
